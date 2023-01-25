package com.cji.exam.trademark.util;

import lombok.Data;

@Data
public class Page {
	int itemTotalCount = 0; // 페이지 아이템 총 개수
	int	pageItemCount = 10; //한 페이지에서 한번에 보여줄 페이지 아이템 개수
	int pageCount = 1; // 
	int currentItem = 1; //현재 아이템 번호

	public Page() {
	}
	public Page( int itemTotalCount, int pageItemCount, int pageCount, int currentItem) {

		setItemTotalCount(itemTotalCount);
		setPageCount(pageCount);
		setCurrentItem(currentItem);
	}
	//아이템크기

		public int getItemTotalCount() {
			return itemTotalCount;

		}

		public Page setItemTotalCount(int itemTotalCount) {
			if(itemTotalCount < 1){
				itemTotalCount = 0;

			}

			this.itemTotalCount = itemTotalCount;
			return this;

		}

		//페이지에 한번에 보여줄 아이템크기
		public int getPageItemCount() {
			return pageItemCount;

		}

		//페이지당 보여줄 아이템개수
		public Page setPageItemCount(int pageItemCount) {
			this.pageItemCount = pageItemCount;
			return this;

		}

		//페이지수 보여줄 개수
		public int getPageCount() {
			return pageCount;

		}

		public Page setPageCount(int pageCount) {
			this.pageCount = pageCount;
			return this;

		}
		//현재 페이지 번호

		public int getCurrentPage() {
			int currentPage = (currentItem/pageItemCount) + ((currentItem%pageItemCount)>0?1:0); //현재위치 / 페이지에보여줄아이템수  + 나머지0이상있는경우 +1
			int pageMax = getPageMax();
			int pageMin = getPageMin();
			if(currentPage>pageMax){
				currentPage=pageMax;
			}else if(currentPage < 1){
				currentPage = pageMin;
			}
			return currentPage;
		}

		public Page setCurrentPage(int currentPage) {
			currentItem = (pageItemCount*currentPage - 1) + 1; //바로전페이지로 이동후 +1로 아이템위치셋팅
			int totalCont = getItemTotalCount();
			if(currentItem>getItemTotalCount()){
				currentItem = totalCont;
			}else if(currentItem<1){
				currentItem=0;
			}
			int pageMax = getPageMax();
			int pageMin = getPageMin();
			if(currentPage>pageMax){
				currentPage=pageMax;
			}else if(currentPage<1){
				currentPage = pageMin;
			}
			return this;
		}


		//현재 아이템 번호
		public int getCurrentItem() {
			return currentItem;

		}

		public Page setCurrentItem(int currentItem) throws IllegalArgumentException {
			if(currentItem>getItemTotalCount()){
				throw new IllegalArgumentException("max over");
			}
			this.currentItem = currentItem;
			return this;
		}

		

		//////auto------

//		public int[] getPage() {

//			return page;

//		}

		public int getPageMin() {
			return 1;

		}

		public int getPageMax() {
			int max = (itemTotalCount/pageItemCount) + ((itemTotalCount%pageItemCount)>0?1:0);
			int pageMin = getPageMin();
			if(max<1){
				max = pageMin;

			}
			return max;

		}

		

		//현재 페이지의 아이템 최소값
		public int getCurrentPageItemMin() {
			return (getCurrentPage() - 1 ) * getPageItemCount() + 1; //전페이지 

		}

		//현재 페이지의 아이템 최대값
		public int getCurrentPageItemMax() {
			int itemTotatCount = getItemTotalCount();
			int max = getCurrentPageItemMin()+ getPageItemCount() - 1;
			if(max>itemTotatCount){
				max = itemTotatCount;
			}
			return max;

		}

		

		//페이징 표시의   처음 페이지  값
		public int getCurrentPageMin() {
			int currentPage = getCurrentPage();
			int currentPageMin = currentPage - (getPageCount() / 2);
			if(currentPageMin < 1){
				currentPageMin = 1;

			}
			return currentPageMin;

		}

		//페이징 표시의   최대 페이지  값
		public int getCurrentPageMax() {
			int pageMax = getPageMax();
			int currentPageMin = getCurrentPageMin() + (getPageCount()) - 1;
			if(currentPageMin>pageMax){
				currentPageMin = pageMax;
			}
			return currentPageMin;

		}
		public void process(){
			getItemTotalCount();
			getPageItemCount();
			getPageCount();
			getCurrentPage();
			getCurrentItem();
			getPageMin();
			getPageMax();
			getCurrentPageMin();
			getCurrentPageMax();

		}
		@Override

		public String toString() {

			process();

			return "getItemTotalCount(총아이템수)="

					+ getItemTotalCount() + ",\r\n getPageItemCount(한페이지당 표시 아이템수)="

					+ getPageItemCount() + ",\r\n getPageCount(페이징쪽에 페이지표시 보여줄수)=" + getPageCount()

					+ ",\r\n getCurrentPage(현재페이지)=" + getCurrentPage()

					+ ",\r\n getCurrentItem(현재아이템위치)=" + getCurrentItem() + ",\r\n getPageMin()="

					+ getPageMin() + ",\r\n getPageMax(마지막 페이지 번호)=" + getPageMax()

					+ ",\r\n getCurrentPageMin(보여질페이지에 처음페이지 번호)=" + getCurrentPageMin()

					+ ",\r\n getCurrentPageMax(보여질페이지에 마지막페이지 번호)=" + getCurrentPageMax()

					+ ",\r\n getCurrentPageItemMin(현재페이지 처음 아이템 번호)=" + getCurrentPageItemMin()

					+ ",\r\n getCurrentPageItemMax(현재페이지 마지막 아이템 번호)=" + getCurrentPageItemMax()

					;

		}
		
}

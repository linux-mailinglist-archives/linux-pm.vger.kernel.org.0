Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167EC2F4751
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 10:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAMJOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 04:14:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38258 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbhAMJOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 04:14:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D99gQR125560;
        Wed, 13 Jan 2021 09:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=PJppwapMJ05TyudPkc3cYi6LZO9tAK25mpSwQywEWRw=;
 b=NuwFQIe25jyda5T61hLMe0Q9HRBtB4v7+aR31uwCP28mc+JotF1GfIJdmeJKdRtS0dUq
 YrdwuMZ8gk5N//MO0IPRCV2Em4wEweM9l6FGncCd6GE6JuM383vx5omVW5XtMdcHl9SY
 /qOWCYyA3QKWxkDx8vvW7B3uVCxQ+7wfwRSj7tl+3hKZzvGUfIKu8oDF/WTv00h4xj/J
 bnrJn7+Qg7z9IPkgsDM/oEwG00YGref1YOlclPgs0+9HHeP34drTo7mXTONVM4r1TSCX
 Z8k6WWpUvEb+UQVNrJ7rwP+lod3iMKUziRiT40D3v5Kg0drNZ4R2gzasE71DrirXC5ga 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1tck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 09:14:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D9BePD104307;
        Wed, 13 Jan 2021 09:14:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke8159u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 09:14:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10D9E2Lt028370;
        Wed, 13 Jan 2021 09:14:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 01:14:01 -0800
Date:   Wed, 13 Jan 2021 12:13:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [EXTERNAL] [bug report] power: supply: bq256xx: Introduce the
 BQ256XX charger driver
Message-ID: <20210113091356.GF5105@kadam>
References: <X/1jy5+2elOl3Lm8@mwanda>
 <d0a0fccf-d7c5-c5a4-c4f0-68a8a01b7c34@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0a0fccf-d7c5-c5a4-c4f0-68a8a01b7c34@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130055
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 05:44:52PM -0600, Ricardo Rivera-Matos wrote:
> Dan,
> 
> On 1/12/21 2:54 AM, Dan Carpenter wrote:
> > Hello Ricardo Rivera-Matos,
> > 
> > The patch 32e4978bb920: "power: supply: bq256xx: Introduce the
> > BQ256XX charger driver" from Jan 6, 2021, leads to the following
> > static checker warning:
> > 
> > 	drivers/power/supply/bq256xx_charger.c:1512 bq256xx_hw_init()
> > 	error: buffer overflow 'bq256xx_watchdog_time' 8 <= 8
> > 
> > drivers/power/supply/bq256xx_charger.c
> >    1503  static int bq256xx_hw_init(struct bq256xx_device *bq)
> >    1504  {
> >    1505          struct power_supply_battery_info bat_info = { };
> >    1506          int wd_reg_val = BQ256XX_WATCHDOG_DIS;
> >    1507          int ret = 0;
> >    1508          int i;
> >    1509
> >    1510          for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
> >    1511                  if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
> >    1512                      bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
> >                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > The last four members of this array are all zero.
> ACK, BQ256XX_NUM_WD_VAL should actually be 4 instead of 8
> > 
> > On the last iteration through the loop this will read beyond the end of
> > the array possibly setting "wd_reg_val = 7" uninitentionally.
> ACK, bq256xx_parse_dt() will clamp bq->watchdog_timer so then in
> bq256xx_hw_init()
> 
>     for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>         if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
>             wd_reg_val = i;
>             break;
>         }
>         if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>             bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>             wd_reg_val = i;
>     }
> 
> The first if will catch the exact matches and the second if will catch the
> "in-betweens" and round down. The final iteration will always fall into the
> first if statement and break.
> 

This looks good.  This is a patch you are proposing or it's already
merged in an upstream tree somewhere?  Either way, that sounds fine.
Thank!

regards,
dan carpenter


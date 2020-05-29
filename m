Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191591E7893
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgE2IoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 04:44:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgE2IoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 04:44:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8fhZQ071273;
        Fri, 29 May 2020 08:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tR/yWELL8anMcW8acbohYFPhoTO/I2XfrJ5Sv4f/7I8=;
 b=mRLONHVbeKBsZzOw1nDJq066y3vXK/27IzDC7PkuU8ayQqSwRr//0AeAn82U7btzHQmb
 +Fs1AslTrRsdjlFIHOw3ED3DOsn9qEuMBy1RbtaPOgaEETt+JlvWHwMIMt36F3BQiKwl
 8q2VphIyKR5OeDkbkmYgYh4Dxk33aZp4GdtHFzcr7qrrwBfuACuc/26UudPhDq6Lglzm
 sgqYgGHl4kTx09yrDuvwqER6MVKXCbqPNtYcOidOeXOwGqemZVpBDhdK6XaaqV1DkINZ
 aJxNNFll2WL9hudb3S79vLwtsizJ8p33SWlo1+8zG/RCFYalZ1W0QyUujH3Akee83Dlg tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8r96xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 08:43:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8Xhbu011031;
        Fri, 29 May 2020 08:41:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31a9ktwsw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 08:41:59 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04T8fwJ0027507;
        Fri, 29 May 2020 08:41:58 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 01:41:58 -0700
Date:   Fri, 29 May 2020 11:41:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] opp: Remove bandwidth votes when target_freq is zero
Message-ID: <20200529084153.GA1298732@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=3
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290069
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch c57afacc9270: "opp: Remove bandwidth votes when target_freq
is zero" from May 27, 2020, leads to the following static checker
warning:

	drivers/opp/core.c:875 dev_pm_opp_set_rate()
	error: uninitialized symbol 'opp'.

drivers/opp/core.c
   844   */
   845  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
   846  {
   847          struct opp_table *opp_table;
   848          unsigned long freq, old_freq, temp_freq;
   849          struct dev_pm_opp *old_opp, *opp;
                                             ^^^

   850          struct clk *clk;
   851          int ret;
   852  
   853          opp_table = _find_opp_table(dev);
   854          if (IS_ERR(opp_table)) {
   855                  dev_err(dev, "%s: device opp doesn't exist\n", __func__);
   856                  return PTR_ERR(opp_table);
   857          }
   858  
   859          if (unlikely(!target_freq)) {
   860                  /*
   861                   * Some drivers need to support cases where some platforms may
   862                   * have OPP table for the device, while others don't and
   863                   * opp_set_rate() just needs to behave like clk_set_rate().
   864                   */
   865                  if (!_get_opp_count(opp_table))
   866                          return 0;
   867  
   868                  if (!opp_table->required_opp_tables && !opp_table->regulators &&
   869                      !opp_table->paths) {
   870                          dev_err(dev, "target frequency can't be 0\n");
   871                          ret = -EINVAL;
   872                          goto put_opp_table;
   873                  }
   874  
   875                  ret = _set_opp_bw(opp_table, opp, dev, true);
                                                     ^^^
Not initialized.

   876                  if (ret)
   877                          return ret;
   878  
   879                  if (opp_table->regulator_enabled) {
   880                          regulator_disable(opp_table->regulators[0]);
   881                          opp_table->regulator_enabled = false;
   882                  }

regards,
dan carpenter

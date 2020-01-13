Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF4138F23
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAMKdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 05:33:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41512 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAMKdg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 05:33:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DANP9j169492;
        Mon, 13 Jan 2020 10:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=bXiZojaHjBD1dP3hyyEd5RCQpgbq825ponM/lKiehBY=;
 b=sIQl3gJ8B9H5FSHRq2zEk2h4Vhkt1VfOJRWi3xWeFNkQ9KPk0Nwk71nImscaQ33nFV/2
 m4opZKugYjpnUWBe0A8wvSGXicnQsZViFLzSLsG0ywrlappX3WtOaKqb9RboVjBGg4K+
 NvpGFdEcE9ewp+wIESbZt9Lg5k+th3a9x6BOCe/HjRkUGZh7Pd3TamyNygV7a0FtlX6F
 LBoCKAR5h+HC4iVaTR6ckBHGzgJbzsM5Td3Q+6FZIo6qh9NPaFCLn5IPVsJ5Fzj4ZUeA
 pYKHQS1KKql0GYfY6HknepiFQSA/A791zN0QHs8oDSf1J6upOceFlvX8SZLLMuWebK9I vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74rx3k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:33:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DAO8Gi119110;
        Mon, 13 Jan 2020 10:33:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xfqu4anym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:33:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DAXSB1001279;
        Mon, 13 Jan 2020 10:33:28 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 02:33:27 -0800
Date:   Mon, 13 Jan 2020 13:33:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dan Murphy <dmurphy@ti.com>
Cc:     kbuild-all@lists.01.org, sebastian.reichel@collabora.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 4/4] power: supply: bq2515x: Introduce the bq2515x
 family
Message-ID: <20200113103320.GA9488@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108202314.11791-5-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130089
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dan,

url:    https://github.com/0day-ci/linux/commits/Dan-Murphy/BQ25150-155-Charger/20200110-055201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/power/supply/bq2515x_charger.c:316 bq2515x_set_ilim_lvl() error: buffer overflow 'bq2515x_ilim_lvl_values' 8 <= 8

Old smatch warnings:
drivers/power/supply/bq2515x_charger.c:320 bq2515x_set_ilim_lvl() error: buffer overflow 'bq2515x_ilim_lvl_values' 8 <= 8
drivers/power/supply/bq2515x_charger.c:322 bq2515x_set_ilim_lvl() error: buffer overflow 'bq2515x_ilim_lvl_values' 8 <= 8

# https://github.com/0day-ci/linux/commit/f5918978695e4e465d54f5c34f356af86874b051
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f5918978695e4e465d54f5c34f356af86874b051
vim +/bq2515x_ilim_lvl_values +316 drivers/power/supply/bq2515x_charger.c

f5918978695e4e Dan Murphy 2020-01-08  311  static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
f5918978695e4e Dan Murphy 2020-01-08  312  {
f5918978695e4e Dan Murphy 2020-01-08  313  	int i;
f5918978695e4e Dan Murphy 2020-01-08  314  
f5918978695e4e Dan Murphy 2020-01-08  315  	for (i = 0; i <= ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Typo.  This should be < ARRAY_SIZE().

f5918978695e4e Dan Murphy 2020-01-08 @316  		if (val == bq2515x_ilim_lvl_values[i])
f5918978695e4e Dan Murphy 2020-01-08  317  			break;
f5918978695e4e Dan Murphy 2020-01-08  318  
f5918978695e4e Dan Murphy 2020-01-08  319  		if (val > bq2515x_ilim_lvl_values[i - 1] &&
f5918978695e4e Dan Murphy 2020-01-08  320  		    val < bq2515x_ilim_lvl_values[i]) {
f5918978695e4e Dan Murphy 2020-01-08  321  			if (val - bq2515x_ilim_lvl_values[i - 1] <
f5918978695e4e Dan Murphy 2020-01-08  322  			    bq2515x_ilim_lvl_values[i] - val) {
f5918978695e4e Dan Murphy 2020-01-08  323  				i = i - 1;
f5918978695e4e Dan Murphy 2020-01-08  324  				break;
f5918978695e4e Dan Murphy 2020-01-08  325  			}
f5918978695e4e Dan Murphy 2020-01-08  326  		}
f5918978695e4e Dan Murphy 2020-01-08  327  	}
f5918978695e4e Dan Murphy 2020-01-08  328  
f5918978695e4e Dan Murphy 2020-01-08  329  	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
f5918978695e4e Dan Murphy 2020-01-08  330  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

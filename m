Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264D0268D4C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgINOTi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 10:19:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgINOSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 10:18:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EEEG9w157815;
        Mon, 14 Sep 2020 14:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=bsxzxxauVuOHcTQxTCVqBJw5rHgiolwtE47OQbVgT34=;
 b=uZvxoH1hFLXW3YZr+4PJFop/qjEQoukA/tu3txJxRlZL5MTySCP8nNnDiM97D8XwVjWH
 APqqN/LRsRZHb7M/mpIXyO+d7GZ8Rz/6dwN0ttp5aba2MtCvM1IL4FflD+nMRPt5nbkA
 Z+yf7+S8q6iG0d9vmOhnczZ+32Iz0JZPWLGeuloZxU3JGBiOZ/F0W/bDPcqkJuPLIald
 xVL2MldZsS53lt3aiv8C9p3iJMwhPGGe9XUYo3hrQ6y+daLmjnSaa/mfso1Y+GcbGBsc
 ShSbo41iRm9Lr/o9D9ZrRHLFBuAnUsVQb7vVotLnQsPWA6BwocRt0axo06I95yWjjPMo Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91d8f5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 14:18:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EEFvOe011616;
        Mon, 14 Sep 2020 14:18:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33h7wm80qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 14:18:04 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08EEI2tm001838;
        Mon, 14 Sep 2020 14:18:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 14:18:01 +0000
Date:   Mon, 14 Sep 2020 17:17:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
Message-ID: <20200914141754.GB18329@kadam>
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140117
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 04:56:26PM +0300, Dmitry Osipenko wrote:
> 14.09.2020 10:09, Chanwoo Choi пишет:
> > Hi,
> > 
> > On 9/8/20 4:25 PM, Dan Carpenter wrote:
> >> This error path needs to call clk_disable_unprepare().
> >>
> >> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >> ---
> >>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> >> index e94a27804c20..dedd39de7367 100644
> >> --- a/drivers/devfreq/tegra30-devfreq.c
> >> +++ b/drivers/devfreq/tegra30-devfreq.c
> >> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
> >>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> >>  	if (rate < 0) {
> >>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> >> -		return rate;
> >> +		err = rate;
> >> +		goto disable_clk;
> >>  	}
> >>  
> >>  	tegra->max_freq = rate / KHZ;
> >> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
> >>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> >>  
> >>  	reset_control_reset(tegra->reset);
> >> +disable_clk:
> >>  	clk_disable_unprepare(tegra->clock);
> > 
> > Is it doesn't need to reset with reset_contrl_reset()?
> 
> Hello, Chanwoo!
> 
> It's reset just before the clk_round_rate() invocation, hence there
> shouldn't be a need to reset it second time.

Ah...  I was looking the wrong code.  Plus I don't really know this code
very well.

If clk_prepare_enable() fails, then I would have assumed we need to call
reset_control_deassert().  I would have assumed the
reset_control_assert() and _deassert() functions were paired.  So what
I'm suggesting is something like the following:  (I'll resend this if
it's correct).

[PATCH] PM / devfreq: tegra30: Add missing reset_control_deassert()

If clk_prepare_enable() fails then probe needs to call the
reset_control_deassert() function.

Fixes: 6234f38016ad ("PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 +
 1 file changed, 1 insertions(+), 0 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e94a27804c20..ce217aba7b9d 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -828,6 +828,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to prepare and enable ACTMON clock\n");
+		reset_control_deassert(tegra->reset);
 		return err;
 	}
 

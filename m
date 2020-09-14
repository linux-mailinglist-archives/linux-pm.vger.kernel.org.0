Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28422268CC2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgINOC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 10:02:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgINOAY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 10:00:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EDxoon031798;
        Mon, 14 Sep 2020 14:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x4gHGC7Duk/cI1wHDTEGzvJCX3l7Q0Ymx16IcLniY94=;
 b=I4ymGcYoyg0CTsKPsVNJkIaadO7jjLKPV73T/z/om8Tx25O6LyxIcLmhA6j5lYAHOlCb
 gw1l0t0SS4Uf/rjpHOF0oE7o7CjsvtLh29mO5rtRuUzUvWg8A4xSh7aYzzmTR1jYHg6Q
 vgltM7pldX9t9kiAvQyubronQ7UfJeQpkUvQDuOh+kbLDQhjlzzRYbXO9iDYNquQqA8L
 cY7tuwcUrXr7jhfWt7e4kFEC91c4KVvQ5AM3TLlVI3c2A4mQ+3XPCoIM0lWWS1WYZuIC
 MwOLKTNTZlep0a9XuvBPAJRDeRXZeOmDWgKfSJfeCg1kgY34kecqXqPxX7D3WiC/P1BF 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqpr47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 14:00:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EDtObg147788;
        Mon, 14 Sep 2020 13:58:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h881j7qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 13:58:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08EDw5MC000594;
        Mon, 14 Sep 2020 13:58:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 13:58:04 +0000
Date:   Mon, 14 Sep 2020 16:57:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
Message-ID: <20200914135757.GA18329@kadam>
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140115
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 04:09:02PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 9/8/20 4:25 PM, Dan Carpenter wrote:
> > This error path needs to call clk_disable_unprepare().
> > 
> > Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> > index e94a27804c20..dedd39de7367 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
> >  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> >  	if (rate < 0) {
> >  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> > -		return rate;
> > +		err = rate;
> > +		goto disable_clk;
> >  	}
> >  
> >  	tegra->max_freq = rate / KHZ;
> > @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
> >  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> >  
> >  	reset_control_reset(tegra->reset);
> > +disable_clk:
> >  	clk_disable_unprepare(tegra->clock);
> 
> Is it doesn't need to reset with reset_contrl_reset()?

Is that a rhetorical question?  I don't know this code very well but
it looks like you are right.

I'll send a v2.

regards,
dan carpenter


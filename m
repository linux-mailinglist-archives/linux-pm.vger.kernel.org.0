Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD66ADC2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfGPRgd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 13:36:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPRgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 13:36:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5C8D60591; Tue, 16 Jul 2019 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563298591;
        bh=flqKaEmSQjxxoHBpu8cQ/orRLe2npA6LtU2nHtNtRwQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=InSyd6mUA5T/6MMXzp9SmTR19V61VKuCg6PR0tlj0dqcnP3Q/be3ywuUiiwowI0I4
         pu/6Uh2yUp1LmZRmlbwibzurLyJodJD6XNGot8aMiCBOhwsBDbYdgBpPMSwJcrkuR/
         iTfKtLj6FlBQkCRUMBU0wThAWDrTjvr+Pja+LQ7k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DCAF6049C;
        Tue, 16 Jul 2019 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563298587;
        bh=flqKaEmSQjxxoHBpu8cQ/orRLe2npA6LtU2nHtNtRwQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vv5VjC8btXcbR+RRKt75OO90/3lHKCdmZdLEMsvpgkhItgVOHNZNZmX884opmM0Bb
         qeBJBCQtAil4E6xmh1PS1sqFRPCIOxtaH5w7iPRYFBkrReKWWiLJ3VekqVpiQjcHUI
         JQXQV3yjWN9yZIKVSiPGgb4+IEcXkFTB6/DOs7sA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DCAF6049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in devfreq
To:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, adharmap@codeaurora.org
References: <20190625213337.157525-1-saravanak@google.com>
 <20190625213337.157525-4-saravanak@google.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <e9c9b150-43a6-dc6b-5d88-21608120e940@codeaurora.org>
Date:   Tue, 16 Jul 2019 23:06:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625213337.157525-4-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

On 6/26/19 3:03 AM, Saravana Kannan wrote:
> The OPP table can be used often in devfreq. Trying to get it each time can
> be expensive, so cache it in the devfreq struct.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/devfreq/devfreq.c | 6 ++++++
>   include/linux/devfreq.h   | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6b6991f0e873..ac62b78dc035 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -597,6 +597,8 @@ static void devfreq_dev_release(struct device *dev)
>   	if (devfreq->profile->exit)
>   		devfreq->profile->exit(devfreq->dev.parent);
>   
> +	if (devfreq->opp_table)
> +		dev_pm_opp_put_opp_table(devfreq->opp_table);
>   	mutex_destroy(&devfreq->lock);
>   	kfree(devfreq);
>   }
> @@ -677,6 +679,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   	devfreq->max_freq = devfreq->scaling_max_freq;
>   
>   	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (IS_ERR(devfreq->opp_table))
> +		devfreq->opp_table = NULL;
> +
>   	atomic_set(&devfreq->suspend_count, 0);
>   
>   	dev_set_name(&devfreq->dev, "devfreq%d",
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74bfc1b..0d877c9513d7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -156,6 +156,7 @@ struct devfreq {
>   	struct devfreq_dev_profile *profile;
>   	const struct devfreq_governor *governor;
>   	char governor_name[DEVFREQ_NAME_LEN];
> +	struct opp_table *opp_table;

please add it to the function docs as well

>   	struct notifier_block nb;
>   	struct delayed_work work;
>   
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

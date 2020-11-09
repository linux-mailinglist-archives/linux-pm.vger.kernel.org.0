Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143802AB362
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgKIJRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 04:17:45 -0500
Received: from foss.arm.com ([217.140.110.172]:35880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJRo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 04:17:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 425E91042;
        Mon,  9 Nov 2020 01:17:44 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ED713F718;
        Mon,  9 Nov 2020 01:17:42 -0800 (PST)
Subject: Re: [PATCH 6/7] drm/panfrost: dev_pm_opp_put_*() accepts NULL
 argument
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1604646059.git.viresh.kumar@linaro.org>
 <43be6d118201f9feb70fb030390fddce0852ab0b.1604646059.git.viresh.kumar@linaro.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8f59b818-306e-05e2-3a0a-8351098b1bbb@arm.com>
Date:   Mon, 9 Nov 2020 09:17:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <43be6d118201f9feb70fb030390fddce0852ab0b.1604646059.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/11/2020 07:03, Viresh Kumar wrote:
> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
> there is no need for us to carry the extra check. Drop them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 8ab025d0035f..97b5abc7c188 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -170,10 +170,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   		pfdevfreq->opp_of_table_added = false;
>   	}
>   
> -	if (pfdevfreq->regulators_opp_table) {
> -		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
> -		pfdevfreq->regulators_opp_table = NULL;
> -	}
> +	dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
> +	pfdevfreq->regulators_opp_table = NULL;
>   }
>   
>   void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> 


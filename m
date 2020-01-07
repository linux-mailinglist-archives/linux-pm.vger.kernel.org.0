Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86241320DA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAGIBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 03:01:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGIBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 03:01:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so28101199pgb.13
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1umg53pWWYl/6QRnWmVkxLsY3gucZgYzRZz/LWAqWXY=;
        b=BlBCC1hiGJuDUOHYeGFUhTU+3bqykxr60JA6uoCkj+4HY3eTrNi4NvoLxplc/UKcqU
         ped4ttm0ekXaCxOUhJMVJvGhGpZoLmklcLuq3MK9lBeUaal74NLtlj5AIxWKbC98uUKX
         1hnFr8c8mZISKLpHrBY99PcmiscsjGLsjM2sgayj15VZdXSfqrzTvE3RTdXvurGoB7OS
         lfGcZKxmJC1dT5gWFdALnMOiqK8vNi1FNLQsc8zNqaeAzYmVmCOW1rnQ88xcK5AWJeGd
         Cglhy5Il1zp9ZQID4qS8cO7jxEN8f7BesDZn378gxeH+aD37tsUB0NEBbuu091ko3yAH
         U4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1umg53pWWYl/6QRnWmVkxLsY3gucZgYzRZz/LWAqWXY=;
        b=AU36QoxWZEmRkBI7B7n5GZoZTiHpkksZLBW+lrXcu7F2WNJkgO5nVbFx9JM2dEVYCi
         6n9SmzlZhpwIDP8KBcM7Bj0CaEwVB7TV9/q9ofWB/6DTRdTpBwRLttXjQ6/Hb5q70FO4
         cm1ALBPfYNs1/6qX9TrJADoZw0nOxY15IaUI/qvS4sneX3cbNX+NPJgQarqCIUwUUhtp
         qyeFdT7C4LFz57bxkOVuZVEQJUyelo+rFl2GQbHGIMdn+R4fpQFfefEgjqPqH5JVAV5v
         qnRtDi2Gi0jqDuKPjuQndmaITCRpOZJMGcjO3R5mLUnYqbhF66kSoN7fG0X8p2Bc1yLs
         LWBA==
X-Gm-Message-State: APjAAAXuHMMBaRntxBiWyeBH4mLOUyW0sgxK6paxmER2eU0H/ePOKgJn
        vPoRcIdBH8NobNnYkMbCbE/sIg==
X-Google-Smtp-Source: APXvYqxVE2VEnVPb0aAGxiZJ/oIQEyVvSKjAKPvgVOOZNl4CcAjr60FWxaJEKvnLnoSswGARFg69Rg==
X-Received: by 2002:a63:5924:: with SMTP id n36mr115765526pgb.43.1578384112408;
        Tue, 07 Jan 2020 00:01:52 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id w11sm79495860pfn.4.2020.01.07.00.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 00:01:51 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:31:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: s3c: fix unbalances of cpufreq policy
 refcount
Message-ID: <20200107080145.7c4gxilnjjxjfqpc@vireshk-i7>
References: <1578383599-11207-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578383599-11207-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-01-20, 15:53, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> The cpufreq_reboot_notifier_evt() call cpufreq_cpu_get() to get the
> cpufreq policy of cpu0, meanwhile, it also increments the kobject
> reference count to mark it busy. However, a corresponding call of
> cpufreq_cpu_put() is ignored to decrement the kobject reference count
> back, which may lead to a potential stuck risk that the cpuhp thread
> deadly waits for dropping of kobject refcount when cpufreq policy free.
> 
> With this patch, the cpuhp thread can be easily exercised by attempting
> to force an unbind of the CPUfreq driver.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
> changes in v3:
>  - Rewrite title and commit message.
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c | 12 +++++++++++-
>  drivers/cpufreq/s5pv210-cpufreq.c | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

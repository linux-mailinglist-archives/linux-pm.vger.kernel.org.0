Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2913B0CFE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFVSi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 14:38:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D813C06175F
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:36:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so2793996pjn.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1QBBjNwfaVF7Ipv8w2OJCC7fG5ClgOQKcBvL6eDfXh0=;
        b=VB80WzIPcsnlE/p80VwR7GhK75UuVyxl6Z10E8bIr5+Zj8FAuyYJVBbzQHj18JA6j5
         wjbzKFHzUdOIqFj6de6wrsN088tkxcObzTm4nVblt6ZevDERjteoXFtA8pT73/YT/YPI
         XDds1Fe5JkOqys6xm/k3RjN0koZ6TfYY6aaRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1QBBjNwfaVF7Ipv8w2OJCC7fG5ClgOQKcBvL6eDfXh0=;
        b=PoNr88VNh5Figc21qKeW/bYT/VM+TJ27xWXH6alXMxGm4TWXN1ctm1HlDU4leYlfFm
         zfkACPxmIpy/LGtIVm0XhFcpfZFXeLR3qvH1GqouVlNh1OECJqX7tspxGk2QyKKey2ez
         naRyA0FejsBzjCeoi4fMnCh8JW2APa/yq2a8BrabIhqQC0c+0E2RPIlmcHpXFHU1aMAn
         8U8cTW0cMK+yiSzP9G/s1AP6xmy7CVF+Hq2RIjl4IwGMpkW2RnrSdHonz8ceMlxqI2nH
         NO0i5sL6VlSsbNp5bAV5ihEiTNxp5yZ7+pjRxWIqGdAm2Xer9pHs55D8flSu6s3SYzMb
         Sg7Q==
X-Gm-Message-State: AOAM531VEjcQIP37ya/65VEbTDKwDbucZ4e+2dKxcK6QloHkZ0WSRQOS
        2nPopPxqEvgUw0Wf9HbE4F+dpw==
X-Google-Smtp-Source: ABdhPJwkAc7+XdjK4uZl3VgfQY0ZstQsryDfYmOBg3QcvzwALmDWfeOR89rDVldL8j8Z5YoqDtx5sw==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr23989245plk.62.1624387002615;
        Tue, 22 Jun 2021 11:36:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dc21:8b6f:f8cd:9070])
        by smtp.gmail.com with UTF8SMTPSA id l201sm53483pfd.183.2021.06.22.11.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:36:42 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:36:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, cwchoi00@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 3/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Message-ID: <YNItuDsinxDCVDGa@google.com>
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae@epcas1p4.samsung.com>
 <20210617060546.26933-4-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617060546.26933-4-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 03:05:45PM +0900, Chanwoo Choi wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure that the
> cache is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
> 
> To achieve this, this patch adds support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjust the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> * Derives the optimal devfreq device opp from required-opps property of
>   the parent cpu opp_table.
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [Chanwoo: Fix conflict with latest code and clean code up]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor.h         |  22 +++
>  drivers/devfreq/governor_passive.c | 264 ++++++++++++++++++++++++++++-
>  include/linux/devfreq.h            |  16 +-
>  3 files changed, 293 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 9a9495f94ac6..3c36c92c89a9 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -47,6 +47,28 @@
>  #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
>  #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
>  
> +/**
> + * struct devfreq_cpu_data - Hold the per-cpu data
> + * @dev:	reference to cpu device.
> + * @first_cpu:	the cpumask of the first cpu of a policy.
> + * @opp_table:	reference to cpu opp table.
> + * @cur_freq:	the current frequency of the cpu.
> + * @min_freq:	the min frequency of the cpu.
> + * @max_freq:	the max frequency of the cpu.
> + *
> + * This structure stores the required cpu_data of a cpu.
> + * This is auto-populated by the governor.
> + */
> +struct devfreq_cpu_data {
> +	struct device *dev;
> +	unsigned int first_cpu;
> +
> +	struct opp_table *opp_table;
> +	unsigned int cur_freq;
> +	unsigned int min_freq;
> +	unsigned int max_freq;
> +};
> +
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:		list node - contains registered devfreq governors
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index fc09324a03e0..07e864509b7e 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -8,11 +8,84 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
>  #include "governor.h"
>  
> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +#define HZ_PER_KHZ	1000
> +
> +static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
> +						struct opp_table *p_opp_table,
> +						struct opp_table *opp_table,
> +						unsigned long freq)
> +{

s/get_taget_freq_by_required_opp/get_target_freq_by_required_opp/

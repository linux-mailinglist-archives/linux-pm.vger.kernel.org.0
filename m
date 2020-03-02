Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C0175298
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 05:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCBETh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 23:19:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36947 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCBETh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 23:19:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so4760190pgl.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHBK3/rKn+LVN6MYF4Du3i4K2LjtQ7eKL0BsrScrxdY=;
        b=d7/Qsko0GvwfGJb8ZsXpoGwF4rLMogSWMCfssVO7mz/dNvAwHn/isV+n87qCFFmbOv
         5zjVJd8s8wTvzQuK/rSEXqdU7n80xgKmPi+YT/pi6b1nRslw9JCLYyEeex4hei2hqpZo
         n8IhdQ4UE13WUvK0oiJaVpkoTqF0ZeOpeFgwoUoJ0rdFRBI2ROI1V/riSgt+SoknniUG
         oU74Yzahxa4Zjlorq1Kj4Atgho4PDTJSYAoV83Dc7sxa8T3EPZoEX2sRIf/JlrFhm6Wo
         XbASG8ErPAaNqYZbbvREyHbQyxN/d5ir00tcBlEylWqYtxDW2w1GK+ZAT+ppZyfIcTfd
         d46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHBK3/rKn+LVN6MYF4Du3i4K2LjtQ7eKL0BsrScrxdY=;
        b=ObYpMRt/hWp5OBxbjJ0KMDIE7PDdNtp7Op56598OckY0Enfz41qTF3su2D9cfp6w0Q
         ui7PD5Pnpp3QO/Vx6xY6Kpg9RP92Djpe4dWELwbfIQ9PmnuHtf86i+F0KzMlUZDsxu0F
         AXKFy+hytAMFHRSQqc9f7Rhwa2ZydIVfQ+rDwtgV7eh9MR/YgIp0CdvYIDCJFL3Vo+d7
         SRHd7lP952mO4C3WRZit1LV7xWpKeO/u0NSLt4CvigN9PLNY5qbSUJxm9M4Tw/witaza
         8LSX5iIeA8uaofU/Ee+AFUGft1bop1RTALhAJ+r/Vp0Fd1zDpaBMVaAatDdeqkWsv/E3
         cl1Q==
X-Gm-Message-State: APjAAAW4x3Sdff5SAt/4F0beAyh4Sh+6gX+CKkurGWnwpZzepxOczqpp
        EVCxFbZNt7TiGRxe53zZu2NeTw==
X-Google-Smtp-Source: APXvYqymLyln6a38K5aMXFA9lXxZgKiZg4FWlryrDmM9cXV42wpxdOAYp3guF6wE7YivyJTj7tRdBw==
X-Received: by 2002:a63:c546:: with SMTP id g6mr16910592pgd.243.1583122776505;
        Sun, 01 Mar 2020 20:19:36 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id z13sm18823624pge.29.2020.03.01.20.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 20:19:35 -0800 (PST)
Date:   Mon, 2 Mar 2020 09:49:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
Message-ID: <20200302041933.uuoa5kbvgtde37oq@vireshk-i7>
References: <20200228144529.14548-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228144529.14548-1-t-kristo@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-02-20, 16:45, Tero Kristo wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
> support for this OPP in ti-cpufreq driver.
> 
> Acked-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 557cb513bf7f..d62b6b21325a 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -25,11 +25,14 @@
>  
>  #define DRA7_EFUSE_HAS_OD_MPU_OPP		11
>  #define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
> +#define DRA76_EFUSE_HAS_PLUS_MPU_OPP		18
>  #define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
> +#define DRA76_EFUSE_HAS_ALL_MPU_OPP		24
>  
>  #define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
>  #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
>  #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
> +#define DRA76_EFUSE_PLUS_MPU_OPP		BIT(3)
>  
>  #define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
>  #define OMAP3_CONTROL_IDCODE			0x4830A204
> @@ -80,6 +83,9 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	 */
>  
>  	switch (efuse) {
> +	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
> +	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
> +		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
>  	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
>  	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
>  		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;

This is already merged, why sending it again ?

-- 
viresh

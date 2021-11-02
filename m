Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9867442629
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKBDvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 23:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhKBDu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 23:50:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5431CC061714
        for <linux-pm@vger.kernel.org>; Mon,  1 Nov 2021 20:48:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so18931316pgc.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Nov 2021 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HL76J82mhEsYvpFLZR8zFqvMaADrPeiRze7TCUFwrMo=;
        b=IlI4UvrybrLWCM3Xa0O3S+Da0h0dCpoGRy/Bg1I/j8LcyR2g/nsY22hk0MXw0DEEAd
         pKb0NVDNg06K0zSKHGpLZexbw0tvAjkqDdhdAo5dbLOW0TLTuVR7E+qE/AGX40h5fOPd
         RYYUgsOxYviGtTGEPqv8xB25y1XqrgCTwLuVSvDlY7OceUf8GwZcW2hCPe2QQZVW9P9Z
         sMZa/LaR3dQFPQoQ1AFVPPY4MiEKIQyJWTJxna6nSjlYsQDtq96kLy70FBwR+xN0NAoz
         JXGXAGtKtAjgKIRVhPiNxnLGggGZ5ub3Ome7tzwVtaA72jz77cwu5HDCk8BW9iL7EN2n
         CwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HL76J82mhEsYvpFLZR8zFqvMaADrPeiRze7TCUFwrMo=;
        b=5t9NS4i4VU5mhcKJS0/u/37cmLWZ+ZudX3nBG1xnz6K802LYymy7RUPJk/ZnkJ/x05
         g2tYz3QBl/9JLQB7V5Kuk/vofBzU6N7nWnUP6aQVhgsjYyc0hc6X5EMPXln500hxclI8
         YMcR3ypfYAOwdCItlf30s+js9mWPlEMo58JaCtpqZfFP0buqG+GwyLJKZCjIX7lnDV7m
         SJcPY2OCshCcnzFF1r2c9/iQvMkHcaTaWWXGy5z+yPpt34cUwEZ6lFq7fyaa+fFnIh9Q
         M6uE/gyFGiGy5ZohtnBZp/PQNydKmqlsDmDdQLqi94ajq3NpM9vrPh6JS94rK3iMCM2V
         u9sg==
X-Gm-Message-State: AOAM532RybMvdSJvxlh4+renqJ5qlbLe0huIuyAqZ5HaWCiVvPjVo6oW
        GQ5Q0fZozN2z5MYJrASYd7jMzg==
X-Google-Smtp-Source: ABdhPJy52XEJHvzjoewrnya/QJ4mP74UN137kw4m4/t3XFFBGOH861VeugtexrGN0aCtmM3r1MSN2w==
X-Received: by 2002:a63:9844:: with SMTP id l4mr25617862pgo.271.1635824904845;
        Mon, 01 Nov 2021 20:48:24 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id l4sm18602015pfc.121.2021.11.01.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:48:24 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:18:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Fix double devm_remap in
 hotplug case
Message-ID: <20211102034822.diil2tgggpppf4ma@vireshk-i7>
References: <1635507743-17919-1-git-send-email-hector.yuan@mediatek.com>
 <1635507743-17919-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635507743-17919-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-21, 19:42, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> When hotpluging policy cpu, cpu policy init will be called multiple times.
> Unplug CPU7 -> CPU6 -> CPU5 -> CPU4, then plug CPU4 again.
> In this case, devm_remap will double remap and resource allocate fail.
> So replace devm_remap to ioremap and release resources in cpu policy exit.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 0cf18dd..25317d7 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -36,6 +36,8 @@ enum {
>  struct mtk_cpufreq_data {
>  	struct cpufreq_frequency_table *table;
>  	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	struct resource *res;
> +	void __iomem *base;
>  	int nr_opp;
>  };
>  
> @@ -156,6 +158,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,

pdev specific initializations shouldn't be done from policy->init(),
but instead do those only once from mtk_cpufreq_hw_driver_probe().

That way such bugs won't occur again.

-- 
viresh

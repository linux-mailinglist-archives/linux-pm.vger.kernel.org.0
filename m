Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535D229DAE8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJ1Xil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390567AbgJ1Xhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:37:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C0C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:37:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y14so751060pfp.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HOLVJZragnogI83AL7H7xsw1FRW50J26vaXwlw6VSvU=;
        b=wAW/Rjf4En10sBEiY4jdkSvsj0xci8ukot36BnsZw/HtdrZJfLGQq3I/1tEqnlGtLy
         YCjdYHuEa9i/IDF7Wh1+XVhCwxwMr4sMHTL5yMsgzJV+0eDJ6pWYVLH20Yr5xX4AlLzM
         bClcW1MTKolJaQ15A2uPD9zA2SJo+dG7lB3+SMeX3F/l0Aephv7jEf7L+ghfWCyAgEWI
         Kt3GqycLa+0BxJIcTG8ZYvJEOZpjhuqWLzKLlLhkTbSrXOjX/XIy1Nhb8RiVDSYx2den
         CqKsxAZeGekYMWnCfZjR6DX6i7h0xzalwXjYfOkdKBrkTvlvWF3D/IjW4ENfA1t9JpcY
         Yctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOLVJZragnogI83AL7H7xsw1FRW50J26vaXwlw6VSvU=;
        b=KwuKrI+Vhrp113II7lRCPvlHxsA2j3PQQMqNFAVMAZv8KDhNUG4QD88EILmRlbCi/q
         LNCduY6GDB49ExG7G4nASsiIFQIAbyAS0wOWTE11dVYg7/S+8Tw33hIZd4KK36u4cjTo
         0/k9uYFLApUPb/GVCVi4e7q0iDot/46529CeQmx/qx0TU6xuyIQEAtZlywctPnFzZ5Iy
         Hu0qc4GZKhA1HpoH2NhcQgJv0aEPEN402bKal+xX9WK8lU5U755fxajgKk4EQ2ppa5+L
         oLOnjsF0lDU2nunPCemep2fAEFqW6W8EovGEasVfbKf+5nNGeWYKpRkNTlgqQcpC+NV9
         29gw==
X-Gm-Message-State: AOAM5335ZS5iZsu2iebZAODbuA5gK7+8HSFxdX78wdbQ0dNSY8EQHH0e
        A9h09sF/A30T67n25Kli0UWU3vYQxWKMvQ==
X-Google-Smtp-Source: ABdhPJx2eljw7UcU0BCI0KQNkHipnmVzz2C1K9PAWVmK+t/4Y9zrp3nrvO1yv7RFXzMNRpax0Rcj1A==
X-Received: by 2002:a63:4086:: with SMTP id n128mr4829611pga.387.1603865325897;
        Tue, 27 Oct 2020 23:08:45 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ge6sm3868281pjb.29.2020.10.27.23.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:08:45 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:38:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add support for mt8167
Message-ID: <20201028060843.wlfjuyk5nnou7pfb@vireshk-i7>
References: <20201013092709.3336709-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013092709.3336709-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-10-20, 11:27, Fabien Parent wrote:
> Add compatible string for mediatek mt8167
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 7d01df7bfa6c..b8d48ed37156 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt2712", },
>  	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
> +	{ .compatible = "mediatek,mt8167", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 7d1212c9b7c8..c09bff86bb9b 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -532,6 +532,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt2712", },
>  	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
> +	{ .compatible = "mediatek,mt8167", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },

Applied. Thanks.

-- 
viresh

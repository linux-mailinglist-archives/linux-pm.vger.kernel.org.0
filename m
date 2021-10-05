Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7320F421D32
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 06:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhJEEXY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 00:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhJEEXX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 00:23:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD1AC061749
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 21:21:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a73so15644624pge.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 21:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XYDK2OrMAt5LQifO3ckjgLogx91TVAqE/NRbe8lTiQ=;
        b=OTAbVKDf+Y5TJO2+i6nYPeY7DmH4WHagakuuacBBKky/xgnsEYkv/LFLRKp2COqYK3
         HpkL9pE/qVkT+PwDnmR/JM79VN/scw7j+BmjqjKLaKz/kaBajfo8Za+QZyewmGke/tFu
         Ciis62LC9esLcwoQzZzfai94lRDyFuWeOKZ7LYn2U7U4vbHyMwgrFJrpYoeucOtQhVVd
         Nb4ZxCfEKIMcpG4HPQ2/2gox7Wlm0F+j+BDkIOnFiuTv7qYqNWsvdhFtMKXpOeER9jCj
         FN4Eup/Y8niobob0RrwRPTYrk6Oe8EW2PM1jDelUgkKzpaux/pevszCtQANfHi42gcMV
         6/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XYDK2OrMAt5LQifO3ckjgLogx91TVAqE/NRbe8lTiQ=;
        b=WzZ4cz1m+gN0NGcmyeUABf55Oc3jysCMTz3rbJfUNyBSrT7bcuqHo8alxXRja3yydB
         RBfmsmWqwcpECCe2yTBf4evuBbIGkQultx4LsOm1c3tfemb8ugtBpDdkVWGqpN9AwBtU
         oOZuJhiwVJjLgNau04Kzolbj3s0uS8Nc0zNjqdIHUT++23K0TdV07M9Sym3bGLEMGGpJ
         9qlcNgkBSiAF7HWREwBLR3NQLaTGLedCeD7ul7c+IMRHOyIku4ouyDO+XCaIPELeb6kP
         qaX9u2gB4LuHfVe6oadnxGDpbpBl3WUQI9gMf9eEJWO+2UezsDVN/uFtttWxcQ0+Ochh
         Urmg==
X-Gm-Message-State: AOAM533Yg3CaIV+xwN611EtksMtOIXgwjsWA3XAmOTxBxZndPG7rAlLd
        bEevWYTRXfAczRcpGPFsnWjVNg==
X-Google-Smtp-Source: ABdhPJxIDkexXupjkm7UaofuJsbybc7Bj6eXwQj/5/OMNDUKaVWNtmseeaTTDNbzm6h65LNitJJVyg==
X-Received: by 2002:a63:d456:: with SMTP id i22mr13954080pgj.421.1633407693629;
        Mon, 04 Oct 2021 21:21:33 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id g23sm16313352pfu.71.2021.10.04.21.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:21:32 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:51:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq:Fix parameter in parse_perf_domain
Message-ID: <20211005042128.o47qximtibgak33q@vireshk-i7>
References: <1633358553-2842-1-git-send-email-hector.yuan@mediatek.com>
 <1633358553-2842-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633358553-2842-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-10-21, 22:42, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Should pass per-cpu id to map perf_domain for related_cpus
> rather than map policy_cpu several times.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  include/linux/cpufreq.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ff88bb3..66a1f49 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1041,7 +1041,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  		if (cpu == pcpu)
>  			continue;
>  
> -		ret = parse_perf_domain(pcpu, list_name, cell_name);
> +		ret = parse_perf_domain(cpu, list_name, cell_name);
>  		if (ret < 0)
>  			continue;

Applied. Thanks.

-- 
viresh

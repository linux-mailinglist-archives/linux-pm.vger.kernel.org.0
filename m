Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2E21E684
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 05:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGNDsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 23:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGNDsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 23:48:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B329C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 20:48:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so6458418plk.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EsBq089GZDoIsvZsbiScToJsxprKvs/96JCOecXXXpQ=;
        b=uJcRAIpO/eks3FbmlqRMbW3QTtdRhagCtBBH/OPRFzO+cItithAHhWdexOdJ0Qd4PJ
         /2Cb47Eiz6ndS7Pq12thMyP16KBwyvGmNOR0aXL4HkMoYjwI5Gdvxclz02dpsz5+be3e
         RDYvNtm5JmHU3p6Jq2ji4NCzRuWwhF9g2Wjr43rZoQNFT73EI8NKtaRRODCtcMXRaQ4U
         W0WiiM7dXislDwe3VkYVgNYylgwa/KBKaQJqZAjlH23E5tQhzRNLXsvV+gyxSNclygYD
         OqX55Quq6wpD0uq2nuLV01i4AyXuFwkU0wrOfSBIQ3IkeeojSYD8GlbGaLtpFT5Tfb8/
         3+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EsBq089GZDoIsvZsbiScToJsxprKvs/96JCOecXXXpQ=;
        b=M6tKKf/yZXbreWRPS/bT2oSGQO4HXUZrWQ6Kt3iA8r5y1VUscmbXuK1ovlsM6pjZbo
         GnTSR/lPkGMCgGlfVMlO1RZttKQMwSJ6BuiNoDs2Fp16oJ5THOTfUu+ommqfCTX4R3OY
         LFn4u4gO8S1WHcUNwI573coFE/majv6uJWb1Y/zcjjTleuGpVYq422WJslV84E4STjvy
         53xAVUmE4Vcqg/DQBSyABj8hZFEk9DUempK59f/O/0sBA7xxiRsGp8+OOs27gQ1HA1w1
         +USWoouqLSwcmJCwW4DzjbwUdiBkW11w2FVk0lbvLvCo/ePX3XoWs/51eGT5xA198Rkw
         x9sQ==
X-Gm-Message-State: AOAM530lQfbxCMtLQELEyiyxlImDxNyS2dD7IKTx3QMShdkHBMNAMSQv
        wR8EJ15tOhI+7SfLbH0QSQLiBnO6evc=
X-Google-Smtp-Source: ABdhPJzRBT5ZmUusJ1D4/9YXERxeJndlFfagLYukjSBjqjbkA64+3k6R2Ucrsr5Y2e6mTn3WY83raA==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr2436607pjb.44.1594698484589;
        Mon, 13 Jul 2020 20:48:04 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id i184sm15489021pfc.73.2020.07.13.20.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 20:48:03 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:18:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: ti-opp-supply: Replace HTTP links with HTTPS ones
Message-ID: <20200714034802.jq2y5km4qentpehe@vireshk-i7>
References: <20200713180516.36746-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713180516.36746-1-grandmaster@al2klimov.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-07-20, 20:05, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index e3357e91decb..bd4771f388ab 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
>   *	Nishanth Menon <nm@ti.com>
>   *	Dave Gerlach <d-gerlach@ti.com>
>   *

Applied. Thanks.

-- 
viresh

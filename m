Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355376A4A6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGaXRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGaXRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 19:17:05 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B81728
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 16:17:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca5d6dcedso1135493a34.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690845419; x=1691450219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8ua9oJZuaplLKApOoOkZO4imSzRRPEkrxgh9MzX6eQ=;
        b=MRoUyK3tDM70iZUtX070fFz+firyj2lfTJ1XnXANIO+ivnv8m8bTICXQgqrH8gx49f
         526lqY3qDTC6OXQpTVm6V9nlEyOnznV/7rw5cWJCQdvnqQtJnECaLtFS2qKcrZrj3pRZ
         K2wPcUMxIn2jEisqWgZuO7jL+1dK69RjZY2jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845419; x=1691450219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8ua9oJZuaplLKApOoOkZO4imSzRRPEkrxgh9MzX6eQ=;
        b=Ox8y9gAh9kOHs0rDdoRWEMyBcQrWmdcVJKKWzYSx0dkayVhcahlryjF76nz3N6HsNz
         FQ/HvHTj+ikQVNIu/SKDDNxjkrsmOhZ20JkZbqnV9jjXyj8UK/00U0pGO1WyBWT4QBSq
         33UWmne0iS2c2WW1sNvv226L0YMiSHq7OSMpf2o4v9Dbpe/lWJJLdPwBS9HoPOgVdpIv
         suVPQqzvHC7EC9MsvKppqWAB1R+C1BJXxkN8V5G942v9CJxet87iB+DmP6R4IfwwOhUb
         jtYrixe7AQVYK9izSvDHuJ/moe6g5MAfsDaqcwKtpnFScRzZ5/BS68+gCeWHwfdBQept
         +9+g==
X-Gm-Message-State: ABy/qLZIv5J/5aDF3pStE81wPtD8J+D1Od6tHUzN/zo6oapN4l543BDh
        HjBRuCtf4pI8d/S2iMNaCW/TomZwDX/RSdVk0WY=
X-Google-Smtp-Source: APBJJlHW6hb0A5gM3w1lWC0L6AnstuIDB765N0cHvSxfZb4GZ25ntHbzjG+bjp5400aNwHH7nIm3BQ==
X-Received: by 2002:a54:4390:0:b0:3a7:2d21:2916 with SMTP id u16-20020a544390000000b003a72d212916mr4865294oiv.9.1690845419333;
        Mon, 31 Jul 2023 16:16:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c29-20020a63725d000000b005348af1b84csm8663037pgn.74.2023.07.31.16.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:16:58 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:16:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Message-ID: <202307311610.B1EB796684@keescook>
References: <ZMgiiEmBORZRaobc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgiiEmBORZRaobc@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 31, 2023 at 03:07:20PM -0600, Gustavo A. R. Silva wrote:
> Update the iteration conditions in the for() loop to avoid writing in
> array `table` beyond its allocated size at:
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c:
> 449         table[i].frequency = CPUFREQ_TABLE_END;
> 
> This fixes the following -Warray-bounds warning seen after building
> ARM with multi_v7_defconfig (GCC 13):
> In function 'brcm_avs_get_freq_table',
>     inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
> drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
>   449 |         table[i].frequency = CPUFREQ_TABLE_END;

#define AVS_PSTATE_P0           0x0
#define AVS_PSTATE_P1           0x1
#define AVS_PSTATE_P2           0x2
#define AVS_PSTATE_P3           0x3
#define AVS_PSTATE_P4           0x4
#define AVS_PSTATE_MAX          AVS_PSTATE_P4

        table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
                             GFP_KERNEL);
	...
        for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
		...
	}
        table[i].frequency = CPUFREQ_TABLE_END;

I see "AVS_PSTATE_MAX + 1" being used for the allocation, and so the
loop is likely correctly doing P0 through P4. If there is supposed to be
a terminating element in the table, I think the correct fix would be to
allocate an additional element, not stop the loop from processing P4.

> [...]
> -	for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
> +	for (i = AVS_PSTATE_P0; i < AVS_PSTATE_MAX; i++) {
>  		ret = brcm_avs_set_pstate(priv, i);
>  		if (ret)
>  			return ERR_PTR(ret);

-Kees

-- 
Kees Cook

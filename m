Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F334CEF8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2L3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhC2L3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 07:29:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5237C061574;
        Mon, 29 Mar 2021 04:29:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so6487853wmj.2;
        Mon, 29 Mar 2021 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B4UbXj840h4a71/q2at4GMy9N6Sb2gByhZKiwU4vJrY=;
        b=vH6Jk2ErhRmQrT8JMSNBb3j8ljVgY0/xJ5pSRb8OkKWdN7V8Fb/uQ6ezV/2eriBi0S
         +XKgxqRkg/XIHcyMOg8OIThPyhC3X72qZ9LcZ2dn6QIthICoN4qMggesQFWxEdxL9EMr
         ZHqLQRdhOFn8+INmmFZ4vYqtYHw4lq2DtiuCSWE6YFEMJI2js8vVYdV2OFX+lRTQX+1z
         bL690l+yTWTOOUuV2xvaLLYbe7a8+KblJqL6/wtzaDkyaK6+sNUe6cOfR0ng9E8GjU2T
         MS/V3CIT9SwlnA/clttGsasiWGgWLwTeua2qNoWcM+EWiMYDgxrCq6vgwIUbGD7L9nJf
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B4UbXj840h4a71/q2at4GMy9N6Sb2gByhZKiwU4vJrY=;
        b=OalLnwTYnDhc//P9aRSjnqrTeXGLozHobBoafy/sWoCsfZ10w4GRjmsfX6O5166/1Z
         +y5UUU2axQKwSiYuqtQqmZaYkeFXGQDbzegAExU7AiIFBdzTWxiupJnhyX8hhvUA4CXX
         gfvQ+K6dS6SCjD+EsJb5vDNgyF/Rpj40J+Ui5r32WBZXnPABnU/OSXpN1DIyWm2BVATa
         WPybXpbBl5G7nbD0Q7J/YgD8lTZgKg8MbzmnT5IGu6ZqVvVvEXblXHwJwGBTBC58XFdw
         8L8GZniPUWPi9GfzGQz/I481KrXEUG/4ZbUZCkywjxL4ks1RbB7iKNVOvl/GwavaVzSN
         3Sgg==
X-Gm-Message-State: AOAM530QLyyWoe/fH1FM+JKEHo8esLzzX/2F/YC9A+eIh/5vhRDUNMUH
        bK3o8c3v7Qq6jZAAeuhPFNo=
X-Google-Smtp-Source: ABdhPJwh1CpNaMjP9xoCHDNi8l5BEedqRd9AdlvpPDnD5cmQsxeJJFyojmhA1GZ5Ktlc90ch/G+1lw==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr24768425wml.55.1617017358485;
        Mon, 29 Mar 2021 04:29:18 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id k24sm24211189wmr.48.2021.03.29.04.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:29:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] clk: mediatek: remove deprecated CLK_INFRA_CA57SEL
 for MT8173 SoC
To:     Seiya Wang <seiya.wang@mediatek.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <20210326031227.2357-1-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1c54a2f1-64e8-0fa5-e2e3-55c367332626@gmail.com>
Date:   Mon, 29 Mar 2021 13:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326031227.2357-1-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2021 04:12, Seiya Wang wrote:
> Remove CLK_INFRA_CA57SEL for MT8173 since it's no longer used.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  include/dt-bindings/clock/mt8173-clk.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> index 3acebe937bfc..3d00c98b9654 100644
> --- a/include/dt-bindings/clock/mt8173-clk.h
> +++ b/include/dt-bindings/clock/mt8173-clk.h
> @@ -186,7 +186,6 @@
>  #define CLK_INFRA_PMICWRAP		11
>  #define CLK_INFRA_CLK_13M		12
>  #define CLK_INFRA_CA53SEL               13
> -#define CLK_INFRA_CA57SEL               14 /* Deprecated. Don't use it. */
>  #define CLK_INFRA_CA72SEL               14
>  #define CLK_INFRA_NR_CLK                15
>  
> 

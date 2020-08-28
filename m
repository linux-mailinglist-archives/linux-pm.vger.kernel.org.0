Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928CE25556E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH1HiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1HiE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 03:38:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EDC061264;
        Fri, 28 Aug 2020 00:38:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f26so227712ljc.8;
        Fri, 28 Aug 2020 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMnnx9UgKJlPAys3nN74UUky5VP624uCT521MPgtXds=;
        b=Kfy9bGLN/THrCEeDmaNxKGDbD4hZsShRhyR6OCuRPNsaRzSeb6wxRqomft6f9dk0vt
         2UwmmejDrWyfrZrkIhH3BGBCB3Jk6W5wJ+SYi2Z/FF0p36YhmxIoMsyzLJ6iDEArLO93
         Q07R6CWuqrHrDdr4EzsIaQGfbF63Wz9zs4CHyH/1S2c/N+j3LcLaD+m3UZ8yzap3eC81
         DCm56g2RSAfXK9bm+spPmYxEiIw+TXNgNiO3TUntelSBTWSBN2vgIxdLsFDuTzGX/81l
         Ax+3KaqsashQJppfEYfPKluwmSbV6Nd8HniO0AEihaWP0z3T9GczDGBCbAKqmN6KShGV
         tg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMnnx9UgKJlPAys3nN74UUky5VP624uCT521MPgtXds=;
        b=qzL371/4iRUDGbQV2d1wt87abmKAQkZ+2cPxaywZty1yKQ3Qy6X+H/NMlFCts0q8zj
         3z8dBrQQq2igv2BL474eKY0w5DaplOd02Fpc4HGZUTMDNBP+6dOyaNK1Ju+z6q19Fax/
         7dJ2/xKru34wkpjjlaRD3Hu9osEloxA+QuiTrsSnQJi1UXIyZYb0OokPt4yMrjNXzwcu
         jq+lhdTf5GX9nOCNOCK+WLKyQ6q52dMKJ23CmntkxpqkdQiY/SkB/cH8R6klbsXKqMtd
         OMdgSSdkbJEIzGYK8B2hEnPOv1tHqW/V1mGdnRqmZiUWZDsAOnP5gNbpHwnrceTLrXJf
         Y90A==
X-Gm-Message-State: AOAM531+q7n/E+bvacEH4XcsGEkE5UQ6GwpC+wQZkaKgTiPe5esl3/Hb
        /koApcdqIAm/PB6ziOCX+sDWfX9iDiw=
X-Google-Smtp-Source: ABdhPJx9/jSoTqJ9o/ncgb8+G2MsM8QW5/IDwmGMqTi9NzfCgJVhq4cgfg+CaSaPBoSW/Z3kcO17tg==
X-Received: by 2002:a2e:9d19:: with SMTP id t25mr267324lji.222.1598600281652;
        Fri, 28 Aug 2020 00:38:01 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id y13sm38967ljd.19.2020.08.28.00.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 00:38:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
Date:   Fri, 28 Aug 2020 10:37:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.08.2020 14:50, Viresh Kumar пишет:
> We can now pass multiple versions in "opp-supported-hw" property, lets
> do that and simplify the tables a bit.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> Dmitry, I think there is further scope of simplifying stuff here by
> using the opp-microvolt-<name> property and corresponding
> dev_pm_opp_set_prop_name() call.
> ---
>  .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  36 -
>  arch/arm/boot/dts/tegra20-cpu-opp.dtsi        |  67 +-
>  .../boot/dts/tegra30-cpu-opp-microvolt.dtsi   | 512 ---------
>  arch/arm/boot/dts/tegra30-cpu-opp.dtsi        | 986 +++---------------
>  4 files changed, 149 insertions(+), 1452 deletions(-)

Hello, Viresh!

Thank you very much! Very nice cleanup! I changed my OPP-gen tool to
produce the new OPP format and then comapared the result to yours
change, the result is matching.

...
> diff --git a/arch/arm/boot/dts/tegra30-cpu-opp.dtsi b/arch/arm/boot/dts/tegra30-cpu-opp.dtsi
...
> -		opp@1000000000,975,3,7 {
> -			clock-latency-ns = <100000>;
> -			opp-supported-hw = <0x08 0x0080>;
> -			opp-hz = /bits/ 64 <1000000000>;
> +			opp-supported-hw = <0x0F 0x0001>,
> +				<0x01 0x0002>,
> +				<0x01 0x0010>,
> +				<0x01 0x0080>,
> +				<0x01 0x0100>;
> +			opp-hz = /bits/ 64 <475000000>;
>  		};

The only very minor difference between my OPP-gen result and yours is
that the above hunk has inconsistent single-column formatting, while all
others are two-column.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

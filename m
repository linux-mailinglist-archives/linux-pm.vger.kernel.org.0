Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E55D34CEFB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2L3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2L3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 07:29:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0EDC061574;
        Mon, 29 Mar 2021 04:29:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so12489606wrc.3;
        Mon, 29 Mar 2021 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i2Q5jhlwjrk9FBYJg4e9MsdVUp4rHTY83siPq5FBlxc=;
        b=tZ/j8mBOAsEl8O51Jd/uLW/7eD7Yc0kadz6MTsdOPkHO62+I2TOPHXn2I3XDFtQo6s
         KILd/fbgO82YSdcx7sT4Cv7TYGcson5CtGe62Eh5aD/ybie/wVhfWV2nT1ZzJ1WBz9+B
         +5bqRICvmP79uZ0Ce1nC8BH0a7/O0NkaWhu10n0PKXOrKLx+kJGvvuPRyVaX60bxzCeF
         NUFChgzyHjgLpAkofiZqbkOM+dzdyBah9Ip2OiXIaUPK6jA78RCXSujTloex5u0Usmro
         DTe0nF9jLinyH3KTX5ga6l82h6ERfqNwqClBmmqG3/VwOJDHSUQrEzrQZgHmstXpgab6
         eIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2Q5jhlwjrk9FBYJg4e9MsdVUp4rHTY83siPq5FBlxc=;
        b=ju/gIPH1pausyOkD7GkuXhdLhk0H0PvipuyDGUYyfd+w0bk+TQr+c517/C84MNSpsf
         IyJDOKarJKhW9OCXmO/LHHzzTIEPrTp1/tpAu9gsrVJrmsC+g//IUNSoGtLB7g8Z9m6J
         topeXS+uX1u7GkOaD1AM+eMJ44B0e1esmDbHN0hQNnG1MMBgrbJFpXGP8KZ+P4lIpZhi
         gVUs/z16UHzsvJLfVkHbDHRtThXaDtPgoAXky497i0+Dd4S6fEbEhGIYJTEYBCwuXl46
         9r/ZTekhCLCHDdcj4V6zLVzcuOUsFrLCmTBPJKg4JEeldl9UXq+ynGtWlUr9HY4nY3Z4
         vo0Q==
X-Gm-Message-State: AOAM530+MmHVu52L/0SRCpqyyH9oGpKskBHg36uAQvJXPvG5qtomRBGz
        C+rBXQaGz4Ib/qhOofjSMxU=
X-Google-Smtp-Source: ABdhPJy/hWvL+p84DPBEAVpW9viyFKwk9h3tUV6b9J6xEIHRfpzQ202GV7+umxvUEZOSt8Cc/97NXw==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr23695472wru.368.1617017370459;
        Mon, 29 Mar 2021 04:29:30 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id k13sm34402847wri.27.2021.03.29.04.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:29:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: update cpu type and clock name
 for MT8173 SoC
To:     Seiya Wang <seiya.wang@mediatek.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <20210326031227.2357-1-seiya.wang@mediatek.com>
 <20210326031227.2357-2-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e460b0b8-9e99-974d-e6bc-e6fc89177ecb@gmail.com>
Date:   Mon, 29 Mar 2021 13:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326031227.2357-2-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2021 04:12, Seiya Wang wrote:
> Update the cpu type of cpu2 and cpu3 since MT8173 used Cortex-a72.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index ea4994b35207..ef68711716fb 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -202,11 +202,11 @@ Example 2 (MT8173 SoC):
>  
>  	cpu2: cpu@100 {
>  		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> +		compatible = "arm,cortex-a72";
>  		reg = <0x100>;
>  		enable-method = "psci";
>  		cpu-idle-states = <&CPU_SLEEP_0>;
> -		clocks = <&infracfg CLK_INFRA_CA57SEL>,
> +		clocks = <&infracfg CLK_INFRA_CA72SEL>,
>  			 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  		clock-names = "cpu", "intermediate";
>  		operating-points-v2 = <&cpu_opp_table_b>;
> @@ -214,11 +214,11 @@ Example 2 (MT8173 SoC):
>  
>  	cpu3: cpu@101 {
>  		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> +		compatible = "arm,cortex-a72";
>  		reg = <0x101>;
>  		enable-method = "psci";
>  		cpu-idle-states = <&CPU_SLEEP_0>;
> -		clocks = <&infracfg CLK_INFRA_CA57SEL>,
> +		clocks = <&infracfg CLK_INFRA_CA72SEL>,
>  			 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  		clock-names = "cpu", "intermediate";
>  		operating-points-v2 = <&cpu_opp_table_b>;
> 

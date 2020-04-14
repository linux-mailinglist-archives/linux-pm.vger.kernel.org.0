Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089861A8577
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437221AbgDNQoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 12:44:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38898 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437160AbgDNQoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 12:44:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so278401otl.5;
        Tue, 14 Apr 2020 09:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdJGN+n2VYiCEYSu8u8xlSZpkqPfV2n6FeIMEPtdiVw=;
        b=jRawnFkhpMXRAk9E226hLegLZOwJm+sg5V2l2IliKC7kTYlv3AjUbLNF2Q/3Db2pG8
         /kBLzUav3peM7gUMIYvigwE7gudFjwgnz5cgfkvZaBIEmTKPPMwy21G9B/mNL19P0q+u
         RnRmLqPM6octnPqaWHTIeyAzVkUP1eqT5CxQ+EQLFFSo5E3Mut6TtUNXCoiT+xikwlw8
         o4EOKK1f3egKel9MXtX8QR4O0SnZQ7KJJxhMuX5CycDZ1j950fQCO+wXDhRdANxD+A/N
         sCw5YYCzQa4ob6TORHTfkpqBzF6UeZV4grvYJZmGRw3Ll8N3V0Kt80ikIwcC8Gae8mtE
         LH9w==
X-Gm-Message-State: AGi0PuYsill/UOYWVcuAPTo1VL4eUTb985sb7O5B8uo3WEl08upTdoj1
        qt2ARle7JPS4CPTrL/Hnyw==
X-Google-Smtp-Source: APiQypINczSaAx3RvBdTvMgP/hZFPK9N4KYJKAMcgw+8KVN2riIwZXpaqEpmPb+hOROqaiW2MJnmaw==
X-Received: by 2002:a4a:a98b:: with SMTP id w11mr19105677oom.80.1586882640106;
        Tue, 14 Apr 2020 09:44:00 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm6274633ooq.24.2020.04.14.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:43:59 -0700 (PDT)
Received: (nullmailer pid 11212 invoked by uid 1000);
        Tue, 14 Apr 2020 16:43:57 -0000
Date:   Tue, 14 Apr 2020 11:43:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, daniel.lezcano@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Talel Shenhar <talel@amazon.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: thermal: Get rid of thermal.txt and replace
 references
Message-ID: <20200414164357.GA11178@bogus>
References: <cbd70c2f0f5ddae0d8e418fcb1e03101e408f6c2.1585753313.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd70c2f0f5ddae0d8e418fcb1e03101e408f6c2.1585753313.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed,  1 Apr 2020 20:35:50 +0530, Amit Kucheria wrote:
> Now that we have yaml bindings for the thermal subsystem, get rid of the
> old bindings (thermal.txt).
> 
> Replace all references to thermal.txt in the Documentation with a link
> to the appropriate YAML bindings using the following search and replace
> pattern:
>  - If the reference is specific to the thermal-sensor-cells property,
>  replace with a pointer to thermal-sensor.yaml
>  - If the reference is to the cooling-cells property, replace with a
>  pointer to thermal-cooling-devices.yaml
>  - If the reference is generic thermal bindings, replace with a
>  reference to thermal*.yaml.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
>  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
>  .../arm/marvell/ap80x-system-controller.txt   |   2 +-
>  .../arm/marvell/cp110-system-controller.txt   |   2 +-
>  .../bindings/cpufreq/cpufreq-dt.txt           |   3 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt     |   4 +-
>  .../devicetree/bindings/hwmon/gpio-fan.txt    |   3 +-
>  .../devicetree/bindings/hwmon/lm90.txt        |   4 +-
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     |   2 +-
>  .../bindings/thermal/amazon,al-thermal.txt    |   2 +-
>  .../bindings/thermal/brcm,avs-ro-thermal.yaml |   2 +-
>  .../bindings/thermal/brcm,bcm2835-thermal.txt |   2 +-
>  .../bindings/thermal/hisilicon-thermal.txt    |   2 +-
>  .../bindings/thermal/max77620_thermal.txt     |   6 +-
>  .../bindings/thermal/mediatek-thermal.txt     |   2 +-
>  .../thermal/nvidia,tegra124-soctherm.txt      |  10 +-
>  .../thermal/nvidia,tegra186-bpmp-thermal.txt  |   2 +-
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt |   2 +-
>  .../bindings/thermal/rockchip-thermal.txt     |   2 +-
>  .../bindings/thermal/tango-thermal.txt        |   2 +-
>  .../bindings/thermal/thermal-generic-adc.txt  |   2 +-
>  .../devicetree/bindings/thermal/thermal.txt   | 586 ------------------
>  .../bindings/thermal/uniphier-thermal.txt     |   2 +-
>  23 files changed, 33 insertions(+), 615 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0122071A2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbgFXK5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgFXK5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 06:57:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE724C061796
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 03:57:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j13so1138502vsn.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vn4droilz5xGM4KfZXgTLDdDZ7pkVwg0FkXdJSTh6us=;
        b=jsrHEYsjYaln2VseebXDq9KSHpUlVCIp31IbwlZNiLEWvQQUW3jOQYJyYJ7ilWsi8t
         N4yIdR3YaRGUPVNKe7i4mRT46gYHqXTnBpAYFx6g326/StBM1zMIZgqE/Il1qOv3STOn
         fxiahpFUpRclnlN6ofiAe89/gsyxluoR8eawmKIV9o+dvNVy1/F0Jl2dJ7hK2dxOREOc
         YXbt1vQ34xDe+W0KAHfmGph3WghyiCvx0EDecfobr2KxmbamtlyrwfbCgjpWvdza+gsD
         BGzm8TnsM3OhMG8PgIzFCF995Q9nxS7OXOXKBdJQhWQ7HGO4f0RZSlTPw1OZeUPe4Fex
         JV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vn4droilz5xGM4KfZXgTLDdDZ7pkVwg0FkXdJSTh6us=;
        b=Hocayg+Y7EEEM8tjthN5vDhUk+RfrihkZjWDu34DFxM4aJHU9aG67MnxvmKpSK+8zz
         XBt1fZCa5qVQiItVDn5PanLuaTtGpuzJatTOpux8FZ8I1HtQ0YjKWuM3aKAGrKW+Xrab
         +MFB6UEvUT5jnweNORPkC9DqpVoKf0W4ZCw713tG0qUOCBUUPnlzBoZiFmS+D8Rk/2/+
         rXF8gyzgGwp5Yj7RriipeQZ5ziLlrTFgw3Eu6j/kKRE6UPDX+Qgx1EWInVjSxuwnfQgQ
         gwKgl9xpRXRouuLks6AT/1TOxUsKR0BUzBxlfje5q9PxXRj5jNOVxq/u63jMvsVufYR8
         GkVg==
X-Gm-Message-State: AOAM530z9IJh1SMNmkGrqgyBhtjgtCrnpb1XLQjGf9XJtatojm5WKDmX
        umjWCtYGZvWcj+JDq0WKcbAdnxGmmJLkjDthz+ZUHA==
X-Google-Smtp-Source: ABdhPJwsxJpI/X+t50qo0pfoptqsNIIaJYL0e6gqFMktW+4P7dgIwXfmwMKeXKnC5Tvh/SK00ZCwC18Bi+FEfhZtYJ4=
X-Received: by 2002:a67:e10d:: with SMTP id d13mr23383320vsl.27.1592996231712;
 Wed, 24 Jun 2020 03:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <cbd70c2f0f5ddae0d8e418fcb1e03101e408f6c2.1585753313.git.amit.kucheria@linaro.org>
 <20200414164357.GA11178@bogus>
In-Reply-To: <20200414164357.GA11178@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 24 Jun 2020 16:27:00 +0530
Message-ID: <CAHLCerM7hwKS=jNtMLnoCXr6z9ckOo1879e-MR-BnOC0JO=adA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Get rid of thermal.txt and replace references
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Talel Shenhar <talel@amazon.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 14, 2020 at 10:14 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed,  1 Apr 2020 20:35:50 +0530, Amit Kucheria wrote:
> > Now that we have yaml bindings for the thermal subsystem, get rid of the
> > old bindings (thermal.txt).
> >
> > Replace all references to thermal.txt in the Documentation with a link
> > to the appropriate YAML bindings using the following search and replace
> > pattern:
> >  - If the reference is specific to the thermal-sensor-cells property,
> >  replace with a pointer to thermal-sensor.yaml
> >  - If the reference is to the cooling-cells property, replace with a
> >  pointer to thermal-cooling-devices.yaml
> >  - If the reference is generic thermal bindings, replace with a
> >  reference to thermal*.yaml.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
> >  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
> >  .../arm/marvell/ap80x-system-controller.txt   |   2 +-
> >  .../arm/marvell/cp110-system-controller.txt   |   2 +-
> >  .../bindings/cpufreq/cpufreq-dt.txt           |   3 +-
> >  .../bindings/cpufreq/cpufreq-mediatek.txt     |   4 +-
> >  .../devicetree/bindings/hwmon/gpio-fan.txt    |   3 +-
> >  .../devicetree/bindings/hwmon/lm90.txt        |   4 +-
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     |   2 +-
> >  .../bindings/thermal/amazon,al-thermal.txt    |   2 +-
> >  .../bindings/thermal/brcm,avs-ro-thermal.yaml |   2 +-
> >  .../bindings/thermal/brcm,bcm2835-thermal.txt |   2 +-
> >  .../bindings/thermal/hisilicon-thermal.txt    |   2 +-
> >  .../bindings/thermal/max77620_thermal.txt     |   6 +-
> >  .../bindings/thermal/mediatek-thermal.txt     |   2 +-
> >  .../thermal/nvidia,tegra124-soctherm.txt      |  10 +-
> >  .../thermal/nvidia,tegra186-bpmp-thermal.txt  |   2 +-
> >  .../bindings/thermal/qcom-spmi-temp-alarm.txt |   2 +-
> >  .../bindings/thermal/rockchip-thermal.txt     |   2 +-
> >  .../bindings/thermal/tango-thermal.txt        |   2 +-
> >  .../bindings/thermal/thermal-generic-adc.txt  |   2 +-
> >  .../devicetree/bindings/thermal/thermal.txt   | 586 ------------------
> >  .../bindings/thermal/uniphier-thermal.txt     |   2 +-
> >  23 files changed, 33 insertions(+), 615 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Daniel, Rob,

This seems to have been missed in the 5.8 merge window. I suspect this
should go in through the thermal tree.

Regards,
Amit

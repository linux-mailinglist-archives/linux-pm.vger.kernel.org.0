Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B797C81B1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJMJOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 05:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJMJOj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 05:14:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52737B8;
        Fri, 13 Oct 2023 02:14:37 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3afc38cbdbcso940344b6e.1;
        Fri, 13 Oct 2023 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697188476; x=1697793276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iITHodXztbcWwg3ew9/mnZlKKPH9Jqt1hfq+W2xedZ4=;
        b=CKagQY4TPoid41jQh9IYUOR6H8U83+kHRrFfDvtO1HqbcuHzEXfy4oPFRu4spzH29D
         fB4MIMwkoW0eFlGpKBxciCmAmcINWdaKsWAgBsScFDVqFtisCmEAhPqmNFunx1MN+loc
         zt5XwRem+/L2uIuwdXfGChIYAYqzLi1B8zV5KpjwKhT7oBiuEVfG6jE3JZ98SVKUfe44
         mr4GEKH2gehaBnXi5NHYRkDQFW7JcS3R4ODznWSd3OOtgYMyS6LKk0Kkz59ezuGxaTNE
         TbBnRoMMnHMTOnLH7Zk2oCyvmLLmSWEoUsahydWhAxg4Q9X1yOfWrz35hMrj8RUHt2TT
         9jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188476; x=1697793276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iITHodXztbcWwg3ew9/mnZlKKPH9Jqt1hfq+W2xedZ4=;
        b=at4gw3bd4/ZctZXEuSGfGsnuyJLB4JUQgi++ndHi8Ra3//LKRfAPO+0iWhEzttUWu9
         3zn5UaYcjdwOFbxeMg5DCZ1oZFRtrpphGvg+8RWWlhntndbOm8EiDDGTFFh0zIGZD/0N
         9Frz72YGR5JutrFcamXlWnI18+GIS7siIireGLJCh3FadU1ZN4alXaKEu0Sc7aLOCDyR
         Ai6UY+ayozCALN82QWpJ37AVo5ZcAIPk50ZiC705Kas3omGp+MiVy19hwOG5B+mzKZe9
         /LA/HbbjEGTz6qZPAFnjzi7UYgneg3YTwKk8WrU8vQmAOOQpCf3zxbkU6D2yV250/Oaz
         C4hQ==
X-Gm-Message-State: AOJu0YyXfZNPW28/LcHMbbhoTF2ahvCGQbz+prihJRuTROOOwNDUyvl1
        x22+MLQPn+wR1yMT98t2orMuc3Xdksu/fPm0cJU=
X-Google-Smtp-Source: AGHT+IFx3ivvMb5P/wbW5yQS7zyC/Y9PCBWyFkgehS1NaFGE1gUeArrc9b4tnj+0M0POP1kkCnpq1eagAi1fB5Fk75c=
X-Received: by 2002:a05:6808:b0d:b0:3ad:d90d:32e with SMTP id
 s13-20020a0568080b0d00b003add90d032emr11148673oij.25.1697188476488; Fri, 13
 Oct 2023 02:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Fri, 13 Oct 2023 11:14:25 +0200
Message-ID: <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] thermal: tegra: Do not register cooling device
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
<thierry.reding@gmail.com> a =C3=A9crit :
>
> From: Thierry Reding <treding@nvidia.com>
>
> Hi,
>
> this set of patches removes the registration of the SOCTHERM internal
> throttling mechanism as cooling device. Since this throttling starts
> automatically once a certain temperature threshold is crossed, it
> doesn't make sense to represent it as a cooling device, which are
> typically "manually" activated by the thermal framework when thermal
> sensors report temperature thresholds being crossed.
>
> Instead of using the cooling device mechanism, this statically programs
> the throttling mechanism when it is configured in device tree. In order
> to do this, an additional device tree property is needed to replace the
> information that was previously contained in trip points.
>
> There's a few preparatory patches to make the removal a bit simpler and
> also some follow up cleanups included as well.
>
> Changes in v2:
> - rework the device tree bindings:
>   - add nvidia,thermal-zones property to attach throttling to zones
>   - use -millicelsius suffix and add hysteresis
> - add patch to store thermal zone device tree node for later use
> - add patch to enforce self-encapsulation of the thermal core now that
>   no drivers need to reach into it anymore
>
> This applies on top of Daniel's self-encapsulation hardening series:
>
>         https://lore.kernel.org/all/20231012102700.2858952-1-daniel.lezca=
no@linaro.org/
>
> Thierry
>
> Thierry Reding (13):
>   thermal: Store device tree node for thermal zone devices
>   dt-bindings: thermal: tegra: Document throttle temperature
>   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
>   thermal: tegra: Use driver-private data consistently
>   thermal: tegra: Constify SoC-specific data
>   thermal: tegra: Do not register cooling device
>   thermal: tegra: Use unsigned int where appropriate
>   thermal: tegra: Avoid over-allocation of temporary array
>   thermal: tegra: Remove gratuitous error assignment
>   thermal: tegra: Minor stylistic cleanups
>   ARM: tegra: Rework SOCTHERM on Tegra124
>   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
>   thermal: Enforce self-encapsulation
>
>  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
>  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
>  drivers/thermal/tegra/soctherm.c              | 525 ++++++++----------
>  drivers/thermal/tegra/soctherm.h              |   1 +
>  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
>  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
>  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
>  drivers/thermal/thermal_core.h                |   2 +-
>  drivers/thermal/thermal_of.c                  |   3 +
>  11 files changed, 329 insertions(+), 453 deletions(-)
>
> --
> 2.42.0
>

I'm still experiencing the following message on jetson-tx1 with this
serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
applied).
oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-thermal:
Failed to register thermal zone: -19
oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid
prop

Is this expected ?

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2714E344B33
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhCVQ0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 12:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhCVQ0D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 12:26:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A448D61923;
        Mon, 22 Mar 2021 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616430362;
        bh=ceQ5NOwJb9FM/epRVuKXnXy9KZ3kKLgrUadTmgZr2Nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XQ4OnlKCgYf2qA8cha/7tibsbD3VcoMYzhKL5Lf38Y3CHx2XWKqHvppccXKaPGmTW
         td4U1Th95B0qy1EC9R2ZBOAxsS1aTZxM5M00htG6bkjsVOmGd8jpFg/eXyEnhB/QsK
         RcL7oJN9nUwuFO+1b2nSvkkmywyH9DuftEgS5fGbj7zpWql43hi1histS4PPXU9omk
         t4KJG+GD8no22EGODQRQfktSYPKDYuuwAaMLqWQ0JhmXQ9BP74+RVZcfpqTFezYCGp
         1VHxVg5d2Rjpjq0Fzz/LfNg5uUyRCYJp2WhocWWwCrkovhkRlPWWnsxaIXIhse/Vml
         WhLWPbAdhry6A==
Received: by mail-ed1-f53.google.com with SMTP id dm8so20123902edb.2;
        Mon, 22 Mar 2021 09:26:02 -0700 (PDT)
X-Gm-Message-State: AOAM532KmTd8ixaf4Ud618nivEF7RPakY2GuwmumCPWClMxRtYFiqDnI
        0KB2sGTfKrygI6K4hWfgmcXA+JhMC+pCg7rkPQ==
X-Google-Smtp-Source: ABdhPJwuPn8U7kIVUhCfwZoxyYPPdZcXFdxetHAglstyF75ep9cAElEhNjBTsVpxYryDcJzvlZY0sdWXj7LXFY54zpA=
X-Received: by 2002:aa7:d385:: with SMTP id x5mr353341edq.289.1616430361296;
 Mon, 22 Mar 2021 09:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Mar 2021 10:25:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLASixNRTf712201w1nghxdaB28HsN7fdsjeogsoA=oQg@mail.gmail.com>
Message-ID: <CAL_JsqLASixNRTf712201w1nghxdaB28HsN7fdsjeogsoA=oQg@mail.gmail.com>
Subject: Re: [PATCHv2 00/38] Convert power-supply DT bindings to YAML
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 17, 2021 at 7:49 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I keep getting patches for existing drivers, that modify DT behaviour
> without updating the binding file. Let's move everything to DT schema
> files, so that this can easily be cached automatically by dtbs_check.
>
> After this series only three bindings are left unconverted:
>
> 1. max8925_battery.txt
>    This describes a node below the PMIC, which does not have its own
>    compatible value. It needs to be described in the PMIC binding
>    file, which has not yet been converted.
>
> 2. stericsson,ab8500-battery.txt
>    This also describes a node below the PMIC, which does not have
>    its own compatible value. The same applies.
>
> 3. charger-manager.txt
>    This is far more complex to convert than the other files, due
>    to the 'cm-regulator-name' / "<>-supply" thing. I skipped it
>    for now.
>
> I tested the series using dt-validate 2021.3.dev6+g38efe3f and nothing
> is reported when running dtbs_check like this:
>
> make -s -j100 dtbs_check DT_SCHEMA_FILES="Documentation/devicetree/bindings/power/supply/*.yaml"
>
> Also nothing is reported when checking the power-supply binding files
> like this:
>
> for file in Documentation/devicetree/bindings/power/supply/*yaml ; do
>     make -s -j42 dt_binding_check DT_SCHEMA_FILES=$file ;
> done
>
> This is also available as 'psy-yaml-binding' branch from my repository:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>
> Changes since PATCHv1:
> [1] https://lore.kernel.org/linux-devicetree/20210312154357.1561730-1-sebastian.reichel@collabora.com/
>  * Drop #gpio-cells/gpio-controller dependency (inherited from standard binding)
>  * Drop $ref for properties with standard suffix
>  * ti,bq24735: Add $ref property for poll-interval
>  * ti,lp8727: Combine usb and ac property information using patternProperties
>
> Thanks for reviewing it,
>
> -- Sebastian
>
> Sebastian Reichel (38):
>   ARM: dts: motorola-cpcap-mapphone: Prepare for dtbs_check parsing
>   dt-bindings: power: supply: cpcap-battery: Convert to DT schema format
>   dt-bindings: power: supply: cpcap-charger: Convert to DT schema format
>   dt-bindings: power: supply: bq25890: Convert to DT schema format
>   dt-bindings: power: supply: bq24257: Convert to DT schema format
>   dt-bindings: power: supply: bq24190: Convert to DT schema format
>   dt-bindings: power: supply: bq2415x: Convert to DT schema format
>   dt-bindings: power: supply: bq24735: Convert to DT schema format
>   dt-bindings: power: supply: isp1704: Convert to DT schema format
>   dt-bindings: power: supply: sbs-charger: Convert to DT schema format
>   dt-bindings: power: supply: sbs-manager: Convert to DT schema format
>   dt-bindings: power: supply: ds2760: Convert to DT schema format
>   dt-bindings: power: supply: sc27xx-fg: Convert to DT schema format
>   dt-bindings: power: supply: sc2731-charger: Convert to DT schema
>     format
>   dt-bindings: power: supply: tps65090: Convert to DT schema format
>   dt-bindings: power: supply: tps65217: Convert to DT schema format
>   dt-bindings: power: supply: twl4030: Convert to DT schema format
>   dt-bindings: power: supply: n900-battery: Convert to DT schema format
>   dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema
>     format
>   dt-bindings: power: supply: max17040: Convert to DT schema format
>   dt-bindings: power: supply: max14656: Convert to DT schema format
>   dt-bindings: power: supply: max17042: Convert to DT schema format
>   dt-bindings: power: supply: max8903: Convert to DT schema format
>   dt-bindings: power: supply: ucs1002: Convert to DT schema format
>   dt-bindings: power: supply: pm8941-charger: Convert to DT schema
>     format
>   dt-bindings: power: supply: pm8941-coincell: Convert to DT schema
>     format
>   dt-bindings: power: supply: act8945a: Convert to DT schema format
>   dt-bindings: power: supply: axp20x: Convert to DT schema format
>   dt-bindings: power: supply: da9150: Convert to DT schema format
>   dt-bindings: power: supply: lp8727: Convert to DT schema format
>   dt-bindings: power: supply: lt3651: Convert to DT schema format
>   dt-bindings: power: supply: ltc294x: Convert to DT schema format
>   dt-bindings: power: supply: rt9455: Convert to DT schema format
>   dt-bindings: power: supply: olpc-battery: Convert to DT schema format
>   dt-bindings: power: supply: ab8500: Convert to DT schema format
>   dt-bindings: power: supply: sbs-battery: Fix dtbs_check
>   dt-bindings: power: supply: Fix remaining battery.txt links
>   dt-bindings: power: supply: Drop power_supply.txt

Thanks! For the series:

Reviewed-by: Rob Herring <robh@kernel.org>

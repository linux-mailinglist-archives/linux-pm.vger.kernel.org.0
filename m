Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0046B4B5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 08:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhLGH5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 02:57:08 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45660 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhLGH5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Dec 2021 02:57:08 -0500
Received: by mail-lf1-f50.google.com with SMTP id m27so31443540lfj.12;
        Mon, 06 Dec 2021 23:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M4053ddcoCHS9XCjXf2+vp4Q/MRlOghuFfClCrWQbZk=;
        b=2hytIXLDmXfiQHbsMJvW28KaTRK+kdS3DNE+ZCUtjdEoUJ56ySXwZUrsX9MiGcP4TA
         caBZmvICJd3e6+o4cU3CQFLK5kjNFw5XdYqW4ESS3w3hSbL0DXqk0nHlYHXn+yFv3Xan
         oW42z6YOA8zOSeZGGq86xozpGHBrY/5FX09xkvJyjjVP5P+m0WJyScC4vxLyxENF1UiJ
         QwKouVA0bjEv0DsKOyJFRMmNyLEwnR2+onZctiQkgGlg41wgzOgZpdgPy0qjuC32W4AZ
         eSiPm56GVNhiovnfmeJirACwuj3z3Dh1s5o7vYbPWUQeRo8T4uFVf9j1z6F7zvkr6/Ej
         CGdg==
X-Gm-Message-State: AOAM5331jePzUjgufc0dI2m9/roTfpNlpslJ+A/oKAt9fn9w9RTubEIb
        dAt4zJrhTUJUOwjMVxv3dv5lvWkVXNg=
X-Google-Smtp-Source: ABdhPJybWEAeDT1BawilHdGupYSRFULaP24I+Mpw/m9i298feiMs/XMhC7gF+xfx7zTAF0WK4FdM6Q==
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr12351490lfu.199.1638863616404;
        Mon, 06 Dec 2021 23:53:36 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.googlemail.com with ESMTPSA id t6sm78436lfl.215.2021.12.06.23.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:53:35 -0800 (PST)
Message-ID: <009b3350-4424-76d5-66d6-7393cdd8cd8a@kernel.org>
Date:   Tue, 7 Dec 2021 08:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 00/11] Apple SoC PMGR device power states driver
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211124073419.181799-1-marcan@marcan.st>
 <8fdf7a68-1a24-89eb-96d6-93c3f334621c@marcan.st>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <8fdf7a68-1a24-89eb-96d6-93c3f334621c@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/12/2021 06:30, Hector Martin wrote:
> On 24/11/2021 16.34, Hector Martin wrote:
>> This series adds the driver for the Apple PMGR device power state
>> registers. These registers can clockgate and (in some cases) powergate
>> specific SoC blocks. They also control the reset line, and can have
>> additional features such as automatic power management.
>>
>> The current driver supports only the lowest/highest power states,
>> provided via the genpd framework, plus reset support provided via
>> the reset subsystem.
>>
>> Apple's PMGRs (there are two in the T8103) have a uniform register
>> bit layout (sometimes with varying features). To be able to support
>> multiple SoC generations as well as express pd relationships
>> dynamically, this binding describes each PMGR power state control
>> as a single devicetree node. Future SoC generations are expected to
>> retain backwards compatibility, allowing this driver to work on them
>> with only DT changes.
>>
>> #1: MAINTAINERS updates, to go via the SoC tree to avert merge hell
>> #2-#5: Adds power-domains properties to existing device bindings
>> #6-#7: Adds the new pmgr device tree bindings
>> #8: The driver itself.
>> #9: Instantiates the driver in t8103.dtsi. This adds the entire PMGR
>>      node tree and references the relevant nodes from existing devices.
>> #7: Adds runtime-pm support to the Samsung UART driver, as a first
>>      working consumer.
>> #8: Instantiates a second UART, to more easily test this.
>>
>> There are currently no consumers for the reset functionality, so
>> it is untested, but we will be testing it soon with the NVMe driver
>> (as it is required to allow driver re-binding to work properly).
>>
>> == Changes since v2 ==
>> - DT schema review comments & patch order fix
>> - Added the power-domains properties to devices that already mainlined
>> - Now adds the entire PMGR tree. This turns off all devices we do not
>>    currently instantiate, and adds power-domains to those we do. The
>>    nodes were initially generated with [1] and manually tweaked. all
>>    the labels match the ADT labels (lowercased), which might be used
>>    by the bootloader in the future to conditionally disable nodes
>>    based on hardware configuration.
>> - Dropped apple,t8103-minipmgr, since I don't expect we will ever need
>>    to tell apart multiple PMGR instances within a SoC, and added
>>    apple,t6000-pmgr{-pwrstate} for the new SoCs.
>> - Driver now unconditionally enables auto-PM for all devices. This
>>    seems to be safe and should save power (it is not implemented for
>>    all devices; if not implemented, the bit just doesn't exist and is
>>    ignored).
>> - If an always-on device is not powered on at boot, turn it on and
>>    print a warning. This avoids the PM core complaining. We still
>>    want to know if/when this happens, but let's not outright fail.
>> - Other minor fixes (use PS names instead of offsets for messages,
>>    do not spuriously clear flag bits).
>>
>> On the way the parent node is handled: I've decided that these syscon
>> nodes will only ever contain pwrstates and nothing else. We now size
>> them based on the register range that contains pwrstate controls
>> (rounded up to page size). t6000 has 3 PMGRs and t6001 has 4, and
>> we shouldn't have to care about telling apart the multiple instances.
>> Anything else PMGR does that needs a driver will be handled by
>> entirely separate nodes in the future.
>>
>> Re t6001 and t6000 (and the rumored t6002), t6000 is basically a
>> cut-down version of t6001 (and t6002 is rumored to be two t6001
>> dies), down to the die floorplan, so I'm quite certain we won't need
>> t6001/2-specific compatibles for anything shared. The t6000 devicetree
>> will just #include the t6001 one and remove the missing devices.
>> Hence, everything for this SoC series is going to have compatibles
>> named apple,t6000-* (except the extra instances of some blocks in
>> t6001 which look like they may have differences; PMGR isn't one of
>> them, but some multimedia stuff might).
>>
>> [1] https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/tools/pmgr_adt2dt.py
>>
>> Hector Martin (11):
>>    MAINTAINERS: Add PMGR power state files to ARM/APPLE MACHINE
>>    dt-bindings: i2c: apple,i2c: Add power-domains property
>>    dt-bindings: iommu: apple,dart: Add power-domains property
>>    dt-bindings: pinctrl: apple,pinctrl: Add power-domains property
>>    dt-bindings: interrupt-controller: apple,aic: Add power-domains
>>      property
>>    dt-bindings: power: Add apple,pmgr-pwrstate binding
>>    dt-bindings: arm: apple: Add apple,pmgr binding
>>    soc: apple: Add driver for Apple PMGR power state controls
>>    arm64: dts: apple: t8103: Add PMGR nodes
>>    tty: serial: samsung_tty: Support runtime PM
>>    arm64: dts: apple: t8103: Add UART2
>>
>>   .../bindings/arm/apple/apple,pmgr.yaml        |  134 ++
>>   .../devicetree/bindings/i2c/apple,i2c.yaml    |    3 +
>>   .../interrupt-controller/apple,aic.yaml       |    3 +
>>   .../devicetree/bindings/iommu/apple,dart.yaml |    3 +
>>   .../bindings/pinctrl/apple,pinctrl.yaml       |    3 +
>>   .../bindings/power/apple,pmgr-pwrstate.yaml   |   71 ++
>>   MAINTAINERS                                   |    3 +
>>   arch/arm64/boot/dts/apple/t8103-j274.dts      |    5 +
>>   arch/arm64/boot/dts/apple/t8103-pmgr.dtsi     | 1136 +++++++++++++++++
>>   arch/arm64/boot/dts/apple/t8103.dtsi          |   36 +
>>   drivers/soc/Kconfig                           |    1 +
>>   drivers/soc/Makefile                          |    1 +
>>   drivers/soc/apple/Kconfig                     |   21 +
>>   drivers/soc/apple/Makefile                    |    2 +
>>   drivers/soc/apple/apple-pmgr-pwrstate.c       |  317 +++++
>>   drivers/tty/serial/samsung_tty.c              |   93 +-
>>   16 files changed, 1798 insertions(+), 34 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>   create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
>>   create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
>>   create mode 100644 drivers/soc/apple/Kconfig
>>   create mode 100644 drivers/soc/apple/Makefile
>>   create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c
>>
> 
> Applied everything except the samsung_tty change to asahi-soc/dt (DT 
> changes) and asahi-soc/pmgr (just the driver). Thanks everyone for the 
> reviews!
> 
> Krzysztof: feel free to take that patch through tty if you think it's in 
> good shape. I'm not sure how much power UART runtime-pm will save us, 
> but at least it's a decent test case, so it's probably worth having.

The tty/serial driver change goes via Greg's tree.


Best regards,
Krzysztof

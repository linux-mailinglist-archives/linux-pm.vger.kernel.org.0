Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECBAF288
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfD3JLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 05:11:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36227 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfD3JLT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 05:11:19 -0400
Received: by mail-it1-f196.google.com with SMTP id v143so3576146itc.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=74N8uVDgnbUU0QJxHwKxdfXzPWk/Zhn2TmoGdHEfMro=;
        b=ldYgztHLOex01cWo7A8vpjaHy+3VBSZrTEvsXM2SOVENFEAAXRUeUNZxJ5XS2PXj5l
         6t/yfMBBxtDy0KJ0Jukw4LWzu0TYWUJU7qraZejg65DLny0TdVgOJebBb9ZUCnoFfKru
         /U6HNt738iugvH50W7FlM/3+FUa4G+domWWepkZXnhlXfxSO95K8hmWWli59IqIcfeVg
         ss0wkp2oHpYw1UYkYfApDq9aU517Slnm+KOu5nO+o9sar9Ii5bDPzwUKM6/eatOgbwBF
         ll8M2lhgdELpOnW/KOE6cfRBvtgryj+CJHGV7Je5JmFYFJ7XMociMhedhuoKRqDs2vOj
         PDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=74N8uVDgnbUU0QJxHwKxdfXzPWk/Zhn2TmoGdHEfMro=;
        b=WOOrwWIRt+edUvRdtQ9HqXPm/fDyVE9hCHSqtnfOwEC8s5iRLltQN+pC/8eVHuAusl
         ij/38nEw7Ap0aQQ9fc82osGBh7el5OyMkZwNgikLxarknExYX51i5aXSSvEYXaCFrOPX
         b6163ururhF0TJR8a5Z+0y1tLlZzBS0wSghEOV91C+nHMy5HGxSVT8mupJXlp/o9Gx1s
         sgjWJUfzEyeGIwTKnL99MEr2b4gCE0Bk7M8cCKtY3ZnKoWsHqUuIXbtnwP36HDN8LYyV
         t5YDO0UqLynSwEP8U+GoS8Vm/WNEp7VbUFNpKsOdyUQr2qmOP0Luxrd6PCWoQFqDk+q/
         F1RA==
X-Gm-Message-State: APjAAAUh7vwAuLWBvXt6/PzHdnFIAjax7jJQC8s9QGhS6JPiJS6CuQtc
        YHwycbab7Mnj3TughrsjkoSHn8GhUTPAuGxtjotJAQ==
X-Google-Smtp-Source: APXvYqxbYlBvWIHtRFN78GqEkysV6RnX4j67zaKjrkqgheGXygI16+B7GQxThoj2QX6LH0gcp2FUQWsFCnwGhVMEl2k=
X-Received: by 2002:a24:4d85:: with SMTP id l127mr2917671itb.53.1556615478181;
 Tue, 30 Apr 2019 02:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090451.23711-1-brgl@bgdev.pl>
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 30 Apr 2019 11:11:07 +0200
Message-ID: <CAMRc=MfDVc6nTRTOcDzKtqphtC1J+uDGwwgtuVLCO9yqVUz1nQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

wt., 23 kwi 2019 o 11:04 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This series adds support for max77650 ultra low-power PMIC. It provides
> the core mfd driver and a set of five sub-drivers for the regulator,
> power supply, gpio, leds and input subsystems.
>
> Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devic=
es().
> Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for thi=
s
> device.
>
> The regulator part is already upstream.
>
> v1 -> v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - use C++ style comments for the SPDX license identifier and the
>   copyright header
> - s/MODULE_LICENSE("GPL")/MODULE_LICENSE("GPL v2")/
> - lookup the virtual interrupt numbers in the MFD driver, setup
>   resources for child devices and use platform_get_irq_byname()
>   in sub-drivers
> - picked up review tags
> - use devm_request_any_context_irq() for interrupt requests
>
> LEDs:
> - changed the max77650_leds_ prefix to max77650_led_
> - drop the max77650_leds structure as the only field it held was the
>   regmap pointer, move said pointer to struct max77650_led
> - change the driver name to "max77650-led"
> - drop the last return value check and return the result of
>   regmap_write() directly
> - change the labeling scheme to one consistent with other LED drivers
>
> ONKEY:
> - drop the key reporting helper and call the input functions directly
>   from interrupt handlers
> - rename the rv local variable to error
> - drop parent device asignment
>
> Regulator:
> - drop the unnecessary init_data lookup from the driver code
> - drop unnecessary include
>
> Charger:
> - disable the charger on driver remove
> - change the power supply type to POWER_SUPPLY_TYPE_USB
>
> GPIO:
> - drop interrupt support until we have correct implementation of hierarch=
ical
>   irqs in gpiolib
>
> v2 -> v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - dropped regulator patches as they're already in Mark Brown's branch
>
> LED:
> - fix the compatible string in the DT binding example
> - use the max_brightness property
> - use a common prefix ("MAX77650_LED") for all defines in the driver
>
> MFD:
> - add the MODULE_DEVICE_TABLE()
> - add a sentinel to the of_device_id array
> - constify the pointers to irq names
> - use an enum instead of defines for interrupt indexes
>
> v3 -> v4:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> GPIO:
> - as discussed with Linus Walleij: the gpio-controller is now part of
>   the core mfd module (we don't spawn a sub-node anymore), the binding
>   document for GPIO has been dropped, the GPIO properties have been
>   defined in the binding document for the mfd core, the interrupt
>   functionality has been reintroduced with the irq directly passed from
>   the mfd part
> - due to the above changes the Reviewed-by tag from Linus was dropped
>
> v4 -> v5:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - add a patch documenting mfd_add_devices()
>
> MFD:
> - pass the regmap irq_chip irq domain to mfd over mfd_add_devices so that
>   the hw interrupts from resources can be correctly mapped to virtual irq=
s
> - remove the enum listing cell indexes
> - extend Kconfig help
> - add a link to the programming manual
> - use REGMAP_IRQ_REG() for regmap interrupts (except for GPI which has
>   is composed of two hw interrupts for rising and falling edge)
> - add error messages in probe
> - use PLATFORM_DEVID_NONE constant in devm_mfd_add_devices()
> - set irq_base to 0 in regmap_add_irq_chip() as other users to, it's only
>   relevant if it's > 0
>
> Charger:
> - use non-maxim specific property names for minimum input voltage and cur=
rent
>   limit
> - code shrink by using the enable/disable charger helpers everywhere
> - use more descriptive names for constants
>
> Onkey:
> - use EV_SW event type for slide mode
>
> LED:
> - remove stray " from Kconfig help
>
> v5 -> v6:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> MFD:
> - remove stray spaces in the binding document
> - rename the example dt node
> - remove unnecessary interrupt-parent property from the bindings
>
> LED:
> - add a missing dependency on LEDS_CLASS to Kconfig
>
> Onkey:
> - use boolean for the slide button property
>
> Charger:
> - fix the property names in DT example
> - make constants even more readable
>
> v6 -> v7:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Charger:
> - rename the current limit property to current-limit-microamp
>
> v7 -> v8:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - collected acks from Lee
> - changed the documentation for mfd_add_devices() as suggested by Lee
> - rebased on top of v5.1-rc3
>
> v8 > v9:
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - collected new tags
> - rebased on top of v5.1-rc4
>
> MFD:
> - various improvements in error messages
> - coding style tweaks
>
> Charger:
> - named the two optional properties in a more descriptive way, so that
>   we can make them generic for charger bindings if more potential users
>   appear
>
> v9 -> v10:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> General:
> - added the review tag from Sebastian
> - rebased on top of v5.1-rc6
>
> Charger:
> - fixed the example in the binding document
>
> Bartosz Golaszewski (11):
>   dt-bindings: mfd: add DT bindings for max77650
>   dt-bindings: power: supply: add DT bindings for max77650
>   dt-bindings: leds: add DT bindings for max77650
>   dt-bindings: input: add DT bindings for max77650
>   mfd: core: document mfd_add_devices()
>   mfd: max77650: new core mfd driver
>   power: supply: max77650: add support for battery charger
>   gpio: max77650: add GPIO support
>   leds: max77650: add LEDs support
>   input: max77650: add onkey support
>   MAINTAINERS: add an entry for max77650 mfd driver
>
>  .../bindings/input/max77650-onkey.txt         |  26 ++
>  .../bindings/leds/leds-max77650.txt           |  57 +++
>  .../devicetree/bindings/mfd/max77650.txt      |  46 +++
>  .../power/supply/max77650-charger.txt         |  28 ++
>  MAINTAINERS                                   |  14 +
>  drivers/gpio/Kconfig                          |   7 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-max77650.c                  | 190 +++++++++
>  drivers/input/misc/Kconfig                    |   9 +
>  drivers/input/misc/Makefile                   |   1 +
>  drivers/input/misc/max77650-onkey.c           | 121 ++++++
>  drivers/leds/Kconfig                          |   6 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-max77650.c                  | 147 +++++++
>  drivers/mfd/Kconfig                           |  14 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/max77650.c                        | 232 +++++++++++
>  drivers/mfd/mfd-core.c                        |  13 +
>  drivers/power/supply/Kconfig                  |   7 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/max77650-charger.c       | 368 ++++++++++++++++++
>  include/linux/mfd/max77650.h                  |  59 +++
>  22 files changed, 1349 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/max77650-onke=
y.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.=
txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.txt
>  create mode 100644 drivers/gpio/gpio-max77650.c
>  create mode 100644 drivers/input/misc/max77650-onkey.c
>  create mode 100644 drivers/leds/leds-max77650.c
>  create mode 100644 drivers/mfd/max77650.c
>  create mode 100644 drivers/power/supply/max77650-charger.c
>  create mode 100644 include/linux/mfd/max77650.h
>
> --
> 2.21.0
>

Hi Lee,

just a gentle ping before I leave on vacation.

All the relevant Acks are there. Any chance of getting this in for
v5.2? Obviously this cannot cause any regressions so it shouldn't be
too late in the release cycle.

Thanks in advance,
Bartosz Golaszewski

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69B5E69B1
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 22:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfJ0ViI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Oct 2019 17:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfJ0VEE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:04 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EB6222BE;
        Sun, 27 Oct 2019 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210243;
        bh=ejTMU2PKQBIvXRez9MZn4+fwYEV5lq+acuqnLFVTjRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YS5blBDgCLLdaVUBscufdzFBWqilByx/mzOp2lPJdgTGefAY0qo7zl3CToLksevf5
         RXNIWsBQgj8DjxJbSlCw5u0MnvbfSlZbd31dvvM2s/w15qFbLDC356zis+nFLypp+y
         yuu51CWefzALIDqXy6XOnj/tfiMfRjVJ+DlH3lgg=
Received: by mail-qk1-f180.google.com with SMTP id w2so6699615qkf.2;
        Sun, 27 Oct 2019 14:04:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWQjCkEogmbS7F72uuk9gf6P1BLLMRa82DuhREgwqfdZjxmB47d
        as/hJcrlWEMSmkan7tzNtZ8AFkbXZ01qJPtpjA==
X-Google-Smtp-Source: APXvYqxH6jcRbIdQqMyzEbVP8RBOqjV1tIloJha8kSXqB1poy40CPrXvcGOaIctBmE89+n7Vi2T5C7riiCYexD1eFZE=
X-Received: by 2002:a37:9847:: with SMTP id a68mr13244112qke.223.1572210242357;
 Sun, 27 Oct 2019 14:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191021124428.2541-1-brgl@bgdev.pl> <CAMRc=MeYS+rQMCEc_z1FudnremUhUsXnxdcB2heF6qdtOkH9uQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeYS+rQMCEc_z1FudnremUhUsXnxdcB2heF6qdtOkH9uQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Oct 2019 16:03:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK+6-pz6gQyW3ZEEb6_2AOzwsM0aDZ1PwVCLy-=OeSjhw@mail.gmail.com>
Message-ID: <CAL_JsqK+6-pz6gQyW3ZEEb6_2AOzwsM0aDZ1PwVCLy-=OeSjhw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] dt-bindings: max77650: convert the device-tree
 bindings to yaml
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 26, 2019 at 6:54 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> pon., 21 pa=C5=BA 2019 o 14:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=
=C5=82(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series converts all DT binding documents for MAX77650 PMIC to YAML=
.
> >
> > v1 -> v2:
> > - use upper case for abbreviations in commit messages
> >
> > v2 -> v3:
> > - pull all example fragments into the binding document for the core MFD=
 module
> > - fix all dt_binding_check errors
> > - add references to submodules to the main binding document
> > - drop the type for gpio-line-names
> > - drop the description for the interrupts property
> > - completely delete the previous txt files
> >
> > v3 -> v4:
> > - remove unnecessary parts of descriptions, added details on the chip
> > - correct file references (.txt -> .yaml)
> > - fix mixing scalar and array constraints
> > - dropped type refs for globally defined properties
> >
> > Bartosz Golaszewski (6):
> >   dt-bindings: input: max77650: convert the binding document to yaml
> >   dt-bindings: regulator: max77650: convert the binding document to yam=
l
> >   dt-bindings: power: max77650: convert the binding document to yaml
> >   dt-bindings: leds: max77650: convert the binding document to yaml
> >   dt-bindings: mfd: max77650: convert the binding document to yaml
> >   MAINTAINERS: update the list of maintained files for max77650
> >
> >  .../bindings/input/max77650-onkey.txt         |  26 ---
> >  .../bindings/input/max77650-onkey.yaml        |  35 ++++
> >  .../bindings/leds/leds-max77650.txt           |  57 -------
> >  .../bindings/leds/leds-max77650.yaml          |  51 ++++++
> >  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
> >  .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
> >  .../power/supply/max77650-charger.txt         |  28 ----
> >  .../power/supply/max77650-charger.yaml        |  34 ++++
> >  .../bindings/regulator/max77650-regulator.txt |  41 -----
> >  .../regulator/max77650-regulator.yaml         |  31 ++++
> >  MAINTAINERS                                   |   4 +-
> >  11 files changed, 302 insertions(+), 200 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/max77650-on=
key.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/max77650-on=
key.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-max7765=
0.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-max7765=
0.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/max7765=
0-regulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/max7765=
0-regulator.yaml
> >
> > --
> > 2.23.0
> >
>
> Hi Rob,
>
> thanks for reviewing the series. Can you please take it through your
> tree for v5.5? I think it'll be easier than bothering all the
> respective maintainers and it only touches on bindings anyway.

Okay, series applied.

Rob

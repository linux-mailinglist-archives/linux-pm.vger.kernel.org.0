Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16B10EDE7
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLBRJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 12:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfLBRJx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 12:09:53 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F135A20833;
        Mon,  2 Dec 2019 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575306592;
        bh=GkbsSdmQ4eR/q4AClvX3n4KtKQbJWCPbVsm/uxNan0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O9xXSKg8S6lM7Iks/wTYvZ1NUVYF6WWGXCJkhky2yE71DNlpRkTRLzZhxrC6aZxkN
         ToP5TwKHAJgs+QW1VaDoiA6W3a5kpzPcupLLKeHa+wllldyjGFH0H0P7EPUsSLAalA
         9xQ7l+0h5xI37uH0Tl7CPLR65PoHhN633F6cpQQw=
Received: by mail-qt1-f179.google.com with SMTP id k11so464235qtm.3;
        Mon, 02 Dec 2019 09:09:51 -0800 (PST)
X-Gm-Message-State: APjAAAVBF1FojDo1bliIp6ou+5kBv6NJiRndW+Mx1HTygBlcZqXRG+Dj
        PNyEFajNgada9iq+yxSE8zdhVNPYDKKEGX949A==
X-Google-Smtp-Source: APXvYqx0eGKoau2S6a0rZyzd5VHUrfCL9liT+60FFeUQX4HBFesTQx2qmA3e+5um+KvbMtTh9mBqfuVW9OHHwdbtYdQ=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr310765qtq.143.1575306591095;
 Mon, 02 Dec 2019 09:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20191021124428.2541-1-brgl@bgdev.pl> <20191021124428.2541-6-brgl@bgdev.pl>
 <20191111080837.GF18902@dell> <CAMRc=Me_b5c_e+qZ1s=TgTh7k_bQqrqthC8VTb7ak8+3AOEugg@mail.gmail.com>
 <20191112105035.GR3218@dell>
In-Reply-To: <20191112105035.GR3218@dell>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Dec 2019 11:09:40 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cpPppgVg_42m55DKOwA5uk7CLV_juDyCCECJMuuZYeg@mail.gmail.com>
Message-ID: <CAL_Jsq+cpPppgVg_42m55DKOwA5uk7CLV_juDyCCECJMuuZYeg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 12, 2019 at 4:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 11 Nov 2019, Bartosz Golaszewski wrote:
>
> > pon., 11 lis 2019 o 09:08 Lee Jones <lee.jones@linaro.org> napisa=C5=82=
(a):
> > >
> > > On Mon, 21 Oct 2019, Bartosz Golaszewski wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Convert the binding document for MAX77650 core MFD module to YAML.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
> > > >  .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++=
++++
> > > >  2 files changed, 149 insertions(+), 46 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.=
txt
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.=
yaml
> > >
> > > Applied, thanks.
> > >
> >
> > Hi Lee,
> >
> > FYI this series is already in next through Rob's DT tree.
>
> Why don't I see an 'applied' email?

There was discussion about it in the cover letter.

With the schema for MFDs, we need to merge all the schema thru one
tree because the main schema references the child node schemas.
Otherwise, 'make dt_binding_check' will start failing (as Linus' tree
is now). Perhaps we should encourage they be a single patche because
1) child devices alone don't make sense and 2) it will be clear not to
apply each separately.

Rob

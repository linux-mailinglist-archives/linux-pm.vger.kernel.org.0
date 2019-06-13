Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E164436A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392480AbfFMQ3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 12:29:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37644 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbfFMIfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 04:35:18 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so12118840vsq.4;
        Thu, 13 Jun 2019 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/j512S8iNawEe8Fwmcxi5za0FB/PptLS7JGUaidYWg=;
        b=OxnRIln/sM87E9yAMKkBvxzTuS55PzqwilzIiUk16/vzQLB+YOVGxrkEOMI/1T0fef
         Tjz9MlXar7WzM/oRrPg8KIGEA5YlpiPcjw/e2QqsyG5dYc2SqlOwKu3q5+itA54IALWn
         i96hlCvrcOOhMadLxROp27+OUusTMbi4nQ115G/RCUC6eYXU8ff6zsvwdCqPbhqW0EgS
         m7zoVLxR8BXVvsqTQF04zStHGjY9yKdLJQEaxG2TAM44GxQitJ+n+Dyw+5dYgvENw2u8
         PiEQV5fuRzvkDr6D0I8omoYJl4DVMhg+0BqBmwJKtbxT/nznxzjNEtJil+Csn25bB3et
         cbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/j512S8iNawEe8Fwmcxi5za0FB/PptLS7JGUaidYWg=;
        b=LSkFMlSIR2q7+qqD8Sx/v34wjavq/hJ6nu0QV6B9FuOdg8xlLEVq43iez72S58PTo5
         XvVsaKlhYGomWO0OzyzzRbQCaOiHFoO1mCuUzE9+/MC7k5W8G3VTMTLyL9si90CIgtyQ
         UdgEKH1lh2GM7AIfojwD+8wZnuXpEP5Fp6/lWlrvtseUDVIs0N7hkp3d/2L+yeVd2X2p
         xlkDbfeQn0eByq6b5fijvNEATjGY4jVB4bF4cdGn4uX5SgeTwNhW2rSaapyf2/Z9rOjc
         UQDyRe82kFx96qumUGUGYTolFLF/3hn3AXqGpKagO+lLDXsu3V7xEdR0yO/X3EtqS/yN
         YFmw==
X-Gm-Message-State: APjAAAWRmi7aEEHndzryzvc9ReAvx5KPlzokErywysDEHjEYSHilwSKi
        jUrXLJP+i0EU77ELYlYCjj/UPsdbFQ4fd6gJ9RE=
X-Google-Smtp-Source: APXvYqzXlBh2rBUbKHiKWqg1RIV3kUDnHNMsS0QRYDwTtb3AQTQI4zniACIqmZ18a8Q2qK+cPo7L2dtUQdc3qhiJdAo=
X-Received: by 2002:a67:fb8d:: with SMTP id n13mr32198844vsr.46.1560414917499;
 Thu, 13 Jun 2019 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
 <20190611200043.eib3g3acc7ilawsx@earth.universe> <20190612060328.GQ4797@dell>
In-Reply-To: <20190612060328.GQ4797@dell>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 13 Jun 2019 11:35:06 +0300
Message-ID: <CANhJrGNM7fBXa8cY6ybF8WsaigwcREMvbGN0K4pdUVKck4POzw@mail.gmail.com>
Subject: Re: [PATCH v15 0/7] support ROHM BD70528 PMIC
To:     Lee Jones <lee.jones@linaro.org>,
        "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 12, 2019 at 9:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 11 Jun 2019, Sebastian Reichel wrote:
>
> > Hi,
> >
> > On Mon, Jun 03, 2019 at 10:23:37AM +0300, Matti Vaittinen wrote:
> > > Patch series introducing support for ROHM BD70528 PMIC
> > > [...]
> >
> > I think all patches have been reviewed by the respective subsystem
> > maintainers. Lee, can you provide an immutable branch with the MFD
> > patches (1, 2, 4)? Looks like the other patches only depend on those
> > and can go through their respective subsystems.
>
> Yes.  It's on my TODO list.
>
> Would you prefer this method over me just taking them all and sending
> out a PR?  The latter is my usual flow, but I'm happy with either.

Thanks guys for taking care of this! :)

--Matti

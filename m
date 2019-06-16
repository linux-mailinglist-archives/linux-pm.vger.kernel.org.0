Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857C14757F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2019 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFPP14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Jun 2019 11:27:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46533 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfFPP14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jun 2019 11:27:56 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so15863006iol.13;
        Sun, 16 Jun 2019 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPdgLhFxC6S2iXglokqYTyVchXogMF9BrEQ21au7qLg=;
        b=uLl1WLigX67Y767DajoTMuwBZl+FMbCzg3H0R+gdR8tvCtt6AspF3DXQt6YHTFEZ5C
         n8Yvjo7pXBdo4PMdDHsIA1nq/u69en2un8UqNEsP1ykVPJCfMB0fZb69WafPuyK1cv9e
         g9QjhtZdtU4FCgk+hi2+6kOzcrE8LVbaoJDCLjwxhgDUzEUH6YYvtT0nz5qk4gN44Wyt
         hwbKTZzxfMC2ofYjznYNCrsrrkPnSzhkyOtWW6CyLIfK9VIfIw43cWhV/wOltf41T0LV
         VvwSZYUIXLX1V/6ATgESQFdX8XmOoAa8H9Z4Ccy+K/czrTTo6TB08A48xaZqE/C2ftvD
         W9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPdgLhFxC6S2iXglokqYTyVchXogMF9BrEQ21au7qLg=;
        b=ijBfpbHVCmrzizKqclqTXDhb7n/j8zgrozFCOPyIbZ98N3b6JfMLBYS+wBInWvXMI+
         kBDkT9M46tOVIm4DVCvd5eDommWendhSZnbmQFGpO2qfvTd2tfiiGrV3eJPc5+ZR98yI
         3rJSkQuO69otfu/TC5+60tzf73J239GtTLehQmZv9iZbgWZHFRFpXczQmwzlxo8VGdoQ
         kAR18bUdiQmFr7JFfvhiI59n9NpilTndZeCf6fnkBOe7zK9h8ZgHLPsx6Y0dv4WQhp/N
         Lx8bkTD4g0512F+lb6ksTeYNNu0/9Aonnb3u4f/Bc4rYxyMcybePP80ATn2cCHNtJdbk
         fJ8w==
X-Gm-Message-State: APjAAAXWyQ9ezsJyyH+eICB0tcnUM5lWKq6i76vegtAH3Ef3doJA8Zpy
        167w11aQIoiFO2WKcyXWlEHtRhMlfifuOu7MbRY=
X-Google-Smtp-Source: APXvYqyF2bj9jxL7xKv9ieUmH9q3g6ph/705HIVbMWqkgg4NJla/npMnFF+tY5IccVOZhEi0qd3NB0W8VtO4QPo4oMQ=
X-Received: by 2002:a5e:8e42:: with SMTP id r2mr15141138ioo.305.1560698875702;
 Sun, 16 Jun 2019 08:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
 <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
 <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com>
 <CAEExFWs58UNcVcQNnwK3dk5cpmfQRnjdRWAmYs5M1t_ONr1Bpw@mail.gmail.com> <CA+E=qVf-_2DWbf55bCnjbkZH9N4a1_K16OxN9=o=NrZAV7GXPA@mail.gmail.com>
In-Reply-To: <CA+E=qVf-_2DWbf55bCnjbkZH9N4a1_K16OxN9=o=NrZAV7GXPA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 16 Jun 2019 23:27:44 +0800
Message-ID: <CAEExFWthch7MOafwyma0qkx3szii6TG_kB26K+KeY=82xwu=Aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 15, 2019 at 7:08 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 9:50 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > > If you have a git tree I'll be happy to contribute A64 support. IIRC
> > > it was quite similar to H3.
> >
> > I built a ths branch and I will do some work later.
> >
> > https://github.com/TinyWindzz/linux/tree/ths
>
> Looks like you forgot to add your patches to this branch.

Frankly, I started the new version this weekend. There is still a
small part of the
hand that has not been completed, and I will push patches to my branch
these two days.

MBR,
Yangtao

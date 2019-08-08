Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83E986ABB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfHHTrs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 15:47:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36778 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbfHHTrs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 15:47:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so123406733oti.3;
        Thu, 08 Aug 2019 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVsgaqUQ+TY2x5x7j3h0EJIjp1dyKYtAS/dTFHwFE4Q=;
        b=OpC2gncSoouwEVr7BnFdYNGd+LTHxiJVVLiZJqUASJhCoGnH7dth65A7q3cNhqzbaR
         pFGqq1Rvb1KcpsNFycH3tgSzHrHKMhleLnfVvqcyAQEKvIXtUPBMw2RLnJ7wsYwEaJ5E
         yFi56IdDPTVsWQpc/jaUbb2QY+sA0j32RCCUgsvHocyOyswM51qD1lPxs8a15pOav2Vg
         Uuk6GL3du0HTsrRV9oaaDjUPtyNNRKIYLoSLXls/+1ZSRgtGHWJLqnap/u5EQfPfsA8z
         ml9FIlnAiDzEokQGAeydeUOI8nz4l8lKhbmdO4H4lzO5iDYpQzzc8wh3lHuKDySsu+fO
         ZFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVsgaqUQ+TY2x5x7j3h0EJIjp1dyKYtAS/dTFHwFE4Q=;
        b=d7j9nMEaspP6HcY1TrL1CbJeq1ZMx4Imd3Z2XmCeCy5ckctxHLNtdlukmNKOeS7GkL
         +ugpp5A9kaqGjUlEGy7a6qXsFM0QhF8BzdGhA0s0iGqw4B6OKM0RmFK+uOj5wCdDkEGT
         A1DvVbhoto0xUyrYsmwXmoNDqmm5JKocNcaWQT1sC/XdcPYyWD1DVT7yfFRiuaziGp09
         Ri0hk16xCB75Hkw3vwenznCepCE5HQTOTCQzCv6UNVWPjnUfA5Ow08jI26Z4XNUaBzLC
         47kDvdbByB84s5uZ4oUoIjD8zDKrzDpheR9227XuSQL7qNhrunUv5chNH0ijBQ3bA/CQ
         F1NQ==
X-Gm-Message-State: APjAAAWJi5B2gNaeiPOveQ6vtez2K3Id7lkGdKA5tVSdBtNhD5XazWQU
        HFQKeCAK3upb0ZqTURSFyTLRqVFwrQn8xlEEWvU=
X-Google-Smtp-Source: APXvYqwB+udbmGy6ZFtRl3z5o6an+2PDm6oq7fHTtN2/gSnu1r5f4Cu204e9wczn6Do0L2d8lFmaDEqcIHEGVEjwifU=
X-Received: by 2002:aca:d415:: with SMTP id l21mr3860865oig.96.1565293666522;
 Thu, 08 Aug 2019 12:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-3-glaroque@baylibre.com>
 <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com>
 <14e14cd9-46bd-0d43-654c-6db64397f5c7@baylibre.com> <CAFBinCB3ZBPVEJKV2Rfh_w-zWrhoToYdoYE6Wox+JeB-YH+Khw@mail.gmail.com>
 <7hblx0fjkw.fsf@baylibre.com>
In-Reply-To: <7hblx0fjkw.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 8 Aug 2019 21:47:35 +0200
Message-ID: <CAFBinCBzDM7dpAKwf29UENvHgCEscyUCHdjQwb6Wkz4i2ShJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] thermal: amlogic: Add thermal driver to support
 G12 SoCs
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     guillaume La Roque <glaroque@baylibre.com>,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kevin,

On Thu, Aug 8, 2019 at 4:59 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Hi Guillaume,
> >
> > On Mon, Aug 5, 2019 at 2:48 PM guillaume La Roque <glaroque@baylibre.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> again thanks for your review.
> > you're welcome - thank you for working on the driver :-)
> >
> > [...]
> >> > The IP block has more functionality, which may be added to this driver
> >> > in the future:
> >> > - reading up to 16 stored temperature samples
> >>
> >> it's not working, you can verify it if you check the regmap define in the driver. in fact temp is only write in one register, it's confirmed by amlogic.
> > I missed that - so please skip this part
> >
> > [...]
> >> >> +config AMLOGIC_THERMAL
> >> > we typically use "MESON" in the Kconfig symbols:
> >> > $ grep -c AMLOGIC .config
> >> > 1
> >> > $ grep -c MESON .config
> >> > 33
> >> >
> >> > I also wonder if we should add G12 or G12A so we don't conflict with
> >> > upcoming thermal sensors with a different design (assuming that this
> >> > will be a thing).
> >> > for example we already have three different USB2 PHY drivers
> >> >
> >> > [...]
> >>
> >> i check with Neil and for new family it's better to use Amlogic instead of meson.
> > can you please share the considerations behind this decision?
> > if new drivers should use AMLOGIC_* Kconfig symbols instead of MESON_*
> > then we all should know about it
> >
> >> i don't add G12 because we already know it's same sensors for SM1 SoC family [0].
> > my idea behind this was to avoid conflicts in the future
> > in case of the thermal driver we may be fine with using a generic name
> > assuming that Amlogic will not switch to a new IP block in the next
> > years
> > I'm not saying you have to change the name - I'm bringing this up so
> > you can decide for yourself based on examples from the past
> >
> > here are a few examples:
> > - when Kevin upstreamed the MMC driver for GX he decided to use
> > MMC_MESON_GX for the Kconfig symbol name. it turns out that this is
> > smart because there are at least two other MMC controller IPs on the
> > 32-bit SoCs. due to him including GX in the name the drivers are easy
> > to differentiate (MMC_MESON_MX_SDIO and MMC_MESON_MX_SDHC being the
> > other ones, while the latter is not upstream yet)
> > - when Carlo upstreamed the eFuse driver he decided to use MESON_EFUSE
> > for the Kconfig symbol name. I found out much later that the 32-bit
> > SoCs use a different IP (or at least direct register access instead of
> > going through Secure Monitor). the driver for the 32-bit SoCs now uses
> > MESON_MX_EFUSE. if you don't know which driver applies where then it's
> > easy to mix up MESON_EFUSE and MESON_MX_EFUSE
> > - when Jerome upstreamed the ALSA driver for AXG (which is also used
> > on G12A and G12B) he decided to use the SND_MESON_AXG_* prefix for the
> > Kconfig symbol names. in my opinion this was a good choice because GXM
> > and everything earlier (including the 32-bit SoCs) use a different
> > audio IP block. we won't have a Kconfig symbol name clash when a
> > driver for the "older" SoCs is upstreamed
> > - (there are more examples, Meson8b USB PHY driver, Meson8b DWMAC
> > glue, ... - just like there's many examples where the IP block is
> > mostly compatible with older generations: SAR ADC, RNG, SPI, ...)
>
> While these are all good examples, you can see it can go both ways, so
> there's really no way know up front what is the "right" way.  We only
> know after the fact.  Unfortunately, we simply have no visibility into
> future chips and where IP blocks may be shared or not (there are other
> examples where vendors add a new version of an IP *and* keep the old
> version. ;)
>
> Even having worked inside a (different) SoC vendor and having some
> knowledge about what IPs are shared, it's difficult to get this right.
right. The fact that it'll be the IP block in SM1 will be backwards
compatible (or even the same) means that it has a longer life-span
than some of the USB PHY IP.
so I'm fine either way


Martin

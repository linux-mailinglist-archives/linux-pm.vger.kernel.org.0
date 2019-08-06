Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC75839DD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfHFTwp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 15:52:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37885 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 15:52:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so68433536oih.4;
        Tue, 06 Aug 2019 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4E/kye31gm/TUQMINOCXfCGV9Lfx0lm6nnvhyTx90lw=;
        b=Yzk47bOJktflINEYudmIXcRskp+l8U5BovlNaqWp2akIE2xwTuHvoX3zT22MAUDuJ3
         XO8JCNSJ39+r3FvB83PSqvCOdBb6dA453gqBq5UjxYm/x939xxHrUQzGEjpWMeDkbg7C
         PU9R1vq6BARJBbD+Qx8FegPLsD/BA+rrPXewHWSRN9ukZN2EId0grtB068+Xr6vbxVvs
         fJ9+rJiecg5Jn3pzoqdn4FJOtqfEIua19AftTYsNEwolx2VFWVCN7f0cwiIYqdjfj2ew
         nwgw6Avn3h9aL2w/i5R+J0oEt6Ie4TjULWWKGT8FbgpuY1Nd4cVcGk7HfaKsTVYhV7NB
         aslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4E/kye31gm/TUQMINOCXfCGV9Lfx0lm6nnvhyTx90lw=;
        b=J97I8khRV4aUIrKxU6BpSL428fy58Qzn4U/9L8pGQy6saPuRu3i44xEiAm0Rz4v6MP
         6DNatja/cWF+9Wn372TT1ZHqiVEeAo7oZ4YHLbcHJzLyKYKT8fPEPZOEP6E7Z7W5hlVr
         kf8XhvCIdNf6W0k2VSXLkxmDeW/PrJoedyVufBhIBUQ52BuM3VmkSeYV/z8KmiRcOtEA
         ZCdf0mCsSWfXVHjnRauWedADjc2s1Th3BQfU4KYoBDc3/2ZMI7mXj+R9dSBg+bgdQML2
         8DvoT60TYlDabSldY5MPov/ziuX5y0tYFoOIlwVQiTg91eyJzYt/iP6YYQkoxYwT8luB
         c3Ew==
X-Gm-Message-State: APjAAAV/shxJ67pIMrWbDh2zVcJz8z03F/4C4DZPwvQL+gXJtZFEuM/P
        HX66+xx5lFm5qM30tE4f/fNsRpSUvd4Brz3hlXU=
X-Google-Smtp-Source: APXvYqw1ATDKzq4Ht5dmq0BSO1jAsgEOQjI9m/cdHrI7S9kc9h6PS8yJ28neuhhhpzIY2bUqGqV7RB4pF2K8DWgt1V0=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr3801512oie.140.1565121163808;
 Tue, 06 Aug 2019 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-3-glaroque@baylibre.com>
 <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com> <14e14cd9-46bd-0d43-654c-6db64397f5c7@baylibre.com>
In-Reply-To: <14e14cd9-46bd-0d43-654c-6db64397f5c7@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Aug 2019 21:52:32 +0200
Message-ID: <CAFBinCB3ZBPVEJKV2Rfh_w-zWrhoToYdoYE6Wox+JeB-YH+Khw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] thermal: amlogic: Add thermal driver to support
 G12 SoCs
To:     guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

On Mon, Aug 5, 2019 at 2:48 PM guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Hi Martin,
>
> again thanks for your review.
you're welcome - thank you for working on the driver :-)

[...]
> > The IP block has more functionality, which may be added to this driver
> > in the future:
> > - reading up to 16 stored temperature samples
>
> it's not working, you can verify it if you check the regmap define in the driver. in fact temp is only write in one register, it's confirmed by amlogic.
I missed that - so please skip this part

[...]
> >> +config AMLOGIC_THERMAL
> > we typically use "MESON" in the Kconfig symbols:
> > $ grep -c AMLOGIC .config
> > 1
> > $ grep -c MESON .config
> > 33
> >
> > I also wonder if we should add G12 or G12A so we don't conflict with
> > upcoming thermal sensors with a different design (assuming that this
> > will be a thing).
> > for example we already have three different USB2 PHY drivers
> >
> > [...]
>
> i check with Neil and for new family it's better to use Amlogic instead of meson.
can you please share the considerations behind this decision?
if new drivers should use AMLOGIC_* Kconfig symbols instead of MESON_*
then we all should know about it

> i don't add G12 because we already know it's same sensors for SM1 SoC family [0].
my idea behind this was to avoid conflicts in the future
in case of the thermal driver we may be fine with using a generic name
assuming that Amlogic will not switch to a new IP block in the next
years
I'm not saying you have to change the name - I'm bringing this up so
you can decide for yourself based on examples from the past

here are a few examples:
- when Kevin upstreamed the MMC driver for GX he decided to use
MMC_MESON_GX for the Kconfig symbol name. it turns out that this is
smart because there are at least two other MMC controller IPs on the
32-bit SoCs. due to him including GX in the name the drivers are easy
to differentiate (MMC_MESON_MX_SDIO and MMC_MESON_MX_SDHC being the
other ones, while the latter is not upstream yet)
- when Carlo upstreamed the eFuse driver he decided to use MESON_EFUSE
for the Kconfig symbol name. I found out much later that the 32-bit
SoCs use a different IP (or at least direct register access instead of
going through Secure Monitor). the driver for the 32-bit SoCs now uses
MESON_MX_EFUSE. if you don't know which driver applies where then it's
easy to mix up MESON_EFUSE and MESON_MX_EFUSE
- when Jerome upstreamed the ALSA driver for AXG (which is also used
on G12A and G12B) he decided to use the SND_MESON_AXG_* prefix for the
Kconfig symbol names. in my opinion this was a good choice because GXM
and everything earlier (including the 32-bit SoCs) use a different
audio IP block. we won't have a Kconfig symbol name clash when a
driver for the "older" SoCs is upstreamed
- (there are more examples, Meson8b USB PHY driver, Meson8b DWMAC
glue, ... - just like there's many examples where the IP block is
mostly compatible with older generations: SAR ADC, RNG, SPI, ...)

I'm not sure what driver naming rules other mainline SoC teams use
to me it seems that the rule for Allwinner driver names is to use the
"code-name of the first SoC the IP block appeared in"

[...]
> >> +static int amlogic_thermal_get_temp(void *data, int *temp)
> >> +{
> >> +       unsigned int tvalue;
> >> +       struct amlogic_thermal *pdata = data;
> >> +
> >> +       if (!data)
> >> +               return -EINVAL;
> >> +
> >> +       regmap_read(pdata->regmap, TSENSOR_STAT0, &tvalue);
> >> +       *temp = code_to_temp(pdata,
> >> +                            tvalue & TSENSOR_READ_TEMP_MASK);
> > maybe simply move the implementation from code_to_temp here?
>
> for the optional function it could be a problem if i move all in code_to_temp.
>
> i prefer to have a function which are just do the conversion.
I didn't consider this before but you are right
if the other temperature registers (like IRQ thresholds) also use a
"temperature code" then it should be a dedicated function (so it'll be
easier to add more functionality to the driver)


Martin

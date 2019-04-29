Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8665EAA5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfD2TKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 15:10:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37780 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbfD2TKk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 15:10:40 -0400
Received: by mail-it1-f196.google.com with SMTP id r85so818268itc.2;
        Mon, 29 Apr 2019 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkDvipA08mC8IxvH8qSF4bz6Gcm5+BjwC5oiwie6/+k=;
        b=Ve8XuKyGlDC7d2Jvv5JaFeEFVAN2jn4Wg3QY/h79fYFFc1Gn6E1SWgOE0LXGs3cKFE
         6uJSMSnHFL3OsVIykxCMPR0dttZ74X/ELKhgOBL/ILoONnzQ5ThckDLH1amLcUVNx3d6
         W/GUBBAdD1ZPt3D110gl+7UoYrQEFRHsuAOLEsF1Rf6WgvZ7q0UqANogslubKvkn9tbF
         9WbTvIoSc5HK9pb826UynoX6IbBoyw0t5qU8973CIGOQalIHLmjjCufU5CwqO/ovGSmV
         FjgjjcPs9sqpnYkXcILGgODVrWI8Aef3xVhVoTbkJY1uRom7QOEMy/Pnn+J/nw8hHS0V
         P/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkDvipA08mC8IxvH8qSF4bz6Gcm5+BjwC5oiwie6/+k=;
        b=RI4LI1MzZQtp2BVEm0mp0MN9NN/FUWuyBl736HfLvXHbvqEOFJn7CM+sJfLZLThHZ6
         nSIDKGfmN9Rb7+VrkihIJQAkYiNBnkXmG52a8MimgIhEPwuyOlxu5Mo8wX1tIlCd+PbF
         6g7kSESYpSsrpwWKA8+TeoDs0GXocJ4wCVuZasaMUQqOpH/YIdZ8BP5wpMA40pio3t1D
         eQsKRgw6XrKKpeUe3XI5+20B0uBwsH4JyzVigPoDpcHKeBvlZstBUM0XvkPV4LshEXWE
         w2TPODtMChCRYoGkS+YdbCnEYf9oA5W2r/AZ6IxsAnAh9ZcqcsHeuF3PHhf2Ju6nbPCN
         BM4g==
X-Gm-Message-State: APjAAAVsBwIG9aeQ+XQbW8RdO03s8L13w8iACZk6TGt2WCeyj0lwZAH2
        8my/gW0CKqkaNsq/wD2XiVqiK8zGRwROvCmzDZM=
X-Google-Smtp-Source: APXvYqxjcgCsVThGvzbspmleSENSy0vAB6gHVpHLHIM/eJvNC75iwpTXhF3s96hudw8y9HP19dvMhBdh2kK5aKvCYO4=
X-Received: by 2002:a02:62ce:: with SMTP id d197mr43109134jac.91.1556565038867;
 Mon, 29 Apr 2019 12:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190429054741.7286-1-andrew.smirnov@gmail.com>
 <20190429054741.7286-3-andrew.smirnov@gmail.com> <1556533656.2560.7.camel@pengutronix.de>
In-Reply-To: <1556533656.2560.7.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 29 Apr 2019 12:10:27 -0700
Message-ID: <CAHQ1cqECkn3242zVb55ifmgEHdq0se91=PpS1zDL4wj2WdZmbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] power: supply: Add driver for Microchip UCS1002
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 3:27 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Sonntag, den 28.04.2019, 22:47 -0700 schrieb Andrey Smirnov:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > > Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> [...]
> > +     /* Enable charge rationing by default */
> > > +   ret = regmap_update_bits(info->regmap, UCS1002_REG_GENERAL_CFG,
> > > +                            F_RATION_EN, F_RATION_EN);
> > > +   if (ret) {
> > > +           dev_err(dev, "Failed to read general config: %d\n", ret);
> > > +           return ret;
> > > +   }
> > +
> > > +   /*
> > > +    * Ignore the M1, M2, PWR_EN, and EM_EN pin states. Set active
> > > +    * mode selection to BC1.2 CDP.
> > > +    */
> > > +   ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> > > +                            V_SET_ACTIVE_MODE_MASK,
> > +                              V_SET_ACTIVE_MODE_BC12_CDP);
>
> This doesn't work as the F_PIN_IGNORE bit isn't set, so the the
> external strap settings are applied. I had to apply the following diff
> to make the driver behave as expected again:
>

Ugh, I missed this since pins on my board are set properly. Thanks for
catching that and sorry about the bug. Will fix in v3.

Thanks,
Andrey Smirnov

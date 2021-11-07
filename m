Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6D447602
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhKGVLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 16:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhKGVLS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 16:11:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693ABC061570;
        Sun,  7 Nov 2021 13:08:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o18so31699434lfu.13;
        Sun, 07 Nov 2021 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HS4k4dHmpgQy3IqheKIAT8SevHkNeUPtj1WupoOJbtI=;
        b=dB/y4YdDzEqpBD6m6sq1ZL/7rdqgAg4MxsLjqz/1yza27d/65lJGEElo9THcMTqDBz
         Pt4OGNG9VYfEJEdJJ8/sz6Y0zPsbpwP1A+2Ln5Mba76p7rk7rgB1yEQmzXfAyDO3rjU8
         8Ktq+qh/dfmIZqQITkYS6ApDzOLdDqvegs8rXTxqOVDXKBBL9IpWmYelH6gx40ieC1Fs
         6UDabh8MfD9kXRUk6qM3TeaBa1uDj0PPMADsoDrDpyCRwzr3rMpljKmhoRQ4XD8hmJJl
         wxx/Cp8GCc+B2ofQZH8jS0pHRP9AhwI/d0eBgQLQEnpKhkH8llnbJBMTe+wHw2TXWrj6
         +oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HS4k4dHmpgQy3IqheKIAT8SevHkNeUPtj1WupoOJbtI=;
        b=oRRujwbl/dQof1eAydib0ztAMV7dLVIBWCyic7gk9Y9gm1eVOBV9qUiAJEAdVualow
         bAF1ZBd79QTj1cpkklHrTl+nIW/mtvxvCmyVc3/+MVpn1N9YCNwQBzplpxWNkS/QAquF
         NX2+7PuEsonHKXynx75VNw9x+iXmrYh0TykNJYPhY7Dlr1tONshCMPGZ+kTy8P8dgHVk
         MNBnpiU98FtmrbZT9Wt8T/MZV2OSj22YX6Mgw7elRdlgiJa8CFyFNPflkINg84MlyDbr
         Z7Q+625JWDowgPoVTjZLsz3J3wFi3IGfcAyU+tTdnVdUrtFCzQkO5lVw2rG6yEPzWcVE
         fLzg==
X-Gm-Message-State: AOAM533d0PnptwGZtrVngVZJQ9Gjh0oICO0ERNu6O6gPrQqP5LgBstjy
        9jVV0wdQRbbLau6YcRp2O4cP61/awiOX8Xti
X-Google-Smtp-Source: ABdhPJx4Hs/rCXJfQNYbGNLuVDduJUtdFGeIrCSBHQdexfyx9j0WBPJeJaYIxUwt8FVzk+j6WPUgSA==
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr3253855lfb.35.1636319313687;
        Sun, 07 Nov 2021 13:08:33 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id f6sm1500114ljk.45.2021.11.07.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 13:08:33 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjpOy-000EQl-7g;
        Mon, 08 Nov 2021 00:08:32 +0300
Date:   Mon, 8 Nov 2021 00:08:32 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] bq25890: Add max input current limit property
Message-ID: <YYhAUH2nvj1b0uCW@jeknote.loshitsa1.net>
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-2-jekhor@gmail.com>
 <85a4674a-9212-6f02-d351-72b2223cc4a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a4674a-9212-6f02-d351-72b2223cc4a9@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 07, 2021 at 09:41:55PM +0100, Hans de Goede wrote:
> Hi Yauhen,
> 
> On 11/7/21 21:19, Yauhen Kharuzhy wrote:
> > Add property 'ti,input-max-current' to define input current limit if
> > needed. It will be applied if automatic charger type detection is
> > disabled and using of ILIM pin is disabled or such pin defines greater
> > limit than IINLIM field.
> 
> Sorry, but this makes no sense, as the datasheet says the charger
> itself updates iinlim dynamically when it has done charger-type
> detection (for the bq25890 version) and for the bq25892 version
> which does not have the D+ + D- USB pins for BC1.2 detection,
> the iinlim should be updated based on the charger detection
> done elsewhere (by the Whiskey Cove PMIC in case of the Yoga Book).

For Yoga Book, charger detection in the bq25892 is disabled and done in
the extcon driver.

> My plan for this is to have drivers/extcon/extcon-intel-cht-wc.c
> also register a power_supply device which models the detected
> charger / negotiated external charger/power-brick settings and
> which is the supplier of the bq25892 charger.
> 
> Then an external_power_changed handler can be added to the
> bq25892_charger code using the
> power_supply_set_input_current_limit_from_supplier()
> helper to dynamically set iinlim based on the detected
> "power-brick"/external-charger.
> 
> This is also how this is done for (X86) devices with an
> full-featured USB Type-C port where this needs to be handled
> by the kernel (rather then it being done in firmware) in
> this case the current-max property of the Type-C power-supply
> class device gets set either based on the Type-C pull-up
> resistor in the charger (setting 0.5A / 1.5A / 3A), with
> a fallback to BC1.2 for the 0.5A case, or based on the
> USB-PD negotiated max-current.

Agree, looks reasonable.

> 
> Since we will need this mechanism to dynamically set
> iinlim based on the PMIC-s charger-detection it seems
> to me that setting it at boot is both unnecessary and a bad
> idea, since we don't know the correct value to set at boot.
> 
> The extcon code will start a charger-detection cycle
> as soon as it loads (if there is Vbus present) and then
> trigger the external_power_changed handler .
> 
> TL;DR: I don't really see a need for this ?

Hmm... I think you are rigth. The only case when such property can be
needed – if the device may be damaged by maximum current supported by
charging source. I use it to limit current by 2A when original Lenovo adapter
is connected because the linux kernel has default max current limit
5A for DCP (drivers/usb/phy/phy.c) but adapter supports only 2A.

> 
> 
> > ---
> >  drivers/power/supply/bq25890_charger.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> > index 34467bfb9537..1c43555d5bd8 100644
> > --- a/drivers/power/supply/bq25890_charger.c
> > +++ b/drivers/power/supply/bq25890_charger.c
> > @@ -85,6 +85,7 @@ struct bq25890_init_data {
> >  	u8 treg;	/* thermal regulation threshold */
> >  	u8 rbatcomp;	/* IBAT sense resistor value    */
> >  	u8 vclamp;	/* IBAT compensation voltage limit */
> > +	u8 iinlim_max;	/* maximum input current limit allowed */
> >  };
> >  
> >  struct bq25890_state {
> > @@ -657,6 +658,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
> >  		{F_TREG,	 bq->init_data.treg},
> >  		{F_BATCMP,	 bq->init_data.rbatcomp},
> >  		{F_VCLAMP,	 bq->init_data.vclamp},
> > +		{F_IINLIM,	 bq->init_data.iinlim_max},
> >  	};
> >  
> >  	ret = bq25890_chip_reset(bq);
> > @@ -870,11 +872,13 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
> >  		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
> >  		{"ti,ibatcomp-micro-ohms", true, TBL_RBATCOMP, &init->rbatcomp},
> >  		{"ti,ibatcomp-clamp-microvolt", true, TBL_VBATCOMP, &init->vclamp},
> > +		{"ti,input-max-current", true, TBL_IINLIM, &init->iinlim_max},
> >  	};
> >  
> >  	/* initialize data for optional properties */
> >  	init->treg = 3; /* 120 degrees Celsius */
> >  	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
> > +	init->iinlim_max = 0x3f;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(props); i++) {
> >  		ret = device_property_read_u32(bq->dev, props[i].name,
> > 
> 

-- 
Yauhen Kharuzhy

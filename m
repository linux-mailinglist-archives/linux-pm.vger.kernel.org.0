Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AC30AEB0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBASEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 13:04:23 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36674 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBASEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 13:04:21 -0500
Received: by mail-wr1-f54.google.com with SMTP id 6so17627825wri.3;
        Mon, 01 Feb 2021 10:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fKxZfOhT/DW7ng3x2hQg+/AugT9c3F61tbpfJY+S9fg=;
        b=o0ja68jjfo0vxAZuQK1dJm18nv709vSsKmLfIwnUOxB/tO4pA0T7vf1atU+1tlx0zO
         3EZaev+FtG0p32/dhSFuWVfF8ySvs6dz+gOsNZ4IuH514agCQHDWwbYv1gV3v33Ca7pV
         khvqZPcr+1qAE4opjFbHmue3U9DIPV4X3eAmymoM5E7DTB03Ul5Qs0tCWpGbjhwrFgFa
         ooWhIlZdTHQsmn4mIv7o/sWQeMuDQwFcaxQY5V3aWabb6UCmcGV/OiRGBP4MV35S78ZA
         MDLMNiQFwhQ3BUSJ0PJKxu7/e1YNTwD7K6S+irIBhpFt9ESL+ldeX00M/eRkCt/Bjyfv
         xEOw==
X-Gm-Message-State: AOAM530b6sfj7V5vBEToDA36W8IPbwp1yh0B83praLVcMg9VX3/RT7o4
        I2IHukhV52dUTmPKv7PxW74=
X-Google-Smtp-Source: ABdhPJwL6YHDCvYoDuQCnzLFd63X1o28rVOo0eX5DFDlJKIewDByM/euMbQI7hRpkiGev2a9nEBpbg==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr18936280wrk.89.1612202619004;
        Mon, 01 Feb 2021 10:03:39 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t17sm42062wmi.46.2021.02.01.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:03:37 -0800 (PST)
Date:   Mon, 1 Feb 2021 19:03:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210201180335.rrsqfvbcmxvx64gf@kozik-lap>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
 <20210130172747.2022977-4-timon.baetz@protonmail.com>
 <20210131172840.fxaadhhsafa4aeex@kozik-lap>
 <20210201083128.18499ffd.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201083128.18499ffd.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:42AM +0000, Timon Baetz wrote:
> On Sun, 31 Jan 2021 18:28:40 +0100, Krzysztof Kozlowski wrote:
> > On Sat, Jan 30, 2021 at 05:30:14PM +0000, Timon Baetz wrote:
> > > Get regulator from parent device's node and extcon by name.
> > >
> > > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > > ---
> > >  drivers/power/supply/max8997_charger.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> > > index 321bd6b8ee41..625d8cc4312a 100644
> > > --- a/drivers/power/supply/max8997_charger.c
> > > +++ b/drivers/power/supply/max8997_charger.c
> > > @@ -168,6 +168,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > >  	int ret = 0;
> > >  	struct charger_data *charger;
> > >  	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  	struct i2c_client *i2c = iodev->i2c;
> > >  	struct max8997_platform_data *pdata = iodev->pdata;
> > >  	struct power_supply_config psy_cfg = {};
> > > @@ -237,20 +238,23 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > >  		return PTR_ERR(charger->battery);
> > >  	}
> > >
> > > +	// grab regulator from parent device's node
> > > +	pdev->dev.of_node = iodev->dev->of_node;
> > >  	charger->reg = devm_regulator_get_optional(&pdev->dev, "charger");
> > > +	pdev->dev.of_node = np;  
> > 
> > I think the device does not have its own node anymore. Or did I miss
> > something?
> 
> The idea is to reset of_node to whatever it was before (NULL) and basically 
> leave the device unchanged. Probe might run again because of deferral.

Good point.

> 
> > >  	if (IS_ERR(charger->reg)) {
> > >  		if (PTR_ERR(charger->reg) == -EPROBE_DEFER)
> > >  			return -EPROBE_DEFER;
> > >  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
> > >  	}
> > > -	charger->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
> > > -	if (IS_ERR(charger->edev)) {
> > > -		if (PTR_ERR(charger->edev) == -EPROBE_DEFER)
> > > +	charger->edev = extcon_get_extcon_dev("max8997-muic");
> > > +	if (IS_ERR_OR_NULL(charger->edev)) {
> > > +		if (!charger->edev)  
> > 
> > Isn't NULL returned when there is simply no extcon? It's different than
> > deferred probe. Returning here EPROBE_DEFER might lead to infinite probe
> > tries (on every new device probe) instead of just failing it.
> 
> extcon_get_extcon_dev() just loops through all registered extcon devices
> and compared names. It will return NULL when "max8997-muic" isn't
> registered yet. extcon_get_extcon_dev() never returns EPROBE_DEFER so
> checking for NULL seems to be the only way. Other drivers using that
> function also do NULL check and return EPROBE_DEFER.

Indeed, thanks for clarification. Looks good:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


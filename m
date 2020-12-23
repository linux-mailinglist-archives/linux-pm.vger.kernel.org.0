Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091352E19ED
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLWI2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 03:28:04 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35728 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgLWI2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 03:28:03 -0500
Received: by mail-wr1-f48.google.com with SMTP id r3so17757876wrt.2;
        Wed, 23 Dec 2020 00:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUVBf1H4BZsLh5EiHS+l8aTe/qKRYRM0fwXYQnOuMno=;
        b=HIQaBD1sU+67Bvzp3J4WY3IkgOsnxH89ELXHMyhMziirZlTjtol3/O7ldRMaBM68A3
         NI9s1O3MCroFCIOqQVn4+PPHDA4eQUiHj5nXDIImhrWvw9TQw1T3OpR1pOcDBBoQKoEv
         1c6h8wtqEpGp6aEpk2AMGrYqeThUANulvYfQ96ovuizwPyAhmnc6IZOJDYxL0FUz5ANV
         +17dBzTACENmwozwXUCrUf2GSgP1SJBerOJ9A7tm0zppnWlnGedkQLWT64DTh40Qc3qE
         JfTxShTcrbzLt6FXOnvTWB1Ycq/fprfGZ5XgLxfXxqPRT9XJ0DPGLp935HGgioxRrngI
         EOnQ==
X-Gm-Message-State: AOAM5320tVERD8ZJPMie8dlK+XqdVFYCBXusvutOfLKrOSxom1n5dR0D
        pDOsbz0+yGCwp0jTiEk5sCM=
X-Google-Smtp-Source: ABdhPJz5X6Cf0bT7wSFl1EyCVBJePEFERj0lAztwVNT4Nv4+gegPgh9sxDuQYcJ9POAVur3wpM3Ldw==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr28315130wrw.157.1608712041535;
        Wed, 23 Dec 2020 00:27:21 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c81sm31699679wmd.6.2020.12.23.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:27:20 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:27:18 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 4/7] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201223082718.GA5472@kozik-lap>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
 <20201222070520.710096-4-timon.baetz@protonmail.com>
 <20201222084004.GD5026@kozik-lap>
 <20201223090114.750664cd.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223090114.750664cd.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 23, 2020 at 08:09:55AM +0000, Timon Baetz wrote:
> On Tue, 22 Dec 2020 09:40:04 +0100, Krzysztof Kozlowski wrote:

(...)
> > >  	.name		= "max8997_pmic",
> > >  	.type		= POWER_SUPPLY_TYPE_BATTERY,
> > > @@ -170,6 +237,33 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > >  		return PTR_ERR(charger->battery);
> > >  	}
> > >
> > > +	charger->reg = devm_regulator_get(&pdev->dev, "charger");  
> > 
> > The code looks good but isn't it breaking all existing platforms?
> 
> So there is 2 other DTS in the kernel sources that are using MAX8997
> pmic:
>  - Insignal Origen evaluation board
>  - Samsung Trats
> Non of them have charging regulators.

But still the power supply was probing on them (if not the error you
mentioned).  Now, the charger will fail.

> Also probing of the charger has been failing for long time because of 
> https://lore.kernel.org/lkml/20201109194251.562203-2-timon.baetz@protonmail.com/
> but that seems to land in 5.11.

That's a good argument supporting introduced breakage. Use it in commit
message. Don't hide such information.

> That being said, I guess I could make extcon and charger-supply
> optional if you prefer.

Since at least two boards will loose now power supply, I don't think you
have a choice.

Best regards,
Krzysztof


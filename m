Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA952E35F2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 11:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgL1Kbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 05:31:38 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:33951 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgL1Kbi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 05:31:38 -0500
Received: by mail-ej1-f41.google.com with SMTP id g20so13645657ejb.1;
        Mon, 28 Dec 2020 02:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VUjlviQhQrSckmn29OEdX9bqN+0BiO0akV0P/7OhNnY=;
        b=tsO+4pQ0IWrCZOm5n2LQEru6fIdLIp1gAAa93fB3dnMfZmSKv/WENSWnscyAdBghvF
         f+ZWPUdFhb0Mpv+VBmVHA6sNXHT+IdVwrZ4+tuIe1Fmb/FwPSZEHWWVP06IoQzqQLjyM
         gxfCsXxfG9P3WEOVZvZZxkolXzaES+YSq/bjLC9sZKQZ380Zahk6BxzroXWNcwNOWxga
         OsEBlaBpOBNVCChxEkRK8CCBx+VP2EnaML28o3W7SkdsaUwDYyj4Fq8NVLR1MFumsL9w
         zJ35puXZMTCox64LSoYLbrFEpwo2Wth9wxdkKlyl0VQ7npmCcsyDnmE2hignouQj1QHW
         nW3Q==
X-Gm-Message-State: AOAM532GUNbvpYjNXD/JoGySyF1AD9tldE+ZfxcY4q9pcYP7iuRc9qIZ
        6oXRtFbhiMKkvPi64fSgewnxm06hB8Zq7g==
X-Google-Smtp-Source: ABdhPJxRR2cnhjtQAthTX/Fjjz9P8N9PhzThFiMV+fdIW92Qdl5+Q9zI5tasD0QR4x7LSUCDm0lNkg==
X-Received: by 2002:a17:906:c00c:: with SMTP id e12mr30601431ejz.103.1609151455583;
        Mon, 28 Dec 2020 02:30:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l14sm36138468edq.35.2020.12.28.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 02:30:54 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:30:52 +0100
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 4/7] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201228103052.GA6435@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-4-timon.baetz@protonmail.com>
 <20201224095559.GB10937@kozik-lap>
 <20201224141246.7ad0ffc4.timon.baetz@protonmail.com>
 <20201224133706.GA22856@kozik-lap>
 <20201224140038.GA48009@kozik-lap>
 <20201225123300.07c84dd8.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201225123300.07c84dd8.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 25, 2020 at 11:33:21AM +0000, Timon Baetz wrote:
> On Thu, 24 Dec 2020 15:00:38 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Dec 24, 2020 at 02:37:06PM +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Dec 24, 2020 at 01:13:02PM +0000, Timon Baetz wrote:  
> > > > On Thu, 24 Dec 2020 10:55:59 +0100, Krzysztof Kozlowski wrote:  
> > > > > > @@ -170,6 +237,28 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > > > > >  		return PTR_ERR(charger->battery);
> > > > > >  	}
> > > > > >
> > > > > > +	charger->reg = devm_regulator_get(&pdev->dev, "charger");  
> > > > >
> > > > > Since you do not use get_optional, you will always get a dummy
> > > > > regulator. In case of error, you should either print it or entirely fail
> > > > > the probe. Silently continuing makes it difficult to spot errors.
> > > > >
> > > > > Since the driver could operate in case of extcon/regulator error, just
> > > > > dev_err() so failure will be spotted with dmesg.  
> > > >
> > > > I will switch to devm_regulator_get_optional() and print an error on
> > > > failure, thanks.
> > > >  
> > > > > It will complain on older DTBs because you are introducing incompatible
> > > > > change, but that's expected. Just correct all other in-tree DTS.  
> > > >
> > > > The other 2 in-tree DTS don't have CHARGER regulators. Not sure
> > > > how to correct those. Should I add muic and charger nodes without a
> > > > charger-supply? It will still complain in that case.  
> > >
> > > +Cc Marek,
> > >
> > > This is why leaving the code as is - devm_regulator_get(), not optional
> > > - makes sense. Core would provide dummy regulator, so you only have to
> > > provide MUIC node.
> > >
> > > If you change the code to devm_regulator_get_optional(), you need to add
> > > everything: the charger regulator, the charger node and MUIC node.
> > >
> > > For Trats, the configuration should be similar as i9100, although I
> > > don't know the exact values of chargign voltage.
> > >
> > > For Origen, there is no battery, so the power supply should not bind.
> > > Maybe this could be achieved with "status disabled" for charger node? It
> > > depends whether MFD will respect such field... If it disables the
> > > charger, you're done.  
> > 
> > I just looked at the MFD code and tested it - it nicely skips disabled
> > devices. Therefore, for Origen I propose to add disabled nodes for
> > charger and MUIC because these pins are not connected. No need to add
> > regulators in such case.
> 
> With a dummy regulator regulator_set_current_limit() fails with -EINVAL.

Good point.

> Isn't it better to just skip charging control (and dev_info()) when there 
> is no extcon or regulator? The charger driver would still probe
> without those 2 properties and work as before.

Yes, makes sense.

> 
> Adding disabled nodes for Origen would probably still makes sense.
> 
> I also noticed that adding nodes for those MFD cells prints "DMA mask
> not set" which seems to be related to https://lkml.org/lkml/2020/4/23/873.
> Any suggestions on how to handle that?

I don't think it is your problem to solve. It affects other MFD devices
as well.

Best regards,
Krzysztof

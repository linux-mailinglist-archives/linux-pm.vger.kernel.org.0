Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ECA2E2789
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 15:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgLXOBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 09:01:23 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40715 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXOBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 09:01:23 -0500
Received: by mail-wr1-f51.google.com with SMTP id 91so2249157wrj.7;
        Thu, 24 Dec 2020 06:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXPJKdw80z+OB5yk21y07mm+iviqQpsWpPbSM4Th92c=;
        b=a3bk5Ge0c2s7QYmcVI8Fb81Uz5JLoN1CMXkJBV/ayV8BYxIYTrhhCCmoEIOrPpWfLT
         VWXCDWFuYTJTXVwJvGbsNk9dr45Lo1rLZD+nkMZVl65U5+y8fAGyWYjxPxuGku7nGoM4
         7zJb60Hl3oDxAmMvjDhjiq0gwiKGdM0qiY9oFXBGZp8M+Liyw84VKL9m8Yq4Jftqfgxg
         /nwPC91r0ZrVcJVD7gBf6Dpc4S43kzF8EimP9v2KXwDYpw4VRqFUhl2IUqOeYpnCntg0
         1BwI0k+wqdft5aSVgJUjARD1EX53O14iuPB+YhVlPuyHWGgShI7w85n5aGs6OGT4/BDB
         G0ug==
X-Gm-Message-State: AOAM5322Ixeq35UekeLYyY3aCc6cjY43fqWnmPLXiUaeK2B+3MBtghuN
        NQyQWQ+zp9zBdToaFxydPJg=
X-Google-Smtp-Source: ABdhPJznCRPR6sm397ISThve5dgEO81eDZPCPfAysBrZ8OHDU8wWmjjYYLQ5mpdB4e0gR8EizOqiLw==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr34110095wru.201.1608818440801;
        Thu, 24 Dec 2020 06:00:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h9sm38246689wre.24.2020.12.24.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 06:00:39 -0800 (PST)
Date:   Thu, 24 Dec 2020 15:00:38 +0100
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
Message-ID: <20201224140038.GA48009@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-4-timon.baetz@protonmail.com>
 <20201224095559.GB10937@kozik-lap>
 <20201224141246.7ad0ffc4.timon.baetz@protonmail.com>
 <20201224133706.GA22856@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201224133706.GA22856@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 24, 2020 at 02:37:06PM +0100, Krzysztof Kozlowski wrote:
> On Thu, Dec 24, 2020 at 01:13:02PM +0000, Timon Baetz wrote:
> > On Thu, 24 Dec 2020 10:55:59 +0100, Krzysztof Kozlowski wrote:
> > > > @@ -170,6 +237,28 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > > >  		return PTR_ERR(charger->battery);
> > > >  	}
> > > >
> > > > +	charger->reg = devm_regulator_get(&pdev->dev, "charger");  
> > > 
> > > Since you do not use get_optional, you will always get a dummy
> > > regulator. In case of error, you should either print it or entirely fail
> > > the probe. Silently continuing makes it difficult to spot errors.
> > > 
> > > Since the driver could operate in case of extcon/regulator error, just
> > > dev_err() so failure will be spotted with dmesg.
> > 
> > I will switch to devm_regulator_get_optional() and print an error on 
> > failure, thanks.
> > 
> > > It will complain on older DTBs because you are introducing incompatible
> > > change, but that's expected. Just correct all other in-tree DTS.
> > 
> > The other 2 in-tree DTS don't have CHARGER regulators. Not sure
> > how to correct those. Should I add muic and charger nodes without a
> > charger-supply? It will still complain in that case.
> 
> +Cc Marek,
> 
> This is why leaving the code as is - devm_regulator_get(), not optional
> - makes sense. Core would provide dummy regulator, so you only have to
> provide MUIC node.
> 
> If you change the code to devm_regulator_get_optional(), you need to add
> everything: the charger regulator, the charger node and MUIC node.
> 
> For Trats, the configuration should be similar as i9100, although I
> don't know the exact values of chargign voltage.
> 
> For Origen, there is no battery, so the power supply should not bind.
> Maybe this could be achieved with "status disabled" for charger node? It
> depends whether MFD will respect such field... If it disables the
> charger, you're done.

I just looked at the MFD code and tested it - it nicely skips disabled
devices. Therefore, for Origen I propose to add disabled nodes for
charger and MUIC because these pins are not connected. No need to add
regulators in such case.

Best regards,
Krzysztof

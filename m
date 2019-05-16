Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27120FE0
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfEPVLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 17:11:54 -0400
Received: from vps.xff.cz ([195.181.215.36]:39694 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfEPVLy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 17:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558041111; bh=UWj0YrD5goghSNEmjJRSGrmoJDVqz/hOGHbwFS3q6Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3leZ/bqG3v4DiQd1HKgqnMfkAa7iAxPpIzoIlBCCQj3c66wJJ6OgdrtNC5DtmCNa
         Cp3h0aZBMHwlX3d5eNFGjc6m7TcqfiXv5VMD65SoK/sQmsXpRcKtskw2OjsUYtitVD
         0Im+OWUvLKknjoD+fI/QT1jHkX0x9EXUhozhOCzw=
Date:   Thu, 16 May 2019 23:11:51 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        paulmck@linux.ibm.com, stefan.wahren@i2se.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com,
        devicetree@vger.kernel.org, marc.w.gonzalez@free.fr,
        Eduardo Valentin <edubezval@gmail.com>,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190516211151.qwac53shdjhlwj4p@core.my.home>
Mail-Followup-To: Frank Lee <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        paulmck@linux.ibm.com, stefan.wahren@i2se.com,
        Linux PM <linux-pm@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com,
        devicetree@vger.kernel.org, marc.w.gonzalez@free.fr,
        Eduardo Valentin <edubezval@gmail.com>,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, David Miller <davem@davemloft.net>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Fri, May 17, 2019 at 01:51:56AM +0800, Frank Lee wrote:
> > > +static int tsens_probe(struct platform_device *pdev)
> > > +{
> > > +     struct tsens_device *tmdev;
> > > +     struct device *dev = &pdev->dev;
> > > +     int ret;
> > > +
> > > +     tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > +     if (!tmdev)
> > > +             return -ENOMEM;
> > > +
> > > +     tmdev->dev = dev;
> > > +     tmdev->chip = of_device_get_match_data(&pdev->dev);
> > > +     if (!tmdev->chip)
> > > +             return -EINVAL;
> > > +
> > > +     ret = tsens_init(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = tsens_register(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = tmdev->chip->enable(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > >
> > > +     platform_set_drvdata(pdev, tmdev);
> >
> > Your registration should be the very last thing you do. Otherwise, you
> > have a small window where the get_temp callback can be called, but the
> > driver will not be functional yet.
> No. Anyway, ths data qcquisition is ms level.

Tz code can change in the future, and call the get_temp callback during
registration, and this would break. It's better to be correct, than make
dangerous assumptions. So platform_set_drvdata should be done somewhere 
prior to init_resource.

Enable should be after register though. Because otherwise you may be calling
tz update on non-registered tz from an interrupt handler.

> > > +     return ret;
> > > +}
> > > +

regards,
	o.

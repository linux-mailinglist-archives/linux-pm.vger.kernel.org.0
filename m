Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740CFA548E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfIBK6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 06:58:19 -0400
Received: from vps.xff.cz ([195.181.215.36]:35122 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730702AbfIBK6T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 06:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1567421896; bh=0+YtJ5mB5rWakjDiMfZibOLsuS/yEq29XZ5qfNzcLuU=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=ZbXSnUMVfg4rtkOpS+y5AV70FlL40OX7C2yA4xkApWMjPmylOteNvAaflG151OGc6
         tKkEvcYvWlHD7DXmQqkU8jrSlXCGt5jIyUHDsmX+1pGoVjQ6Gx+M0dxSdNxKgSE+6H
         3qfcFDTOsr6b01Q30YlcLFrpquM4afSkHVZkBWno=
Date:   Mon, 2 Sep 2019 12:58:16 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
Message-ID: <20190902105816.zurkkh2vjfexft7t@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190901215214.f4vbxemdd7mf3gun@core.my.home>
 <20190902072735.zkrueocyz4glc26n@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190902072735.zkrueocyz4glc26n@flea>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Maxime,

On Mon, Sep 02, 2019 at 09:27:35AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Sep 01, 2019 at 11:52:14PM +0200, Ondřej Jirman wrote:
> > Hello Yangtao,
> >
> > On Sat, Aug 10, 2019 at 05:28:11AM +0000, Yangtao Li wrote:
> > > This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.
> > >
> > > Thx to Icenowy and Vasily.
> > >
> > > BTY, do a cleanup in thermal makfile.
> >
> > I've added support for A83T and also some cleanups, according to my
> > feedback:
> >
> > https://megous.com/git/linux/log/?h=ths-5.3
> >
> > Feel free to pick up whatever you like from that tree.
> >
> > For others, there are also DTS patches in that tree for H3, H5, A83T, and H6, so
> > that shoul make testing of this driver easier.
> 
> I'm not convinced that always expanding the number of SoC supported is
> the best strategy to get this merged. Usually, keeping the same
> feature set across version, consolidating that, and then once it's in
> sending the new SoC support works best.

That's fine and all, but I've mostly added DT descriptions for already supported
SoCs and fixed bugs in the driver, so that people can actually test the existing
driver.

I think adding DT changes will actually help get needed exposure for this
patch series.

A83T support that I added, was actually just a small change to the driver.

regards,
	o.

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

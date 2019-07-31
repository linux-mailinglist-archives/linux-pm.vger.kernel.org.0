Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C269A7C299
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfGaNBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 09:01:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38764 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfGaNBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 09:01:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190731130148euoutp02779e3a9dd017bb1592e47823b5da3c3b~2f4AIi0az1517315173euoutp02g
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 13:01:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190731130148euoutp02779e3a9dd017bb1592e47823b5da3c3b~2f4AIi0az1517315173euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564578108;
        bh=uIZjK2mDYGGIQoh1L8WzyXdHyo8GssTHvhq/RxYs6Uk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uBXqMhXsZ5RMPNSzD+hvziPd3ueErlFr57XLeoL3zG8MSppyQ8zSXwgVodf+TBTRG
         Qfrk7r6gX7cCPBpcCE+edtRgvETM0XSKCH2sU7uluSybyR+JjXU9Ws+n8BQTbKkJU6
         4Ql2dATHWlcMHhGMnSsaXnQhIWcViBEPDT1iVhrM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190731130147eucas1p2622981052b71f0c9b305a38c448eab62~2f3-WA7jT2160421604eucas1p2P;
        Wed, 31 Jul 2019 13:01:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.F1.04298.B31914D5; Wed, 31
        Jul 2019 14:01:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190731130146eucas1p13647e6bd5004b9b858f82a95d9bf2928~2f3_kUhyz3209332093eucas1p1Y;
        Wed, 31 Jul 2019 13:01:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190731130146eusmtrp193ab339d7f7c267bd73035f03355d67a~2f3_WEMb62537425374eusmtrp1f;
        Wed, 31 Jul 2019 13:01:46 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-2a-5d41913bfd1e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.D3.04140.A31914D5; Wed, 31
        Jul 2019 14:01:46 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190731130145eusmtip2d16e9993c297dd63cdd5a647debb0c70~2f39r4f1i2937029370eusmtip2_;
        Wed, 31 Jul 2019 13:01:45 +0000 (GMT)
Message-ID: <a1fc0e2b5ef2d131f4e896c9c0aa7621bf4b79e2.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com,
        =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Date:   Wed, 31 Jul 2019 15:01:44 +0200
In-Reply-To: <20190724183639.GA14346@kozik-lap>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUgUYRju2zl23Br7XK19u3UjpEi3oB8DZiVELvWjC/qRme7moLVe7KSd
        lKWEeWXZklnhklqiqDlmma2Vx7ap1KaZBZorHmmFFHmEhFrTGPXveZ/jPeBlCHUjtZg5HHuU
        N8caorW0inzwfNLpF3A5KHTd1TFPrjK3guLejQ1RXH7TK4rrGP9Kc9fqRJq74somOafznpIT
        +zsp7k3tTZobzWxCXK7ziYIra/qg5LrOFdNcbs4neou7Xiy5SOu7O2203pXuUOirCs/qs+6X
        IP2ouHwXvV+1MYKPPpzIm3WbwlVR6cN2Kr7b63il6zaVhGw4DbkxgDfA1IsBRRpSMWpcjGCs
        OB3JxRiCh809s8oogi/Dk+TfiL06lZSFuwhKxWZaLj4iqPpYhCQXi3dBakY5IWFPbARrXxsl
        YRoHw/RQxx/shVfDu6kflBQm8DMC6ussyjTEMCReBR1PgiWPG9aBWGRD8uS1MNKSRUoWFnvA
        VI2nRBN4BSRX3yCkNoB7lOAasdCyfyu8LbhLydgTPjvuK2W8FFpzMmavEWDwkYuSw0kIxDtN
        hCwEQKNDWpr5PWE1VNTqZDoIRrLshEQDdof3Ix7yDu5w5cG1WZqF1AtqGa4B688QOQhwvrRz
        trceUvqGlNnIJ+/fLXn/3ZL3b6oVESVIwycIMZG8sD6WP+YvGGKEhNhI/0NxMSL6/Vqt047v
        NWi83diAMIO089gXF4NC1ZQhUTgR04CAIbRebIFmc6iajTCcOMmb48LMCdG80ICWMKRWw56a
        0xuixpGGo7yJ5+N5819VwbgtTkLXtx14XlZ63Oa9aMm37hl2AW35Frax91LAy/p229Jc35K+
        icQ9voUZD99PO4N4FLhjrylT05U8MT99ABUcHN7/+Gnh9rie8IVzy8+0rXwd1jY4zEWk7M58
        1r8z0I5MG1oa9+XDU2PNsWX3dKV+lhar9y2j7vRMRGVOlUlxJF/0+awlhSjD+jWEWTD8AnSD
        goRWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7pWEx1jDdaukrDYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWMya/ZHPg89i0qpPN4861PWwe97uPM3lsXlLv0bdlFaPH501yAWxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehndL46yFtwRqdh4fxFr
        A+MegS5GTg4JAROJo1s7WLoYuTiEBJYySnx88ZINIiEh8XH9DVYIW1jiz7UuNoiiJ4wSV+5/
        AkvwCgRIdPSsYwaxhQWSJBY8uggWZxNwl/j3/AqYLSKgKXH973dWkGZmgUPMEusOdAM5HBws
        AqoSV/a5g9RwCuhLbFq6hxFiwTdGid+dJxlBEsxAza3bf7NDXKEj8fZUHwtIL6+AoMTfHcIQ
        JfISzVtnM09gFJyFpGMWQtUsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbktmM/
        t+xg7HoXfIhRgINRiYf3RKdjrBBrYllxZe4hRgkOZiUR3sXi9rFCvCmJlVWpRfnxRaU5qcWH
        GE2B3pnILCWanA9MFnkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhgZ+s6e2hzFfYP7duW0NRvsttXPfGYa/H2fRWzHkyDeCVtNzlRLyguoJjpscFupqJb38zpf
        ZMnyDR8XihuvLt5xab/EX9VNvab63bs5mLbfSvNKdvGbzVc3XULbl1Xy3u59fl+Zns7hnMHb
        GHSk4OWXw/UFKcsPBtkH18ilpursPRnq/Psjv78SS3FGoqEWc1FxIgB2NBHi3gIAAA==
X-CMS-MailID: 20190731130146eucas1p13647e6bd5004b9b858f82a95d9bf2928
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
        <20190724183639.GA14346@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-24 at 20:36 +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 23, 2019 at 02:20:14PM +0200, Artur Świgoń wrote:
> > This patch adds interconnect functionality to the exynos-bus devfreq
> > driver.
> > 
> > The SoC topology is a graph (or, more specifically, a tree) and most of its
> > edges are taken from the devfreq parent-child hierarchy (cf.
> > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
> > patch adds missing edges to the DT (under the name 'parent'). Due to
> 
> Do not refer to DT patches. They will come through different tree so
> "previous" will not be correct anymore. You mentioned dependencies in
> cover letter so it is sufficient.

OK.
 
> >  /*
> > @@ -61,6 +69,13 @@ exynos_bus_ops_edev(enable_edev);
> >  exynos_bus_ops_edev(disable_edev);
> >  exynos_bus_ops_edev(set_event);
> >  
> > +static int exynos_bus_next_id(void)
> > +{
> > +	static int exynos_bus_node_id;
> > +
> > +	return exynos_bus_node_id++;
> 
> This does not look robust. Use IDR for IDs. 

OK.

> > +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> > +{
> > +	struct device_node *np = bus->dev->of_node;
> > +	struct devfreq *parent_devfreq;
> > +	struct icc_node *parent_node = NULL;
> > +	struct of_phandle_args args;
> > +	int ret = 0;
> > +
> > +	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
> > +	if (!IS_ERR(parent_devfreq)) {
> > +		struct exynos_bus *parent_bus;
> 
> What if someone unbinds this parent devfreq? I guess everything in
> devfreq starts exploding... however it's not the problem of this patch.
> 
> Do you also need suspend/resume order (device links)? I guess the other
> side, e.g.  mixer, should resume before the bus?

Actually, I think that the bus (devfreq) should resume before mixer. However,
suspend/resume order is another issue that applies to this driver regardless of
using the interconnect framework, although device links could probably also be
implemented in the interconnect framework itself.

> > +		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
> > +		parent_node = parent_bus->node;
> > +	} else {
> > +		/* Look for parent in DT */
> > +		int num = of_count_phandle_with_args(np, "parent",
> > +						     "#interconnect-cells");
> > +		if (num != 1)
> 
> You will return here 0 but isn't it an error?

It is definitely not an error when 'parent' does not exist in DT (for buses that
are parents themselves). I can extend the comment in the code to explicitly
state that.

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics



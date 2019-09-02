Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E28A4FDA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfIBH1p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 2 Sep 2019 03:27:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43203 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbfIBH1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 03:27:44 -0400
X-Originating-IP: 213.190.86.42
Received: from localhost (unknown [213.190.86.42])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D864DC0008;
        Mon,  2 Sep 2019 07:27:40 +0000 (UTC)
Date:   Mon, 2 Sep 2019 09:27:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
Message-ID: <20190902072735.zkrueocyz4glc26n@flea>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190901215214.f4vbxemdd7mf3gun@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190901215214.f4vbxemdd7mf3gun@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sun, Sep 01, 2019 at 11:52:14PM +0200, Ondřej Jirman wrote:
> Hello Yangtao,
>
> On Sat, Aug 10, 2019 at 05:28:11AM +0000, Yangtao Li wrote:
> > This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.
> >
> > Thx to Icenowy and Vasily.
> >
> > BTY, do a cleanup in thermal makfile.
>
> I've added support for A83T and also some cleanups, according to my
> feedback:
>
> https://megous.com/git/linux/log/?h=ths-5.3
>
> Feel free to pick up whatever you like from that tree.
>
> For others, there are also DTS patches in that tree for H3, H5, A83T, and H6, so
> that shoul make testing of this driver easier.

I'm not convinced that always expanding the number of SoC supported is
the best strategy to get this merged. Usually, keeping the same
feature set across version, consolidating that, and then once it's in
sending the new SoC support works best.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

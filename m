Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58B710D61
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEATn2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 15:43:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36966 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 15:43:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id C5023263971
Date:   Wed, 1 May 2019 15:43:41 -0400
From:   =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>,
        linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on
 gru.
Message-ID: <20190501194341.tdmv5cg2ajoebwyx@archlinux.localdomain>
References: <20190415212948.7736-1-gael.portay@collabora.com>
 <20190415212948.7736-6-gael.portay@collabora.com>
 <20190426184559.GA29242@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426184559.GA29242@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob,

On Fri, Apr 26, 2019 at 01:45:59PM -0500, Rob Herring wrote:
> On Mon, Apr 15, 2019 at 05:29:48PM -0400, Gaël PORTAY wrote:
> > diff --git a/include/dt-bindings/power/rk3399-dram.h b/include/dt-bindings/power/rk3399-dram.h
> > new file mode 100644
> > index 000000000000..4b3d4a79923b
> > --- /dev/null
> > +++ b/include/dt-bindings/power/rk3399-dram.h
> > @@ -0,0 +1,73 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR X11) */
> > +/*
> > + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> > + *
> > + * Author: Lin Huang <hl@rock-chips.com>
> > + */
> > +
> > +#ifndef _DTS_DRAM_ROCKCHIP_RK3399_H
> > +#define _DTS_DRAM_ROCKCHIP_RK3399_H
> > +
> > +#define DDR3_DS_34ohm		34
> > +#define DDR3_DS_40ohm		40
> > +
> > +#define DDR3_ODT_DIS		0
> > +#define DDR3_ODT_40ohm		40
> > +#define DDR3_ODT_60ohm		60
> > +#define DDR3_ODT_120ohm		120
> 
> I don't think these defines add much value given the value is in the 
> define itself.
> 
> Do these get used by the driver? If not, then the header can go with the 
> dts file. But I'd just get rid of the header.
> 
> Rob
>

Indeed, I will remove that header and update the documentation file.

Regards,
Gaël

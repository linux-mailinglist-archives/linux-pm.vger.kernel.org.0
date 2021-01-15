Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F12F762D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 11:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbhAOKCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 05:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbhAOKCc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 05:02:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B37F9224F9;
        Fri, 15 Jan 2021 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610704912;
        bh=wv8ySCdCXULDYKAIbJev8yhBQxUDdYmctzFeIbE6JIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrvA5gVmAWWSK8h3wOyiXvdkOKf5i9J8FzvM7tH/j9tiADm2FuM0U3AosQ/mS4eEv
         r0lTVZvBgmdXhhI7ChU2XdoyP4XYoPIMQQSGRUClfsWGAB9UK4HSe4WvdgREIABUGF
         7HtrElBNsFQkGOqy6z1u4nJUShH6K6Ln7I1StVnvfCQq+vixOfv387EL+4h2HVLP9B
         ZEoalEjQk7OK7N8YJvAtbDMoPxkKT79Ms6acp3U51GYtZ+AI4eSoE+eTJbT7SUmQBn
         3CC+676aFhDm0Xto7Qvbkp0izs2mQjkWvQeJbLuVgcUY5jhs2/GHzwkHbxdljqvOew
         LD6h4yZK3xHQQ==
Date:   Fri, 15 Jan 2021 18:01:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] arm64: dts: imx8mq: Add interconnect for lcdif
Message-ID: <20210115100136.GN28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-5-martin.kepplinger@puri.sm>
 <20210115094738.GL28365@dragon>
 <71f61d0b-b09e-84e9-dd6e-77b89b09ba42@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f61d0b-b09e-84e9-dd6e-77b89b09ba42@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 10:57:02AM +0100, Martin Kepplinger wrote:
> 
> 
> On 15.01.21 10:47, Shawn Guo wrote:
> > On Thu, Jan 07, 2021 at 01:17:53PM +0100, Martin Kepplinger wrote:
> > > Add interconnect ports for lcdif to set bus capabilities.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > >   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 89e7de2e7f7a..9300be8c9b53 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -11,6 +11,7 @@
> > >   #include "dt-bindings/input/input.h"
> > >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >   #include <dt-bindings/thermal/thermal.h>
> > > +#include <dt-bindings/interconnect/imx8mq.h>
> > >   #include "imx8mq-pinfunc.h"
> > >   / {
> > > @@ -522,6 +523,8 @@
> > >   						  <&clk IMX8MQ_VIDEO_PLL1>,
> > >   						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> > >   				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
> > > +				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> > > +				interconnect-names = "dram";
> > 
> > Hmm, two interconnect phandles but only one name?
> > 
> 
> Well it's one interconnect path that would more accurately be named
> "lcdif-dram" if that's what you mean. I removed "lcdif-" because it's the
> lcdif node, but maybe we should name it lcdif-dram after all. at least
> that's how others describe it.

Ha, sorry, I misunderstood the interconnects property.

Shawn

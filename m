Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8E689EC7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjBCQC2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBCQC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 11:02:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E92A98E
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 08:02:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNyVz-0004Uw-SP; Fri, 03 Feb 2023 17:02:15 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNyVy-0001d2-2W; Fri, 03 Feb 2023 17:02:14 +0100
Date:   Fri, 3 Feb 2023 17:02:14 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip DFI
 binding to yaml
Message-ID: <20230203160214.GZ13319@pengutronix.de>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
 <20230203125012.3804008-19-s.hauer@pengutronix.de>
 <ed9c3224-2f1a-c335-3028-6c23f40f57f4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9c3224-2f1a-c335-3028-6c23f40f57f4@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 03, 2023 at 04:14:56PM +0100, Krzysztof Kozlowski wrote:
> On 03/02/2023 13:50, Sascha Hauer wrote:
> > Convert the Rockchip DFI binding to yaml. While at it add the newly
> > supported rk3568-dfi to the binding.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

That's what I did. I skipped you and Rob because I know you're wathcing
the list anyway.

> > diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml
> > new file mode 100644
> > index 0000000000000..e082a0df7895a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml
> 
> rockchip,dfi.yaml

ok.

> 
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/devfreq/event/rockchip-dfi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip DFI
> > +
> > +maintainers:
> > +  - Sascha Hauer <s.hauer@pengutronix.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rk3399-dfi
> > +      - rk3568-dfi
> 
> These are not correct compatibles.

What's wrong with them?

> 
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  rockchip,pmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon managing the "PMU general register files".
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> clocks were required

They are no longer, the RK3568 doesn't have a clock. Do I have to add
something to make the clock optional on RK3568 only?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

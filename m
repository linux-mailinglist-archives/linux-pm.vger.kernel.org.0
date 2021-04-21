Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A313674E9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbhDUV6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbhDUV6Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 17:58:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B5C06174A;
        Wed, 21 Apr 2021 14:56:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E12251F41E98
Message-ID: <bf0771cec69e11bf4622421a3aa8f2092da42429.camel@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568
 SoC compatible
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Johan Jonker <jbx6244@gmail.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Date:   Wed, 21 Apr 2021 18:56:31 -0300
In-Reply-To: <ca5d55ef-e364-be7a-5ad6-81f039c691e6@gmail.com>
References: <20210421200445.32977-1-ezequiel@collabora.com>
         <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
         <31272ad0e6a5274080831406796960506c6a6912.camel@collabora.com>
         <ca5d55ef-e364-be7a-5ad6-81f039c691e6@gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-04-21 at 23:25 +0200, Johan Jonker wrote:
> On 4/21/21 11:06 PM, Ezequiel Garcia wrote:
> > On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
> > > On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
> > > > Add a new compatible for the thermal sensor device on RK3568 SoCs.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > > > index 7f94669e9ebe..346e466c2006 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > > > +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > > > @@ -9,6 +9,7 @@ Required properties:
> > > >     "rockchip,rk3328-tsadc": found on RK3328 SoCs
> > > >     "rockchip,rk3368-tsadc": found on RK3368 SoCs
> > > >     "rockchip,rk3399-tsadc": found on RK3399 SoCs
> > > 
> > > > +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
> > > 
> > > This is still a text document.
> > > rob+dt has now scripts that check for undocumented compatibility
> > > strings, so first convert rockchip-thermal.txt to YAML and then add this
> > > in a separated patch.
> > > 
> > 
> > Is it a showstopper to convert devicetree bindings to YAML for driver submission?
> 
> You now that hardware best, so try to fix the documents as well.

Well, not really. I'm just forward porting the driver from downstream kernels,
so we can support this new SoC. Not really a hardware _expert_ for all the
devices I plan to be pushing.

> The new norm is YAML, so aim for that.

I am aware of that. In fact, at Collabora we encourage all the kernel
developers to convert to YAML, if/when possible.

> Try to submit a complete package of YAML, driver (and dts nodes) for review.

The devicetree for RK3566 and RK3568 is under discussion, in fact it was submitted today.
Rockhip is leading that, and doing a great job already :)

Meanwhile, I'd like to merge the small drivers (thermal, pmic, dwmac, io-domains and so on),
so they are ready when the devicetree lands.

Most if not all of these devices just need a new compatible string. It would really delay
things if I aim to convert all those bindings docs to YAML first, so let's please avoid that...
... unless it's a new hard-rule that DT maintainers have agreed on.

Having said that, if you want to help the RK3568 bringup adventure,
converting the bindings to YAML, that would be really appreciated! Of course, I know
you've converted plenty of them already, and I already appreciate that :)

Thanks,
Ezequiel


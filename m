Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4836867E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhDVSVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 14:21:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37636 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhDVSVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 14:21:41 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lZdwh-00021a-Lc; Thu, 22 Apr 2021 20:20:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568 SoC compatible
Date:   Thu, 22 Apr 2021 20:20:58 +0200
Message-ID: <4689477.1oUyQt6lIG@diego>
In-Reply-To: <31c2e531-96d0-a1c1-644c-28c60eb40cf4@gmail.com>
References: <20210421200445.32977-1-ezequiel@collabora.com> <bf0771cec69e11bf4622421a3aa8f2092da42429.camel@collabora.com> <31c2e531-96d0-a1c1-644c-28c60eb40cf4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am Donnerstag, 22. April 2021, 00:12:45 CEST schrieb Johan Jonker:
> On 4/21/21 11:56 PM, Ezequiel Garcia wrote:
> > On Wed, 2021-04-21 at 23:25 +0200, Johan Jonker wrote:
> >> On 4/21/21 11:06 PM, Ezequiel Garcia wrote:
> >>> On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
> >>>> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
> >>>>> Add a new compatible for the thermal sensor device on RK3568 SoCs.
> >>>>>
> >>>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >>>>> index 7f94669e9ebe..346e466c2006 100644
> >>>>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >>>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >>>>> @@ -9,6 +9,7 @@ Required properties:
> >>>>>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
> >>>>>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
> >>>>>     "rockchip,rk3399-tsadc": found on RK3399 SoCs
> >>>>
> >>>>> +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
> >>>>
> >>>> This is still a text document.
> >>>> rob+dt has now scripts that check for undocumented compatibility
> >>>> strings, so first convert rockchip-thermal.txt to YAML and then add this
> >>>> in a separated patch.
> >>>>
> >>>
> >>> Is it a showstopper to convert devicetree bindings to YAML for driver submission?
> >>
> >> You now that hardware best, so try to fix the documents as well.
> > 
> > Well, not really. I'm just forward porting the driver from downstream kernels,
> > so we can support this new SoC. Not really a hardware _expert_ for all the
> > devices I plan to be pushing.
> > 
> >> The new norm is YAML, so aim for that.
> > 
> > I am aware of that. In fact, at Collabora we encourage all the kernel
> > developers to convert to YAML, if/when possible.
> > 
> >> Try to submit a complete package of YAML, driver (and dts nodes) for review.
> > 
> > The devicetree for RK3566 and RK3568 is under discussion, in fact it was submitted today.
> > Rockhip is leading that, and doing a great job already :)
> > 
> > Meanwhile, I'd like to merge the small drivers (thermal, pmic, dwmac, io-domains and so on),
> > so they are ready when the devicetree lands.
> > 
> 
> > Most if not all of these devices just need a new compatible string. It would really delay
> > things if I aim to convert all those bindings docs to YAML first, so let's please avoid that...
> > ... unless it's a new hard-rule that DT maintainers have agreed on.
> 
> Every driver group has it's own delay time, so better do it right in one
> run.
> Mostly people tend to 'forget' documentation and then someone else has
> to clean up the mess. So I propose that the person that submits a new
> driver also fixes the documentation. The norm is now YAML, so this serie
> has more work then other, so be it. Others can help you with it if you ask.

personally I feel this approach being a bit too strict.

While it is definitly cool to convert everything to a yaml base in a
hopefully short time, being overly strict can also stiffle participation.

This is especially true if a series only adds a single compatible to an
already existing binding. So depending on the time constraints of the
contributor they might very well refrain from submitting another version.

In then end though, it's Rob's decision on how strict this conversion
is to be taken.


Heiko




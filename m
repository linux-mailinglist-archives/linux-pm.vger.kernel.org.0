Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808C410B531
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 19:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK0SHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 13:07:47 -0500
Received: from vps.xff.cz ([195.181.215.36]:57420 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfK0SHq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 13:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1574878064; bh=4VzrydAkThomO1NgCSzfkzhhez9X+ie12XCY93OYl4Y=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=EhbwSR5v8v8tPutBJipalzt60OO/s3cONAVvDxDWU8qLetxCn9MUhXeR6DPphGW66
         1y1UxCnqcfb68suXdYaoqRW9qrZC4/BzcBjFxECihzsadeFcyqjySAtvJJlBnCP5Zb
         YIB99+uHHsPQMy+P/A19mNaJ5ky6dNVfJFd5VwD4=
Date:   Wed, 27 Nov 2019 19:07:43 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191127180743.ww5npenlg2urxtjn@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Nov 27, 2019 at 06:44:34PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Nov 26, 2019 at 09:29:30PM -0800, Vasily Khoruzhick wrote:
> > From: Yangtao Li <tiny.windzz@gmail.com>
> >
> > sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> > SoCs. Add YAML schema for its bindings.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > new file mode 100644
> > index 000000000000..e622f0a4be90
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Yangtao Li <tiny.windzz@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun8i-a83t-ths
> > +      - const: allwinner,sun8i-h3-ths
> > +      - const: allwinner,sun8i-r40-ths
> > +      - const: allwinner,sun50i-a64-ths
> > +      - const: allwinner,sun50i-h5-ths
> > +      - const: allwinner,sun50i-h6-ths
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    anyOf:
> > +      - items:
> > +        - const: bus
> > +        - const: mod
> > +      - items:
> > +        - const: bus
> 
> This can be:
> 
> clock-names:
>   minItems: 1

Additionally, minItems should be 0, since A83T doesn't have bus clock/reset. And
then there should be a special case for A83T too with min/maxItems = 0 for both
resets and clocks.

regards,
	o.

>   maxItems: 2
>   items:
>     - const: bus
>     - const: mod
> 
> And the length should be checked based on the compatible value, with
> something like
> 
> if:
>   properties:
>     compatible:
>       contains:
>         const: allwinner,sun50i-h6-ths
> 
> then:
>   properties:
>     clocks:
>       maxItems: 1
> 
>     clock-names:
>       maxItems: 1
> 
> else:
>   properties:
>     clocks:
>       maxItems: 2
> 
>     clock-names:
>       maxItems: 2
> 
> > +
> > +  '#thermal-sensor-cells':
> > +    enum: [ 0, 1 ]
> > +    description: |
> > +      Definition depends on soc version:
> > +
> > +      For "allwinner,sun8i-h3-ths",
> > +      value must be 0.
> > +      For all other compatibles
> > +      value must be 1.
> 
> This should be checked using an if as well.
> 
> > +
> > +  nvmem-cells:
> > +    maxItems: 1
> > +    items:
> > +      - description: Calibration data for thermal sensors
> 
> You can drop the items and just move the description up one level,
> under nvmem-cells
> 
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: calibration
> 
> Ditto for the const
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#thermal-sensor-cells'
> 
> Whether clocks, clock-names and resets are thereshould be check using
> an if statement as well.
> 
> > +
> > +examples:
> > +  - |
> > +    ths_a83t: ths@1f04000 {
> 
> You don't need the label at all, and the node name should be
> temperature-sensor according to the DT spec, not ths. This applies to
> all you examples.
> 
> > +         compatible = "allwinner,sun8i-a83t-ths";
> > +         reg = <0x01f04000 0x100>;
> > +         interrupts = <0 31 0>;
> > +         nvmem-cells = <&ths_calibration>;
> > +         nvmem-cell-names = "calibration";
> > +         #thermal-sensor-cells = <1>;
> > +    };
> 
> New line.
> 
> Thanks!
> Maxime



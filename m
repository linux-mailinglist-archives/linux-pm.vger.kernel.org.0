Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECA18475F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 14:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMNDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 09:03:17 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60776 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMNDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 09:03:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 67C3E80307C4;
        Fri, 13 Mar 2020 13:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m3F-eTf_XM1G; Fri, 13 Mar 2020 16:03:13 +0300 (MSK)
Date:   Fri, 13 Mar 2020 16:02:31 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
 <20200312211438.GA21883@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312211438.GA21883@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 12, 2020 at 04:14:38PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Optional regmap property will be used to refer to a syscon-controller
> > having a reboot tolerant register mapped.
> 
> NAK. It should simply be a child node of the 'syscon-controller'.

Hm, It's dilemma. The driver maintainer said ack, while you disagree.)
So the code change will be merged while the doc-part won't? Lets discuss then
to settle the issue.

Why 'syscon-reboot' can be out of syscon-controller node, while
'syscon-reboot-mode' can't? They both belong to the same usecase: save
cause id and reboot. So having similar properties-set and declaring their
nodes someplace nearby is natural. According to the driver 'syscon-reboot'
can't lack the regmap property because it's mandatory, while here you refuse
to have even optional support. Additionally in most of the cases the
'syscon-reboot' nodes aren't declared as a child of a system controller
node. Why 'syscon-reboot-mode' can't work in a similar way?

Regards,
-Sergey

> 
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  .../bindings/power/reset/syscon-reboot-mode.yaml         | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > index e09bb07b1abb..f47bf52ad983 100644
> > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > @@ -13,9 +13,8 @@ description: |
> >    This driver gets reboot mode magic value from reboot-mode driver
> >    and stores it in a SYSCON mapped register. Then the bootloader
> >    can read it and take different action according to the magic
> > -  value stored. The SYSCON mapped register is retrieved from the
> > -  parental dt-node plus the offset. So the SYSCON reboot-mode node
> > -  should be represented as a sub-node of a "syscon", "simple-mfd" node.
> > +  value stored. The SYSCON mapped register is retrieved either from
> > +  the parental dt-node or from a regmap phandle plus the offset.
> >  
> >  properties:
> >    compatible:
> > @@ -29,6 +28,10 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description: Offset in the register map for the mode register (in bytes).
> >  
> > +  regmap:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to the register map node.
> > +
> >  patternProperties:
> >    "^mode-.+":
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > -- 
> > 2.25.1
> > 

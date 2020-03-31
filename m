Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E3199F73
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCaTuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 15:50:50 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53976 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCaTuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 15:50:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3BE6E8030890;
        Tue, 31 Mar 2020 19:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JaeAPcOyr_X9; Tue, 31 Mar 2020 22:50:45 +0300 (MSK)
Date:   Tue, 31 Mar 2020 22:50:53 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200331195053.dcexmhbsbnbfuabe@ubsrv2.baikal.int>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
 <20200312211438.GA21883@bogus>
 <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
 <CAL_Jsq+W84r687zNV=2S-hj9=xbTQxkx9MpVNDTn6TOrBgiGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+W84r687zNV=2S-hj9=xbTQxkx9MpVNDTn6TOrBgiGUw@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 18, 2020 at 05:14:25PM -0600, Rob Herring wrote:
> On Fri, Mar 13, 2020 at 7:03 AM Sergey Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Thu, Mar 12, 2020 at 04:14:38PM -0500, Rob Herring wrote:
> > > On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > >
> > > > Optional regmap property will be used to refer to a syscon-controller
> > > > having a reboot tolerant register mapped.
> > >
> > > NAK. It should simply be a child node of the 'syscon-controller'.
> >
> > Hm, It's dilemma. The driver maintainer said ack, while you disagree.)
> > So the code change will be merged while the doc-part won't? Lets discuss then
> > to settle the issue.
> >
> > Why 'syscon-reboot' can be out of syscon-controller node, while
> > 'syscon-reboot-mode' can't?
> 
> Look at the history and you will see one was reviewed by DT
> maintainers and one wasn't.
> 
> > They both belong to the same usecase: save
> > cause id and reboot. So having similar properties-set and declaring their
> > nodes someplace nearby is natural.
> 
> Which is what I'm asking for. Where else in the tree does it make
> sense to locate the 'syscon-reboot-mode' node? Locate nodes where they
> logically belong.
> 
> > According to the driver 'syscon-reboot'
> > can't lack the regmap property because it's mandatory, while here you refuse
> > to have even optional support. Additionally in most of the cases the
> > 'syscon-reboot' nodes aren't declared as a child of a system controller
> > node. Why 'syscon-reboot-mode' can't work in a similar way?
> 
> There's plenty of bad or "don't follow current best practice" examples
> in the tree for all sorts of things. That is not a reason for doing
> something in a new binding or adding to an existing one.
> 
> Rob

Alright. I see your point. What about I'd provide a sort of opposite
implementation? I could make the "regmap"-phandle reference being optional
in the !"syscon-reboot"! driver instead of adding the regmap-property
support to the "syscon-reboot-mode" driver. So if regmap property isn't
defined in the "syscon-reboot"-compatible node, the driver will try to
get a syscon regmap from the parental node as it's done in the
"syscon-reboot-mode" driver.

Seeing you think that regmap-property-based design is a bad practice in
this case, I also could mark the property as deprecated in the "syscon-reboot"
dt schema and print a warning from the "syscon-reboot" driver if one is defined.

What do you think?

Regards,
-Sergey

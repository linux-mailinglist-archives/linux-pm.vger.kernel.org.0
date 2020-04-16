Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32B1AD1DA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgDPV2q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 17:28:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35688 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDPV2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 17:28:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id b7so293107oic.2;
        Thu, 16 Apr 2020 14:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZDi6M75xZSmYWePqnnoB2rg9ADM0ASJydJXaT8e6cw=;
        b=cz9Bza8i+enE7ijRp4/UurlFtuvEdZucR19pyNWXNWbQ7wdUhoKLBj1a5cFsBGhTRQ
         jGLXxv1MOj69Q7MVbsZ7sPiGj8Uhq8S9DA4Kr6o83blJ/PqEyCaHrfMi5sW5jpBkn6Zq
         60ERJjY6hockxC8Eutsq9P2XYRCW5fqhhaEHAYi7zhw3FRTzJkDV245qDuwFmzBEiDDg
         BwKir3sfASDlGt+R05Dh9y8rjJNjVRM9FFKDORolZJCYehO1Cyx4a7XRWHD5s3hyCgIa
         Y0LUiOHveSCb54UG87bC5FjF089qp5YhY5mnszd8VwxQSmU9gJJe/UgpPj3Zo+wiG0wQ
         IPkw==
X-Gm-Message-State: AGi0PuaGSuk7qqbb5J2VRpIb68RvyBbftYv7EXjJkPZqH1DmhR0swvFr
        gn28zuVcoG49uRVg1P9l8A==
X-Google-Smtp-Source: APiQypIRlMbrSk467b8ch8GEIs0tdW1iIBJ5clIPnKZJ1NATxlpFo+/Ezfx3Bv68xYsrgs91PDj6mA==
X-Received: by 2002:a05:6808:992:: with SMTP id a18mr110243oic.142.1587072524616;
        Thu, 16 Apr 2020 14:28:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm7405057otk.24.2020.04.16.14.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:28:43 -0700 (PDT)
Received: (nullmailer pid 29393 invoked by uid 1000);
        Thu, 16 Apr 2020 21:28:42 -0000
Date:   Thu, 16 Apr 2020 16:28:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200416212842.GA18756@bogus>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
 <20200312211438.GA21883@bogus>
 <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
 <CAL_Jsq+W84r687zNV=2S-hj9=xbTQxkx9MpVNDTn6TOrBgiGUw@mail.gmail.com>
 <20200331195053.dcexmhbsbnbfuabe@ubsrv2.baikal.int>
 <20200416195620.4q6scqk5rqbonz4s@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416195620.4q6scqk5rqbonz4s@ubsrv2.baikal.int>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 10:56:20PM +0300, Sergey Semin wrote:
> Rob,
> Any comment on my suggestion below?
> 
> Regards,
> -Sergey
> 
> On Tue, Mar 31, 2020 at 10:50:53PM +0300, Sergey Semin wrote:
> > On Wed, Mar 18, 2020 at 05:14:25PM -0600, Rob Herring wrote:
> > > On Fri, Mar 13, 2020 at 7:03 AM Sergey Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > On Thu, Mar 12, 2020 at 04:14:38PM -0500, Rob Herring wrote:
> > > > > On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > >
> > > > > > Optional regmap property will be used to refer to a syscon-controller
> > > > > > having a reboot tolerant register mapped.
> > > > >
> > > > > NAK. It should simply be a child node of the 'syscon-controller'.
> > > >
> > > > Hm, It's dilemma. The driver maintainer said ack, while you disagree.)
> > > > So the code change will be merged while the doc-part won't? Lets discuss then
> > > > to settle the issue.
> > > >
> > > > Why 'syscon-reboot' can be out of syscon-controller node, while
> > > > 'syscon-reboot-mode' can't?
> > > 
> > > Look at the history and you will see one was reviewed by DT
> > > maintainers and one wasn't.
> > > 
> > > > They both belong to the same usecase: save
> > > > cause id and reboot. So having similar properties-set and declaring their
> > > > nodes someplace nearby is natural.
> > > 
> > > Which is what I'm asking for. Where else in the tree does it make
> > > sense to locate the 'syscon-reboot-mode' node? Locate nodes where they
> > > logically belong.
> > > 
> > > > According to the driver 'syscon-reboot'
> > > > can't lack the regmap property because it's mandatory, while here you refuse
> > > > to have even optional support. Additionally in most of the cases the
> > > > 'syscon-reboot' nodes aren't declared as a child of a system controller
> > > > node. Why 'syscon-reboot-mode' can't work in a similar way?
> > > 
> > > There's plenty of bad or "don't follow current best practice" examples
> > > in the tree for all sorts of things. That is not a reason for doing
> > > something in a new binding or adding to an existing one.
> > > 
> > > Rob
> > 
> > Alright. I see your point. What about I'd provide a sort of opposite
> > implementation? I could make the "regmap"-phandle reference being optional
> > in the !"syscon-reboot"! driver instead of adding the regmap-property
> > support to the "syscon-reboot-mode" driver. So if regmap property isn't
> > defined in the "syscon-reboot"-compatible node, the driver will try to
> > get a syscon regmap from the parental node as it's done in the
> > "syscon-reboot-mode" driver.

That seems fine.

> > Seeing you think that regmap-property-based design is a bad practice in
> > this case, I also could mark the property as deprecated in the "syscon-reboot"
> > dt schema and print a warning from the "syscon-reboot" driver if one is defined.

Depends on how many platforms will start getting warnings. I think just 
marking deprecated is enough.

Rob

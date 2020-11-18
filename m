Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29F12B81C7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKRQZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 11:25:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33442 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKRQZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 11:25:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIGOjL7018889;
        Wed, 18 Nov 2020 10:24:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605716685;
        bh=qOI15Yvp3Z3lVQdbe7mRSctNC5WIITWbCkEyLIakvDw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MskiGtjQ3pEHn6u/8heA7p/5JlaOM4CYy0FC4oOSqK95VpycvFNz5d3pBOnbh0xNH
         I8I8vCY+uLaOM/0+eqEHXr8N512xu8GWBvG7c9PYdUOMYdawl4HdkPiScP10+S/SSy
         KhhfxyjT1GAWC+aXEnJA2BiLQ+Q5zIfJspTcIe+8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIGOjsN027775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 10:24:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 10:24:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 10:24:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIGOihP063466;
        Wed, 18 Nov 2020 10:24:44 -0600
Date:   Wed, 18 Nov 2020 10:24:44 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andreas Kemnade <andreas@kemnade.info>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <lkft-triage@lists.linaro.org>, <linux-pm@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] regulator: ti-abb: Fix array out of bound read access on
 the first transition
Message-ID: <20201118162444.ftglntlawvg2zuor@tainted>
References: <20201118145009.10492-1-nm@ti.com>
 <20201118163807.3783192c@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201118163807.3783192c@aktux>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16:38-20201118, Andreas Kemnade wrote:
[...]
> > Though theoretically, there is a possibility that the compare may
> > pass and result in missing bias configuration(and resulting system
> > will be unstable), I have'nt heard of actual report (but, it will be
> > surprising if any actual instability was actually tracked down to this
> > bug). Any ways, I had to go to git full history to pick the exact
> > commit - I have left it in the patch.
> > 
> > 
> Hmm so probably these boot problems which only occur when your debug
> cable is not attached?

If you mean a timing problem introduced by connecting jtag as in a
timing behavior? short answer: NO.

Long winded answer: To understand the bug, we need to understand what
is being programmed, why is there a comparison and then we understand
why this is a bug.

What is bring programmed:

In certain domains, Transistor in the older TI SoCs in OMAP generation
were doped and had specific voltage planes to allow for very fine
grained tuning of transistor switching frequency to be a factor of
vdd (domain voltage) AND a bias voltage. So, if you attempt to switch
the transistors at a specific frequency with either just the voltage
or bias correctly configured, depending on the age of the transistor
and temperature factors, transistors may start misbehaving. This is
basically like a 101 of transistor physics.

Voltage is the other factor that comes into play - Adaptive voltage
control is yet another scheme on TI (and a lot more other SoCs now -
different names, but fundamentally the same thing..) to balance the
correct level so that the transistors dont go and end up in a thermal
runaway scenario. (but not the context of this discussion)

What is the check in the code?
This is basically a check to prevent reconfiguring the ABB (Body bias)
hardware if the configuration that is present on the hardware is the
same as before. this may be the same index, OR could be that multiple
indices have the same programming configuration.

It is the second part (multiple indices have the same programming
configuration) that is of interest for this bug.

Why: The ABB hardware blocks' Bias programming involves a set of steps
that can take too long OR can put the state of the hardware into
intermediate state which may be unstable as the transition of clock
frequencies OR voltage takes place (this is the transients / short
term intermediate configuration "glitches" that we want to avoid).

Now, the problem happens when you compare index[-EINVAL] basically
array negative offset against a valid array, you are comparing
content, so it is not a timing related problem. if it so happens that
the content compared was same (very very very unlikely that after all
linkage etc.. -EINVAL offset will exactly matchup .. but lets say you
use address randomizer of some sort.. then there is a chance that
some unrelated address content may happen to have the same content as
comparison point, yes..).. anyways, if the compare matches, the logic
wrongly assumes.. hey, this was already a configured ABB bias and
ok, lets skip programming it.. Now you end up with freq and voltage
correct and ABB wrongly configured for the duration.. situation
does'nt exactly recover itself till a mismatches content index is
compared.

So, no, unless we are using debug cable to artifically create the
mismatch, you should'nt see a difference of debug vs no debug cable for
this bug at least.
> 
> Is there any connection with commits like this:
> ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo

Side note: Help lookup with commit ID..
341afbc9ea39 ("ARM: dts: omap36xx: using OPP1G needs to control the
abb_ldo")

> 
> So would the potential problem be more probable by patches like the
> that one mentioned above?

Short answer: no.

Long winded answer:
That is actually fixing the problem where one part of the problem
(enabling ABB is being done for higher OPPs) - we will also need AVS
class 1.5 for a complete solution. Honestly, I have'nt had time to pay
closer attention to what was going on there, but note that bias along
with the correct voltage is the functional state for the transistor
the correct switching frequency. Remember: these are configurations that
TI puts on chip assuming all worst case operational conditions AND
adding a margin on top.. Very very few devices in the broad spectrum of
usage ever come and operate in that "bad space".

So, we may have some level of fall outs in probably corner of the bell
curve in the part distributions in the process.. Chances are very
high that the typical device most folks have are "nominal" and not in
the tail end of the process distribution, so, most of the users can
probably survive having a "non-optimal" configuration.


So the combination probability: you are operating in a corner process
lot in the worst possible condition + your invalid array index
pointed memory content exactly matches the content of valid index
memory content, hence skipping a bias programming... Ummm.. If I
was a betting man, I'd probably bet against it.. But, hey, be a bit
conservative at times, who knows..I think there are few of these
devices that have flown off to space, right?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

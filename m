Return-Path: <linux-pm+bounces-5406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C219988C019
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C96D1F35DC0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD6A134C6;
	Tue, 26 Mar 2024 11:02:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FEDDBC;
	Tue, 26 Mar 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450964; cv=none; b=V7kWhXGbTozWzjyu+d8pSaWPrSb+s/+dO3V9ykGAJRirg+6TQ76/GPOaZdc2RmguL4hn/VBfYgBZiBT2vVhYT1/Fjd+WTK+eWbfiSDfiiDS/jTNn201l6+6/ekTN6dtrIlDluF5syrgFO4sdEW2wZcuPI8rHdQAAm7YeLUQEGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450964; c=relaxed/simple;
	bh=lJZ872wzJYmtD936Nj9aY6ECjXsLe8FKlqpmsMJ7meM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHKNkPpPESdnsB0vToIPv9EcHpFuHMEy497W/5DwC3kA4Bvri6seo1em18P8zgD57yk9/UmV45LJXIp7UhVctjPUdyLH8mIh0IeT9zWhYtAU65cfsurPuZQlBEnDfPjOo6KwsS9k3YYuGIXG3CO7KjEQ+/+od0ze7niPS+9fJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D4D2F4;
	Tue, 26 Mar 2024 04:03:15 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5017A3F64C;
	Tue, 26 Mar 2024 04:02:39 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:02:36 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Brandon
 Cheo Fusi <fusibrandon13@gmail.com>, Martin Botka
 <martin.botka@somainline.org>, Martin Botka <martin.botka1@gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: opp: Describe H616 OPPs and
 opp-supported-hw
Message-ID: <20240326110236.69ba33a8@donnerap.manchester.arm.com>
In-Reply-To: <20240321030923.4sf3lifbmnvvidaa@vireshk-i7>
References: <20240318011228.2626-1-andre.przywara@arm.com>
	<20240318011228.2626-4-andre.przywara@arm.com>
	<20240320150228.GA1705913-robh@kernel.org>
	<20240320153738.3e2410bf@donnerap.manchester.arm.com>
	<20240321030923.4sf3lifbmnvvidaa@vireshk-i7>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 08:39:23 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

Hi Viresh,

thanks for chiming in!

> On 20-03-24, 15:37, Andre Przywara wrote:
> > On Wed, 20 Mar 2024 10:02:28 -0500
> > Rob Herring <robh@kernel.org> wrote:  
> > > On Mon, Mar 18, 2024 at 01:12:23AM +0000, Andre Przywara wrote:  
> > > > From: Martin Botka <martin.botka@somainline.org>
> > > > -        opp-1080000000 {
> > > > +        opp-792000000-l {
> > > >              clock-latency-ns = <244144>; /* 8 32k periods */
> > > > -            opp-hz = /bits/ 64 <1080000000>;
> > > > +            opp-hz = /bits/ 64 <792000000>;
> > > >  
> > > > -            opp-microvolt-speed0 = <1060000>;
> > > > -            opp-microvolt-speed1 = <880000>;
> > > > -            opp-microvolt-speed2 = <840000>;
> > > > +            opp-microvolt = <900000>;
> > > > +            opp-supported-hw = <0x02>;
> > > >          };
> > > >  
> > > > -        opp-1320000000 {
> > > > +        opp-792000000-h {
> > > >              clock-latency-ns = <244144>; /* 8 32k periods */
> > > > -            opp-hz = /bits/ 64 <1320000000>;
> > > > +            opp-hz = /bits/ 64 <792000000>;
> > > >  
> > > > -            opp-microvolt-speed0 = <1160000>;
> > > > -            opp-microvolt-speed1 = <940000>;
> > > > -            opp-microvolt-speed2 = <900000>;
> > > > +            opp-microvolt = <940000>;
> > > > +            opp-supported-hw = <0x10>;    
> > > 
> > > So far, we've avoided multiple entries for a single frequency. I think 
> > > it would be good to maintain that.  
> > 
> > Fair, I wasn't super happy with that either, but it still seemed better
> > than the alternatives.
> >   
> > > Couldn't you just do:
> > > 
> > > opp-supported-hw = <0>, <0x10>, <0x02>;
> > > 
> > > Where the index corresponds to speed0, speed1, speed2.
> > > 
> > > If not, then I don't understand how multiple entries of opp-supported-hw 
> > > are supposed to work.  
> > 
> > If I got this correctly, multiple cells in opp-supported-hw are to
> > describe various levels of hierarchy for a chip version, so like silicon
> > mask, metal layer revision, bin, I guess? The binding doc speaks of "cuts,
> > substrate and process", not really sure what that means exactly.  
> 
> Right. That basically translates to hardware versions the OPP will be parsed
> for.
> 
> > I think currently we cannot easily combine microvolt suffixes and
> > opp-supported-hw in one OPP node?  
> 
> It should be fine.

You are of course right, that works. I think I tried without
opp-supported-hw before, and then the code doesn't like missing voltage
lines.

> 
> > I think it bails out if one
> > microvolt-speed<x> property is missing, but I have to double check.
> > But IIRC v1 of this series somehow pulled that off, so we can maybe bring
> > it back? To end up with:
> > 	opp-792 {
> > 		opp-hz = <792000000>;
> > 		opp-microvolt-speed1 = <900000>;
> > 		opp-microvolt-speed4 = <940000>;
> > 		opp-supported-hw = <0x12>;
> > 	};  
> 
> That's what I thought too while reading your email.. Just populate the OPP for
> both 0x10 and 0x02 versions and let the speedN thing get you the right voltage.

Yes, that works nicely. I adjusted the binding example and the actual OPP
table accordingly. Will send a v3 shortly.

Cheers,
Andre


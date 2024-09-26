Return-Path: <linux-pm+bounces-14781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69A3986D8C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1731C23D8A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590B18952E;
	Thu, 26 Sep 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="K8+wIgRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C718E02B;
	Thu, 26 Sep 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335613; cv=none; b=c4cun1RqYH8N+hdm9xRj9Epf3h7Uchk3syaiohoWyFBAFcLIAfr5X0MABn3ElUW62wAVLu+fxcWK7RIJkr2JQ7vc8DCz0zDq2ih01liRnIOnV2CXpEkkhWy11eBR5cVeP23/p0nEpETeE/dVZEfqZDJIojP3trjjsanHvuO4tHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335613; c=relaxed/simple;
	bh=fva6FxQLoAXNisGseAdtmn9L1KpB0FiPdwPR6G5fVUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO0MwLli99U9Lim+I11ecbxpVrDjkPGUq6koZ3X3hQH36NWhsOq56EYUTli3spNzk2QiWzOregrjMZN93vziBKe1qMwF2Xt3QJq8pFbhejEq965KyJeScnP5VWuqSQiS4puqEt+0Qo+wYUwa7y0NCUtbsUkJ6f5YHeU9ha/XHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=K8+wIgRu; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fkKQn+szJITzOoWZafm1yExrFg3A8MegVG+DAbo/JSQ=; b=K8+wIgRunqfQ0d4l9TZike/Cmi
	QXEaehuKUWpbJgl0dPZFVnPZVM3kfD/nMCxhvqk2VOmpKGO538Y5Q9L8fglnMHRhY2Z4kT3KsUxfM
	fyqEmSshnLRaaFvcuy130yxIVGAJNhha4pHfwHMQ+Z05Zy75Ms1NF1AQXqo2KJz3hnBYIJSdv9JOv
	f889fnFgREfwSbvtn0kXsPA7UloSzCPkQX7fCsw/PHepN49sCO24zKj650F8KZtzf8qniqnaLFlD8
	Tag1U7yVT/mp8vc9rG3xc72UE9mne2UOGQUWSiqLdUiBvjQf2aeZCTwbEtuP2oJNohtJJpMFPoH8X
	eq+qzFRw==;
Date: Thu, 26 Sep 2024 09:26:43 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com, Sebastian
 Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: twl: add charger node also for
 TWL603x
Message-ID: <20240926092643.7b8a452d@akair>
In-Reply-To: <20240921005125.GA165161-robh@kernel.org>
References: <20240918084132.928295-1-andreas@kemnade.info>
	<20240918084132.928295-3-andreas@kemnade.info>
	<c38c9ada-e054-4a14-9265-25065048ae54@kernel.org>
	<20240921005125.GA165161-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Fri, 20 Sep 2024 19:51:25 -0500
schrieb Rob Herring <robh@kernel.org>:

> On Wed, Sep 18, 2024 at 12:47:22PM +0200, Krzysztof Kozlowski wrote:
> > On 18/09/2024 10:41, Andreas Kemnade wrote:  
> > > Also the TWL603X devices have a charger, so allow to specify it
> > > here.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  .../devicetree/bindings/mfd/ti,twl.yaml        | 18
> > > ++++++++++++++++++ 1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > > b/Documentation/devicetree/bindings/mfd/ti,twl.yaml index
> > > e94b0fd7af0f8..4064a228cb0fc 100644 ---
> > > a/Documentation/devicetree/bindings/mfd/ti,twl.yaml +++
> > > b/Documentation/devicetree/bindings/mfd/ti,twl.yaml @@ -105,6
> > > +105,11 @@ allOf: regulator-initial-mode: false
> > >  
> > >        properties:
> > > +        bci:  
> > 
> > charger
> >   
> > > +          type: object  
> > 
> > additionalProperties: true
> > 
Thinking again. Why additionalProperties? unevaluatedProperties
looks more reasonable for me. There are additional properties but
they should be evaluated by another schema.

> > Each node must end with additionalProperties or unevaluated. I
> > think you never tested it, because dtschema reports this.  
> 
> This is under an if/then schema is why there's no errors.
> 
and then it just accepts anything with compatible twl6032-charger e.g.
and does not care about anything in patch 2, because it has a different
compatible.

> This schema probably should have been 3 with a ti,twl-common.yaml
> schema for the common properties, but I'm not sure it is worth
> changing now.
> 
Or a ti,twl4030.yaml and a ti,twl603X.yaml. 6030 and 6032 have more in
common than the 4030.
I would propose that is something for the next more final cleaning
up/conversion round. First I would like to avoid having drained
batteries because of no charging, so allow for more automated testing
and bisecting. 
I think I will prepare a v2 series on monday.

Regards,
Andreas


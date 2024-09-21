Return-Path: <linux-pm+bounces-14524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A321997DB0A
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 02:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205B71F21F59
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5F2119;
	Sat, 21 Sep 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skeOAPTI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59C15C3;
	Sat, 21 Sep 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726879887; cv=none; b=sa9dYtk/wa18EVByys6lZEXoquAS+oeOhQein9sfjNdQ3N9vEWOkTW9jGwXsu0ahxKh87pkVtH16qMLUiw9V6xFt0RYF0WGy9aOkwsv0VoSbiaAC5kG79GF7IHrrkCDU2dE1HtB5+uae+m2VaCFv2+Ihe0qLN378w07YK8d/nX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726879887; c=relaxed/simple;
	bh=xfWEe9VXimdKEOoSPZSqdLphGcQU8Jjk+vswELSDzKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbaoMATRiVOy1/t2/wkZ0rU8QGTPeiOcLu0NM+Jo8UdFdsZ349DSW55wa7xJHP+VnECOnUvH4SK9Eu+9YAP0iaRCpQfh+ROoogmW/kJIRmWlGlqc2ss3rWML5CEJBtPdcMJfQajilaZZ/S+8mcsdpoSeb52lArkHugxL0/jLyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skeOAPTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCFAC4CEC3;
	Sat, 21 Sep 2024 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726879886;
	bh=xfWEe9VXimdKEOoSPZSqdLphGcQU8Jjk+vswELSDzKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skeOAPTIlhpkJyDgBSPs5lSqa5ttldDH1qhOvFY47o2jtPOmt98dPmGz2ZWeIYbBn
	 X5TX4p2FOFvPG3+S99hf4SM363DCLmO9ZYVKtY4t+9TQ5vNxzOG+pBi50upxD6S9Oi
	 KZWFSdcoLA/PyNC3GhxFRXlRA9+nm3NECq8E1mh/jd2yDdkVRyhtBolDiRz3Rxadcs
	 UgibMqjG1YgTR9+FwBYkFPvwkq1A5ZNzlHw8rWSfMk0k+TZPTHX3mtyAVWOYs4qQVM
	 xDkHRrGyyF3Y/b47s7Z80nPQNR+r3EocThTdC49Re83f/2tZD0zoXuxVqrb86RSxcJ
	 +7aptXJOWuuiQ==
Date: Fri, 20 Sep 2024 19:51:25 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
	Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: twl: add charger node also for
 TWL603x
Message-ID: <20240921005125.GA165161-robh@kernel.org>
References: <20240918084132.928295-1-andreas@kemnade.info>
 <20240918084132.928295-3-andreas@kemnade.info>
 <c38c9ada-e054-4a14-9265-25065048ae54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38c9ada-e054-4a14-9265-25065048ae54@kernel.org>

On Wed, Sep 18, 2024 at 12:47:22PM +0200, Krzysztof Kozlowski wrote:
> On 18/09/2024 10:41, Andreas Kemnade wrote:
> > Also the TWL603X devices have a charger, so allow to specify it here.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../devicetree/bindings/mfd/ti,twl.yaml        | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > index e94b0fd7af0f8..4064a228cb0fc 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > @@ -105,6 +105,11 @@ allOf:
> >              regulator-initial-mode: false
> >  
> >        properties:
> > +        bci:
> 
> charger
> 
> > +          type: object
> 
> additionalProperties: true
> 
> Each node must end with additionalProperties or unevaluated. I think you
> never tested it, because dtschema reports this.

This is under an if/then schema is why there's no errors.

This schema probably should have been 3 with a ti,twl-common.yaml schema 
for the common properties, but I'm not sure it is worth changing now.

Rob


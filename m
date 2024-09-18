Return-Path: <linux-pm+bounces-14407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCD97BBAF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB111F23B96
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AAA18858E;
	Wed, 18 Sep 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="aB4sLtY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC1282E5;
	Wed, 18 Sep 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726659356; cv=none; b=o+hJWUIx7dqvr036pSe5U0KqRdDrEOboRhJeQxDvemtccWnCN3A5z3dX0PKBfyhB+nrzGFd6gveJURdKLloIrndpGw9p6p+upG4xMtg25krVXsLBJRcxdEqulP9SEN8viWgJdQsJB6EJpDMneD2KzUCcmzhoRPANMpaqANx/Q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726659356; c=relaxed/simple;
	bh=PPDrz82lIfrteE+dEjEqvbG0bP+PLJJgb9hsrt8OMl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aws+d+2TUygEap33mcJJsQW0VIbD91LdtKQPKmbVj78o/ufIdrr0OpEChTVj7K02i2iZ0/IISXbbeEa+wia3CEGwW8zxb4/LKuR7dNFacpT334sBnmhHO4V8DWC1b4xVNHxQSRQ94c0YN4He1nlicyfBewDQVrjw0BPJgbVxtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=aB4sLtY8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=c+4wISZpTBZ5pFb7R+0lordsy6M0zdVfp3Wwwcoc6g4=; b=aB4sLtY8ju6ohBMuN3AV9zX8TM
	3F4E1iB+yGNMjguydi/Akd6s9lRhMiXsWALCyq9WH0wvHNyGlsk1xcUnQjthvySuaGtoTs9xGIYpD
	/cV/Z7zU9jknjL/ASjyez8+PY+sEs+Ij0NuxZtra+Fo/W/737JPZCbyjle2o13cJ3Xs7oWDtwElCw
	oizzrpcGkBeSvDDaDPaEQeTYXafcDEQOFHzncVUh91ww7dFUTN+SJAO0j2Hx5BclczEj6DhHcRSPy
	TtwueghTfLIt8oMFKUKVKAmch8k25EGf7pOVeocYOFHbwn4WCKzIAHY+aTv5Jk2oRn5nXp5PVmFtz
	qvSD6nlA==;
Date: Wed, 18 Sep 2024 13:35:46 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tony@atomide.com, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: twl: add charger node also for
 TWL603x
Message-ID: <20240918133546.33cb6d68@akair>
In-Reply-To: <c38c9ada-e054-4a14-9265-25065048ae54@kernel.org>
References: <20240918084132.928295-1-andreas@kemnade.info>
	<20240918084132.928295-3-andreas@kemnade.info>
	<c38c9ada-e054-4a14-9265-25065048ae54@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 18 Sep 2024 12:47:22 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

> On 18/09/2024 10:41, Andreas Kemnade wrote:
> > Also the TWL603X devices have a charger, so allow to specify it
> > here.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../devicetree/bindings/mfd/ti,twl.yaml        | 18
> > ++++++++++++++++++ 1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > b/Documentation/devicetree/bindings/mfd/ti,twl.yaml index
> > e94b0fd7af0f8..4064a228cb0fc 100644 ---
> > a/Documentation/devicetree/bindings/mfd/ti,twl.yaml +++
> > b/Documentation/devicetree/bindings/mfd/ti,twl.yaml @@ -105,6
> > +105,11 @@ allOf: regulator-initial-mode: false
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
> Each node must end with additionalProperties or unevaluated. I think
> you never tested it, because dtschema reports this.
> 
I did run it, no complaints:

andi@aktux:~/kernel$ touch Documentation/devicetree/bindings/mfd/ti,twl.yaml 
andi@aktux:~/kernel$ touch Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml 
andi@aktux:~/kernel$ make ARCH=arm dt_binding_check DT_SCHEMA_FILES=twl
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/andi/kernel/Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTC [C] Documentation/devicetree/bindings/power/supply/twl4030-charger.example.dtb
  DTEX    Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.example.dts
  DTC [C] Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.example.dtb
  DTC [C] Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.example.dtb
  DTC [C] Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.example.dtb
  DTEX    Documentation/devicetree/bindings/mfd/ti,twl.example.dts
  DTC [C] Documentation/devicetree/bindings/mfd/ti,twl.example.dtb
andi@aktux:~/kernel$

Regards,
Andreas


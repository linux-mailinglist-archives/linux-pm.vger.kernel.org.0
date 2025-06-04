Return-Path: <linux-pm+bounces-28115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD0ACE0BA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F02188CE53
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE9290DA7;
	Wed,  4 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="JeQB3GwK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9925C801;
	Wed,  4 Jun 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048526; cv=none; b=ruqpWd97hdWdES2W4b5eNVOuXFx+MUQ3GwawaQsDQFj+eJUJ+gfTzYSuVVBd5+GqruFIFwhb0dklH+M6n2/GeZn2crBTZPRP5JMRt9juUfjoNpsKJQkczz+DG12YcJDKCWcMUNKDIIuhHNPG7VEwSMx39nj8sM52QTo/FN+Aajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048526; c=relaxed/simple;
	bh=iAh3S8VOuuZTZ4HbWC4OQklPUScRAN7wXnHJJOh3i9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRPpC342ppILaBacHOSrzx6e84ERmkP5UdKXry6hBSqkQI+ykZ5droC5UPSuO9JlQe8sNC4gOyNAbgqtwwhx7twDxsMr6xt6wg9/yGpoVw5GZqDa8/hYaIy4103ejiVYPoskzojJ7YlDOUYuYvzzHxP9Dkx1QubZ5RPhK1kgasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=JeQB3GwK; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7C8123D852DB;
	Wed,  4 Jun 2025 10:48:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VQ7zUzPCdv6W; Wed,  4 Jun 2025 10:48:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E55A73D856F5;
	Wed,  4 Jun 2025 10:48:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E55A73D856F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1749048521; bh=YT5CSr2behDQmvPervqqlHa1+NLbBpJUObmWSJIQq/Y=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=JeQB3GwK3wTiyXogTAfOrYwGcRm8xVrhtaSj171R6hqkME5SkY4/ym+sMcOH++T3y
	 tmk3ZzALIR/ozEhe9tTMRPfLBi8YFnD+khmcifiZmLuUAkV+EiQjInaZdXTMt/N6zz
	 e24EQgG+kxWDvS3C4vDNq1wUhi2BNII8C6PwUcIYmSCR0unF21ochP0uJTed8MYpez
	 ZP+Kw8Nv2OAoMEbhnLtko7wJEGOXzCbyhUjUm/pFkaaMAQOw8eps4YH84qIpRbXtyE
	 I9zakO/U6PGJsyikSZzdq/D3EmDxYNxgHvCc00WIsQFluPLzqkVqKP2QiuBdX+4x3Y
	 XKfc3i0yYY8Lw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id N-LkPakHOke5; Wed,  4 Jun 2025 10:48:40 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9437B3D852DB;
	Wed,  4 Jun 2025 10:48:40 -0400 (EDT)
Date: Wed, 4 Jun 2025 10:48:39 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 3/6] regulator: pf1550: add support for regulator
Message-ID: <aEBcx0ySywwa4BaZ@fedora>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-3-bfdf51ee59cc@savoirfairelinux.com>
 <eb1fb4e2-42aa-4795-bc6c-dbcf1fa04f11@sirena.org.uk>
 <aEBSSHA8bxw2igAW@fedora>
 <f2064326-e696-48cc-8f0e-5e51c95548b5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2064326-e696-48cc-8f0e-5e51c95548b5@sirena.org.uk>

On Wed, Jun 04, 2025 at 03:25:29PM +0100, Mark Brown wrote:
> On Wed, Jun 04, 2025 at 10:03:52AM -0400, Samuel Kayode wrote:
> > On Wed, Jun 04, 2025 at 12:35:21PM +0100, Mark Brown wrote:
> 
> > > > +	switch (irq_type) {
> > > > +	case PF1550_PMIC_IRQ_SW1_LS:
> > > > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > > > +	case PF1550_PMIC_IRQ_SW1_HS:
> > > > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > > > +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> > > > +		event = REGULATOR_EVENT_OVER_CURRENT;
> 
> > > You appear to be flagging all these events as over current events which
> > > doesn't seem entirely plausible.
> 
> > It does seem like it but the manual describes these interrupts as "current limit
> > interrupt". The interrupts ending in _LS are "low-side current limit interrupt",
> > _HS are "high-side current limit interrupt" and _FAULT are "current limit fault
> > interrupt".
> 
> That at least needs some comments I think, and for the _LS while it's
> hard to parse what "low side" means my guess would be that it's a
> warning to match the other interrupt being the actual error.

Yes, It certainly does need comments. The high-side sensing is more accurate
and can detect load shorts, so a warning for low side would be more appropriate.

Thanks,
Sam




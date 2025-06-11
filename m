Return-Path: <linux-pm+bounces-28430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B0AD493F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586F718994D0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBEB7E0FF;
	Wed, 11 Jun 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ud1rhdty"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540C382;
	Wed, 11 Jun 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749611719; cv=none; b=UuVNgOilyuKoYR1SoeX0ELx9BrmlZmkbf75rBIz02ahaQti9NoTXdiolR3hCc6Zii1l7MzEPG1X7LMz/BLOKLJXX6Qk5gCavA3WqzHyEhU3E/JMz7DUoaaLscesRWqE0/b08tpdXmt7YAQnHHZPvQ6ZGo8jnM95tO15NfArJVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749611719; c=relaxed/simple;
	bh=DVA5qFswk6iXJ/N1plbE7chdHkrDmca4dgefxI9a7qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnvAVpRvcH9eOEsCp2s4X2tJMxnnAOxR678CNKMNUiG7Gqiohsj9IQG8ipFLBYBsAtNLv5sUkXzX20j93WqQqZynno86iLUwWADKoTW5lmiir0n7Xvu96bIF40XFnvCWzFjqQDWMxnEq7UhZG+s3wHskHv72z99rtJLfS1yR3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ud1rhdty; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4D1EC3D875C7;
	Tue, 10 Jun 2025 23:15:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id atB_blumOGNh; Tue, 10 Jun 2025 23:15:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DB55D3D8760A;
	Tue, 10 Jun 2025 23:15:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DB55D3D8760A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1749611707; bh=lUqSdGomfcXWRdfKxjUuLGoqWQaLYyPcpWf4O0c0pSg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ud1rhdty7qh7DmmQ3zxh270/Mn2E0gqn/nr76xbHtOJeTpdeYoQnafN4Mg/NySJCw
	 2xsQz1B6acejnDdCr9nzhhHVfj/yF3maOOzfCPa3XpE364EjcnFVdGop4mzSdwq5ww
	 YM/sQDbWofDd+4NgDQbEGXiX12jrFs3fRplJ9zLtXpA7RaxUsHY1QqNTRZVWDu6TFu
	 ciPj/F+HWiBsDjnfcbV+Oa/oqOTXoy/Xx7CllxeHqwjLOlwUbjrD5fo+FjeuvQH3vi
	 Cfcc42fMeQiPa/ipWh8VHkxxn4ex1EaxIVwrg7LiesRj93+6Cm26Xd0N4TBTAcbG/c
	 7Sk4ABVimsjww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YhwpZXGteoB4; Tue, 10 Jun 2025 23:15:07 -0400 (EDT)
Received: from sam-fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1E2733D875C7;
	Tue, 10 Jun 2025 23:15:07 -0400 (EDT)
Date: Tue, 10 Jun 2025 23:15:05 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Message-ID: <aEj0uYahiPOZBrv8@sam-fedora>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-6-ed0d9e3aaac7@savoirfairelinux.com>
 <aEiVZBloUxYcNOIP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiVZBloUxYcNOIP@lizhi-Precision-Tower-5810>

On Tue, Jun 10, 2025 at 04:28:20PM -0400, Frank Li wrote:
> On Tue, Jun 10, 2025 at 03:47:34PM -0400, Samuel Kayode wrote:
> > Add MAINTAINERS entry for pf1550 PMIC.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98201e1f4ab5908ff49d32d19275e123cedb4b66..29287ab3c9d00240ecb0ac9793aa908ec75a9bd0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17853,6 +17853,16 @@ F:	Documentation/devicetree/bindings/clock/imx*
> >  F:	drivers/clk/imx/
> >  F:	include/dt-bindings/clock/imx*
> >
> > +NXP PF1550 PMIC MFD DRIVER
> > +M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> > +S:	Maintained
> 
> Can you add mail list imx@lists.linux.dev ?

Definitely. I'll add it in the next version.

Thanks,
Sam


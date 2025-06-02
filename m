Return-Path: <linux-pm+bounces-27947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3EACA7FA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 03:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942B617DF87
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9D1A8F60;
	Mon,  2 Jun 2025 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="hhN6dSWv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BC19341F;
	Mon,  2 Jun 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824952; cv=none; b=tQ+HeDaRTr+u/Nsey2hh+o1EDfUg1d9e0BvE0M5lUNG6NUyXFQpzG0wFy5biojGU+Zn1RdC8cMNEWmFb1dRBPq1jxpcSzftExnRP2qKDnBb1Ay2xHbFvSMAjW51KeJE5aPy4oPB+1Ik3G/GtBXmolOt7guVlknxguQup8zqArsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824952; c=relaxed/simple;
	bh=qVBY2Xy5VTMBo/Es56vPn+a920Bmz7OMuPkSYK/iDNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnSpCnK+1HoT8afcQ5BmanPkFZHlqo2AN/nt46KMDomWIyycEmRRrTNEFs5fyAA1ivdtm+EFckaGbnuC/a0bWspJWUTWlLEPwvh7RnGxw3QIEhN/AsCUT2qn0wXZ1uF7sx9Oci5+qpTENgbGZ0i+8maGseU+NfWQFPQWw/sezL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=hhN6dSWv; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 491783D8587F;
	Sun,  1 Jun 2025 20:42:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id eBY6RumoAwOC; Sun,  1 Jun 2025 20:42:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B1BCE3D875F6;
	Sun,  1 Jun 2025 20:42:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B1BCE3D875F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1748824941; bh=Xzh1OzEqCoeKsOCqzynE2C4wVEnfI9BFoS0rEmdT1kQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hhN6dSWv799V5B6gURI2E/K9U+Txk5Wx9NRlEXl3Igl7gIChoHqW+hXLeGHbQM+2R
	 onzYAsWxEBfdpswNggp02ivskbUSVRVYPbJqXIdHXjbOP47zHuGvCUwHOFX9dDFgd1
	 TIu4N4gjhdzvrsRam5P3nV2bTTKKGb7HurN7xIkZaL59Hs9x9ukucQgXc+AguIx3zj
	 lJ1jmeaJfrDJpBoFJUMqY3p0MKGd4oeJVinnuL5Oq1ZW2grBlUdLSXT7DF07LMiGzI
	 y0amcnWSGpXfh+F3qXZ4FxRyFZjEF5oDq1SV7mBX93JxFa18SjpmxW1ficQ7TjDDKF
	 eD52yp04qCBFw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hWETjEeJyFga; Sun,  1 Jun 2025 20:42:21 -0400 (EDT)
Received: from sam-fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0DAC63D8587F;
	Sun,  1 Jun 2025 20:42:21 -0400 (EDT)
Date: Sun, 1 Jun 2025 20:42:19 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	eballetbo@gmail.com, abelvesa@linux.com, b38343@freescale.com,
	yibin.gong@nxp.com, Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 4/6] input: pf1550: add onkey support
Message-ID: <aDzza2uN7bsETKT3@sam-fedora>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
 <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>
 <xuuvptsz6ryeanj4wu6hzzskcdspwdis4p54hhsbhny5mmcodw@2ihxnzlva5ff>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xuuvptsz6ryeanj4wu6hzzskcdspwdis4p54hhsbhny5mmcodw@2ihxnzlva5ff>

On Tue, May 27, 2025 at 05:20:48PM -0700, Dmitry Torokhov wrote:
> > +static const struct platform_device_id pf1550_onkey_id[] = {
> > +	{ "pf1550-onkey", PF1550 },
> 
> Why do we need to set driver_data here? 
> 
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
We don't! I'll make changes accordingly.

Thanks,
Sam


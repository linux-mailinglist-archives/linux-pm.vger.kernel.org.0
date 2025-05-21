Return-Path: <linux-pm+bounces-27463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C50ABFB01
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D9A18836D6
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258E22B5B8;
	Wed, 21 May 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="oDFVypqv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7019D06B;
	Wed, 21 May 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844212; cv=none; b=CUVAeEYDwN85KNIpGStBjzoadPjWrGtp63m0FaN7I1k4MZSNfpbg7PDY2e1mfS6X8KcIM05yA/2ZuIMe1Ro/c3AYLAIqvWQqoT4mhXUeanJRPbNys7RmllE15qdLwnfOmgDOeDhrvQtb8X7uyfDLbX76kANjELhFYm1mHpUXRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844212; c=relaxed/simple;
	bh=1Hb/fV8vynL/WHoPFJUB7JwW6gI+j7HC1dneNvZqHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvpduXRTZE6Ty/u/A4anFveCv2U+7yzCuoV3WLTJcsCyx1pmbptj4okTCgHzgKVGyC25K+hPAtZLAncde2N8HhmmuJGoEgSPV8JWiblUhWi2Mgm3tXd7+bGS0hrMGTF8PURB2rR4oqb3YhDbYrfZZCliSMQm4grz9xZbrULGXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=oDFVypqv; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3363F9C84F4;
	Wed, 21 May 2025 12:16:46 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1XEZUwglflx3; Wed, 21 May 2025 12:16:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7D7AD9C349D;
	Wed, 21 May 2025 12:16:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7D7AD9C349D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747844205; bh=CNJLqa+6SVTv26hUSJn7PR+xYiguC9onV8d3jIXIGeQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=oDFVypqvHIQ0SK+3G0UEBnx+4IfmmoXmcyHgScMJPoIk9/DInIK4fsjxFAhKwh+2y
	 3mVLMdU+H7JWzpgmqpi34iu7Sfh55cf5NJjTeeBxTykMj9UNNJqvYUDP1AGoMXrXp4
	 btWAE56KhHfpc98Le1+KhYSPL/IoyG4WB564nRIFdHLOTwUyteL+mOIF29OHOAcaal
	 weT6sRIFQwr2CssbtPFtYf+7LqiNeqixGBh7H2DMOtDN8mEodJtDNRvcyT1EuD9Jmf
	 KfIQbFLBs9InI+3Al6ImGE2bK0mQCYyYAG4SFjZMkZtW5+2cYdnccBZNGwAoa1NL68
	 imPui4ptq954A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x0Yn-fXdqO84; Wed, 21 May 2025 12:16:45 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2D8AC9C1464;
	Wed, 21 May 2025 12:16:45 -0400 (EDT)
Date: Wed, 21 May 2025 12:16:43 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/9] dt-bindings: mfd: add pf1550
Message-ID: <aC38a4hbxPqsUpXS@fedora>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <8be1626f970c9fab8b50ae9ad45e0ddd88fa36bf.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <31542315-5ea1-4849-b2f9-686cabce914a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31542315-5ea1-4849-b2f9-686cabce914a@kernel.org>

On Sat, May 17, 2025 at 01:16:38PM +0200, Krzysztof Kozlowski wrote:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  regulators:
> > +    $ref: /schemas/regulator/pf1550.yaml
> > +
> > +  charger:
> > +    $ref: /schemas/power/supply/pf1550_charger.yaml
> > +
> > +  onkey:
> > +    $ref: /schemas/input/pf1550_onkey.yaml
> 
> This makes merging via separate trees not possible...
> 
> Just fold everything here, drop compatibles and then put binding in the
> regulator. Unless children are re-usable which would justify
> compatibles, but then please provide arguments for that.

Yes, compatibles are not needed for the children. For adding binding to the
regulator, did you mean for all children: charger and onkey included? So,
replacing the separate yaml for all children with bindings in the mfd yaml?

Thanks,
Sam


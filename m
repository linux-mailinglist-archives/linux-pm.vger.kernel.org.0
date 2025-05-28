Return-Path: <linux-pm+bounces-27753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F9AC6FF1
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D801BA2A67
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738228DB75;
	Wed, 28 May 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="jGL4wvld"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4B1B6D06;
	Wed, 28 May 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454516; cv=none; b=i5pkhgVCPWkPYSv3/GwMkRRY27JIgKXwOUCeMy96INxJJ+S2j0xV2PBmEawTEGiYQPgA6GwtXHdDEuIYcv+8nFh8Nr22Nxc5A8umbDSKKp3CRAL9GZB4lSa49gjbAX05i9i8ephd5WtZwpKv94z0zDvVSvOVwk9f08rU6eK565s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454516; c=relaxed/simple;
	bh=oCM+4Vgs42XHFi0Q/Yw0LwFfT7ORF04eoTofghmj170=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1kkTmnKS79EAi6T9TE7pbQ8ypFhAFf4aLfwA87FhGzjUJDQod3qMM3u6L7GleqMVAnHSDftgaD7BKPFIaYOaNmZ4lz4pfGJpZUnLme1rJWe2/agY99sQ+89xTEG4NWe1z+vHRuYRFL2pVzGr2tjDNZ5CgZDcMxCsn0FYgeOSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=jGL4wvld; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 868F59C9227;
	Wed, 28 May 2025 13:48:24 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id G0zVtnKNW432; Wed, 28 May 2025 13:48:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D64AF9C8FCB;
	Wed, 28 May 2025 13:48:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D64AF9C8FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1748454503; bh=KpmI7Pi+aSOUO0HqHzu9340E24hqvfaUnrw9F71PejE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jGL4wvlddFcvnAxrAVR54BGXFMF3BPRMVKyJiTSLy3hH6C689YQAULoVp/HKyo5RK
	 aPXN+XRJNqnhi2NmweXkDyBahmZvzPy8WvCEY9eHTDLdO9WBHHGKBiypZwM7ji1NYP
	 Hd+xrVUZz3lBquYRGD8XnHh1rwrHcFmF/XHhe1e5w4L0szhxIdc3p+CZBjeyA0Vlv7
	 QhATr3OuqsrIDNTcW/tsjsHj3kS1/Y6GG+ZtK8jwFwAOJ5UUkGAnWSMGxdwp7VRASt
	 1yMoK7UdHFWvqMxNEmI5dgIJa/lmCAHsUcsHVqFCfSFuYoESt2qAsAb6wll6kKnGCP
	 oib7Ig2t3bI5w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id s24kzK8CnL84; Wed, 28 May 2025 13:48:23 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 7E30B9C84CB;
	Wed, 28 May 2025 13:48:23 -0400 (EDT)
Date: Wed, 28 May 2025 13:48:22 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, eballetbo@gmail.com, abelvesa@linux.com,
	b38343@freescale.com, yibin.gong@nxp.com,
	Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: add pf1550
Message-ID: <aDdMZoIOqlYcvbGg@fedora>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
 <20250527-pf1550-v3-1-45f69453cd51@savoirfairelinux.com>
 <250c9bf7-c958-4383-9b3f-45b4174585c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250c9bf7-c958-4383-9b3f-45b4174585c5@kernel.org>

On Wed, May 28, 2025 at 08:08:17AM +0200, Krzysztof Kozlowski wrote:
> > +    description:
> > +      Temperature threshold for thermal regulation of charger in celsius.
> 
> But this now makes me wonder whether this should be just part of thermal
> zone and get the threshold from there. I assume this is temperature of
> CHARGER, not the battery. If battery, you have such properties in
> battery.yaml (monitored-batter).
Yes, it is the charger junction temperature.
> 
> @Sebastian,
> Are there existing bindings or devices which regulate temperature based
> on thermal-zones in DT?
> > +examples:
> > +  - |
> > +    battery: battery-cell {
> > +        compatible = "simple-battery";
> > +        constant-charge-voltage-max-microvolt = <4400000>;
> > +        operating-range-celsius = <0 75>;
> 
> So this looks like duplicating thermal-regulation property.
Yes, thermal-regulation should suffice.

Thanks,
Sam


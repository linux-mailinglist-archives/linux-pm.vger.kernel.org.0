Return-Path: <linux-pm+bounces-11352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0DB93A7AA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3D8284748
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0D13EFFB;
	Tue, 23 Jul 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmvUYNz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01813C3F5;
	Tue, 23 Jul 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762681; cv=none; b=dBLe6oSihYn6ICVYFVKY0oD9RQImTIjH72OmvEEXwDifouuqSOFSp1P0sSZ2Sq8b1bn3Tbv4zMjiEDgukpJ3/f820rADecf5EvdkxNZ5fnku/qOWperMCcS35/ihRhCCpirKaFEc4PWsRWgyiHy/TcGvsid0sFY6xtCnDZFJD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762681; c=relaxed/simple;
	bh=2DRmsMG6kRZYBP6pQwNntBFkhKv/vMvD1XVjf+i6onU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXyk81RkpckarqDkStqXpe6shL43dWQGNuwGZZ2LKW80UpmPLoQmwl8gj+m2UViw6VPnEWgIlMDWHQT+m3CpIqIKs+H08e6h1BHE/uAl0KGVEYCciA0msvTUv/fSFsbKqAw5c9Nz+hjcgRQ6weG/MXNTPgKW0ZH3yYQgT7JkbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmvUYNz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0E9C4AF0E;
	Tue, 23 Jul 2024 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721762680;
	bh=2DRmsMG6kRZYBP6pQwNntBFkhKv/vMvD1XVjf+i6onU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmvUYNz3ONMuK2pG4a893R+elit1FD5m6kh1P896luOy5uwOzX8kZDrGQVNTyTnnR
	 y7BpXGhUNhVO3ImibjUZ5DjhYqCIiysJx7NyXrRg81gThR+FA2gBV4nH/pF8reKv8R
	 QpblgoYkzh14gnlr9uVsQSycwqV9qR1vObIsOYXmq0Am9Be7u2valoMpvILoY61i11
	 14q6uz9e+OCzNzf8iCyxuZhQPFm1siJ/XEnkV2+PQYaA7lZjgU7RnSOZyNhX4YnZzb
	 yfU2TwaeBdyr9INR4b/3GgBl2kpLFdSMn2/fAf9eswgvQOuCvXlYSPiLqMu1djtWZa
	 zuw2r5+F3YLhQ==
Date: Tue, 23 Jul 2024 13:24:39 -0600
From: Rob Herring <robh@kernel.org>
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Message-ID: <20240723192439.GA986360-robh@kernel.org>
References: <CGME20240723141723eucas1p18f5675128aa380857f4c854b5a851e34@eucas1p1.samsung.com>
 <20240723141715.374786-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723141715.374786-1-m.majewski2@samsung.com>

On Tue, Jul 23, 2024 at 04:17:14PM +0200, Mateusz Majewski wrote:
> Hi :)
> 
> > > +      temperature thresholds. The trip points will be set dynamically in
> > > +      runtime, which means there is no limit on the number of trip points.
> > 
> > How can the hardware change how many trip points it supports?
> 
> Would just removing the whole "The trip points..." sentence be ok? I see
> how it is more confusing than helpful.

If the old text had nothing to do with the h/w, then I suppose so. I 
would have assumed the h/w supports some number of thresholds causing 
some action whether an interrupt or some sort of shutdown.

Rob


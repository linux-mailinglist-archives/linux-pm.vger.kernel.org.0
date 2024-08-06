Return-Path: <linux-pm+bounces-11946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253C3949354
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C599E1F2196B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5520011D;
	Tue,  6 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3qkA1Xb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828321C37A9;
	Tue,  6 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955147; cv=none; b=EGXkAKyQeId82VEMnpzc6GB7U+xtMzACvqkFgVg0adfT0OQiBYbs6sCCn8s5kUCD7UYG4RrWPCiZrG53gPNMvHcEzQtZ6QhFuQ+j7a2dnImQ1H3iZZLjD2pB8+T2896CbRkU7cnE7ZsdAjScfJ+CrHOh5SuaRXt0sluICI6Ee1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955147; c=relaxed/simple;
	bh=LlJd0JqfCFMd1ko3jYxgFwtygfqrxveC1OJ2+6g06nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CahjqVJfnyrLjukLWPobK/lKgm8s2EZrV0mN0ud2C9ZN36j4EFZqin7KmXyeWdQyw/LmFpdZkISNHZI9IiC1+EXMalyTwhLm9CiXi3Rzxv4RO+8GGgpGpVRzFCZ+axvVkSJhZHNm0dYevf/nL73AxyvuqRscuAAkzzJxv0z1SNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3qkA1Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA88DC4AF09;
	Tue,  6 Aug 2024 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955147;
	bh=LlJd0JqfCFMd1ko3jYxgFwtygfqrxveC1OJ2+6g06nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3qkA1XbArqai7eQhaDGl6mj2urFZL6dyjGarkuGqyfZ5pCxxr1RHoYYkp3OLZ8kv
	 vemAaT5KGTATs+McDjNeb3LJDyHfax5boLJmitgptdsFytXjZcxf4mn0IMEekmDyYU
	 GEmRKo7qRgqA/QbcDVEwwnEF6xnmj6hx4zlNNDCg9BCPstIX9Hn+KwhkrTeZHv97YP
	 nZy6YQsiW1FffZR6WhWc663CUxJr0UDA0Q3bMt4KOgCsfqwEdnEIyX/8Ma7cP0/Cxc
	 OB9NA5NI93UZ6y1ExyOZCbRpgOZ4iFyqWPzrZ56GRB7zO1D+j7vv4nySkRB6u4+CpJ
	 /UHyhC1pUUF9w==
Date: Tue, 6 Aug 2024 08:39:05 -0600
From: Rob Herring <robh@kernel.org>
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Message-ID: <20240806143905.GA1484799-robh@kernel.org>
References: <CGME20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43@eucas1p1.samsung.com>
 <20240731211444.59315-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731211444.59315-1-m.majewski2@samsung.com>

On Wed, Jul 31, 2024 at 11:14:42PM +0200, Mateusz Majewski wrote:
> > Do I understand it correctly that the patch actually removes an
> > outdated description of *driver* implementation, and not outdated
> > hardware description?
> 
> Correct.
> 
> > If so, then maybe it makes sense to rework the
> > patch title and commit message in a way Rob suggests. I.e. rather than
> > stating that the patch removes an outdated information, instead
> > mention it removes *software* (driver) description which was
> > incorrectly added earlier. Because bindings are only meant for
> > hardware description and should be completely independent of driver's
> > side of things. Also in that case it probably doesn't make much sense
> > referencing that commit for using set_trips ops. Just my two cents.
> 
> Makes sense, what do you think about this?
> 
> dt-bindings: thermal: samsung,exynos: remove driver-specific information
> 
> The number of supported trip points was only limited by the driver
> implementation at the time, which mapped each trip point defined in the
> devicetree source file to a hardware trip point. An implementation that
> does not have this limitation is possible; indeed, that is how the
> driver works currently. Therefore, this information should be removed
> from the bindings description, which are meant to be independent from
> the details of the driver implementation.

LGTM


Return-Path: <linux-pm+bounces-4538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036D86C34A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 09:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E331F22978
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B754CE00;
	Thu, 29 Feb 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="O/MHFcwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77E38DF1;
	Thu, 29 Feb 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194790; cv=none; b=XNNmsFnX7AqM2E8O9zxpB17g8cW2RnPoi133YbZOrX4a5x+o1fQGclnrUzoaIJwDQ5AzOUt8lKQ5Bt/2phRkfN/EZ137x0rTy48eULt2RYIN4v+7uTWvJbvy0IXd7IM0lE7jP4tyfpr9oeABkm2/dPIREWdPkury213UtJqO8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194790; c=relaxed/simple;
	bh=0hPI0wfFATDA5MypDojsVq08HLk7GaUSHfZl+oIg/14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/XzOVJdnz8yaHu6ANrslQ7/cVfTHBgChN+p2L37C6IVnp7C0IjTKKi3ut7su2+miAirAUOnLJIfj5fGYhvSdKvWYZ2wsmva/SDZYkkOuLySvtnpaW4yxNrkIHypZGkquSC/66rp7ehcKTOBPnI5946aQhkWFuLMynUxw53LQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=O/MHFcwE; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id B2700603C4;
	Thu, 29 Feb 2024 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709194788;
	bh=0hPI0wfFATDA5MypDojsVq08HLk7GaUSHfZl+oIg/14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/MHFcwEl8IRWQbHddMQLvQFvN1Yl6PFYSrAP2a4jAfr4YK9hI5y8SEX4wmeAY8Kz
	 450Q7XT6qZ3JLTs+FpkwlcGs++w1593zmDOzjp63d9kOWy9dVT4WF34vsHLmpQBdOb
	 WM4bLZr+cBGOeUeW6VBwFiN411Gp+dUS8kETQzoX0/+QQeryEirGxSH7fH9FU5YBEw
	 tG+EgN9L7jEyN1ncgRcq5GXBlDhaNUjgQq73Akq8/aF6YyhtSUUWpXJ8D/6gldOzwJ
	 vVu1P9VvXHtgJ2oT5+eqZGwJJInZoLxqkGtJrlrsap3fd8nGXxKst5+0aKTICL3JqR
	 Wt1pJZnSZRoKg==
Date: Thu, 29 Feb 2024 10:19:23 +0200
From: Tony Lindgren <tony@atomide.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: devicetree@vger.kernel.org,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	pali@kernel.org, sre@kernel.org, spinal.by@gmail.com,
	maemo-leste@lists.dyne.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: set charge current limit to 950mA
Message-ID: <20240229081923.GI52537@atomide.com>
References: <20240228083846.2401108-2-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228083846.2401108-2-absicsz@gmail.com>

* Sicelo A. Mhlongo <absicsz@gmail.com> [240228 10:40]:
> From: Arthur Demchenkov <spinal.by@gmail.com>
> 
> The vendor kernel used 950mA as the default. The same value works fine on
> the mainline Linux kernel, and has been tested extensively under Maemo
> Leste [1] and postmarketOS, who have been using it for a number of years.

Makes sense to me. At -rc6 I'll likely wait until v6.9-rc1 before applying
new patches. If this is needed as a fix before that, then please let me
know.

Regards,

Tony


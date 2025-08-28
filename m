Return-Path: <linux-pm+bounces-33228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58DB39746
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535C67B7D52
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3B2E22B1;
	Thu, 28 Aug 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DNgrO/pM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691532E1EE2
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370491; cv=none; b=MaflqIa1VDsyhL6IlMHoloiRcg9IMPy7Bbexs7X5D5i4P07+qwX2YU6SYqlB2cxFKOENTWxcyusAwD+Y35CtKOC6aOYHLSqGd+gVke1/Pqmb0oZ81/kliy9gNlK4i23FkSPQbQCHxHEjAPuWNzd57Vs6XOvTyJHVMfOmY5E1g0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370491; c=relaxed/simple;
	bh=uScJa8rlegqLIqrsv853yK/Iaq9Dti8xY/5E1SxKeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DueeIeD1V22vXJGiJzbBSa9W+j2lTFVX8gqF1hCIovf3moTfMicXiqC0wfY14YXvC03ZLwELwPlP3F5ajJVFcnR6ZE8VC71xd21Qneb5hbo7RUUfpE1mQFDGrvoVeuzlBKet5qEEn7up1ZgKZrIb/1TTeaM4rFeK7i7EoiQdwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DNgrO/pM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=k1; bh=5CMmV0KmKElMRDG9hxC3TUSIMhPG5BSmmsupIpN8Y
	Tw=; b=DNgrO/pMnhJEEjmzaX8baCZ5m7hOvV0tBYL2JXqRYUxXre96uWr9St/gb
	Bff6r1oQqg9kFk7qYcpIBDvWHh5T7D7u8jM1jOEWdgYNaBtkUKGhrRtTPu7s+fT2
	PzTWkIKFMxJIxig0bI4kY0Nj9pwY3Ppqj9+KwKiclRV467yHuiZ4E2EqdEEXMlur
	w6rnV1JQ75MwXqyopk7AtCo41ueSG2xChezbKMJuBS3WaNxBbeO7NwUzb0kPgaTg
	tSGI+tx9pV6s/7OjdYB9NL+zFZWBeUzdOB4qlEp59aG0ndV5DRUatRntartVND1Y
	UFbsrhNve73yPkCelkaKOpOLOMxnw==
Received: (qmail 930434 invoked from network); 28 Aug 2025 10:41:18 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Aug 2025 10:41:18 +0200
X-UD-Smtp-Session: l3s3148p1@2eVw3mg92r8gAwDPXw2iAG43AYdOknD3
Date: Thu, 28 Aug 2025 10:41:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 0/4] thermal: renesas: Add support for RZ/G3S
Message-ID: <aLAWLZBenSWWqqkK@shikoro>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>

On Sun, Aug 10, 2025 at 03:21:21PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series adds thermal support for the Renesas RZ/G3S SoC.
> 
> Series is organized as follows:
> - patches 1-2/4:	add thermal support for RZ/G3S
> - patches 3-4/5:	add device tree support
> 
> Merge strategy, if any:
> - patches 1-2/4 can go through the thermal tree
> - patches 3-4/4 can go through the Renesas tree

Series applies fine; I can read the temp (36°) which increases
reasonably over time (40°).

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>



Return-Path: <linux-pm+bounces-32953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35599B3305F
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 16:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7AE447062
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730A2DA762;
	Sun, 24 Aug 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fe3mPgo1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575F13E898;
	Sun, 24 Aug 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045451; cv=none; b=p1NuQXGc0DI9C4OEe82CezaBwSZYYO0pnGQPqW+oasg/qAp4liglXy/kG/blQbqLmmhVG+FaMOfkHDCaMnsssvEuNXkImHpKeU92hNc/ZeyISoJIGIeE49qGAFYDMM9miFg0y8gt+cJkBNpMMCdwXF3CLRZddSXLzdGSYtxF+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045451; c=relaxed/simple;
	bh=c3AcTuha+KxfjbXnXT8SmXB8RGUI1YZFmW2b/4MBe7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RaHNyDIeYpQCs4apK3XbW02eKVPv4Y0MEJdPK52c4xyuT0JM8PGTtdaIciTGOPDLGqrmz3h6xpKzIbpTkxRsVh9HE0Yr9R8ltVDRRZRMrvmujOrmLspCE/p5RdGPjHtfh8gTzk5TjEQWKomb+F6Mms+D7FeiG1F3YLQX/Ut9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fe3mPgo1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E3EEAC6B391;
	Sun, 24 Aug 2025 14:23:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ACBE4605F1;
	Sun, 24 Aug 2025 14:24:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDC541C22D86D;
	Sun, 24 Aug 2025 16:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756045444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c3AcTuha+KxfjbXnXT8SmXB8RGUI1YZFmW2b/4MBe7U=;
	b=fe3mPgo1USufpbneU4gpLjsybFhxYZYhtYgY4Tb27R9GxOpor1ouvDDpy7Q0kY4PvUcBtU
	eW0BehihJDd08PezHVRmOV5ob32ZL6X9xPJvivorXYKsxaXhwMq2KNoZoMltmCxVTwJrOy
	cqxegAa/87WjJlWnO00Nst1RCeTtHsAd3n6vLkusLtrXaZumlgUAbi5sleilKhD0QTcjRf
	oWPKerTyGhhdI8Svnf0UauimenJsdGVxbzsASkUYk4VLJAzmkanEiVa9SJWa55Kfmi+h5p
	XtE4KQtGAEXZe7LjYa9e0lt5ADZOIOiFKPBoAgZY8IctIebEsGauCPpWB5sRAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  linux-pm@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: Convert
 marvell,armada370-thermal to DT schema
In-Reply-To: <20250822225645.766397-1-robh@kernel.org> (Rob Herring's message
	of "Fri, 22 Aug 2025 17:56:44 -0500")
References: <20250822225645.766397-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 16:23:50 +0200
Message-ID: <87frdgn6h5.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 22/08/2025 at 17:56:44 -05, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convert the Marvell Armada 3xx/XP thermal binding to schema.
>
> Drop the AP80x and CP110 as they have long been deprecated and have
> been replaced by a new binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l


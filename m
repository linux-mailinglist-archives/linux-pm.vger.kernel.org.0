Return-Path: <linux-pm+bounces-26624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E4AA81C8
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C051189E657
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCDE267B72;
	Sat,  3 May 2025 17:18:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36251C6FF6;
	Sat,  3 May 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292683; cv=none; b=rUKeJydostkQ/gsSJVia4G4B3GOHHv0s1Cf1UW6bPihkdc+Om5KXVfIELDDAugguTm27KwgjhX3Auv53wx9cXLA1hExloo1JGGGL4q5NrGzGfm7cEicEBRHbq2XQgPQmLuiPPRP2xXCMBVUx3Giu9p53N7SDqynkCGECazA/NmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292683; c=relaxed/simple;
	bh=avWD2KryLXdtiRNeAjGiZlyFCs3n+N4jgng9VYOn9uo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cxere/V5dw8r70VotzkrWFXIKsSQRTh3Feinc7VAQxt+KAfi8KEmCY7MWb+1cBR6NNPPGo5fKkqUZLFlBnw7JGRcjgQMLGIGjQ8IqQgoDYlCsTkWkusld5xfknjhVkO031NdFdJn1W30bF/e6St0Kaf74rFIrSnzXm86sJLLf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DDDC4CEE3;
	Sat,  3 May 2025 17:18:03 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2DA981805AD; Sat, 03 May 2025 19:18:01 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Dmitry Baryshkov <lumag@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Andreas Kemnade <andreas@kemnade.info>, Pengyu Luo <mitltlatltl@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250503140431.438727-1-arnd@kernel.org>
References: <20250503140431.438727-1-arnd@kernel.org>
Subject: Re: [PATCH] power: supply: add EXTCON dependency
Message-Id: <174629268116.176094.17056721709509327089.b4-ty@collabora.com>
Date: Sat, 03 May 2025 19:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 03 May 2025 16:04:26 +0200, Arnd Bergmann wrote:
> max8971 is written to work with or without extcon, but it fails
> to link when built-in when the extcon subsystem is in a loadable
> module:
> 
> x86_64-linux-ld: drivers/power/supply/max8971_charger.o: in function `max8971_probe':
> max8971_charger.c:(.text+0x2ab): undefined reference to `extcon_find_edev_by_node'
> 
> [...]

Applied, thanks!

[1/1] power: supply: add EXTCON dependency
      commit: 1ea48c51f03fc3186ee0bcc05d06b652c209e0ae

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>



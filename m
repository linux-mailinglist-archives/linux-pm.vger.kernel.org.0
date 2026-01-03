Return-Path: <linux-pm+bounces-40162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA2CF065F
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F5D30164C9
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B272BE059;
	Sat,  3 Jan 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVu9xCt9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76B251795;
	Sat,  3 Jan 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767475851; cv=none; b=j7w4f/TbY4iK7sIkpFZ6ay/Jub+PI9ITsG2idXdVs5E25U+Rn773jbTmVFSCqvUKhDYwAmGED05Zwb0GMycBvJfx/vbX2AAhWivrkgwqDSIABxvLCWrlVaoY112+vqEYveVI0NKn4U44r5n9CltImJB5X09asEfVxdHW4bfy9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767475851; c=relaxed/simple;
	bh=ROaJG8gVDhBZkblJy4CJj7FKi1NrCB9pkyFw3BBHj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/AWIBkdUXF3F6A1a9B2w1VLTaC7Od52UHPJ8X3+CZqihbWJIV6xE1X7/MmMeDzKH6+dXSB75fJwaos8WDFirpUTu8J4sFgtQ86MZZczA2AXzRGNRVz6V6UgbRjFcWxkyiE+jB8w3INO7DqmJrAXICJt6SoFH5+xC1xOyWKohyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVu9xCt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2420EC19422;
	Sat,  3 Jan 2026 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767475851;
	bh=ROaJG8gVDhBZkblJy4CJj7FKi1NrCB9pkyFw3BBHj/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVu9xCt9s5GIIFO33DLAzllBdkE4g1Ypt7YOsR2SWduyssolc2SV+WYTIpnGMuPFh
	 QHzOGtoJ5RPXePvh4QKUUZ/D48Cuxqnkok7jczv+6nKzE/GKzbD7AsqtQnlIX4hmgG
	 JVmgschg4AzOOoF9nU+vcJ8bbIThK91joqP01aY0bGMLuyLl8oD6F17Q4wng28iGJX
	 uQx9yOnM0k+YEAPObH2+FDivp74qpxpuvj0Z9wnpKnAc7b9+2528j7a5YWjolCsAHJ
	 XSv9WaDrOTDGA+eMusJW5eT3mYt0s8xi8EHjFPhIrFRjbIE0XCRVHo2Xmf9T3kC1Zj
	 rQqD0u8PuoKgQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/3] net: Discard pm_runtime_put() return value
Date: Sat, 03 Jan 2026 22:23:52 +0100
Message-ID: <5973090.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This mostly is a resend of patches [10-12/23] from:

https://lore.kernel.org/linux-pm/6245770.lOV4Wx5bFT@rafael.j.wysocki/

as requested by Jakub, except for the last patch that has been fixed
while at it and so the version has been bumped up.

The patches are independent of each other and they are all requisite
for converting pm_runtime_put() into a void function.

Thanks!





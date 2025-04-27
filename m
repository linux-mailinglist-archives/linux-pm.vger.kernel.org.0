Return-Path: <linux-pm+bounces-26307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEAAA9E51F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 01:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EA9178264
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53620CCF3;
	Sun, 27 Apr 2025 23:27:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AD1E7C38;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745796448; cv=none; b=TxB4QGuOId4mDQrqGc0BjOItpqTPoFwOgKQhqptnjX0aa49qiiDC69pefaAddMVyoSZwei28jQfnCc/J65iku18itLpeUCjHXUcc9CzPWJka9h/dtX0MHH9LHXyctJRbeHCXePdS0fA3wEhjaIxU1K+hopdwU/nNFSibmz6yDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745796448; c=relaxed/simple;
	bh=OdDaRC6CcwfVjGwgLyYP5EYBYBgoc7OFQF+K6ZUqAjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sEanPXL+B/JQtxYw3LZMC1UzlUox1DkdUxZYPnxUlAz6PVvTaGNCZo2xWhm7JXqskVYu4eEAFQicM2I7qS6AYD7XDnAKTBHrQF9IlPTUEjeI02kqo9iS1E+tacINYUnoDXSvhk6jd8P6pLEXCVAsOLCg6FkVT1jcQocfZMCKzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDD9C4CEE3;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 81A111808BE; Mon, 28 Apr 2025 01:27:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, lee@kernel.org, sre@kernel.org, 
 p.zabel@pengutronix.de, Ryan.Wanner@microchip.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-rtc@vger.kernel.org
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH v5 00/11] Enable Power Modes Support for
 SAMA7D65 SoC
Message-Id: <174579644550.306236.7065063387311339385.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 01:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 14:41:17 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for low power modes for the SAMA7D65 SoC and
> the required components and changes for low power modes.
> 
> The series includes changes in the asm code to account for the addtional
> clocks that are in this SoC.
> 
> [...]

Applied, thanks!

[03/11] dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-rstc
        commit: 4e55fb7d60e128fb5a57921cbd59f9ff29cd4297

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>



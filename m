Return-Path: <linux-pm+bounces-23664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F0A576F7
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1531174074
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4E7BE4F;
	Sat,  8 Mar 2025 00:38:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F73610D;
	Sat,  8 Mar 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394299; cv=none; b=AJCPggN69BAFtAvrUxjq2jz8TXRH66FnrqciEtivTS/P9b9CZTH4QPkbz+bdO6zG5m/0AOHsJETllaPLl2ntUqAoXvMnC1sXOwwvnO1WkeWXCx4Vs5dSRde6kSsssVByTcUKORmsmIvGR5upiEW3b5vAgQUyeTLQH+LY2zT9TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394299; c=relaxed/simple;
	bh=vfx7HO2g27rlhV7940SyGS/6OHtEGzFKl8i02EZ/QjU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FwU12hCt66TCg8OFQ4GHPlFxuWFcD+SO0NPazEMG5N9VEnfLpyf1DSK9oL/xqyE6EfxkjUJsBuMCUtJz+M84DQ8q1bbr1Ysw529Zz3VfeCcPTyd97NW6rJLgJ3sDY+eh3kbo6j6LagZIk03jA8wM2BdgofyRmmY+nh684aIZ6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A010C4CEE3;
	Sat,  8 Mar 2025 00:38:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 83CB6180B9A; Sat, 08 Mar 2025 01:38:16 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 p.zabel@pengutronix.de, Ryan.Wanner@microchip.com
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH v3 00/21] Enable Power Modes Support for
 SAMA7D65 SoC
Message-Id: <174139429652.169744.15334502728005076193.b4-ty@collabora.com>
Date: Sat, 08 Mar 2025 01:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 27 Feb 2025 08:51:47 -0700, Ryan.Wanner@microchip.com wrote:
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

[13/21] power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
        commit: 2fc78cd0a3c3013543e5f540eff61e9696138f83

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>



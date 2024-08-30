Return-Path: <linux-pm+bounces-13207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3596599A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F148B22DEB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21711167DA4;
	Fri, 30 Aug 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx8CkU61"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AD16D302;
	Fri, 30 Aug 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005457; cv=none; b=cpTHIgbT7ABziX1R8959i1A8JPH03ISwO+gM2QS3+mn6mLuGh52EQg0pKYmHLT0XMVtxJNoBJsB5vr06qJ1SoBdCIFGGb3+9EIHW0TWNWTPIbFS4N0FOD+9TVWYshwxblmL0gKn7IlbdyTrDIEpl803s7Q8I4thGMBeYWbZZ/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005457; c=relaxed/simple;
	bh=3ydTwNGyIXL6fFISp1v27alYYBcjKlkwV1nvJ+LgMmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nnxfIPSAYX/lDpUqB+D35hQhIHDJ4gU4/jiexAz4Bv4qv5Ie05PJsbt3Y4gX4epBYfJqBmbdoTl0wNW6mla9/2k4Qfx392hsL2SSqStXgcy/iLyplDDyeVCYhTppwsLtLkxc6jZw/yu60V1awUcHetsgR+IGEJpQRmvcPNsYVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx8CkU61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E7EC4CEC2;
	Fri, 30 Aug 2024 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725005456;
	bh=3ydTwNGyIXL6fFISp1v27alYYBcjKlkwV1nvJ+LgMmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nx8CkU61PYK7Ada7KKWaqejI8FCF8TStl2f+Lw5+1n4UDd90SM5ZBa3jvhEHSaR75
	 KdGvTylNPwJRnzbGXeaBtrK6ruDB289UA0oHbFmAP0TNeWHoZp3uSW3b/LSkvNEBYp
	 VJ4q/jMCAnOZ1UMBUlpS00GJ0iJVQWH0wunSHU8zK/mIE2QJ3XwN0tHd7KrVphxUxO
	 kvTAjnQTR1j8louOu9sUpRx/2B0jVU//KySTJ8fl/qd4UdmBTpitZM+bL9oWT1gw7a
	 85fp//ihugYz2QqYkXOKyFNwEHYg0ghd19VjmGf3BEkjBwUkIIBA8Ymp3RfgoqV0OB
	 oKHX9w1cnrk/g==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
 biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org, 
 Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: (subset) [PATCH 00/16] Add initial USB support for the Renesas
 RZ/G3S SoC
Message-Id: <172500545045.434293.2799164142138573835.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 13:40:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 22 Aug 2024 18:27:45 +0300, Claudiu wrote:
> Series adds initial USB support for the Renesas RZ/G3S SoC.
> 
> Series is split as follows:
> 
> - patch 01/16		- add clock reset and power domain support for USB
> - patch 02-04/16	- add reset control support for a USB signal
> 			  that need to be controlled before/after
> 			  the power to USB area is turned on/off.
> 
> [...]

Applied, thanks!

[10/16] phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
        commit: 4eae16375357a2a7e8501be5469532f7636064b3
[11/16] dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings
        commit: f3c8498551146dfb014be0d85d3a7df98be16aa2
[12/16] phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC
        commit: 3c2ea12a625dbf5a864f4920235fa1c739d06e7d

Best regards,
-- 
~Vinod




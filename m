Return-Path: <linux-pm+bounces-25487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7FCA8A54F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB25442E80
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB5215793;
	Tue, 15 Apr 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS5MinAf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEB1BC2A;
	Tue, 15 Apr 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737806; cv=none; b=lPQdWptz4Z+yEsREq8+9ntOotFRG+kSVXQZ/Gv30yIJTVIsrBX23wOcftEn/dvjKMyJS8G+tW072f67y8ftPaVxpEHvsnytp2SZ9zamxPtJij+FAg9NQWpE7U/PUiZn39bh60VRo+S8dhPHyV3ZHBrFmpY/IC3g3qpyVNRvKXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737806; c=relaxed/simple;
	bh=yaZo5HTwWyPwFa+BmejUuYfJejNARyfDGIEj1j58WyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RFsSiZqeRV82fRjhlT4cn9IFsxukKgigWXUTg22y2T3L5lA1XdzA9169H4swi2Ep2oXPrHBDEOvVLNqvtd3ouDJa3dQKkH96P7X7Jg/ntxZdD1eKQeBQPha0qPYxawUpBc5ScPdCWdBTm00uXU8hd12f7TpDvFTd6Y2IsJA71hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS5MinAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B6C4CEE9;
	Tue, 15 Apr 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737805;
	bh=yaZo5HTwWyPwFa+BmejUuYfJejNARyfDGIEj1j58WyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IS5MinAf55aSLnW94s8yMqwZ1wZjb521aXAF1ekUfDYry3IX5VX8gSXuSAiiJzWLZ
	 +lxUetawsjegnCh1PFnhfCbmZxZcW86EdjKAUzBWN/jxJdh8dQk0IkXxWbRSmY3Xr8
	 PbAubgmf+qZnoHBKABjkci4vN+Cgyv6MUeDaCZMvnbzIzYfLUpnLQtj+08//3JuaiE
	 8zRaBsaLsKM0RFen2PV3YTKtRwMBRo+rAMQ3YzTHXmVUFDM/kp+t85cPWCd8DgusQm
	 v267OefCwJny+m1JiLmF8nOfbM+aobn1DqdZ30F2jg2pz2AQQlLBNViH3xdnEnUAtG
	 kNVuNeoJfAMkQ==
From: Lee Jones <lee@kernel.org>
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
Message-Id: <174473780295.3016428.18003689351078217968.b4-ty@kernel.org>
Date: Tue, 15 Apr 2025 18:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

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

[06/11] dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
        commit: cf616eb55ba84118d0f8274a3e78dd526ef235a4
[07/11] dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
        commit: da4151479628b170074dadcdcdbb1c042643bd3b
[08/11] dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
        commit: d0eceba4d13341a1d2d52a1ffc31b6987174dfd0

--
Lee Jones [李琼斯]



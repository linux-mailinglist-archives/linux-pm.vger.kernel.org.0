Return-Path: <linux-pm+bounces-24371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5443A6B9ED
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 12:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B35219C1EA4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030362206B1;
	Fri, 21 Mar 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN/Rh+b0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5706155753;
	Fri, 21 Mar 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556738; cv=none; b=eybntG69c4t8dB7ArajTQcxgTEclY9IDBZzk6FI8JgTlI907xu3H01T7dnuwZTXvisvvyTzhaLLHH643gaE+2baSPmmrrfUdcypHstyzCtwyUbHJRseH+EovCLYGQrxI+8oVST8zldeNEXNJUaWwlsPm+yXsFabvvLyKHDhup6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556738; c=relaxed/simple;
	bh=1Wc2vlIwYcC3jhY0Jz7QVH4Dj57VeZG15hR+/aWfVGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RshA51VN2Cg/HTocHRy3q+N9Z3CqxX4qsGPMER22eFgjoMusVHNZ4/iuRWHtnTJHr2kc8ytY+2bOUGBab9qtTOUhc3MFsEjZo+2wxW/mHQBLIa28vLbG8mkViWa8yGRMiA7SD1oNY6pcgPtcJdyRfybtXqUuVwzA0qW5oW4qQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN/Rh+b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2458EC4CEE7;
	Fri, 21 Mar 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742556738;
	bh=1Wc2vlIwYcC3jhY0Jz7QVH4Dj57VeZG15hR+/aWfVGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SN/Rh+b0AiUEHVonJTT7heYqUtvzSbzZ+WcqLqrV33B85TPzFlYoKXLHjhAHgUX3N
	 wUtYQoLI4scGp7UQNKYrv3S6ZXk5hFIQ9sX/aq+/JCiRitw1G3zIOuZj7IMSsKow3f
	 WfypeOdSLl17QKR/rUY0mFhNuaEsiQGZbhdXzwH+kMSsxUDmrdet3Msv+uq3d9b5kb
	 yBQ9bsgFXPZpvv9j1GE6LYqEgBEZGAtZpyWGAOgYbt1U2XtHx3fVj3NdlFRSUkA3On
	 zQ+NyQPJ3iSAgEKxyUVqfmyib2Y0vS7gTnKRKLGhLeicrZ0tEOGmcP3SJEjAErr9ZQ
	 5n7JQHtYcNKmg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 p.zabel@pengutronix.de, Ryan.Wanner@microchip.com
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5d602b7d4c29333013ef3f75544c2eb7e4b8dab.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <c5d602b7d4c29333013ef3f75544c2eb7e4b8dab.1740671156.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH v3 01/21] dt-bindings: mfd: syscon: add
 microchip,sama7d65-ddr3phy
Message-Id: <174255673486.2091509.9339030316768600844.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:32:14 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 27 Feb 2025 08:51:48 -0700, Ryan.Wanner@microchip.com wrote:
> Add SAMA7D65 DDR3phy compatible to DT bindings documentation
> 
> 

Applied, thanks!

[01/21] dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
        commit: 2b4d2bdc07a152b3869f7888f64f37d4b09ae58e

--
Lee Jones [李琼斯]



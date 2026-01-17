Return-Path: <linux-pm+bounces-41045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042CD38B5F
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 02:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7476B303C9B0
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696F3033C3;
	Sat, 17 Jan 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIF+kQRq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199617BEBF;
	Sat, 17 Jan 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768614953; cv=none; b=eGt8ePg+wRIpq1kaCVS0Blf/q/1iuDhcX86fZkHy2G0Koy2FyHGUZwp6epTbhnvxmVKUhZza4VS7vfoDWMmLcmtxWwUMqVynpwzz1AEep5aBaWdRKr0tBSPh8PAeIsMl1qsnqJ53sIuPVlbDJJ3EOB8Zy98pxouLucWijfET5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768614953; c=relaxed/simple;
	bh=/ndufQu+5ufz1nSWIQD0PSCXNtfxZ4UB7J4iOp1rMug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jClhD279jNj2tzFzRORmoEqP1F2ae2cHo8Fy6001S+gCRDCzuY5C+YFzXpNo7Ggw4T6EQzmNy0SMSGLisCHr23rwR3OHmjrJq5rl+5DNMF8J/tNPHbGCEfVVpqjYJxpiVD7B/l9gmpaaLkCIl9vWM3l4VqBZ5sWvPqqBcaIZIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIF+kQRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5812EC116C6;
	Sat, 17 Jan 2026 01:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768614953;
	bh=/ndufQu+5ufz1nSWIQD0PSCXNtfxZ4UB7J4iOp1rMug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIF+kQRqUNRgSz3CUmtB4HrLAyXh0CrtZdIqpO2CaMoZVT+f975ZW5QOHy90xPQ3S
	 ly1eqMia8GAedMwQX3/9nW7RImllHgacShWL+fmAu1C4xgdYMsZB6zQCKO2wCfKzIN
	 T14lRFEwLsX/6lpsVtNjC0K6m28/jsgoiJzFlIs8r5OLYdczXAv0E+fHYWO2U7aMUf
	 k7Y2wTsj/Ah/HV334CTdejsRACZf8Isg20RGef9an8tilKsLjgGCIbN2gOBWTMS0a/
	 cqg0Ju+OZa+jQSQSRfoSjkt5mwhpc3/AaEi1TgpKgI6omPnmSfUP8v0I+yR6VTXsEn
	 OlcN5M1TqwkyQ==
Date: Sat, 17 Jan 2026 09:55:44 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com
Subject: Re: [PATCH v7 3/3] arm64: dts: imx91: Add thermal-sensor and
 thermal-zone support
Message-ID: <aWrsIIAVgZrcSCtq@dragon>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
 <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>

On Mon, Oct 20, 2025 at 03:00:42PM -0400, Frank Li wrote:
> Add thermal-sensor and thermal-zone support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


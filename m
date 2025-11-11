Return-Path: <linux-pm+bounces-37799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11484C4FD0C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 22:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71AA64E4376
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E092459C9;
	Tue, 11 Nov 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCMQr7hP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWBf5/sd"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD635CBDC;
	Tue, 11 Nov 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895649; cv=none; b=PxTjoOIbiX1DzS8d8c5QVxYRLEyrpjt88Oc2Pj8jYf9+uxoC4bddnHTb4yeeWupC1iKVaHbtXo1iUACxIWFVeH4K9PiuQyyixJlDf9ibLIGE9qrfTXHoDtuDPvWTTBYkKbmdOK86V2rumcAzupgFr5zDT6ODkdYKFsNCi3KZYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895649; c=relaxed/simple;
	bh=FkkC1Vko+WvOxUwHMvXg7IztDR/h0HWvV2LknFPdch4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jA0OthLA/jeGJi8tfXIoDhg3m8/cczy4QZyLvufeu9fnP/N6riUnP1mnlSznQ4+QWXBjA/5uj9iRZBK4y01vul8iUCBjKA3zVoBcz/ls0jdewUSOxl0SlM4RLNvMlBbYIrgYngQ1a3Tyaf7TmBlRpmLzGPvfhI8SlOt+ehxuilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCMQr7hP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWBf5/sd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762895643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkkC1Vko+WvOxUwHMvXg7IztDR/h0HWvV2LknFPdch4=;
	b=QCMQr7hPcgn6dCNJX98bU9IBPqeWfG3Ql1Mu6n4Y9LoOsmj13Etz6iojOHwYcweudjPD6n
	SK/kCBfBz6KHrLyBW4voUWmuCls3bRLR2gEq423UrMYkvZdtVNxv7SvFOCAP3KCL+ZhPSo
	Dh/VMTFWyHwCEmcQ3Z8Du+I1btcxjEpqUhRVsa7eN99ptH/HLbsRNisS0yihVrXlq0rGP8
	hRsZYRDGXfgiJHTuKco1FN4OkNy+IONOBB7xByVDeUTKgENRw/W1pfx/4LJrIVjnP3S1Qz
	mO56wI/bcpbDvixGbOZtVIv1bUZhfKw7uJGMp7CkplGZ5sr9XomnpaqRXhYcJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762895643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkkC1Vko+WvOxUwHMvXg7IztDR/h0HWvV2LknFPdch4=;
	b=NWBf5/sdMIqLgR3LBr+nNke9DKJfpj5OuIHKoW7Yv0z8dk6zF4g7KO2sAVROMns0UW7FTe
	1xvl6jVq0thmABAw==
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Maximilian Luz <luzmaximilian@gmail.com>, Hans
 de Goede <hansg@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-tegra@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 08/13] irqchip/atmel-aic: Simplify with
 of_machine_get_match_data()
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-8-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-8-d780ea1780c2@linaro.org>
Date: Tue, 11 Nov 2025 22:14:02 +0100
Message-ID: <87cy5oxof9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 06 2025 at 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


Return-Path: <linux-pm+bounces-30999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58994B08A7E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6103A7F7F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E9299951;
	Thu, 17 Jul 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="goFADbou"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868E2046B3;
	Thu, 17 Jul 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748114; cv=none; b=j7GyLHuwvyyo15qtXmPzAEoIY4aixDnXA86wT2j2/PTF2Kqjpt6OXrz3F2T/HSQN28dB9lknRrI4BMBNen//x5HGBUugBjo/CaGMdZa+AVL3Kx+u3BULIXuroVzKl8FZeE/p1Ue6Sz1PLhgYtphFTnZvbgAcz73B3hv1L3FKNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748114; c=relaxed/simple;
	bh=njeWmQfR2ai9XZ2ITqvd5C2J/w/hnFAgXQdfFFO0UcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhEgFXLgwqNDZnNTPbR2xsFmhk4idEgxxcqfWl1s/+2VrDK4BrJIJBz8W4MbCPVioE6VIhHhnAlpabQgUcPiGGH5rbYNmAE3zoiZev2PWf9KWPCvYw7sqm4UULuR3LVEv6xm3SIYvke8OVRhgx8T6RV5AlRguCQteVwZqHfI2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=goFADbou; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752748111;
	bh=njeWmQfR2ai9XZ2ITqvd5C2J/w/hnFAgXQdfFFO0UcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=goFADbouZPEm62xcrdBEBQ4wStXnDAZkiZ7cYFTr1o2KiRQ6fx6zhrE2H13mjeFxI
	 r7zJnDxtTdeHIgQm9b+FmAmhljUVi/LDgVEWn6Xj8mspK6ygd0Xb36Odd+VUSpbkxC
	 e4MBC6zKRmP0N+f5nZQxPUdVeYsX23V281J/O4sYg84MW52LHH5qzUbAq3lP2U8GAi
	 b3bTDMrR6GLzR0A4P7rIafgDEFzoQSdVF9B7mHG7YtGK4nbQ2ATBz/8MwzkSN4OExr
	 x0R84IgFpBEHe5F9vp+SqPZjxphLOIng5SRFdl+UPhc82nDRXAuzG2pqADnJlvYTNs
	 rrYQtIzKNZE8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 83CFC17E0D15;
	Thu, 17 Jul 2025 12:28:30 +0200 (CEST)
Message-ID: <384e41cd-8bc0-4f98-9fcb-362608d93859@collabora.com>
Date: Thu, 17 Jul 2025 12:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
 <20250716-mt8196-cpufreq-v3-1-d440fb810d7e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250716-mt8196-cpufreq-v3-1-d440fb810d7e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/07/25 19:51, Nicolas Frattaroli ha scritto:
> The MediaTek MT8196 SoC has new cpufreq hardware, with added memory
> register ranges to control Dynamic-Voltage-Frequency-Scaling.
> 
> The DVFS hardware is controlled through a set of registers referred to
> as "FDVFS". They set the target frequency the DVFS hardware should aim
> for for each performance domain.
> 
> Instead of working around the old binding and its already established
> meanings for the reg items, add a new binding. The FDVFS register memory
> region is at the beginning, which allows us to easily expand this
> binding for future SoCs which may have more than 3 performance domains.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



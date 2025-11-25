Return-Path: <linux-pm+bounces-38555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D7C84A63
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 426A534DFC0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C0314A7A;
	Tue, 25 Nov 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hyO0EVwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A02EE5FD;
	Tue, 25 Nov 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069066; cv=none; b=kCuVFsvxOWNznK9b6213xqk9RkuoTTSLVkRNCCMwai9BQKIRej36WFixOjd+pjuCL8SSFOWZyvFZDrKdpYJFXV9mbnygTdGwuxDhPsHRzO+86gLeEvrqylDkWybzAg+0OfWI29743JnOAZVuVebjlEXe5/R6nSLWGlvwU+5zJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069066; c=relaxed/simple;
	bh=XK7rjGRc2Nc677jOtGjLy/E3OT/7UlqQeU7obCac8QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vt8XKz/C4cfOrcUC+Ieknsc3mqpcjw+edNEeWfKVlA3o0GeODAX+f1b9RwaaJsgBmzc2fYhAEHQ/GLgX1B1pQK1OIZPHbFDUwRKKIrRtpj7M+CxXfuMmhShGXFecCvbXjTUUQxtR3tNHiSN70ZjmDp9Ez0N/ongyLOG4r0Qflkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hyO0EVwM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764069063;
	bh=XK7rjGRc2Nc677jOtGjLy/E3OT/7UlqQeU7obCac8QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyO0EVwMYvTohlPbkccYriFZiWQP5OSCoysj9zU8rbpkAyUEDmhe1+1gaWUvsF4UT
	 j+1HqOq0X67tDMPWj+j5B6AZYQ2Mm7mYevhaTuRG9pIeC0pFOu8cLFmpLd4ejCFi1X
	 vl5gLss3pMM/PsOr130vRdhTvTwzfnHjWLpg2y6pXQ7BXWz/bp38YoKYK/7Mq+ChQY
	 9xXgWFuKayQ8CIQEiLMDThnQrwiUG7qNVKkwtpF3+sgUVsKopds2u5yN/QcOquLRDd
	 hog/LddLBeHX9I6ecPDJi/TnS6/v8GJuT/vL+gmPwjOF4cAg3dSyjZCv7R8rnHaG5i
	 GMkHRQgObP3Aw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:657b:ae76:a0f8:4811])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 26B7117E12D5;
	Tue, 25 Nov 2025 12:11:02 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: frank-w@public-files.de
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	fshao@chromium.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org
Subject: Re: [PATCH v4 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Tue, 25 Nov 2025 12:10:46 +0100
Message-Id: <20251125111046.23680-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <19D052E6-7E81-455B-AB31-C805AD65F96A@public-files.de>
References: <19D052E6-7E81-455B-AB31-C805AD65F96A@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/21/25 14:02, Frank Wunderlich wrote:
> Am 21. November 2025 14:00:29 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 21/11/25 12:16, Laura Nao ha scritto:
>>> Introduce lvts_platform_ops struct to support SoC-specific versions of
>>> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
>>>
>>> This is in preparation for supporting SoCs like MT8196/MT6991, which
>>> require a different lvts_temp_to_raw() implementation.
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>
>
> Should this patch not have same prefix like the others?
>
>

Whoops, that's right. I'll fix this, thanks for the heads up!

Best,

Laura



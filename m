Return-Path: <linux-pm+bounces-29975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977DAF14C7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956264E076D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97025BEE6;
	Wed,  2 Jul 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XrJpGbKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22821DF27F
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457639; cv=none; b=SODFQk/13SQsNANUUWW2/+Zx+DHSjnKoKHU9y/oGDOjteX9G7NR+Mjuglt7mg78CHhLWLRhdYx0z/9j25fApTqxZHMtxlvKD3ALqJ9AS19J1nyNURijuhCV4ICYuwGhR9YcIRop29Oq+FF9FMJsfeybXW+GseZidsUsCQRqN1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457639; c=relaxed/simple;
	bh=UfxI7FkpGi+6Wc89Rwbmcy6HPJBc92AHPV5wIaVHwYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XszOGSRiZekaA7ZbKoCSHqHLuOyPsVp9dyPr4TrvydLCu5FPlpZr1O9XBb66EnGnYopXEowW99uWnyczgZEkD9+V1/yGQrAPsIuqXs4RTO66k7aAmM0Py7SlL01io5IXZkovOnKfzoyXQDMhBPYz5aNrOb4Lg3vVKdpWSZ3pOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XrJpGbKl; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250702120030euoutp02822b6cc5c4429e03838a307f02c59e9b~ObW9TsAkn2561225612euoutp02M
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 12:00:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250702120030euoutp02822b6cc5c4429e03838a307f02c59e9b~ObW9TsAkn2561225612euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751457630;
	bh=zbq4GNHat/YXSM/ERlCYg0/nrsQ+ewI/Ix0VbmpNdWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrJpGbKlXQ4g5MpUQ8I2j+gdIGKeMyxr5rUv2YPxjV+6j2Wd8ur297Q/UJp8bhTvH
	 MRHqXZFqZyB+AAeUUY5vtQYovN5oJGlFYE6O5AqvgogTOpEOcKP6ShT/HZf586I3Lv
	 W+RHCTurgI6RElm8uZazO1lzc22/KCsWKx7/0v9A=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250702120029eucas1p21cb8337b313f134047817c2e5d5790b8~ObW87y1jk0330203302eucas1p22;
	Wed,  2 Jul 2025 12:00:29 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250702120028eusmtip16bfcac7925fd7ad8a957595a387c0e37~ObW8Ik_7a2544025440eusmtip1H;
	Wed,  2 Jul 2025 12:00:28 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux.amoon@gmail.com
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org,
	justinstitt@google.com, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	llvm@lists.linux.dev, lukasz.luba@arm.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com
Subject: Re: [PATCH v6 2/4] thermal/drivers/exynos: Use
 devm_clk_get_enabled() helpers
Date: Wed,  2 Jul 2025 14:00:15 +0200
Message-ID: <20250702120015.350609-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430123306.15072-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250702120029eucas1p21cb8337b313f134047817c2e5d5790b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250702120029eucas1p21cb8337b313f134047817c2e5d5790b8
X-EPHeader: CA
X-CMS-RootMailID: 20250702120029eucas1p21cb8337b313f134047817c2e5d5790b8
References: <20250430123306.15072-3-linux.amoon@gmail.com>
	<CGME20250702120029eucas1p21cb8337b313f134047817c2e5d5790b8@eucas1p2.samsung.com>

Hello :)

These:

> +	data->clk = devm_clk_get_enabled(dev, "tmu_apbif");

> +		data->clk_sec = devm_clk_get_enabled(dev, "tmu_triminfo_apbif");

should probably call devm_clk_get_prepared instead, as they are only
prepared inside current code:

> -	ret = clk_prepare(data->clk);

> -		ret = clk_prepare(data->clk_sec);

as elsewhere they are only enabled on use and then disabled. Only
data->sclk is enabled immediately:

> -			ret = clk_prepare_enable(data->sclk);

Thank you,
Mateusz Majewski


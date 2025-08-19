Return-Path: <linux-pm+bounces-32645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1965B2C623
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36901C23CA1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A821341ADB;
	Tue, 19 Aug 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iDuI4579"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128A341ACB
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611288; cv=none; b=ksJGcq+fpl0hu34DEuF3xvo4LVFKHgp+t1YU32zWk4RiJbpa7calUGtGBvG8Dare+pLnFXVPrAsTmjKZLIy4hIM+pmN/nB5prZoZeBtU9fOwoEb10OSD68shAmj5/Csh+Wm3sm0s2x04SVhR3qY7vWDI7vCuvJC9MTNs+6bCHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611288; c=relaxed/simple;
	bh=WgxoQGTefGQy6krhXNt6jyY6Ogd2/MoAfO4+6xkHD0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bFk2mUr0ei1ip5Q/RTgUJTSaMnw1O3zlcUOelHDvjVAsVhetMyzVcbVoN9EJGs5GxsDAVnTHWBGdnOSVOgQsq9MhPr072NTh2PZsgQB4NeXwuolyTWWpam88MdLO6L7c+EjTAher1bBkaCsKsvfsdhQALY3DrAWcxW7K1/CfNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iDuI4579; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250819134804euoutp02b51d6653ae52d6d02b1d641dd04da36b~dLyl_C7ox1778917789euoutp02i
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 13:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250819134804euoutp02b51d6653ae52d6d02b1d641dd04da36b~dLyl_C7ox1778917789euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755611285;
	bh=rNNRF4Z64xSeC0TtYIjoq13C5zAXQshZP/bVM+z+NiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDuI4579/yT2PSmol4tFFkDPplMZDmKc2g2rMu5dRM4X5bFq8Mp9N9d8ms5MibZt7
	 368lvC9S/XM+zfdLWHKDyLl7aVWbm3yIS0yqTu3B0yEvgwuioypHKq/KuZhwAp+6ps
	 UvZGL7usRQvkKiZq+w9jzFcXFra/MftkQdpbXkm8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250819134804eucas1p1ed14f9680e66327a86af4e98319eed11~dLylHjeKm2798127981eucas1p1o;
	Tue, 19 Aug 2025 13:48:04 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250819134803eusmtip14d110ea7c0e1c86224f6c2ecf32b88ba~dLykUPeUf2742627426eusmtip1o;
	Tue, 19 Aug 2025 13:48:03 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: m.majewski2@samsung.com
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org,
	justinstitt@google.com, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux.amoon@gmail.com, llvm@lists.linux.dev, lukasz.luba@arm.com,
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	rafael@kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH v7 6/7] thermal/drivers/exynos: Handle temperature
 threshold IRQs with SoC-specific mapping
Date: Tue, 19 Aug 2025 15:47:55 +0200
Message-ID: <20250819134755.92187-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819131704.19780-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250819134804eucas1p1ed14f9680e66327a86af4e98319eed11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250819134804eucas1p1ed14f9680e66327a86af4e98319eed11
X-EPHeader: CA
X-CMS-RootMailID: 20250819134804eucas1p1ed14f9680e66327a86af4e98319eed11
References: <20250819131704.19780-1-m.majewski2@samsung.com>
	<CGME20250819134804eucas1p1ed14f9680e66327a86af4e98319eed11@eucas1p1.samsung.com>

> +		pr_warn("exynos-tmu: Unknown SoC type %d, using fallback IRQ mapping\n", soc);

I missed this when writing the previous reply, but this doesn't build:
"soc" should be "data->soc". This line disappears in 7/7 though, so 7/7
builds just fine for me.

Kind regards,
Mateusz Majewski


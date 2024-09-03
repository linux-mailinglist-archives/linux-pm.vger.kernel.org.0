Return-Path: <linux-pm+bounces-13384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1F96952D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CAC1C23087
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80820010E;
	Tue,  3 Sep 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n1VIFgZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578E20012B
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348015; cv=none; b=K3iv6uxwtHh8P1SvKOVkHiK7RI8p8o7U3fk+4vPUKCpNKJ+14wh46CEHK8jAGpSWfPuQtVErElS08yF+L6J6uMqi6fTbsPYxsMVzhyxwuxxUZo54G2zUQB1P/ofhuk3PRimnJCPgRNoeNUIpX6BjWqIefujQ096dkXlmQuMHIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348015; c=relaxed/simple;
	bh=rtgDhsbqm35GHC11I3GwCh+rR+829viIN/jTvn5fWHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GIV7G1c0ZDaAmp6hABo9Hmup2EAzsLt++Y4OxT8hhMjh/E+Aq6ImnyYGaoeZztQffrVbipmSBbOcLld8nHYr2/gMmbwtu3YgzrdzYCItaJ+jmAFHPutSC1nK9GEjbHzR1CBhI8tn/pjcLJx5rB/+LqMU9xWQx1UUP3H3Gm+BxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n1VIFgZZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240903072006euoutp0270fb836fb03ab97866160a3a969d42c7~xqt7XDtXt3035830358euoutp02S
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 07:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240903072006euoutp0270fb836fb03ab97866160a3a969d42c7~xqt7XDtXt3035830358euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725348006;
	bh=65/2SJVng6lo7el3hUE88dgFRt6/tL+Cj7xnrVtuP/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1VIFgZZP9Gj2KJ/lsKfgSQQl/xgHYasM5NDQwi7MOVYjDyP7frNZEqfy+cofOAyr
	 t4bfYBt7urH3lXNzwKGxV8VvzB5kXjIBFvOBXV8ei8ZMuunU4s7fvllD1sbTzXGeXJ
	 PU0cKRGxtwklfzTCQ9hpJywFdqU9UdYQHi8NrKfY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240903072005eucas1p2a9cd2d95d5469422f749dbb64a7cce8f~xqt6yR9TN1361813618eucas1p2Z;
	Tue,  3 Sep 2024 07:20:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.1B.09875.5A8B6D66; Tue,  3
	Sep 2024 08:20:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e~xqt6TA2tt0454704547eucas1p2S;
	Tue,  3 Sep 2024 07:20:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903072005eusmtrp280e043ecaedc2accfd500370f6e10ced~xqt6SI37t1499014990eusmtrp27;
	Tue,  3 Sep 2024 07:20:05 +0000 (GMT)
X-AuditID: cbfec7f4-9acd8a8000002693-6d-66d6b8a5f5b0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.A7.19096.5A8B6D66; Tue,  3
	Sep 2024 08:20:05 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240903072004eusmtip13cee34ab07b41ab79b033a209c143bf0~xqt5ZmHIj1257912579eusmtip1L;
	Tue,  3 Sep 2024 07:20:04 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v3 3/6] drivers/thermal/exynos: improve
 sanitize_temp_error
Date: Tue,  3 Sep 2024 09:19:55 +0200
Message-ID: <20240903071957.2577486-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <664344db-5a60-46c4-b108-38ca1b4e1a13@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87pLd1xLMzi1T9HiwbxtbBbft1xn
	sliz9xyTxbzPshbzj5xjtTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNZtvMVusbCphd1i
	4rHJzBZzv0xltvi/Zwe7xZOHfWwWz/v2MTkIeqyZt4bRY+esu+wei/e8ZPLYtKqTzePOtT1s
	HpuX1Hv0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXRtf+XsaCQ+IVrY/WsDcwThXuYuTkkBAw
	kfjffoili5GLQ0hgBaNEY/caJpCEkMAXRolzKzwhEp8ZJW5dn84E03Hv6V4miMRyRomrJ3ey
	QzitTBJTTreAVbEJGEg8eLOMHcQWEdCTaHzfBtbBLHCTRaK78SRYkbBAoMSsz4/AilgEVCXO
	PLnLCmLzCthJ7OvcywaxTl7i4prnYDYnUPzbvK1sEDWCEidnPmEBsZmBapq3zmYGWSAhMJlT
	4v2xi+wQzS4S9+dMYoGwhSVeHd8CFZeR+L9zPtQ/+RIzNr8HquEAsisk7h70gjCtJT6eYQYx
	mQU0Jdbv0ocodpT4e2MTM0QFn8SNt4IQB/BJTNo2HSrMK9HRJgRRrSpxfM8kZghbWuJJy22o
	lR4SPZdXsk9gVJyF5JVZSF6ZhbB3ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMAk
	d/rf8S87GJe/+qh3iJGJg/EQowQHs5IIb+zGq2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT
	5FOFBNITS1KzU1MLUotgskwcnFINTOHrj/f7h9w2vKefbTJxr5TT57ZUvd49x4wS+BkfPp7R
	XfK30TuXt8rz2+PDL3emJi30TYnWUGt8sdPc7yobf6itf+OxZ2tyk7ZFuPmsXxhRofVp9+ea
	jBOvHRbU2oqsSkm4fTfctPhuldTEh0f+2rw/arFcv+yC3utpb1LO7fxiaCwR3nL29YGvShm7
	U9zEJ0bvUeeZ27R7Vu7JqdbvN20LWndtv8K+b5uMQ11fCJ/6Y2h6ZecE/Tr1xxpLWjbYtehp
	m7fbVQbPr8ooNfCQsnlu/nljbc7vVSfUD+k2/FKxnf3v79TVJ8Nq/M8oH0o2+tulm9VQxJps
	tmkH5wmxWWmS63bIB85+6pf4Zbm1uhJLcUaioRZzUXEiAKAbgrbhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7pLd1xLM3h4l9XiwbxtbBbft1xn
	sliz9xyTxbzPshbzj5xjtTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNZtvMVusbCphd1i
	4rHJzBZzv0xltvi/Zwe7xZOHfWwWz/v2MTkIeqyZt4bRY+esu+wei/e8ZPLYtKqTzePOtT1s
	HpuX1Hv0bVnF6PF5k1wAR5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJeRtf+XsaCQ+IVrY/WsDcwThXuYuTkkBAwkbj3dC9TFyMXh5DAUkaJIyv3
	skEkpCUOf5nCDmELS/y51sUGUdTMJPF0xU+wIjYBA4kHb5aBFYkI6Ek0vm9jArGZBZ6zSFzo
	tgCxhQX8JeYvmAIWZxFQlTjz5C4riM0rYCexrxNmmbzExTXPwWxOoPi3eVvBbCEBHolXG/Yz
	QtQLSpyc+YQFYr68RPPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cT
	IzAmtx37uWUH48pXH/UOMTJxMB5ilOBgVhLhjd14NU2INyWxsiq1KD++qDQntfgQoynQ3ROZ
	pUST84FJIa8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6pBiYlfoat
	3/3PsrztuzDx21YO5W3X9nQVzhKXjBEyP7h5YmJx27sdT/TDRZl0Xi3m/7ON0XWVfv3f8tab
	r9U/yz17+mBtJ2+h7JUvdyq2Fgr/XDnzt/jKtpC5New8auxnFGPuxGzPN5l/Y4P6gsXaK0Pu
	8ldOqu1fH5p8wC3a9MWEmUufyxebf3qrZz2vt2hOxK6CpiuiEm0ZcVInsu91H3qp73qt8FAM
	x1t9P5tz+k7/+ufOnvljsf7X3fLCpm6yU2fsU2qzX2dXnMZR0LO/5eMPjWsWq2fe+CN77pjF
	fWdrg4UHQ0/yO0155OPJW3dV/l/zS6b6uIRa0U0eohxJ9kdCbsnbfQp9PO+q6nnf9/uUWIoz
	Eg21mIuKEwHPSSp0UgMAAA==
X-CMS-MailID: 20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e
References: <CGME20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e@eucas1p2.samsung.com>

Hello :)

> May I suggest to convert this function to a specific soc ops to be put
> in the struct exynos_tmu_data ?

Like this?

static void exynos4210_sanitize_temp_error(struct exynos_tmu_data *data,
					   u32 trim_info)
{
	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
	if (!data->temp_error1 ||
	    (data->min_efuse_value > data->temp_error1) ||
	    (data->temp_error1 > data->max_efuse_value))
		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
}

static void exynos5433_sanitize_temp_error(struct exynos_tmu_data *data,
					   u32 trim_info)
{
	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
	if (!data->temp_error1 ||
	    (data->min_efuse_value > data->temp_error1) ||
	    (data->temp_error1 > data->max_efuse_value))
		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;

	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
		data->temp_error2 = (trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
				    EXYNOS_TMU_TEMP_MASK;
		if (!data->temp_error2)
			data->temp_error2 = (data->efuse_value >>
					     EXYNOS_TRIMINFO_85_SHIFT) &
					    EXYNOS_TMU_TEMP_MASK;
	}
}

static void exynos7_sanitize_temp_error(struct exynos_tmu_data *data,
					u32 trim_info)
{
	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
	if (!data->temp_error1 ||
	    (data->min_efuse_value > data->temp_error1) ||
	    (data->temp_error1 > data->max_efuse_value))
		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;
	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
}

static void exynos850_sanitize_temp_error(struct exynos_tmu_data *data,
					   u32 trim_info)
{
	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
	if (!data->temp_error1 ||
	    (data->min_efuse_value > data->temp_error1) ||
	    (data->temp_error1 > data->max_efuse_value))
		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;

	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
		data->temp_error2 = (trim_info >> EXYNOS7_TMU_TEMP_SHIFT) &
				    EXYNOS7_TMU_TEMP_MASK;
		if (!data->temp_error2)
			data->temp_error2 = (data->efuse_value >>
					     EXYNOS7_TMU_TEMP_SHIFT) &
					    EXYNOS_TMU_TEMP_MASK;
	}
}

Or maybe we could put tmu_temp_mask and tmu_85_shift in data instead,
and have one function like this:

static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
{
	data->temp_error1 = trim_info & data->tmu_temp_mask;
	if (!data->temp_error1 || (data->min_efuse_value > data->temp_error1) ||
	    (data->temp_error1 > data->max_efuse_value))
		data->temp_error1 = data->efuse_value & data->tmu_temp_mask;

	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
		data->temp_error2 = (trim_info >> data->tmu_85_shift) &
				    data->tmu_temp_mask;
		if (!data->temp_error2)
			data->temp_error2 =
				(data->efuse_value >> data->tmu_85_shift) &
				data->tmu_temp_mask;
	}
}

Thank you,
Mateusz


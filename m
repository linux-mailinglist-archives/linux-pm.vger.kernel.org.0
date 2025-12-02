Return-Path: <linux-pm+bounces-39024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28EC99A63
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 01:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75AF3A44F9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402335B21A;
	Tue,  2 Dec 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BB5s1QU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BED42A82
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635499; cv=none; b=UnTPcokGnJxzi+xKNQB0XpoxkcVQzE0Sp/vGXUt/AbVuZ4a33CNWbl0gv4N9EGukdOsWQIDtzDkphUjdlC4oEksP4EK/v1/ODY/m9hw6KifTbpNsRbEjrDRPEy5wpeVTmxL2LW4qY/3pSGNgc+X5e3cqrLvBkCVtbi6tRvPxbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635499; c=relaxed/simple;
	bh=6nQ7CHXUD5DNsZgGpGIHq00pzr32pifTx9D3xVMpP6U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=UeREQFp/XUNOVgb0o9lISYnyCNUlKF6i64YMgy8JeIDht2k8fpz9OcqzeMuwmtmgoqyr2gUdeMIXY3/XtV+eTyE7T2cTLQd2/VmUfmj457RZs6WQ0+8oHvEjhgnj0VXOdRcyUukUz6+Eye1CUv9qGoq7izrPDAB7Gug4roN3Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BB5s1QU/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251202003134epoutp04d417b755c09520cbf082e2abcd87d52b~9PqIZCXJw2423824238epoutp04x
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 00:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251202003134epoutp04d417b755c09520cbf082e2abcd87d52b~9PqIZCXJw2423824238epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764635494;
	bh=KFnBHkWxVElb54NLeG+ptXXjdRVbe7DkPWr+FQzj0HE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BB5s1QU/Mxe3333UqcFs6G9d8kKQbbmdva/4o5lXVXTQQbAPFLN37Esn/nVIyesu5
	 InLb7g3yzNqNZT8+Ekqpulsq1rVrSYbb2JSVqv+7maKONZcrqPJsPFA2Ez9D7328Qi
	 BGrqPgQhqodQ9TW8sTCz/f6/SEOBiIN4bUHeplKw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20251202003134epcas2p1fa31937e020b763ba81d61dca9442d0c~9PqHxqywI1926719267epcas2p1d;
	Tue,  2 Dec 2025 00:31:34 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.209]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dL1sx6Xd0z6B9m6; Tue,  2 Dec
	2025 00:31:33 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20251202003133epcas2p47e7fc8d62bf92c698df9c996d6b3d3d7~9PqG1MUaC0426004260epcas2p47;
	Tue,  2 Dec 2025 00:31:33 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251202003133epsmtip2e09f100cb125186b33f363fb7f9d62c5~9PqGregYo0713407134epsmtip2q;
	Tue,  2 Dec 2025 00:31:33 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Youngmin Nam'" <youngmin.nam@samsung.com>, "'Tudor Ambarus'"
	<tudor.ambarus@linaro.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Rafael J
 . Wysocki'" <rafael@kernel.org>, "'Daniel Lezcano'"
	<daniel.lezcano@linaro.org>, "'Zhang	Rui'" <rui.zhang@intel.com>, "'Lukasz
 Luba'" <lukasz.luba@arm.com>, "'Rob	Herring'" <robh@kernel.org>, "'Conor
 Dooley'" <conor+dt@kernel.org>, "'Alim	Akhtar'" <alim.akhtar@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Peter	Griffin'" <peter.griffin@linaro.org>,
	=?UTF-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'William
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>,
	<shin.son@samsung.com>
In-Reply-To: <c3cc4b6f-ac75-448e-9fdf-c3c45e2ceed7@samsung.com>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Tue, 2 Dec 2025 09:31:29 +0900
Message-ID: <022e01dc6323$028136a0$0783a3e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KICEvKvogHXMeJ7AVgXt0UB8c+VXLO8VEzQ
X-CMS-MailID: 20251202003133epcas2p47e7fc8d62bf92c698df9c996d6b3d3d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
	<20251113064022.2701578-3-shin.son@samsung.com>
	<5a6a749b-b2b7-41bb-bcb4-a2342e7f4e98@linaro.org>
	<015501dc5ea5$0c7dd460$25797d20$@samsung.com>
	<401ed9b9-19a4-4a19-b397-0f353e9f0c97@linaro.org>
	<c3cc4b6f-ac75-448e-9fdf-c3c45e2ceed7@samsung.com>

Hello, Youngmin Nam.

> Hi Shin Son,
> if possible, please consider this approach as well.
> 
> Thanks,
> Youngmin


Ok, Understood. When I resume this task, I'll CC you.
Thank you for your opinion.

Best regards,
Shin Son



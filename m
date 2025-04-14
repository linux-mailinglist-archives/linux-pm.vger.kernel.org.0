Return-Path: <linux-pm+bounces-25396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCFA88BD1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F14189AEFC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81A288C99;
	Mon, 14 Apr 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GfkAtLgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26128F51E
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656807; cv=none; b=ESHDjvYIm7XeX1NCxokCbN3HghtKlzvWwIEYVoTTTzCUItsTd6LsXoCyk6g7E0rpOXP8HJQLJRYznOV6eVIcaWWh8OIKVeiSqxONKIFeQOyQy6snOZe3Dgc8nkYNCTiJHFlVYARMpzJTciKa4Ormt/ztPyJpye0Bwa/L0hVSKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656807; c=relaxed/simple;
	bh=TdQ7pQpU0JnTiHhlWrvD+tSYVG+wDTEGAVyByh2OK0w=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=ZrOLjYRWfiyjAFMM5BwW0vxn+oX25x7z0nM3SYg501EQCSsJBxdAVboCvoPBgJLIt02Ngu/iTXeBFw51v6uZ6f/Sog0v8DmrQFyGlXxbUuG805K2iTzS9g5LJ4Z2Hbzd3V9/ozRMdifUPSy+AjUINtyOX1nHMmom7fl/95ir9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GfkAtLgZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250414185318euoutp02e96a4e08348ae9712b7906ba9c5acb18~2RB1w9zpH3024330243euoutp02H
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 18:53:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250414185318euoutp02e96a4e08348ae9712b7906ba9c5acb18~2RB1w9zpH3024330243euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744656798;
	bh=qnyf6hlDWuWsG9w7ndgnCLFpfCuFBEM/Kpzf3HaSX/c=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=GfkAtLgZEbONy7/aUF5aYyPd9ZXoTs96Uo/XOhkbHbuGbpJAsktudccfb2pgJSSNu
	 S/6aJ0GPC7KWNy+ee589AtwBPPnlDiUA3jateQ96cMXmdH4aTTiu3+bh4Y1wzPA3Ma
	 2yM9xi9w8/hek5QFQ/Q1wVfsCNltVCh/IQP8ah6Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250414185317eucas1p16a400431aaf5bb8865c6b26d22190246~2RB02ccgA3084730847eucas1p1s;
	Mon, 14 Apr 2025 18:53:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id EC.72.20397.D995DF76; Mon, 14
	Apr 2025 19:53:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250414185317eucas1p139284a38dc4418ac90bd081c2825142a~2RB0YURv33084730847eucas1p1r;
	Mon, 14 Apr 2025 18:53:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250414185317eusmtrp15acfa0562b019e9407af601f1d8a6600~2RB0V7sFQ0705407054eusmtrp1h;
	Mon, 14 Apr 2025 18:53:17 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-3b-67fd599dc9db
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 66.64.19654.D995DF76; Mon, 14
	Apr 2025 19:53:17 +0100 (BST)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250414185316eusmtip247f53d5453989b8f086b807c2a4109b1~2RBzRoeRG2643326433eusmtip2e;
	Mon, 14 Apr 2025 18:53:16 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 14 Apr 2025 20:52:58 +0200
Subject: [PATCH v2 4/4] drm/imagination: Skip clocks if platform PM manages
 resources
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-apr_14_for_sending-v2-4-70c5af2af96c@samsung.com>
In-Reply-To: <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,  Danilo Krummrich
	<dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,  Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
	Dooley <conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,  Philipp Zabel
	<p.zabel@pengutronix.de>,  Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>,  Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,  m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRz3ed9378a64euwfMBOL0ov65wUHD4X1WXrzlexrKvLFmDt9G2A
	MLxNIqRyKBK/JGJCMZkz4mSA/Dg2135Ai7nb2GGjA1S6G/gDFVNx4GCecLOc7yz/+3w/n8/3
	+X6+33t4uFBNxvGy5PsYhVyaE0/yCZPr/tB6rSQkS2iYTEADF5owdKrPi6Fb9TMk0jm9HDQx
	bMTQ6LyfRJ3X/uSiG33FBPpbM0GiEWsjiQJHnACZAiUk6nCOc1HXvA5DP8+eJlCz2QpQaflJ
	DhqfGCBQmV+FI+1cHY7+6TVz0bE7di4y3v6Bg9wdO1CJ/SjxVizdFzxB0BbNOJeuspwFdE9b
	OUn7zveS9HHPB/TFSjdGG5oP0CUdLoz+PpRA+387R9LVxjZAGwaL6EDPqvejP+W/vpvJyfqS
	UWx483N+pmZyiNh79amvPOXNuApciaoAUTxIJcH+gy68AvB5QkoP4I1QK5ct5gCst6kiSgBA
	Z7uB+7hFrbtAsEILgPqxGg5blGLQ13KRCLtI6lV4qUX3UODxCGoN1NUmh+kYage85reQYSyg
	lkFPw9VHdpxaDX+dbsRZfjO0Hb5FhFujKBpa1DvDzy+nFjmwLJIVp7QAOkyHCDbR03BRbX2U
	CFLVfBg8VxwR3oFarZFkcQy86TZGVngWDqqrIp48eOn0XZzFX0NLlTuCU6DPu0CGU+DUOthl
	3cDSm+DiXzN4mIZUNBybXsbmj4a1ph8jtACWlQpZ91pYV3Xkv6FevQljMQ37Lx/k1IDnNE9c
	QvPEJTT/zz0B8DawgslX5soYZaKcKRAppbnKfLlMtCsvtwc8/LeDD9zzZqC/OStyAIwHHADy
	8PjlAr54QSYU7JYW7mcUeZ8p8nMYpQOs5BHxKwRN9sMyISWT7mP2MMxeRvFYxXhRcSqMcfD3
	b1/jmDw7M7U5+XLqtx+HqEMOU4F0GBvakmi2Sz86MOUZzkLDoqFQe6op/XfbLzXp0a22ezWD
	sal3R06Bbcn6ftFraSljoYLsyoWdi0u0henKe2eSjs32xCzdmDrSmi/uCqz6ovl6abvhujdT
	fJ+xFku6PTqpRLJEvPWZJqpuY9TRxMl2y3rxWGa95kxcdxF4caLS4LV3fvhd8GV3cNvolaW7
	pnC3vGFgLqO7/xPDCyv7VNltvZSz6bjzbctJ2PjTwHvQ4X9+z4M776Ylpbtct/HCrQPBRQ5K
	q/CaO8WSlIzq6XUZq//YdL7IRmeP+rbXrlXyR2Nn3zBs8X0TTygzpa+8hCuU0n8BVFGYJCYE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7pzI/+mG9z7zWtx4voiJos1e88x
	Wbye9oHNYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxeDnrHpvF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7JY+HEri8WSHbsYLdo6l7Fa3L13gsWi430Ds8XcL1OZLf7v2cFuMfvdfnaL
	LW8mslocXxtu0bJ/CouDpMfebwtYPHbOusvu0bPzDKPHplWdbB53ru1h85h3MtDjfvdxJo/N
	S+o9WtYeY/Lo/2vg8X7fVTaPvi2rGD02n672+LxJLoAvSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
	0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j1uPzLAVPuCtOdi5hbmB8xNnFyMkhIWAi
	MXn+dZYuRi4OIYGljBLTLj9ihkjISFzrfskCYQtL/LnWxQZR1MIkcf/fSTaQBJuAkcSD5fNZ
	uxg5OFgEVCXmTzIDCQsLhEs8fb8TrIRXQFDi5MwnLCAlzAKaEut36YOEmQXkJba/ncMMUeIu
	sbv1NdgqISB72oKvbCDlnAIeEjsnx4FsFRFoYpP4tv0z2AnMAvMYJT7NmwB1m6jE78m7WCYw
	Cs5Csm4WwrpZSNYtYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZhEth37uWUH48pXH/UO
	MTJxMB5ilOBgVhLh5XL+lS7Em5JYWZValB9fVJqTWnyI0RTo44nMUqLJ+cA0llcSb2hmYGpo
	YmZpYGppZqwkzst25XyakEB6YklqdmpqQWoRTB8TB6dUA5N3yUfuZUdenfFpnPh2te/pOx+j
	oi7tnKnG+TtSTG6ivN6rtreuJ55piM8/c1lpnqZp4p9NGQfkX75ZbarwWc5kl0VexlnJGt2k
	2Oz/XdJ9Xwq0/+iyan67tmoOo4qcjRozy2f+m7HuORqcCfGXdCc6T4q48HbS9eWCIZOe+Mbt
	7ctbwNX/Iz5/0tz4zSYBad3JWtZMG1TXGPyra7zsdrvp+y73bp6bES909OZ6Tspuq7tdfUGD
	t332RZsNK1zE7DX3zgtK9XIMrdY817owufIiq1pv1q6iH21F/8sdCvP1CzL7hQrlm/z3T83Y
	qP+7p9ZnCfv8+V8bWTw7RPLe/Zp9iI3j5WFDr8NBkfzxSizFGYmGWsxFxYkAGKJT/qsDAAA=
X-CMS-MailID: 20250414185317eucas1p139284a38dc4418ac90bd081c2825142a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250414185317eucas1p139284a38dc4418ac90bd081c2825142a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250414185317eucas1p139284a38dc4418ac90bd081c2825142a
References: <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
	<CGME20250414185317eucas1p139284a38dc4418ac90bd081c2825142a@eucas1p1.samsung.com>

Update the Imagination PVR driver to skip clock management during
initialization if the platform PM has indicated that it manages platform
resources.

This is necessary for platforms like the T-HEAD TH1520, where the GPU's
clocks and resets are managed via a PM domain, and should not be
manipulated directly by the GPU driver.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/pvr_device.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 1704c0268589bdeb65fa6535f9ec63182b0a3e94..f40468b99cf14da418aeecde086f009695ff877c 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -504,10 +504,16 @@ pvr_device_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
-	/* Enable and initialize clocks required for the device to operate. */
-	err = pvr_device_clk_init(pvr_dev);
-	if (err)
-		return err;
+	/*
+	 * Only initialize clocks if they are not managed by the platform's
+	 * PM domain.
+	 */
+	if (!device_platform_resources_pm_managed(dev)) {
+		/* Enable and initialize clocks required for the device to operate. */
+		err = pvr_device_clk_init(pvr_dev);
+		if (err)
+			return err;
+	}
 
 	/* Explicitly power the GPU so we can access control registers before the FW is booted. */
 	err = pm_runtime_resume_and_get(dev);

-- 
2.34.1



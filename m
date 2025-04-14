Return-Path: <linux-pm+bounces-25393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDBA88BC3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F34172023
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE9284690;
	Mon, 14 Apr 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jVEuNlus"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1B1A3A80
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656799; cv=none; b=QRZE8sWgYFCRpHs9/rieAEs9ykv0gIEGovCHdKdopQut2oU7AxmoEDeZ3rCv9/xYTbtzAun4hUW7Od8aHHmECZ/00MuCA8oGaV4I9/Gc/DVNdXZ5qfKJ4O5wI4o6ABpaDAvIDa8OvLowefv1hwsMKAYKWy5rIyX7GOOhL1hr+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656799; c=relaxed/simple;
	bh=P9GVDFFYrg1AuURByZjUKnIGE9SwnanTkkMJjBc1bMk=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=kKtsiMGzvG8FtphLQonUZxFyvw+4CXKHtmsZiaes1YnAq0Rtgz8d61+9QwlYjoAjVGGoASQBagIV80unTB6HqqKzRY0S1vnDP6M1zTAgyuCqQMPd32ZH8cdAFLZ6Ye6bfyH/vhPEx07cIjtMa+3RMUc+yJbq3mlLI+kK6gPIFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jVEuNlus; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250414185316euoutp01727b85d891395b65939750e08e23fd3d~2RBzF3U-s3271432714euoutp01N
	for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 18:53:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250414185316euoutp01727b85d891395b65939750e08e23fd3d~2RBzF3U-s3271432714euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744656796;
	bh=HULZmsPNZV3ns4nzRTJKqZffc7MgM4O6Xryp2C0QHoM=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=jVEuNlusL3Sl2IpUC7fARH+jhuj6Bb3sYO+Yz5y7evwP5FegEYEDIjgmP0er4KuxM
	 JYVyfS0yGi94i8z0GpdpH4w+P4RSbjS6u2GMUUXKfIhifHLL59SQxFlmVrnwQj9kpr
	 ZVKbKIH9709KmzQW5bJVYkqfn1hMCZqccnySh1II=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250414185314eucas1p18699318fe1a8999d74d80435794f35dc~2RBx-djFR3084730847eucas1p1n;
	Mon, 14 Apr 2025 18:53:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.8E.20821.A995DF76; Mon, 14
	Apr 2025 19:53:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028~2RBxYDIiD3185731857eucas1p1u;
	Mon, 14 Apr 2025 18:53:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250414185314eusmtrp269a3bccbbaa425b599c005bea7c176f7~2RBxXV0KH1486514865eusmtrp2e;
	Mon, 14 Apr 2025 18:53:14 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-77-67fd599a20f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.A9.19920.A995DF76; Mon, 14
	Apr 2025 19:53:14 +0100 (BST)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250414185313eusmtip2c6cb77b89315c268a6d012cb5b6b85af~2RBwTGRne2237122371eusmtip2s;
	Mon, 14 Apr 2025 18:53:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 14 Apr 2025 20:52:55 +0200
Subject: [PATCH v2 1/4] PM: device: Introduce platform_resources_managed
 flag
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-apr_14_for_sending-v2-1-70c5af2af96c@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVDTdRzH/f6e9mPX6OfU+IIc1g6NLAeGf3y9fCgz+HUcJ1xdqaW59Nfg
	gm1tLETtQnkQCTVZgAwnDDEQBDoeJls8eDxNwVaIiF0O8QqJ5xhoNhrEr83yv9fn/f587/2+
	z31pXJxN+dGxigROrZDFSSghYer868d1+l0ueYiz5GV0rb8YQ5ebbBgay/2DQoXtNhIN3KzD
	0K2HUxSqGvpJgH5vOkqgEf0AhXot5yg0c7IdINNMKoUq2+0CVP2wEEPG6XoClTRYAEo/8S2J
	7APXCJQxlYwjw2wOjhYaGwSoYLJFgOrGz5DIWvk+Sm35hnjdl216VESwZr1dwGaZbwC2pvwE
	xd693Uix569Hs/e+smJsbcmXbGplJ8aedoWwU819FHuqrhywtd2H2ZmagCjv3cJNB7i42M85
	dfCWfcKYzrFmTNXz7MHj80YyGeSJMoEXDZkNMK03l8oEQlrMlAFoLjIA9zAL4Pe2S5h7mAHw
	3u0e6skTx7jFY5QCeL+iGOMNMZOOwUuW53mmmFfhYGkhyTPBrIalugmC52XMDjhpysd5FjFL
	4fX83/7VcWYVvDJxblGnF/VwOHFWzqMXw0Kzbi8ftZyZI2HGsU6cH3DGAGCrKYVwF1oB53QW
	gjcgc0oIF9r+xN3GdjjU2+hZWgZHrXUCN/vDBXMh5mYlHKx3ePaPQHOW1cOvwbs2J8W3wJmX
	YLUl2C2/AUeODpO8DBlveGdiqbu+N8w25eFuWQQz0sXu7TUwJ+vkf6G2MpMnlIXdzXPga/CC
	/qlD6J86hP7/3CKAlwMfTquJl3Oa9QouUaqRxWu0Crl0vzK+Bix+2+55q6MBGEanpa0Ao0Er
	gDQuWS4SvumUi0UHZEmHOLXyI7U2jtO0gpU0IfERFbekycWMXJbAfcpxKk79xMVoL79k7JWi
	MaPLmZSzW9e8JSb8qj9SCEKV8VWbLKrosIELKeUts65YuatgJCLsAb1XVb15tD93z7a8Vfb7
	XaFLAg99Zna45hfeIz+pkD3SlymkruFnpPsjE0b6/ANlS35duyuxw2vorQhdb2jHmah6ZdBz
	O4M27ss4cjPxiiI/BAyeP345sSS2KuLv7VHf+aUf3ip+V/lFj93oCmigs8zzN85uDNRfoDI3
	G/qtJOmTMt1WH7AybPyxvrEC/Fz6y3BwUGhSV9o7Gw6uq3I+bvtA67dVmhTw4raupoIP0/bk
	rNG+7Zsd3nNxspnM6ztmdJgmbkVH7ryzIuHjoUiVZPBiR6366oMfUnwlhCZGtn4trtbI/gEr
	eKFBJQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xe7qzIv+mG0y/xWJx4voiJos1e88x
	Wbye9oHNYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxeDnrHpvF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7JY+HEri8WSHbsYLdo6l7Fa3L13gsWi430Ds8XcL1OZLf7v2cFuMfvdfnaL
	LW8mslocXxtu0bJ/CouDpMfebwtYPHbOusvu0bPzDKPHplWdbB53ru1h85h3MtDjfvdxJo/N
	S+o9WtYeY/Lo/2vg8X7fVTaPvi2rGD02n672+LxJLoAvSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
	0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j2Ot9TAUX+Sva/y1kbWCcztvFyMkhIWAi
	8enNLiYQW0hgKaPEwzkxEHEZiWvdL1kgbGGJP9e62LoYuYBqWpgkJvedYAZJsAkYSTxYPp8V
	xGYRUJVYPvktWIOwgL/Eu20zwWp4BQQlTs58AhTn4GAW0JRYv0sfJMwsIC+x/e0cZpAwr4C7
	xNsZ6RAnuEtMW/CVDSTMKeAhsXNyHMhWEYEmNolv2z+DncAsMI9R4tO8CVC3iUr8nryLZQKj
	4Cwk22YhbJuFZNsCRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgSlk27Gfm3cwznv1Ue8Q
	IxMH4yFGCQ5mJRFeLudf6UK8KYmVValF+fFFpTmpxYcYTYE+nsgsJZqcD0xieSXxhmYGpoYm
	ZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MLH5BId3J6RMDxCs/sm/o7X3e2ND
	4ZmYGmf1jPquXz5vH5f3R13mfXjxhckiT4uqP9EyaW0fNstdf7r0pKfw4Ymr3vCtFWbQfOIv
	G3ir889lXQdNicANL51fvnmvtfSl++PZ6/5u2N4svWHa1LceF2Occ9zq1SKM2n8b/Jo9TV9G
	4I7B1aT//0WUNzwrPFVXcWPOxr/8tkv+K+U7m0u4PfL6GHfTI7LlXBTLX5vdPFdPK3WvDtPf
	dl47kvGzlA5nn4O2BX/q36sdTT++Svacd+G4Ed3/L1N5+pHHYQfyi+ceY3mpGHFjgcc8drkP
	m/bO0vx+3eSbjOjWPBlPMdPnX2JTOyotVFJX1Tfsm1i0WomlOCPRUIu5qDgRAFY/RYGqAwAA
X-CMS-MailID: 20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028
References: <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
	<CGME20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028@eucas1p1.samsung.com>

Introduce a new dev_pm_info flag - platform_resources_managed, to
indicate whether platform PM resources such as clocks or resets are
managed externally (e.g. by a generic power domain driver) instead of
directly by the consumer device driver.

This flag enables device drivers to cooperate with SoC-specific PM
domains by conditionally skipping management of clocks and resets when
the platform owns them.

This idea was discussed on the mailing list [1].

[1] - https://lore.kernel.org/all/CAPDyKFq=BF5f2i_Sr1cmVqtVAMgr=0FqsksL7RHZLKn++y0uwg@mail.gmail.com/

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 include/linux/device.h | 11 +++++++++++
 include/linux/pm.h     |  1 +
 2 files changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 79e49fe494b7c4c70d902886db63c4cfe5b4de4f..3e7a36dd874cfb6b98e2451c7a876989aa9f1913 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -881,6 +881,17 @@ static inline bool device_async_suspend_enabled(struct device *dev)
 	return !!dev->power.async_suspend;
 }
 
+static inline bool device_platform_resources_pm_managed(struct device *dev)
+{
+	return dev->power.platform_resources_managed;
+}
+
+static inline void device_platform_resources_set_pm_managed(struct device *dev,
+							    bool val)
+{
+	dev->power.platform_resources_managed = val;
+}
+
 static inline bool device_pm_not_required(struct device *dev)
 {
 	return dev->power.no_pm;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2c09c63d780bb2528693acf2d2da1..cd6cb59686e4a5e9eaa2701d1e44af2abbfd88d1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -670,6 +670,7 @@ struct dev_pm_info {
 	bool			no_pm:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	bool			platform_resources_managed:1;
 	u32			driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP

-- 
2.34.1



Return-Path: <linux-pm+bounces-23745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A4A58ED5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24451188EB07
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEEF224B1C;
	Mon, 10 Mar 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oBR9X44D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B32248B9
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597350; cv=none; b=kTnhN+vmH2PztvCWbT34uJw7XXIlvm1YpL9/4vvW6ghIEYA/bHZGf/5k1eTf358tvx6388ERUkPRXzCvbDdln/eG7ionsOeaC+sOsf9erWLTe8y+P2Pfw/7eXFYVSWyTlJMoT9eDLcHGjn+JAF1IE6fiOPIDP0Iz/MbfKxoxEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597350; c=relaxed/simple;
	bh=0/x1ZSg0Lpyd2Ds2KTEjkgI4HVqlhIR56EXBdJ0XwYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Wx9/HERlC7EB4c8DDcDes6LO1T0AbfMcagNWLT01H+eKOFxWQ46c4lm04SKFC6RokiCSSq+2KfBzcoXg5MsD3Gl7GgojFXHr3gHrPQyxQ7uUEGISOlIax59fWKr6dDL7kMOHBQ905fhdDtVHD/vnufUrDQjQXQHv95D6VxlFfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oBR9X44D; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250310090220euoutp02516d9a9786a4af2fb797f9207315e7c9~rZY27jeTO2552925529euoutp02v
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250310090220euoutp02516d9a9786a4af2fb797f9207315e7c9~rZY27jeTO2552925529euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741597340;
	bh=K2KBwS7B77Ev1bGYtdC2d+pddTbj6i1oKKCPxQ8uO3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBR9X44DdmQIOnuF2oo+Opcdz4fRJR/q5Bh/58MzXLQOEeXqP/SmsMSFGRMk0U0my
	 3c6GhPUKwVsEmuifFasi66why9An0K7Nn4N/fY9fzZcIra55eQ53CMJ/hXTV2kUyDv
	 E0h4MIG9yzBTWxpDFu5v79aJbTESXlrSM9K9tvAw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250310090219eucas1p120f9c79a52e77ac5756fcb51a23bf9f0~rZY2bsv_A2598725987eucas1p1t;
	Mon, 10 Mar 2025 09:02:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.97.20397.B9AAEC76; Mon, 10
	Mar 2025 09:02:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250310090219eucas1p14066b32edfec12b55de972f76b641f6f~rZY2BanGF2339523395eucas1p1u;
	Mon, 10 Mar 2025 09:02:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250310090219eusmtrp1c1f197ae31dc3cb973033aa4362e1bbf~rZY16Vl0i1037610376eusmtrp1S;
	Mon, 10 Mar 2025 09:02:19 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-e2-67ceaa9b9f6b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.0F.19654.B9AAEC76; Mon, 10
	Mar 2025 09:02:19 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090218eusmtip217372da02225495c4d254f123f828c0a~rZY1ABsYp3233232332eusmtip2x;
	Mon, 10 Mar 2025 09:02:18 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 3/5] dt-bindings: power: Add TH1520 SoC power domains
Date: Mon, 10 Mar 2025 10:02:09 +0100
Message-Id: <20250310090211.286549-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310090211.286549-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djP87qzV51LN7h6RdPi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz2Pt6K7vF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7J4ebmH2aJtFr/F/z072C2Orw23aNk/hcVB2OPNy5csHoc7vrB73DsxjdVj
	06pONo871/aweWxeUu/RsvYYk8f7fVfZPPq2rGL0uNR8nd3j8ya5AO4oLpuU1JzMstQifbsE
	rozvexUL+nkr/qz/wdjA2MvdxcjJISFgInHr1SSWLkYuDiGBFYwSR1fMZYdwvjBKNB1cwwjh
	fGaUuHfhJyNMy8Rj06BaljNKbOy/BdXyhlHi+6qdzCBVbAJGEg+Wz2cFSYgI9DNJ9B35D+Yw
	CzxklHj9sokVpEpYwENi1dJvYHNZBFQlFuz8CtbNK2An0bpvMzvEPnmJ/QfPgsU5BewlXmzc
	xAhRIyhxcuYTFhCbGaimeetsZpAFEgLbOSXuNBxghWh2kbje2AY1SFji1fEtULaMxOnJPSwQ
	dr7Eg62fmCHsGomdPcehbGuJO+d+sXUxcgAt0JRYv0sfIuwoca19CSNIWEKAT+LGW0GIE/gk
	Jm2bzgwR5pXoaBOCqFaTmNrTC7f03IptTBC2h8STTbOZJzAqzkLyzCwkz8xC2LuAkXkVo3hq
	aXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYGo8/e/41x2MK1591DvEyMTBeIhRgoNZSYRXbfup
	dCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8i/a3pgsJpCeWpGanphakFsFkmTg4pRqYiniMagyZ
	1wSvXPzjgk1hSdITx6dsAgU2fw6fFDHMEO7ZrvtlZ7nlNof9URuvWLcvWzJ9goLtC5/odev6
	PRXTFDYVn+9Zrns2qZ2pyY3tfItRSIO/xb7s5mksZYqLcrqOFWjLTJh971cUv7q74SmOCQ9f
	d23geF4ns0Uv+Vk1t/zDDxMr/j7OZ7Z5v+fV11qZsGrDE1s3hTf82/f4zlqx/XmLFwRbyl1L
	qpmhprhbg6PKYJqG8prFHYozKpc3Fh/qlJ7E6LyyXEHjkfptFhlP/qat1zgZC1fMj1b5xtP+
	f2qW1LcrRkfc4jt6/O7znz7GLKHb92u/hnktzyqxWz517bdf7dNuyLlnt0t563IlluKMREMt
	5qLiRAAJmBEE/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qzV51LN/i4jcvi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz2Pt6K7vF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7J4ebmH2aJtFr/F/z072C2Orw23aNk/hcVB2OPNy5csHoc7vrB73DsxjdVj
	06pONo871/aweWxeUu/RsvYYk8f7fVfZPPq2rGL0uNR8nd3j8ya5AO4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzvexUL+nkr/qz/wdjA2Mvd
	xcjJISFgIjHx2DSWLkYuDiGBpYwS63tvsEMkZCSudb9kgbCFJf5c62KDKHrFKLHh/2ZGkASb
	gJHEg+XzWUESIgILmSSuTtnADJJgFnjKKLHthjiILSzgIbFq6TewBhYBVYkFO7+C1fAK2Em0
	7tsMtU1eYv/Bs2BxTgF7iRcbN4HVCwHV7Oh+xwpRLyhxcuYTFoj58hLNW2czT2AUmIUkNQtJ
	agEj0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAGN527OeWHYwrX33UO8TIxMF4iFGCg1lJ
	hFdt+6l0Id6UxMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4HJpG8knhDMwNTQxMzSwNTSzNjJXFe
	tivn04QE0hNLUrNTUwtSi2D6mDg4pRqYprotOr3vzcE1J+b+eCrxyDj7ef/l6rMaPS+fdvE+
	b9idZihsqJDJ2SVsuEfMYFHTrh9nvPynT6qR4Lk9LW32c3Ur7cnvctU+pnC7GVxd2KFYu+Tx
	x706kpecNEVaGztEmr4demb5oePy50dahZdzaud/YBRbP6v984dFpV02vPvN3MpyZzCZZefL
	zPq954ONmjuHiYmykZjo++flhfKhxW8M2yPfXTvZsnNKS8lplb48e93T/W/uSJXd5c3ve+4q
	L3fEy0VWhGNyjVFuzAyG2wxWXbFiAYsvL5gvanLBK+DOE/GeHdaMNo5q0fsOzn2XI/Z6w8X5
	kdyr7FkesLMxu6UV/U3N9om4Ef/j2wclluKMREMt5qLiRACf6oHXagMAAA==
X-CMS-MailID: 20250310090219eucas1p14066b32edfec12b55de972f76b641f6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250310090219eucas1p14066b32edfec12b55de972f76b641f6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250310090219eucas1p14066b32edfec12b55de972f76b641f6f
References: <20250310090211.286549-1-m.wilczynski@samsung.com>
	<CGME20250310090219eucas1p14066b32edfec12b55de972f76b641f6f@eucas1p1.samsung.com>

Add power domain ID's for the TH1520 SoC power domains.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                   |  1 +
 .../dt-bindings/power/thead,th1520-power.h    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 27fdf3d6a5c7..efef657ee528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20438,6 +20438,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
+F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
 
 RNBD BLOCK DRIVERS
diff --git a/include/dt-bindings/power/thead,th1520-power.h b/include/dt-bindings/power/thead,th1520-power.h
new file mode 100644
index 000000000000..8395bd1459f3
--- /dev/null
+++ b/include/dt-bindings/power/thead,th1520-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2022 Alibaba Group Holding Limited.
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_TH1520_H
+#define __DT_BINDINGS_POWER_TH1520_H
+
+#define TH1520_AUDIO_PD		0
+#define TH1520_VDEC_PD		1
+#define TH1520_NPU_PD		2
+#define TH1520_VENC_PD		3
+#define TH1520_GPU_PD		4
+#define TH1520_DSP0_PD		5
+#define TH1520_DSP1_PD		6
+
+#endif
-- 
2.34.1



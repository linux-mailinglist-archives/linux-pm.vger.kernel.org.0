Return-Path: <linux-pm+bounces-24996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7CA8210F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954A5178BD3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB2C25D550;
	Wed,  9 Apr 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iWXrOCcg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4724248864
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191042; cv=none; b=aazP4lzc1AyNond1Ha8bA1hjQiAIq1eKpfEEGbvK3cQSlD1auLqgh5OFMfM3NC+HXLilnBjAJ9QAlo6YIJHwcpdM25jTfkXVP4R0LiFy11wRj9a7H9uAUnluDKnvDdVr89xI2yusePiYskX55rPK5xSWWwpRG6JJJNWzRb+s/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191042; c=relaxed/simple;
	bh=7wL4E05FtmOGtchLqTbespinD+RMGeZFWYZwqXoygU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BwUz2AWbpZakYkoDl7t5tpQfCtK6Pl8U10Zvh2aYwqjM4r44pHGTSM6Ab+6vsFiH/8ySb/805YcwQzbWgb4rqkOPhRn/e2q7MW+SThPwXo+SopdXD60dCC3anbDkfMBsOT+/kW0/PlYi4iq0Rfk5JTwcDlzahg67V/41hu0ifQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iWXrOCcg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409093032euoutp0238d23ed45022cff825115c9d85217ae2~0nIDPkIX42436024360euoutp02J
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409093032euoutp0238d23ed45022cff825115c9d85217ae2~0nIDPkIX42436024360euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744191032;
	bh=88zMioXKvGiPwz2QxAEuRNy3/tBRFkE1bR0qzT2Lpig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWXrOCcgXe/cPwuzJVEasnM75V7KsGudX62SmFrT0/uKtV0wKTSD/ukDpKpPtS86F
	 7cFhbrJGQaFxYG/hDbchuK7hcKnlU3Sl+U4eqEy5CEXXwWUrKlZKYZkRPoptVoH9SR
	 FNw+p8IJXPzAaBWWVt6x5Qaf29ox6HRu4d/PrIoI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250409093032eucas1p107e913db3af978c7ba200f11a67fc3e9~0nIC6r3r_2500725007eucas1p1d;
	Wed,  9 Apr 2025 09:30:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.6D.20409.83E36F76; Wed,  9
	Apr 2025 10:30:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab~0nICdcljH1931419314eucas1p1A;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250409093031eusmtrp2451d5156809499af4eb9147d35d3dec8~0nICcicCv2888728887eusmtrp2W;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-4b-67f63e38fa6b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.2D.19654.73E36F76; Wed,  9
	Apr 2025 10:30:31 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409093031eusmtip2971b7ac4857a25cc513aa322db744f80~0nIBvcpd12903329033eusmtip2G;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, ulf.hansson@linaro.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 2/2] pmdomain: thead: Add GPU-specific clock and reset
 handling for TH1520
Date: Wed,  9 Apr 2025 11:30:25 +0200
Message-Id: <20250409093025.2917087-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409093025.2917087-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7oWdt/SDXYuFrJYs/cck8W9S1uY
	LF7sbWSxeDnrHpvF5V1z2Cw+9x5htNj2uYXNYu2Ru+wW67/OZ7K4e+8Ei8X/PTvYLY6vDbdo
	2T+FxYHXY9OqTjaPO9f2sHlsXlLv0bL2GJNH/18Dj/f7rrJ59G1ZxejxeZNcAEcUl01Kak5m
	WWqRvl0CV8b0e2vZCzbpVjxfVdbA+Ey1i5GTQ0LARGJxw2TmLkYuDiGBFYwS99b/Y4dwvjBK
	dHTtYYJwPjNKHJl8lBWmZdbSWVAtyxklHiyZxAjhvGGUuP5xNztIFZuAkcSD5fNZQRIiAnsZ
	JTpPfQBrYRboZpRYu+0G2CxhgXiJO/Mns4DYLAKqEt/2bWUGsXkF7CVO9LQzQuyTl9h/8CxY
	nFPAQeJQzwl2iBpBiZMzn4D1MgPVNG+dDbZAQuAHh8Th5zfYIJpdJG5M62SGsIUlXh3fwg5h
	y0j83zmfCcLOl3iw9RNUTY3Ezp7jULa1xJ1zv4DmcAAt0JRYv0sfIuwoMf/xDBaQsIQAn8SN
	t4IQJ/BJTNo2nRkizCvR0SYEUa0mMbWnF27puRXboJZ6SBx+ep5tAqPiLCTPzELyzCyEvQsY
	mVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJrDT/45/2cG4/NVHvUOMTByMhxglOJiV
	RHjfTvySLsSbklhZlVqUH19UmpNafIhRmoNFSZx30f7WdCGB9MSS1OzU1ILUIpgsEwenVAMT
	Y/+XDfs8zocwTVWzFMsrPjU97dfDkvNf879aMX48dyo6u/FZQaXcybrcSAfP1SwTxdatNrqn
	axCxVHdBptetNUwmu5kyRYISnqvc+81arvtztfDiMM/dr3c8VVVOY5/a8fndv+QJqcohSdmq
	MlIXvvGqpp+Nueh98smDO3oCCVpLsm9ynNoarpahcXaK1OkdUQGzGhgyIjfxb9Zy32GcHfml
	pmx3RUbtNHaxb04su35LdRYp1nO8cjr279mNc7Xh4cnsP+1c1ddlmhV8LLpYzM60UPgQp61F
	2aOkuxw1i7M6QrZf+3RZ47T0Mtm7uyes4OcLrz0bojbFdKrc+ThfmwKrovWLFxd1aM88t1yJ
	pTgj0VCLuag4EQCfGyIgzwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rmdt/SDbp/GVms2XuOyeLepS1M
	Fi/2NrJYvJx1j83i8q45bBafe48wWmz73MJmsfbIXXaL9V/nM1ncvXeCxeL/nh3sFsfXhlu0
	7J/C4sDrsWlVJ5vHnWt72Dw2L6n3aFl7jMmj/6+Bx/t9V9k8+rasYvT4vEkugCNKz6Yov7Qk
	VSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P6vbXsBZt0K56v
	KmtgfKbaxcjJISFgIjFr6SzmLkYuDiGBpYwSV5Y/ZIJIyEhc637JAmELS/y51sUGUfSKUWLO
	8d/sIAk2ASOJB8vns4LYIgInGSXuvqoDKWIW6GeUmPrxClhCWCBW4mrzb0YQm0VAVeLbvq3M
	IDavgL3EiZ52RogN8hL7D54Fi3MKOEgc6jkBtkAIqObSmzVMEPWCEidnPgG7iBmovnnrbOYJ
	jAKzkKRmIUktYGRaxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERhp24793LKDceWrj3qHGJk4
	GA8xSnAwK4nwvp34JV2INyWxsiq1KD++qDQntfgQoynQ3ROZpUST84GxnlcSb2hmYGpoYmZp
	YGppZqwkzst25XyakEB6YklqdmpqQWoRTB8TB6dUA1PH1NN7O7NauScZ7J++2OL+Fx0f9TuX
	puSsmWpzNnX6zAmB3890aPG58r3vYm6o1T1r1unik3h9yyodS8aPmTned0zUlV8/YjqdtuyU
	Gesil2vuNnlO20NnisWJJrDMcdO/e1dqDfdRgadN23jUbFtzjoRdm97BftpQd+/5tSfc33zP
	zhc8Z2u0Rt636U3837RXPy53GJtWL+/LcCl0+W1nc3fDNqUVNZ6NH87xPYn6K1f/NiS4UtnA
	xbN5guCcs4WFAR84Fr7fZ7Lh0D2ZN/c3W7nXZ7/fczV/wye5efPMGfOe6pkIXUrlq3s3a/Pn
	6d8ZbrbxrBXs87pQuiVIdUW7H+/tp7GOZ5q7Ljy89UiJpTgj0VCLuag4EQB6y0gPPQMAAA==
X-CMS-MailID: 20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab
References: <20250409093025.2917087-1-m.wilczynski@samsung.com>
	<CGME20250409093031eucas1p1ee277da31b7de9a16f6b7345df6a89ab@eucas1p1.samsung.com>

Extend the TH1520 power domain driver to manage GPU related clocks and
resets via generic PM domain start/stop callbacks.

The TH1520 GPU requires a special sequence to correctly initialize:
- Enable the GPU clocks
- Deassert the GPU clkgen reset
- Delay for a few cycles to satisfy hardware requirements
- Deassert the GPU core reset

This sequence is SoC-specific and needs to be abstracted away from the
Imagination GPU driver, which expects a standard single reset line.
Following discussions with kernel maintainers, this logic is placed
inside a PM domain instead of polluting the clock or reset frameworks,
or the GPU driver itself [1].

Managing this inside a generic power domain allows better coordination
of clocks, resets, and power state, and aligns with the direction of
treating PM domains as SoC-specific "power management drivers".

[1] - https://lore.kernel.org/all/CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com/

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pmdomain/thead/th1520-pm-domains.c | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index f702e20306f4..aa85c3954c39 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -5,17 +5,29 @@
  * Author: Michal Wilczynski <m.wilczynski@samsung.com>
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/firmware/thead/thead,th1520-aon.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/reset.h>
 
 #include <dt-bindings/power/thead,th1520-power.h>
 
+#define TH1520_GPU_RESET_IDX 0
+#define TH1520_GPU_CLKGEN_RESET_IDX 1
+
 struct th1520_power_domain {
 	struct th1520_aon_chan *aon_chan;
 	struct generic_pm_domain genpd;
 	u32 rsrc;
+
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control_bulk_data *resets;
+	int num_resets;
+
 };
 
 struct th1520_power_info {
@@ -61,6 +73,99 @@ static int th1520_pd_power_off(struct generic_pm_domain *domain)
 	return th1520_aon_power_update(pd->aon_chan, pd->rsrc, false);
 }
 
+static int th1520_gpu_init_clocks(struct device *dev,
+				  struct th1520_power_domain *pd)
+{
+	static const char *const clk_names[] = { "gpu-core", "gpu-sys" };
+	int i, ret;
+
+	pd->num_clks = ARRAY_SIZE(clk_names);
+	pd->clks = devm_kcalloc(dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
+	if (!pd->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < pd->num_clks; i++)
+		pd->clks[i].id = clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, pd->num_clks, pd->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get GPU clocks\n");
+
+	return 0;
+}
+
+static int th1520_gpu_init_resets(struct device *dev,
+				  struct th1520_power_domain *pd)
+{
+	static const char *const reset_names[] = { "gpu", "gpu-clkgen" };
+	int i, ret;
+
+	pd->num_resets = ARRAY_SIZE(reset_names);
+	pd->resets = devm_kcalloc(dev, pd->num_resets, sizeof(*pd->resets),
+				  GFP_KERNEL);
+	if (!pd->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < pd->num_resets; i++)
+		pd->resets[i].id = reset_names[i];
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, pd->num_resets,
+						    pd->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get GPU resets\n");
+
+	return 0;
+}
+
+static int th1520_gpu_domain_start(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
+	if (ret)
+		goto err_disable_clks;
+
+	/*
+	 * According to the hardware manual, a delay of at least 32 clock
+	 * cycles is required between de-asserting the clkgen reset and
+	 * de-asserting the GPU reset. Assuming a worst-case scenario with
+	 * a very high GPU clock frequency, a delay of 1 microsecond is
+	 * sufficient to ensure this requirement is met across all
+	 * feasible GPU clock speeds.
+	 */
+	udelay(1);
+
+	ret = reset_control_deassert(pd->resets[TH1520_GPU_RESET_IDX].rstc);
+	if (ret)
+		goto err_assert_clkgen;
+
+	return 0;
+
+err_assert_clkgen:
+	reset_control_assert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
+err_disable_clks:
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	return ret;
+}
+
+static int th1520_gpu_domain_stop(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct th1520_power_domain *pd = to_th1520_power_domain(genpd);
+
+	reset_control_assert(pd->resets[TH1520_GPU_RESET_IDX].rstc);
+	reset_control_assert(pd->resets[TH1520_GPU_CLKGEN_RESET_IDX].rstc);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+
+	return 0;
+}
+
 static struct generic_pm_domain *th1520_pd_xlate(const struct of_phandle_args *spec,
 						 void *data)
 {
@@ -99,6 +204,20 @@ th1520_add_pm_domain(struct device *dev, const struct th1520_power_info *pi)
 	pd->genpd.power_off = th1520_pd_power_off;
 	pd->genpd.name = pi->name;
 
+	/* there are special callbacks for the GPU */
+	if (pi == &th1520_pd_ranges[TH1520_GPU_PD]) {
+		ret = th1520_gpu_init_clocks(dev, pd);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = th1520_gpu_init_resets(dev, pd);
+		if (ret)
+			return ERR_PTR(ret);
+
+		pd->genpd.dev_ops.start = th1520_gpu_domain_start;
+		pd->genpd.dev_ops.stop = th1520_gpu_domain_stop;
+	}
+
 	ret = pm_genpd_init(&pd->genpd, NULL, true);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.34.1



Return-Path: <linux-pm+bounces-20702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9558A17144
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477AA3A2C0E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383F1EE002;
	Mon, 20 Jan 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IL0l1jDd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A615B102
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393689; cv=none; b=n9DvvnCDoLkttSDzr176F+xbzL6sRBHPvxzhYokoZGQBOF5VJUNwsJS5G6R0K9zDUak2V7klE1uqrM3jOoEVlrkJJbqyppt5cEzsNBb/9ga2tKea6e94FOuXrTHFeqPKDbkuIASh02LakuHmjFKtKmN08JvflJAFfJlkbRM/p4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393689; c=relaxed/simple;
	bh=nIRBE3eoRZyhcsS83Bi5bDzwelGwhfEo19MH8clsRUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VsmUa+zEHm/5VdfSJDn3T62fwTI5/gRI42g1DuX07zWazLh2AqZgEVYO6qdNCU93N161LxRJPPIqaIgSkGwxhUOrAAuC44KwgkkgIFSxlVE1T+31AHLlM5OUcwakvisKkns7zMrs+qIlheH28mvME3mSqWhwDiR0YivXb1kUbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IL0l1jDd; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172122euoutp02ed3ae1703002721afb15d8c91ace1022~cdllR2vkp1370613706euoutp02G
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250120172122euoutp02ed3ae1703002721afb15d8c91ace1022~cdllR2vkp1370613706euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393682;
	bh=75pm72ggHUIqP3+dethg3BurkDTyHOTsalwjt+PQCA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL0l1jDd3R8nicKIRpo0WJN0kbh0LAJa1x6f+EAHXOzhFFpASosneI9lOV9gk3qCh
	 NM/bX+1JpoBQC61sONUsD9DxCa2BMtM+KCcfpo/cOOWQHKUsWpNdLHUcvNykvorRnD
	 pB2GQvM8LqtUjQpTdteT1VfP8JDpFXVxOOhhVq2M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250120172121eucas1p1f93550ca5c3e7ec69557cf12bb56f3e3~cdlktPaRl2176121761eucas1p12;
	Mon, 20 Jan 2025 17:21:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.7B.20821.1168E876; Mon, 20
	Jan 2025 17:21:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b~cdljvebjP1089210892eucas1p2v;
	Mon, 20 Jan 2025 17:21:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172120eusmtrp2828d30292814060899a01fa45f60c4d7~cdljtAqTQ0490804908eusmtrp2X;
	Mon, 20 Jan 2025 17:21:20 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-fd-678e86115997
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.95.19654.0168E876; Mon, 20
	Jan 2025 17:21:20 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172119eusmtip1a1bb99905ece7dc819bf973c83cd0780~cdliVh0BW1307113071eusmtip1M;
	Mon, 20 Jan 2025 17:21:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC v3 01/18] dt-bindings: clock: Add VO subsystem clock
 controller support
Date: Mon, 20 Jan 2025 18:20:54 +0100
Message-Id: <20250120172111.3492708-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffe3luaAZcK8wyIGxi2TDcee5iDPBRQc6bLdFucxmSRZtwU
	AxTTwjZEI6U8BNuKzsks8pwbb5nYMkpEtEMKc7KBAm6TR3hM6EDW8vBBhFFu3fzv+/39Puf3
	/f2SIyTFP9KewoOyJE4uk8T70iKqoe3xr2+6ZWmlgeldPqi9r4xAhgUdg2qaOwlU3NopQAPd
	egLdmZum0cWx3xg03qykUG9FIYNUbXU0mtAN0MiqHhCg203naTSjaQWoYSaDRrWt/Qyqmysm
	UKnVQKELjU0AZeV8L0BdP29D/QPtFJq4rSZRls4VLV1pZNBi7yUKFTxoYZB+8pQAmWv3ooyW
	M9SWtXj6biaDJycmKPzT8VkGN8+XUNio62ew2vgLwPVVOTS+13uFxkUdH+LBE2YCX75wDGfU
	thH45NNAPH21h8ZafRXA3ao+Zrd4vyg0hos/+DknDwiPFsWmX1sSHPrT88uzTUoqDUx45AIn
	IWTfgbPt1UQuEAnFbAWAuSNDDG9mAVyYt5C8mQEw/1oN+ezJZc1XDqocQMviqIOaBPC+qhbY
	KZp9Cw6VFwvsDXc2k4KZN5TAbkj2PoANo+dpO7Wa3QtVep3ArinWDxYZtCsZzuxmaCu4SPN5
	L8OW67dW6k7sFviwp5nhGTfYcW6UsmtymVEZClbWgGytCPYMnl5OEy6brXBsgePnrIYWs57h
	tTdcMhYTvE6EQwab47Yj0Kg2O3QIvNf5hLaPIdnXYV1TAF+OgHkFJ0h+ugu8O+XGb+ACTzfk
	O8rO8HiWmKdfhV+rNf+FdlY0OEIx7Bm3CvKAj+65W3TP3aL7P7cEkFVgDZesSJByiiAZ94W/
	QpKgSJZJ/T9LTKgHy3/75qLZ1ggKLVZ/EyCEwASgkPR1d/b4Ry0VO8dIUg5z8sQD8uR4TmEC
	XkLKd41zWUumVMxKJUlcHMcd4uTPuoTQyTONiNDu6I7fr4k+ctPkmhyZ7yRLtb7XY0mX7IsO
	uxFRoA8c/iSo73qUdtuqt7GqZL3n7x7q0sPFhHflcH/lGwEfnfu4e7tryUmqMa7GFiwY0Wb7
	T8nLBoerh27tyPGKjokMAqVDm+asm89Wz35XlDobbvp2o6G7nH08hfFwMJfw4saQv/dcrdke
	ht/dM5aEo0oGXzhKhISvioh7/+krD0/didzwaZRE+USp7bhUH/Gaqhzk+Xzj/0f0Mc1fZZbK
	Kp/QFP2uR8px77Cu1E3e5l1+Z0J3j7jtLJeYhNnZ7ujR1g3V+35waUvJMa71wg+8ucLsIL91
	L/WlMbbg2MkD8wMfjPkc1fhSilhJ0HpSrpD8C9igPU9KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7oCbX3pBqfWSVmcuL6IyWLr71ns
	Fmv2nmOymH/kHKvFvUtbmCyufH3PZrHu6QV2ixd7G1ksrq2Yy27RfGw9m8XLWffYLD723GO1
	uLxrDpvF594jjBbbPrewWaw9cpfdYv3X+UwWCz9uZbFYsmMXo0Vb5zJWi4unXC3u3jvBYvHy
	cg+zRdssfov/e3awW/y7tpHFYva7/ewWW95MZLU4vjbcomX/FBYHOY/3N1rZPd68fMnicbjj
	C7vH3m8LWDx2zrrL7tGz8wyjx6ZVnWwed67tYfOYdzLQ4373cSaPzUvqPVrWHmPy6P9r4PF+
	31U2j74tqxg9LjVfZw8QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
	SUnNySxLLdK3S9DLaDrwn7XgtlTFtF2NLA2ML0W7GDk5JARMJDb3TmYHsYUEljJKXPodCRGX
	kbjW/ZIFwhaW+HOti62LkQuo5hWjxJMNv1lBEmwCRhIPls8Hs0UEFrNI7N1XCVLELPCWUeL6
	zI1g3cICoRKzH/1mBLFZBFQl5m3tYwaxeQXsJT7NXscGsUFeYv/Bs2BxTgEHie9X90JdZC9x
	52o3I0S9oMTJmU/AZjID1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS
	83M3MQLTy7ZjP7fsYFz56qPeIUYmDsZDjBIczEoivKIfetKFeFMSK6tSi/Lji0pzUosPMZoC
	3T2RWUo0OR+Y4PJK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCUamDq
	T5PyE2abqnhyr+qBi2a/eU7dvbZsiRSrf/wma7HvHMWnBc0rdfI6z71XkbG/let12d2Rbd3p
	LOEy+8l1y6/Vx1xZL6/D1tjxhuHrCzmjp5d4Q1SWN/LFfbvZ9HhDp/XFF1LV6wUfbdN7P33x
	DpvF5/QPf150eAVT0frG010i7TwnN3hMXN7T6vTnm8fy5VqP9M+fPMG46ER9xDLP3UVnDlc5
	b1HZ5fJSKezIPwFfdvfSo5GGcqtF+tJFlm+vePuu/NVO1vAz9mdPrZipwba5bt3C95MKpDYf
	rY2MNWY2X2d+SjQr/Gm78g0W1q/v2s0/F4nETgj4L/91U9ceLuk/zysLfxvz67+WfLWtIPG4
	EktxRqKhFnNRcSIAg8FS+7gDAAA=
X-CMS-MailID: 20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b@eucas1p2.samsung.com>

Add a separate compatible string "thead,th1520-clk-vo" to describe the
Video Output (VO) subsystem clock controller in the T-Head TH1520 SoC.
The VO subsystem configures the clock gates for HDMI, MIPI, and GPU
components. Meanwhile, the existing AP sub-system clock controller
remains responsible for the CPU, DPU, GMAC, and TEE PLLs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml   | 16 +++++++--
 .../dt-bindings/clock/thead,th1520-clk-ap.h   | 33 +++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
index 0129bd0ba4b3..e9ee8152ed5a 100644
--- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -8,7 +8,8 @@ title: T-HEAD TH1520 AP sub-system clock controller
 
 description: |
   The T-HEAD TH1520 AP sub-system clock controller configures the
-  CPU, DPU, GMAC and TEE PLLs.
+  CPU, DPU, GMAC and TEE PLLs. Additionally the VO subsystem configures
+  the clock gates for the HDMI, MIPI and the GPU.
 
   SoC reference manual
   https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
@@ -20,14 +21,16 @@ maintainers:
 
 properties:
   compatible:
-    const: thead,th1520-clk-ap
+    enum:
+      - thead,th1520-clk-ap
+      - thead,th1520-clk-vo
 
   reg:
     maxItems: 1
 
   clocks:
     items:
-      - description: main oscillator (24MHz)
+      - description: main oscillator (24MHz) or CLK_VIDEO_PLL
 
   "#clock-cells":
     const: 1
@@ -51,3 +54,10 @@ examples:
         clocks = <&osc>;
         #clock-cells = <1>;
     };
+
+    clock-controller@ff010000 {
+        compatible = "thead,th1520-clk-vo";
+        reg = <0xff010000 0x1000>;
+        clocks = <&clk CLK_VIDEO_PLL>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk-ap.h
index a199784b3512..470fa34f9a9d 100644
--- a/include/dt-bindings/clock/thead,th1520-clk-ap.h
+++ b/include/dt-bindings/clock/thead,th1520-clk-ap.h
@@ -93,4 +93,37 @@
 #define CLK_SRAM3		83
 #define CLK_PLL_GMAC_100M	84
 #define CLK_UART_SCLK		85
+
+/* VO clocks */
+#define CLK_AXI4_VO_ACLK		0
+#define CLK_GPU_CORE			1
+#define CLK_GPU_CFG_ACLK		2
+#define CLK_DPU_PIXELCLK0		3
+#define CLK_DPU_PIXELCLK1		4
+#define CLK_DPU_HCLK			5
+#define CLK_DPU_ACLK			6
+#define CLK_DPU_CCLK			7
+#define CLK_HDMI_SFR			8
+#define CLK_HDMI_PCLK			9
+#define CLK_HDMI_CEC			10
+#define CLK_MIPI_DSI0_PCLK		11
+#define CLK_MIPI_DSI1_PCLK		12
+#define CLK_MIPI_DSI0_CFG		13
+#define CLK_MIPI_DSI1_CFG		14
+#define CLK_MIPI_DSI0_REFCLK		15
+#define CLK_MIPI_DSI1_REFCLK		16
+#define CLK_HDMI_I2S			17
+#define CLK_X2H_DPU1_ACLK		18
+#define CLK_X2H_DPU_ACLK		19
+#define CLK_AXI4_VO_PCLK		20
+#define CLK_IOPMP_VOSYS_DPU_PCLK	21
+#define CLK_IOPMP_VOSYS_DPU1_PCLK	22
+#define CLK_IOPMP_VOSYS_GPU_PCLK	23
+#define CLK_IOPMP_DPU1_ACLK		24
+#define CLK_IOPMP_DPU_ACLK		25
+#define CLK_IOPMP_GPU_ACLK		26
+#define CLK_MIPIDSI0_PIXCLK		27
+#define CLK_MIPIDSI1_PIXCLK		28
+#define CLK_HDMI_PIXCLK			29
+
 #endif
-- 
2.34.1



Return-Path: <linux-pm+bounces-22428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505BA3C152
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CB0168002
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212501F1818;
	Wed, 19 Feb 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LD+X4e9e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E11F130C
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973776; cv=none; b=Bv1cnOoY/ug/SatVyBT9ynfdO5wr4rpNihthd9T0OAF9tDavSgrVZDtvlFVsm2rfO+ArzwVFjPMQTIwlwmMUiqdUdDCUVIhJF5Ab7Hvblrkzv57JxQS3BISxhPDCYQ5NjE5WuP7nwz/+6dP0/HL97YWxN8d7DVR/DSa2ZpnO4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973776; c=relaxed/simple;
	bh=oEzLfFZJH4LxRYAt4dHQDVjJIWaaUZych4wvP4WFyoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mlqKhk18wlP99jRCsUbzaVfVKD8YbyiPNHDoGgrtkHYYRSOpMCbFw48u5Rq9jV9OKCq31kPbeQ/4of8rSmS0WOATgxCwop/ceQrgKTdn+tfvZofkKLpiGpMStty36Hz+Gmb2tqHbtz3Yk6IBLEWADbgJOEuUWIT7I2V+0Ne/b50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LD+X4e9e; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140252euoutp02fc7965ac88a619da7b21d59c07888ccb~loO1MyuxM0177601776euoutp02G
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250219140252euoutp02fc7965ac88a619da7b21d59c07888ccb~loO1MyuxM0177601776euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973772;
	bh=uo7s5XP9xLCcaXV6zS5at5CrZeY48gYb8finhktiqJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LD+X4e9em9WJylhofuniR3Axa7TTJGtCp5mBu3YW5Fi1xSG9ay7d8JTUhAYXw49Ho
	 EoEvZB/D3s0C+dZiZnWyWNjCBQQ8nwIXf/VSnft7u5Y7L4084v1QXCNmfNvKbDFGwQ
	 aEsCvufBkIJaZAxCTBEj4eVXMd/GNhnMYfNF/AFc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140251eucas1p1af357e5281ba396a4d6369a7305587c6~loO0srYhE1246212462eucas1p1G;
	Wed, 19 Feb 2025 14:02:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.72.20397.B84E5B76; Wed, 19
	Feb 2025 14:02:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140250eucas1p2e099f0f15ce0342f816ae15666e3e2f9~loO0GUseq1970819708eucas1p2u;
	Wed, 19 Feb 2025 14:02:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250219140250eusmtrp1801e2278c4db1da2a8bba7c6a671a3b6~loO0FZLAD2416524165eusmtrp1K;
	Wed, 19 Feb 2025 14:02:50 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-b5-67b5e48b35f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.76.19920.A84E5B76; Wed, 19
	Feb 2025 14:02:50 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140249eusmtip2e60405385117c7a2ec12b5af0b18e71d~loOyqS8N10094500945eusmtip2x;
	Wed, 19 Feb 2025 14:02:49 +0000 (GMT)
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
	<m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 01/21] dt-bindings: clock: thead: Add TH1520 VO clock
 controller
Date: Wed, 19 Feb 2025 15:02:19 +0100
Message-Id: <20250219140239.1378758-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BUZRjG+845e87ZraXjso6fUJI0mjHIpRj7TFJMHQ7ZMF2GCLRgg9NK
	sAvtipZjg7RAAguairorCCqTgCDmXrgEkguyErJyEbAQpISJVZLlsk5KWS4Hy/+e9/l+7/u8
	78xH45J60oNOUG7nVEpZkjcpIsyt96+uzB0xyQNGi5agy/0nMWSa1VOostGGoeIWmwANdRsx
	dM05QaKzo50UGmtMJ1BfWRGFNK3VJLLrh0jUeMdEoUntkAD11BeSaDqvBSDzdAaJqloGKVTt
	LMbQiUkTgUpr6wHKyv5OgLp+2oQGhy4TyN6jxVGW/ln0T0MthR72fU+gY3ebKGQc/1aArFWR
	KKPpEBHixU5cz6TYcbudYJv3zlBs470Sgq3TD1Kstu4KYM9XZJPsjb4Gkj3e9i57M9eKsYbS
	NDajqhVj9/0dwE5c6CXZfGMFYLs1/dQ7kmhRcDyXlLCDU/mvjRVtO3TnZ5BydskXJbpCwR7Q
	B3OAkIZMEOwomaVygIiWMGUA/latE/DFDIAn7p+bL6YBPPVLOv64pbFcQ7q0hDkN4OGarTw0
	DmDrD1NzEMm8AodPF891S5lMAmZeSgeuAmeKMXjmgW6Ocmci4M0OA5YDaJpglkF7ZZjLFjPr
	4K1mG8GnecGmix24CxEyIfBClwePLIBtupE5BH+EaEzHcNd4yJhEsKO9neR7N8I6+wDgtTu8
	bTVSvH4Oth/Uzs9PhsOmqfnLdsM6rXVer4E3bA9IVy7OvAyr6/15ez08U1dOuGzIuMHrfyzg
	V3CDB8xHcN4Ww71ZEp5eDgu0ef+F2srMGK9ZOH30LrEfLNU/cYz+iWP0/+eWALwCLOJS1Qo5
	p35Vye30U8sU6lSl3C8uWXEePPre7Q+tzlpQdnvSzwIwGlgApHFvqTgrzSiXiONlX+7iVMkx
	qtQkTm0BnjThvUh8silTLmHksu1cIselcKrHrxgt9NiD+YZEGl6LK/04wHhwZX5NuE3zTUxc
	zvMeP0b7RyW4Ey9aPfeNHXhBMbJwC/5Mc4nj6dyM46sLbn3uWBWGB2YGegZryocL90de2WJz
	XG2JEL25qq1/VpmWWJqIeYmponVk1ObX25K37qS+DpVOeubeeyo8PCUs/63Y8fDk9W8sXNy/
	IXQ6OH7gJXVXvSMidXXo78WOXVErhNKNusPSvChfe3YPLHjftLa/MvpP69LdTTWxmyTmDwfe
	phP9FL7LlYvxoD6f0fKPDBUNH4RYLq0J2HFqzKen8pP3LF+t6OrpdLptPjcjnPrMoAj6S+dw
	/xXZhP7imN5lgZ3XPpX2dhcNXtQ744civAn1NlmgD65Sy/4Fj0TrFk0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xe7pdT7amG6xermNx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js9j7eiu7
	xceee6wWl3fNYbP43HuE0WLb5xY2i7VH7rJbrP86n8li4cetLBZLduxitGjrXMZqcfGUq8Xd
	eydYLF5e7mG2aJvFb/F/zw52i3/XNrJYzH63n91iy5uJrBbH14ZbtOyfwuIg7/H+Riu7x5uX
	L1k8Dnd8YffY+20Bi8fOWXfZPXp2nmH02LSqk83jzrU9bB7zTgZ63O8+zuSxeUm9R8vaY0we
	/X8NPN7vu8rm0bdlFaPHpebr7AFCUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
	RqZK+nY2Kak5mWWpRfp2CXoZU17fZCxYJ1exYOYc1gbGaxJdjJwcEgImEntXNrOB2EICSxkl
	zm93g4jLSFzrfskCYQtL/LnWBVTDBVTzilGiY/12RpAEm4CRxIPl81lBbBGBxSwSe/dVghQx
	Cyxlknj0/wDYVGGBYIlz22YwdzFycLAIqEq8XOMJEuYVsJd4fPgc1AJ5if0Hz4KVcAo4SOy7
	KAVxj73Eub77rBDlghInZz4BK2cGKm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfm
	Fpfmpesl5+duYgQmmW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeNvqt6QL8aYkVlalFuXHF5Xm
	pBYfYjQFunois5Rocj4wzeWVxBuaGZgamphZGphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPH
	xMEp1cCkk+/xz0rmyXepuQKhuafzcy802q8tmvp/C8dfM3fxV8d+y/OvCQoMrWVh3fZHzbLw
	NOu1TwcPbXLRL840+JFyrErw3NwToTbBfgdCPgmujU3+G+fTkXqpc6+ss0+P3wzd45FejAFH
	ToYFykxjcAhde+jZ31mz259O3rZuinv7fs0vASyLZv5+tfLSkze/T6lYbeU7lhI/c/aKx0d/
	Wrkf79di/avwRfrx69MqIgFa6sem/77P9mxfEsOiCVYqi61nXn3AWT89dHHOki15p+ZZdL54
	MeNUr8Tu9P+3lPjbBeKEea/2LQyZ5Ztb6Ku3UG+LB2N7t+l+U0Ed2Ty1Qpfm5ikxTxXF1Jli
	bnlpbZJTYinOSDTUYi4qTgQA0g9DgrsDAAA=
X-CMS-MailID: 20250219140250eucas1p2e099f0f15ce0342f816ae15666e3e2f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140250eucas1p2e099f0f15ce0342f816ae15666e3e2f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140250eucas1p2e099f0f15ce0342f816ae15666e3e2f9
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140250eucas1p2e099f0f15ce0342f816ae15666e3e2f9@eucas1p2.samsung.com>

Add device tree bindings for the TH1520 Video Output (VO) subsystem
clock controller. The VO sub-system manages clock gates for multimedia
components including HDMI, MIPI, and GPU.

Document the VIDEO_PLL requirements for the VO clock controller, which
receives its input from the AP clock controller. The VIDEO_PLL is a
Silicon Creations Sigma-Delta (integer) PLL typically running at 792 MHz
with maximum FOUTVCO of 2376 MHz.

This binding complements the existing AP sub-system clock controller
which manages CPU, DPU, GMAC and TEE PLLs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml   | 17 ++++++++--
 .../dt-bindings/clock/thead,th1520-clk-ap.h   | 34 +++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
index 0129bd0ba4b3..9d058c00ab3d 100644
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
@@ -20,14 +21,24 @@ maintainers:
 
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
+      - description: |
+          One input clock:
+          - For "thead,th1520-clk-ap": the clock input must be the 24 MHz
+            main oscillator.
+          - For "thead,th1520-clk-vo": the clock input must be the VIDEO_PLL,
+            which is configured by the AP clock controller. According to the
+            TH1520 manual, VIDEO_PLL is a Silicon Creations Sigma-Delta PLL
+            (integer PLL) typically running at 792 MHz (FOUTPOSTDIV), with
+            a maximum FOUTVCO of 2376 MHz.
 
   "#clock-cells":
     const: 1
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk-ap.h
index a199784b3512..09a9aa7b3ab1 100644
--- a/include/dt-bindings/clock/thead,th1520-clk-ap.h
+++ b/include/dt-bindings/clock/thead,th1520-clk-ap.h
@@ -93,4 +93,38 @@
 #define CLK_SRAM3		83
 #define CLK_PLL_GMAC_100M	84
 #define CLK_UART_SCLK		85
+
+/* VO clocks */
+#define CLK_AXI4_VO_ACLK		0
+#define CLK_GPU_MEM			1
+#define CLK_GPU_CORE			2
+#define CLK_GPU_CFG_ACLK		3
+#define CLK_DPU_PIXELCLK0		4
+#define CLK_DPU_PIXELCLK1		5
+#define CLK_DPU_HCLK			6
+#define CLK_DPU_ACLK			7
+#define CLK_DPU_CCLK			8
+#define CLK_HDMI_SFR			9
+#define CLK_HDMI_PCLK			10
+#define CLK_HDMI_CEC			11
+#define CLK_MIPI_DSI0_PCLK		12
+#define CLK_MIPI_DSI1_PCLK		13
+#define CLK_MIPI_DSI0_CFG		14
+#define CLK_MIPI_DSI1_CFG		15
+#define CLK_MIPI_DSI0_REFCLK		16
+#define CLK_MIPI_DSI1_REFCLK		17
+#define CLK_HDMI_I2S			18
+#define CLK_X2H_DPU1_ACLK		19
+#define CLK_X2H_DPU_ACLK		20
+#define CLK_AXI4_VO_PCLK		21
+#define CLK_IOPMP_VOSYS_DPU_PCLK	22
+#define CLK_IOPMP_VOSYS_DPU1_PCLK	23
+#define CLK_IOPMP_VOSYS_GPU_PCLK	24
+#define CLK_IOPMP_DPU1_ACLK		25
+#define CLK_IOPMP_DPU_ACLK		26
+#define CLK_IOPMP_GPU_ACLK		27
+#define CLK_MIPIDSI0_PIXCLK		28
+#define CLK_MIPIDSI1_PIXCLK		29
+#define CLK_HDMI_PIXCLK			30
+
 #endif
-- 
2.34.1



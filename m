Return-Path: <linux-pm+bounces-18458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC979E248B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1CFB3DD4D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313321F1316;
	Tue,  3 Dec 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cfkNzmB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390A1F12F1
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233325; cv=none; b=OTQ50SVDboOaIBC3DfaL8rGk7Plh4eeU7wmgQl6Gb76WyCcj5BUPReCxYYJfs8MUSVWq41K+XWYSrIieV8AeTBsxdEmPYMgF/UnnqWH8Pd5MEcl8YtbJ+F91VLtk7oPO8uEaB0JjB5MeaN52nYzJ2YO6VhsMFMArgbydtKM1ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233325; c=relaxed/simple;
	bh=OGLtTxbpTtXaSRXv6pLjTlt1O9CEipR68uf6gA8hz4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HsaNeiuMPMNzvokOxARWJCyNfj/QHQjzKjaz59eR0aE04kR9XZBtc4ONnSQ6oqdr6eKY+UBq4KTBnbkjxwr/ffU5Or+9i0HqJIJB/nxsHQ6FO5YJTQgiLwsJWiPglOu+Zdos7Y6k5Pyst7bRF0UBDx23VZzDz4gRZeJz3V178uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cfkNzmB3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134152euoutp025759033c94724a121c19d3c729384003~NroPB3oE33035030350euoutp02L
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134152euoutp025759033c94724a121c19d3c729384003~NroPB3oE33035030350euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233312;
	bh=+XIFXNOuRC/rcFhjLbJmehyyVGJ3vIOum8KvaMBq9LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfkNzmB3x86Z2xSbjTLmvnC8O8eNK0nCs/UNO4hXeR43ZlTbIL8JsQv/uTHAUl91Y
	 +GovTpLFSZ6ecaGS6Qa/AwM2iAqiDMHUfKFRbIJDCFEmXe5OUR2FUoPI4XMagJYtGY
	 DmsK14Sx30SPI5xxyxFTq4jaT9ZT7LPBrAGDaeLk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241203134151eucas1p1bbd536f1e8d6d8946eb144dedbb9445d~NroObdrzt2130621306eucas1p1F;
	Tue,  3 Dec 2024 13:41:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 3F.7F.20409.F9A0F476; Tue,  3
	Dec 2024 13:41:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b~NroN-p4wm2535425354eucas1p1Z;
	Tue,  3 Dec 2024 13:41:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241203134151eusmtrp207114ab96da6efa994f6550edf24126f~NroN9FfPc3025130251eusmtrp2H;
	Tue,  3 Dec 2024 13:41:51 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-78-674f0a9f0ccf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.C8.19920.F9A0F476; Tue,  3
	Dec 2024 13:41:51 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134149eusmtip22891f5955fca0861755c99081618733c~NroMrXVOB3010130101eusmtip2U;
	Tue,  3 Dec 2024 13:41:49 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 02/14] dt-bindings: clock: thead,th1520: Rename
 header file
Date: Tue,  3 Dec 2024 14:41:25 +0100
Message-Id: <20241203134137.2114847-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTZxzNd+/tvbfNCpfSxE9gYe2ibi7AaAx8RAMuUXITlgBGAllGtJPL
	IzzTwthwDwwPgZUNF4laqwVEy4odGY9aWDsGIy1S7ZxsUDJB4iSuyCA8xeFg1Fs3/zu/8zvn
	O7+TfDQu6SSD6JyCYk5VoMyTkyLCbH/qCtOLErPePmuLQMPjLRjq2dBS6LrNhSH9kEuApu52
	Y+jX1QUSfTtzh0J/2k4RaKztEoUq7B0k8minSLSomRKg0T4diZbrhwAyL1eSyDQ0SaGOVT2G
	mhd7CNRq6QOouvaaAP0ychh5RjU4qtb6oy2rhUKbY98R6OJ8P4W6584IkMOUiir7zxIHX2UX
	3FUUO+fxEOxPNSsUa1trIthe7STFanpvAbbTWEuy98asJHv5ZjJ7/wsHxna1fs5WmuwYu/DD
	byT7ZbcRsHcrxim2y3kyKeA90YEMLi/nQ04VEXtclH2mNa3o9msfXa0cFpQDS3AdENKQ2Qf/
	abxD1AERLWHaAFw1DWD8sAJgo75PwA/LAI65f6deWDb+mKb4hQFA3dQVn2UOwJahHwmvimQU
	cNqgf26XMo9x6F6dIL0DzjwC0PxQR3pVgcxRuLZZjnkxweyCW2Yt8GIxEwdPb93H+LxQ2D9w
	G/diIXMQPm6sE/CaAHjzwsPnafi2pqLnIu4NgIxJBK/XPCF48yG4Puf2PRQIZx3dvhIhcKtX
	7+ML4XTPEs7jT2CvxuHD++E919/bh9LbAW/Cjr4Inn4H2hdchJeGjB90/xXAn+AHvzafw3la
	DGuqJbx6N2zU1P8X6moz+0JZOKubAA1Apn2pjPalMtr/c5sAbgQ7uBJ1fhanVhRwpeFqZb66
	pCAr/ERhfifY/tbOTceKBRhmF8MHAUaDQQBpXC4VGzoSsiTiDOXHZZyq8JiqJI9TD4JgmpDv
	EO/KCOUkTJaymMvluCJO9WKL0cKgcqxkOL5UJrjS6eSM7a+HNPhrEurl+9azkw4rdLGO3qAL
	VcKGRyRHj0h/thV3xc8kTTmsyZ+l2WeMT/VLwvMt8ht9pW+UXFWe3xMcOW6ZDDiSsjej6oGs
	O8wQGJ1Q5Oz35AkTYw+1t2QWZF+yeKy6qvdzFpdyrc4PFNkPbqXv/j6yOXq+9S2QJttIefdJ
	2WJdWkdqCj3YrrgRfU22VhkzYo+q5Y7teUUjS3XGrZ9sFobuPzW8FJWYLHl2ThHjCTsgXThB
	jotDJX7T3/SMckMTNjZdMJ4R0rgVFX48s2msTFpU9akprul0ZkxIQvxX/kHzO9OP7MytCOKO
	5gueDcy50+WEOlsZuRdXqZX/ApXKKZRFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7rzufzTDU4tFbQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZUxcElFwVqFiacsJ1gbGHdJdjJwcEgImEr8fP2DvYuTiEBJYyigx5fJNNoiEjMS1
	7pcsELawxJ9rXWwQRa8YJZq73jKBJNgEjCQeLJ/PCpIQEehkkXi7eS0jiMMs8JZR4vrMjWDt
	wgJBElum/WAHsVkEVCX+b5vFCGLzCthLtP+/zwSxQl5i/8GzzCA2p4CDxOupXawgthBQzY6/
	h1kh6gUlTs58AjaTGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yf
	u4kRmFa2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuFdvt47XYg3JbGyKrUoP76oNCe1+BCjKdDd
	E5mlRJPzgYktryTe0MzA1NDEzNLA1NLMWEmc1+3y+TQhgfTEktTs1NSC1CKYPiYOTqkGJp/J
	4g1S7XLrdypwFZ0sOJDXsWntDev/ziIJbx1n/1r8luGhXsmHhZ2rP+SemXpw+2VHh8bJyZsX
	aR8SsZyilyAaJ/3a4cZNDlGHhXkTvrncFDUN/6K+xv/inQm7y9f3MC4W3mTwsO/4k5lNTeWq
	RU2b+467q120fiFmc95d8Y1tZ7tit/LhefG/bdZzaT/peaoppsHAcq1/usrFF1EW9ze/z0rS
	X3vq0Pyfb7UchFNdbv3dFj/jWtCFlRf/HpbLLr1vOuHCgtm/DXI8H0sEd1Seznx22uu9zFrn
	6canjeyiV5bOnFj4V3byr76JtwSSVRecnZS4INXiGe/6DV8f/v7uJ8D7h+fSx0NPpWPWzHqn
	xFKckWioxVxUnAgAGT2kN7QDAAA=
X-CMS-MailID: 20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b@eucas1p1.samsung.com>

As support for clocks from new subsystems is being added to the T-Head
TH1520 SoC, the header file name should reflect this broader scope. The
existing header file 'thead,th1520-clk-ap.h' includes the '-ap' suffix,
indicating it's specific to the Application Processor (AP) subsystem.

Rename the header file to 'thead,th1520-clk.h' to generalize it for all
subsystems.  Update all references to this header file accordingly.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/clock/thead,th1520-clk-ap.yaml        | 4 ++--
 .../devicetree/bindings/mailbox/thead,th1520-mbox.yaml        | 2 +-
 MAINTAINERS                                                   | 2 +-
 arch/riscv/boot/dts/thead/th1520.dtsi                         | 2 +-
 drivers/clk/thead/clk-th1520.h                                | 2 +-
 .../clock/{thead,th1520-clk-ap.h => thead,th1520-clk.h}       | 0
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename include/dt-bindings/clock/{thead,th1520-clk-ap.h => thead,th1520-clk.h} (100%)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
index 0129bd0ba4b3..4a0806af2bf9 100644
--- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -32,7 +32,7 @@ properties:
   "#clock-cells":
     const: 1
     description:
-      See <dt-bindings/clock/thead,th1520-clk-ap.h> for valid indices.
+      See <dt-bindings/clock/thead,th1520-clk.h> for valid indices.
 
 required:
   - compatible
@@ -44,7 +44,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/clock/thead,th1520-clk.h>
     clock-controller@ef010000 {
         compatible = "thead,th1520-clk-ap";
         reg = <0xef010000 0x1000>;
diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
index 0971fb97896e..0b58b8d0d351 100644
--- a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
@@ -68,7 +68,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/clock/thead,th1520-clk.h>
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c85abf1dd1e..bd4bbf07d588 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20192,7 +20192,7 @@ F:	drivers/clk/thead/
 F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
-F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
+F:	include/dt-bindings/clock/thead,th1520-clk.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index acfe030e803a..dc2d554b4a71 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,7 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/thead,th1520-clk-ap.h>
+#include <dt-bindings/clock/thead,th1520-clk.h>
 
 / {
 	compatible = "thead,th1520";
diff --git a/drivers/clk/thead/clk-th1520.h b/drivers/clk/thead/clk-th1520.h
index 285d41e65008..5d30f55e88a1 100644
--- a/drivers/clk/thead/clk-th1520.h
+++ b/drivers/clk/thead/clk-th1520.h
@@ -10,7 +10,7 @@
 #ifndef CLK_TH1520_H
 #define CLK_TH1520_H
 
-#include <dt-bindings/clock/thead,th1520-clk-ap.h>
+#include <dt-bindings/clock/thead,th1520-clk.h>
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk.h
similarity index 100%
rename from include/dt-bindings/clock/thead,th1520-clk-ap.h
rename to include/dt-bindings/clock/thead,th1520-clk.h
-- 
2.34.1



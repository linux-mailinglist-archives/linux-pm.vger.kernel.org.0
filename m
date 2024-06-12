Return-Path: <linux-pm+bounces-9025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F19058FE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287D91C21EF9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F93181BB2;
	Wed, 12 Jun 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l+ZmI91j"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B66181B91;
	Wed, 12 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210544; cv=none; b=XaORAwp8Wkrlq0wtFNQstWcrt0TEn8KDyN6Z2kLlApTpYwY4vHC7UcvDAFg1yR/8Yd5WXBvWGgyCeRVjxn3BGxqewjzNs40B+FbRqIND+H9ksIA43qBWJxzztrxTqYCEVmDYtgDeezmG3r8fag334R9jcs6s2uaYJ84olcbP2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210544; c=relaxed/simple;
	bh=5ZIzRsZmwLkhF+loYV2ldRFY5KvqeljcAs10mUbNVqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qA7ktX4sdUw+toDJU+p56difl4l6k6bglvfUJ5XzhSXIJXSOO+/Dy1KMxgPIWzF5MxAUDDmthVlFI8ZOwUcoYmKH/KyFF3nBwP8kCoS8QN+KHfnWKH0QAfg4j8a8rSqipuKqI5NiPoWtOSecc3ImfxkEbr5I5A09M5IHprpj22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l+ZmI91j; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBXb029399;
	Wed, 12 Jun 2024 11:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718210531;
	bh=URgkmHjG21+8HcgxUeOPH9cIZItkVgbPT4MMG7nYknU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=l+ZmI91jPgVWtPYpE7fF1s0GRLL+GiL3/xhxKjHAtzVH2hwYx4v9VAuAXzKThvWmJ
	 2lPTcClF0Hg7Izzf8uBCe2hM+RbmwqC5xcHzBLqcuVNl3aMZxM58m9jbZ3fuBch5Y+
	 F0DQ+mTKYoI5gCwNnxPE7UqlhGQsY+E/D60qP40s=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CGgBZC079729
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 11:42:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 11:42:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 11:42:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBcq099383;
	Wed, 12 Jun 2024 11:42:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 11:41:52 -0500
Subject: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Vibhore Vardhan <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=bb@ti.com;
 h=from:subject:message-id; bh=5ZIzRsZmwLkhF+loYV2ldRFY5KvqeljcAs10mUbNVqc=;
 b=owNCWmg5MUFZJlNZa1NVjAAAZv/////973f2Sv/fZNr8u/cv2KH+2//H3P/7emvdv99f3/+wA
 RmYjFAAD1MgAAAaAABoA0ADQNAAAAA0D1AADRpoAGgGh6hptQeUehPKeSIBkaaADRoGgDRiNGg0
 DQA00BoGQ0MgZPUAADR6g0AyNGTQADTQyaZB6mjanqaAMoPU0aZNMgGTIDRoADIGgaDTTQAaADI
 ZMTIBkGjIDINNDQaDRoGjTE0AaBoGgILANo1Ad1OOgAlvpiHtvJ4r8QC7XyliNCzEkLf2G1r+A9
 Ta8DSccZk+MbXPi7lGKWLc7scIImqU5I5gzN0A33RThQGAmKOraMZVf5p6aZkk59CcW+C5HGZsu
 gWdZMYGg8GcpYIS6bJE5SHmBx3UieAPK4XbTPmms+maogjWNjuKWyX6J0A7y/8wggc3iShioQ1N
 fIVY1a2Uk3/ZvrY3dLsl8UlMXYE4JsK6I0GD/cmyNYWrJzNytMk6RVMqiKxE5J5HfGqo/lJQuh/
 DozyqX30vo5yf8ceJSFtFJgJAhWaWJCCmxUS0MjsYgOR/Byhx/L5SFbDSa4PpQ1Ttv6jcycI4Fq
 my2Jk9yUxKtUBNDoUiYHXQDA1nx5ofuQra+kIb/2hcAwOoHuV9pZ/UdOchUIUAsMLwzCzFGjDWZ
 IKxBz5Yy/G8KoIx/i7kinChINamqxg=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The JTAG_USER_ID_USERCODE efuse address, which is located inside the
WKUP_CTRL_MMR0 range holds information to identify the speed grades of
various components on TI's K3 SoCs. Add a compatible to allow the
cpufreq driver to obtain the data to limit the maximum frequency for the
CPUs under Linux control.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 7ed12a938baa3..ab1fcbe2148f7 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am62-usb-phy-ctrl
+              - ti,am62-opp-efuse-table
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
               - ti,am654-serdes-ctrl

-- 
2.45.2



Return-Path: <linux-pm+bounces-9039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA97E905F00
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 01:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CBF1C21E08
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB9126F1E;
	Wed, 12 Jun 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BKFarr7P"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9241A84;
	Wed, 12 Jun 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234272; cv=none; b=jn+JvX20s9nSt/dVmziKJ/OYwiZ6EtCgt5TstqhSRGFLlLoaZPpsOGNJODiPqCSqecU6RR0aRLMnYQzQYe7deSaKjGbD04/ziey0Ds+z8MJ5CKaGc2T0+aSk22lLS7qjOhvuBb5yjLiArywRWyh0lC3+3sODAF6KF3aN9eFh5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234272; c=relaxed/simple;
	bh=5ZIzRsZmwLkhF+loYV2ldRFY5KvqeljcAs10mUbNVqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T1aMmVXCqLUV25GD5JYZlPzPpIGbWv+hTyj3QsVDbT7R1k6NzTrI9DHTTtGNbW62uXJ5E+BIghl4YuDfCoUsagDwrsooUOMlxbepDffav9qRb01QitL9do3ymLWqSi8LDvu6a2FRChelDOgEOJWDQqOAyi77SOrpCwZAZVoiMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BKFarr7P; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHfSm000523;
	Wed, 12 Jun 2024 18:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718234261;
	bh=URgkmHjG21+8HcgxUeOPH9cIZItkVgbPT4MMG7nYknU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=BKFarr7P9CjOphZENYKMINdVt/ZiylS4HRmgdAunbuy/tDRvihaMSZvBgK8r2KOPE
	 NlUmHkzVTG0onNzMklr1PmdOsRXp4/dZDPW+Td+KbEDZu39g6PtYSy9tlhBKVMXzfF
	 dDZ/tJVR55oTIduiHU+1Rh/lRbSXpgR00BkjgiOg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CNHe8x017773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 18:17:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 18:17:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 18:17:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHebo023165;
	Wed, 12 Jun 2024 18:17:40 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 18:17:36 -0500
Subject: [PATCH v2 3/5] dt-bindings: mfd: syscon: add TI's opp table
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v2-3-422b6747a254@ti.com>
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
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
 b=owNCWmg5MUFZJlNZ1nwjXQAAZP////btV+PvS1uft+l7dbL3DrX3/e/ev39b//sd3r359e6wA
 RswHamjEDQGg0ADEADQAAAABoABtRoyANA0NAaDQwmJoZMhoBk0aYE/U9UQANA0MgaBo00BoaDQ
 yepo0DEBoaDQ0aPSADTQ0GanqDTJtI000NGjQ0NDJo00YQAcJ6RpiAyYjTQAA0yZDEZDTQANNAB
 kwhpkDQMgxANDQGjQaZMgB6mmjE0AAAFAurNQKQCG8xkJEdEBNjkxaTFa92CNlKOzNiQRxIgElQ
 esJfnQ+Le6EvSiQqJeypCNqenjI1tv9hs/YNr9gnG1RzdOdqHh2VLHiREsx6EUMLahFkeZADdS2
 1Fz+8Jbk07UO0zV93/QwYbig1XUUhSA+6Px0gD4JsAsxKmgqdIFJzom3eC2R1Hpi29tnb6PpSpx
 pkYTdAnIrK/aRTyi00meoRpGJSryzfsK7pXvAhWoa5O3p1JlM2TI1aQYY9K9fGMkBqiUALmCgop
 QgbkO7+8B6cayaFjqsjSwIh7jwpxwxcMlX2VQNjOTVpWoaouwWIlyIUtvcEFw+Z1gC0B+dXuaki
 UoMcJqxIS+lwTnX4jmghpGbFOsBGq1YEeMv2eGYciEC7NZNMwjpl9JoW4FQFAQB5FWkxXWtyIfc
 6ATx/RC8A/xdyRThQkNZ8I10A==
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



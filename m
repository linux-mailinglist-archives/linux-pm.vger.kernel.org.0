Return-Path: <linux-pm+bounces-9772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13402912B8D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C312C28AF6B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A51684A9;
	Fri, 21 Jun 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hVtWHqU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E81662FA;
	Fri, 21 Jun 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987998; cv=none; b=EdaDonnRdePxfkW6aFuAwkYPxZN3HAWnAkzCV8Zfpo/ZRaQYzNQwS0vBgo6kIEZ+pv9DiaKYsRwnO60uOHSR8XHaXCfkl9mqUgoZjYDJdkDXeemwy/isp+KabLZVa1Q3zQEhHL6E7GvQqo0OsHHKGd3awkr6GxY3VDnE8m78Ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987998; c=relaxed/simple;
	bh=ta4Z9ycYD1Ka/6WLR31T6TPcPYgv4UQQ32/jEd+kzMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VO6wmZN5QCxqGGnS0dPOIqdaBmUu1lGBZWht83/w5uF8I9jLuqmX7ug7AUyPOq+6y/2JBRxXrFbQEUgDETtjonXkV1H7a4giHNi9szQekH2Jqp3rTwCaeukW6+AT+BfT2WUuvrR+0Yx3oTwMitmKfscaOb01xndf7xwDT5ou13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hVtWHqU1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdksK055953;
	Fri, 21 Jun 2024 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718987986;
	bh=uP817xG5jobY4+PqTNrEl6SkgUuCoSn2TwnFDJQOqq8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=hVtWHqU1Vl5MklyeRoyZhCq29KdFrlllTF0QN8JhlHGxn2R1880Or4NF4M433bJNp
	 XqDkE7RjiFGS98v6KcakPLs+VwU68NSEJRlgnMEthDJDlQZqhQ4h4pDJaFH7BLzDOs
	 FUimgIZozwnd+YkOt4ziw4hVhzg3yM9ibqrUdpfQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGdk16062051
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:39:46 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:39:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:39:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkC0080077;
	Fri, 21 Jun 2024 11:39:46 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 21 Jun 2024 11:39:39 -0500
Subject: [PATCH v3 3/5] dt-bindings: mfd: syscon: add TI's opp table
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-ti-opp-updates-v3-3-d857be6dac8b@ti.com>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
In-Reply-To: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=bb@ti.com;
 h=from:subject:message-id; bh=ta4Z9ycYD1Ka/6WLR31T6TPcPYgv4UQQ32/jEd+kzMk=;
 b=owNCWmg5MUFZJlNZCy37FQAAX////7978vt5/771mz/vOQjS403q/d+1znPd49vf+93t7+ewA
 RswjEgANANAAA00AAGjRpoGgDQ0DQDQ0NNqaAD1AGgDI0ZMj1PUAPSZkmaZIcmhkDJkDQGj9UaA
 BpoGgyaMjQ0AMRoBoB6gA09R6hkaabUyZABoANGBGBAOTT0I0xDQYTTQ0MRpoMCZGTQNAyNNADT
 JoMNRoMgwgNDJoMgA0ADRkAAAAbgpQ0ELgI2MjiprQKiMBijFGZAaESmdLW4gqm1QgyP3VQ0c0O
 B1d/sC3x+DjHft8OTTEkZSNFzurCuOi35RWIAKOQUiIZQomgj5FAn7GGNS2iInSBalUhYhKk4ZF
 KptG7nSyn5bxV4Lzsu/jqcRrz2s/D6DFeTWGd/JenwQGlrBK4UBZKoPJz06KsN6zbstNp7WtEwC
 sA6u7fEJ65W0MuP4apfxoTIT8f0PAskneaHlc/TwIwzJQhvzlgxL6hbZYPBCB0iL0WTA495eqpH
 8vhTQKk0B5XEdg8yCJaJOKKFcJEYSfgL2yko0KH8aq6PWhqJn2ZgW/eggNMUowRPP4h8jXGT5bV
 4MBlbJZkE8jIswW7H7UsmrZvcjuAXkU4m/iWHCIlcFN2eMSIWUdo15bnozjcgECw83PoylI9/Rg
 Tf4u5IpwoSAWW/YqA==
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
index 7ed12a938baa3..d1ed7d33d163b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -87,6 +87,7 @@ properties:
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
+              - ti,am62-opp-efuse-table
               - ti,am62-usb-phy-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl

-- 
2.45.2



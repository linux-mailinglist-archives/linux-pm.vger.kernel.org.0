Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C99E8D1F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfJ2QqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:46:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbfJ2QqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:46:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGgwJm026459;
        Tue, 29 Oct 2019 17:45:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=UqBLShJCTgixGdbgFzma65RAxEtmlze/XM6cp3uTtSQ=;
 b=cepqO2/65Lz5Bhz53U3SzJUY4oirqjrlIoH/Xf+rSA2N//WoxU5JLEhRHpUN3ewF7gGZ
 CBifsmb2jZkxvxCRk8n3NH/w6WvggYteTIFuPgl+Ud0KoO634ZIP6zVBpoyMXtaif00o
 peULpGUwSho/30zIo6YEpkwg/Ixy9v/wUzSaTEW3a9RCxLVSCgx0/2WU1NwetLjsL0mY
 r2jaah/jM/2cfkZuQzhOp7kmTAni0V+sD3FE/kgc2QjBzT/eF/rAGYDX+FpPDvBWyUck
 46adMW/HVVtT+QfANEaVFtVds4QZt0/vSNpOTknykhlkI6+u8espWryGMyR47znJEL+k Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0gwdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:45:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6704810002A;
        Tue, 29 Oct 2019 17:45:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56EFE2A748A;
        Tue, 29 Oct 2019 17:45:46 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 29 Oct 2019 17:45:45
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <david.hernandezsanchez@st.com>,
        <wsa+renesas@sang-engineering.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: remove thermal passive trip point on stm32mp157c
Date:   Tue, 29 Oct 2019 17:45:37 +0100
Message-ID: <20191029164537.1561-5-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164537.1561-1-p.paillet@st.com>
References: <20191029164537.1561-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove thermal passive trip point.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Change-Id: I494313cf467eea491236e73bd2fbe1803345586f
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9b11654a0a39..799b2aedd2c9 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -91,12 +91,6 @@
 			thermal-sensors = <&dts>;
 
 			trips {
-				cpu_alert1: cpu-alert1 {
-					temperature = <85000>;
-					hysteresis = <0>;
-					type = "passive";
-				};
-
 				cpu-crit {
 					temperature = <120000>;
 					hysteresis = <0>;
-- 
2.17.1


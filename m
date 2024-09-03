Return-Path: <linux-pm+bounces-13403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C61969A34
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7BFB22110
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9651C984D;
	Tue,  3 Sep 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SNycJfSY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D191B9857;
	Tue,  3 Sep 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359454; cv=none; b=MyRXC6/WVu689Q4R6vc1YFDAOT7gNlPQvBdvXshQ5EjyxOhmGYdstl2qkup2GgEhuEBs2mnbUQgLuhMDjWZwnDtxQDq19hkzMs147qfFgX6hP/mCpfOdJwCZ01Xbmi2Tk2dzxH2XSt/CeMvi0CDjDwvj5O0+mo2r9FMyjeMHtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359454; c=relaxed/simple;
	bh=i+kEaGGz6VmWoEm6ykbkXEznSzcyaoPLnH5AK/2tuA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OLVOrw5Y+8Tzly91zvcSxc9gOFZjpSr3HlCoCkD+JR2CL18lPsaY0b6qC9OpHSg+lxs+mUfqu4ct7T1kNKZRm48r8sqDoFGxmwJZkaZnsPxeFVa9PXIsse4T6Vic2Lka3oiSBWfzHG/mrSaxdhaj1sIvVm+tYqPRN67CQ4vqTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SNycJfSY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483AUnR0044571;
	Tue, 3 Sep 2024 05:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725359449;
	bh=vw6fTohh+89xPL01oFfBV0+OYrK81CpLkf/sGTAg/lA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=SNycJfSYVzYEPcQify/dsG/2+JcCv2GgUzbOeKLz+9fczLNX/ahqxIl9Z05ARQdmJ
	 kYn+qREryJJ1m8Xyx2RBWtbnRTcIuSQGVnsc6JXxHQBtLyBJPBkig34+0eWilIBjbW
	 YvQS/E9r3UZDtvXT7gFyDUjfRIWheAIcKi2+XIrI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483AUnHC014152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 05:30:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 05:30:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 05:30:49 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483AUb69012445;
	Tue, 3 Sep 2024 05:30:45 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 3 Sep 2024 16:00:08 +0530
Subject: [PATCH 2/2] dt-bindings: opp: operating-points-v2-ti-cpu: Update
 maintainers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240903-b4-opp-dt-binding-fix-v1-2-f7e186456d9f@ti.com>
References: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
In-Reply-To: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725359437; l=845;
 i=d-gole@ti.com; s=20240902; h=from:subject:message-id;
 bh=i+kEaGGz6VmWoEm6ykbkXEznSzcyaoPLnH5AK/2tuA0=;
 b=aZyVtKfP613crdTkmHN/eQACnFNmo6AopC7n4YkcCkCtFQiqriDjx8jnng3ARxKna5sg3mZVU
 /vXP29vHl5SDQKJ0RK4GgjgsIPGYfJqpFxldyQoMvjD3z6RiKxRxiOD
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=yOC9jqVaW3GN10oty8eZJ20dN4jcpE8JVoaODDmyZvA=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the maintainers entry since I will be taking over this file from
now.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index 90855009cb81..a857ca34c98d 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -19,7 +19,7 @@ description:
   the hardware description for the scheme mentioned above.
 
 maintainers:
-  - Nishanth Menon <nm@ti.com>
+  - Dhruva Gole <d-gole@ti.com>
 
 allOf:
   - $ref: opp-v2-base.yaml#

-- 
2.34.1



Return-Path: <linux-pm+bounces-14932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E155A989E6B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FDE28858B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9418871D;
	Mon, 30 Sep 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vs5zXpy/"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB31885B9;
	Mon, 30 Sep 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688779; cv=none; b=HqJD86zRN+PpwFsGf/efK69VM+YFazTtaCZJ+ALP+0s017jDWLGQf/iHegXzyZ4kxOwN1wRg1+9YlYgqlCnSdmmn++ONCF2o0tbpzNCpz0ltbSRK2g5LQ+tGiGVnedJVROnMXXF7h+Vz+CqjTwVK5jLpniWLvodrY45xNaJb38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688779; c=relaxed/simple;
	bh=V+A0Ou56M6vRoU0patGc9ECKhCoDzL11ztYMDea7pDc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rJvnBGWsBYfYJb7uICnJe4UunINIQUWhXnYU2aZlMA9iqQlM1p7N05RCIIPytY/1Iq2Oy2pEZJ7q2hDC+I7nEB770/YuLg6eqvdzz7RWZ8IrJvTtQHfkUnY2zaJoKzAVbHvcPykDe1S6d0WkdXu4Cp5SEVktuiyKoO/Fcs3ZJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vs5zXpy/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9WfcB113827;
	Mon, 30 Sep 2024 04:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727688761;
	bh=N6VXLOB+A2YGsY5wrKf8qTzqYzOMWaSGIZdY10Hn+KE=;
	h=From:Subject:Date:To:CC;
	b=Vs5zXpy/2kOULXGGyVTEBaXhuISt7J3tHQS4kScu/ThNwvU1pET+vE33g0DkX4U+F
	 bGrq/fpmrDgdUlYPMumaad/F8GMgFojNnrNkX6cnUOT/JLBV5XxziBlPNv1tko+Jtm
	 nC1X0glAvppQmmqPTQCTBAN8y29kV6GrOOBT2Ipo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9Wfi9008525;
	Mon, 30 Sep 2024 04:32:41 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:32:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:32:41 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9Wcv9021643;
	Mon, 30 Sep 2024 04:32:39 -0500
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Date: Mon, 30 Sep 2024 15:02:08 +0530
Message-ID: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhw+mYC/x3M3QpAQBBA4VfRXJtaY1O8ilwsBpP8zVopeXeby
 +/inAc8q7CHKnlA+RIv2xqRpQl0k1tHRumjgQxZU+YGW4unYLeHQflAtxSERxCd0RZkifPeOWo
 h5rvyIPe/rpv3/QDJVAqNagAAAA==
X-Change-ID: 20240930-b4-ti-cpufreq-am62-quirk-46242e3daa2b
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof
	<bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis <afd@ti.com>, Dhruva
 Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688758; l=1497;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=V+A0Ou56M6vRoU0patGc9ECKhCoDzL11ztYMDea7pDc=;
 b=Cv67XpFDRnjp0A0mboBPuZUP7yx4pitiDbDFk0zZJXOKl1ZjAGIV5leaOg/urz592MIx8kRVX
 6ZhBbMXCEORDnXncGSiHMx0fw3hvOE31yfGcnfDdFCcuqXLeTTFXv63
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With the Silicon revision being taken directly from socinfo, there's no
longer any need for reading any SOC register for revision from this driver.
Hence, we do not require any rev_offset for AM62 family of devices.

Also, maintain the backward compatibility with old devicetree, and hence
add condition to handle the case where we have the zero offset such that we
don't end up reading the wrong register offset in new AM625 DTs whenever we fix
them up.

These patches have been in discussion as part of another series, which is now
being split up as per discussions with Nishanth. Ref. the following link for
more context on the same:
https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/

**DEPENDS ON:**
"mfd: syscon: Use regmap max_register_is_0 as needed"
https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/

This series has been tested on AM625 on top of above patch:
https://gist.github.com/DhruvaG2000/40b80cc04a9ac90c86445d6e67ece4cb

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Dhruva Gole (2):
      cpufreq: ti-cpufreq: Allow backward compatibility for efuse syscon
      cpufreq: ti-cpufreq: Remove revision offsets in AM62 family

 drivers/cpufreq/ti-cpufreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
---
base-commit: cea5425829f77e476b03702426f6b3701299b925
change-id: 20240930-b4-ti-cpufreq-am62-quirk-46242e3daa2b

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>



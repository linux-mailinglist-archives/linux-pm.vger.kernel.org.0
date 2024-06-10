Return-Path: <linux-pm+bounces-8882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA85902411
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373A71C214CA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E013212C;
	Mon, 10 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rbDMBXU+"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370084DE7;
	Mon, 10 Jun 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029730; cv=none; b=ZZwE5xw8DssHowHTB147duB5ys12SUvS0+qjQZkLy2JtFELaWZ7TeW0rSIN5rkTJ4EHYubc7ehdSznqsuyaSqQXjEIpNIT4q0o8EKq+j4US9DbF/PpRxg4efuuVWoJYHn//Et4ZQv2pK/ujlxvcGPgO14PxFToYzI76ap679R4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029730; c=relaxed/simple;
	bh=YfXaRrnltSNLuJxNuUHGYkWLrOOxy9EROV/wAEM8jgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbQpa0GJmCbxL3dQg6Uq16nWX/Myoi5UmEQtoUHKm8VD5KWfryi/x0BUyupU+YKu91Db+8Dvm9N9JEgWpcjL0peWdpSt7KRZ/CIzfIFCi4vY+AJDiPCdIaRY9jmgoSgDLblb/NJZjQQbe1ochd8glWOy0HOlY+Cit62sgQLBSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rbDMBXU+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AESd27130777;
	Mon, 10 Jun 2024 09:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718029719;
	bh=nRnslfxi5bzrnUsqzY3ovdKR9xwfCouCPnYfjSIo7CU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rbDMBXU+sB7YzSp3H6PZRczP9ei5fcUgu1ZfL8xfWPvsKBn2VHPb5lUpcSXl2lwNJ
	 kWuaC7IsmKyDjL/mMvrruAnJbAHpVXMeVsj4JvqBFFuY5LP9yVKmJDt30vzmUzI9J6
	 HvK5XQmS08R8680x+N3Ofz47nvwFaT0dSxg9fs10=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AESd0G123876
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:28:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:28:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:28:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AESbiM095574;
	Mon, 10 Jun 2024 09:28:39 -0500
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/5] power: reset: brcmstb: Do not go into infinite loop if reset fails
Date: Mon, 10 Jun 2024 09:28:36 -0500
Message-ID: <20240610142836.168603-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610142836.168603-1-afd@ti.com>
References: <20240610142836.168603-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There may be other backup reset methods available, do not halt
here so that other reset methods can be tried.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/brcmstb-reboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 59ed1513cfb30..441b44e0a9f29 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -58,9 +58,6 @@ static int brcmstb_restart_handler(struct sys_off_data *data)
 		return NOTIFY_DONE;
 	}
 
-	while (1)
-		;
-
 	return NOTIFY_DONE;
 }
 
-- 
2.39.2



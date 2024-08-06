Return-Path: <linux-pm+bounces-11942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FD9492A4
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EC8B26B4D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A454205E16;
	Tue,  6 Aug 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOoiUZ+n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A131205E0E;
	Tue,  6 Aug 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952719; cv=none; b=Kn1Z7AKNcZhl2k4VvdnrfGjkaWJilNr4v/EFohiLq6rtC5QzFSXd/qMG9ltGQ8nShdQXL1BMW8tYPrgx3PETL/GkGeJ3ow4cnmbdz5YvMIED3HxPmrd2IbHk+5jYiWZ/AzYeFWKJ9Xmh2mxWwyrdmjy5Paebo/INF8c4KKvDpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952719; c=relaxed/simple;
	bh=uCYvbAMXm2+3AvQKq0Q0abiFwVHINEmdiWc+kAmUIE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AseBqmps9BaqqAk5CBqxNUfsqXM/KNW+xFMRZdOKTDoYuwO4Lay4+Gh0pIwDn452Aq9G3P2k+htzaXbQOxy58SITf9VUr2oWXl3CdfF/icfbEE4bNrKnpYqj+2A/4E7dDenUJycGXTF1tJtkDliR5YCIfUjtlCMk/eGm4qYCTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOoiUZ+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A78C4AF11;
	Tue,  6 Aug 2024 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952718;
	bh=uCYvbAMXm2+3AvQKq0Q0abiFwVHINEmdiWc+kAmUIE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NOoiUZ+nn08tT72C7dMaunByY1Vc4QydgBoYh7mRJ9a4M5SHsk7SQRHwmLHdZWU6+
	 39mxU80tOUaGIsBe1h7UTDsSL2XE3ApGXGurUHJPq8+78RI9F8xJC/ItglKQk6SSb5
	 RDelsWAB6aShmC7h3ObWXhbdjC+s5HNyLfid+kU7gUTJ67gA2NzcvnCVagLEnpAbGx
	 +7jBdZHhyruhLGib9KDTIT1Txx1VV6WKizTgOpHQNPzNUuayECNq21ZUrk/qHaBEFr
	 a3UFEHLZ6djJOuRxjah9eZnnZ/Sqy8Dvg9xosSDhKCUhVDmbRMqdlbz8Oc/uW5lG/i
	 AYmndjDwMnlLg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:25 -0600
Subject: [PATCH 4/6] opp: ti: Drop unnecessary of_match_ptr()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-4-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
In-Reply-To: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

of_match_ptr() is not necessary as the driver is always enabled for DT.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/opp/ti-opp-supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index ec0056a4bb13..5f0fb3ea385b 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -405,7 +405,7 @@ static struct platform_driver ti_opp_supply_driver = {
 	.probe = ti_opp_supply_probe,
 	.driver = {
 		   .name = "ti_opp_supply",
-		   .of_match_table = of_match_ptr(ti_opp_supply_of_match),
+		   .of_match_table = ti_opp_supply_of_match,
 		   },
 };
 module_platform_driver(ti_opp_supply_driver);

-- 
2.43.0



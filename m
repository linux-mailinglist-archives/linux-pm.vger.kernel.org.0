Return-Path: <linux-pm+bounces-12635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B5959B1B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A6AB26BFE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2E1B7905;
	Wed, 21 Aug 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K4AT/enS"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF61B7903;
	Wed, 21 Aug 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240624; cv=none; b=rUvowvp3yJAwtszy120WLN+YHY8tYevFSJgiHH0qjka1Uua55zJapkn0Fc+xO+kG76FKmscDL00pivm6rcU4NqC/Ck1dH+HLLMh/uFqDYSVUMikYgt04e/13/OJ4CciKKeZaB/XtjM9y5sMlvuKwMq8zDWKa+cDn24SXivtXWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240624; c=relaxed/simple;
	bh=bsw35sWFxwfXUbsfrVrmQzI4hOlh95GIVDem8rGh9EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdiH10Y8YkSST/uZEhMAMQDJytlFy5p34WAFSsrPAXD7/dUY6lSg5ZlnZiFP7EAXBkFwZxh3NzrLTtB4vudSuZ8fmtEnwcgNDA8c5xEcaYCt4C/stuTkXBQacsKHFjzM/ZUSpbpCdsLaHYMjaGiiQH3g/3EZ8uFqm3EkdmN5rOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K4AT/enS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LBhcjf036956;
	Wed, 21 Aug 2024 06:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724240618;
	bh=FAFFeDTLUC+SlZtqLcU0vN05qtHka4e5KwhNhbs7JOU=;
	h=From:To:CC:Subject:Date;
	b=K4AT/enShGszP1m163n2x5zpmU9erpPw9j5ksmISE15HdqSEq/R+JPXvZVspK1eKi
	 86hMrvPXkRd4Qt6wVvx8puG4rsvwk0/aWduiQr7Vkrg7J8NrJEC+SfkWm98iY7YZC7
	 XBQXRPbJ+DKD9nLyC2gAGMTO7/aEXZtAYFjrGwm0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LBhctL025017
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:43:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:43:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:43:38 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LBhZ2B033647;
	Wed, 21 Aug 2024 06:43:35 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>
Subject: [PATCH] cpuidle: remove dead code in cpuidle_enter_state
Date: Wed, 21 Aug 2024 17:12:50 +0530
Message-ID: <20240821114250.1416421-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Checking for index < 0 is useless because the find_deepest_state
function never really returns a negative value. Since this code hasn't
been reported in over 9 years it's dead code. Hence, remove it.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Discussions on the original series that added this code:
https://lore.kernel.org/linux-pm/20240821095105.xuf2a5xe3yxqqewj@lcpd911/T/#u

 drivers/cpuidle/cpuidle.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 02e40fd7d948..9e418aec1755 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -228,10 +228,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	if (broadcast && tick_broadcast_enter()) {
 		index = find_deepest_state(drv, dev, target_state->exit_latency_ns,
 					   CPUIDLE_FLAG_TIMER_STOP, false);
-		if (index < 0) {
-			default_idle_call();
-			return -EBUSY;
-		}
+
 		target_state = &drv->states[index];
 		broadcast = false;
 	}

base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
-- 
2.34.1



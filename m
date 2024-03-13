Return-Path: <linux-pm+bounces-4881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07287A7B5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 13:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286D51F23F58
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0783D9E;
	Wed, 13 Mar 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="lb6k9V7S";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="AzXrXVSx"
X-Original-To: linux-pm@vger.kernel.org
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536815D1
	for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333699; cv=none; b=W1ZHuvzQmwm20h0MIbdNtHRUQ0sz5j5mqGHxFzLrqBparKga4IQaf4zf0pt7I4p5PCOgHC89JaBUl245ekDsa4t2GVl8tW1xB6Gf6dzSsU3s37YZLc0BrA6tuZazfiOT/dGz/q3gr9HHNwEfsnF7z9JmAPVRDxY+zFcUbLQQAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333699; c=relaxed/simple;
	bh=C6Ei12qFq1dwjt7LRGxmcGnHjiV+5QZTSZmgID4wPsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miM9D9RPYBe2MSVGYsOb9Uwhko3hkMrLaXaHZSZYjYp7bjvylapmmNixKUXVCgsaieFSqaUgcV7yxVyAj8biuUIXJvPMaLG50jbRKDbGYmUcDKxiIQdgRgnl9xIGIkQkDoSrSOW2X/eoBT/TI6ujg2LU+xdeue1yVPKH3llnHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=lb6k9V7S; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=AzXrXVSx; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=JVz+0/1IvynSUvZNYS9ttPNeUmoE4X67mo1kcxJZITE=; b=lb6k9V7SAG9XZ3D9UYvQV/UEXE
	z4U0sk9d7qCrMHqK4AUCiwoU3JVXp2RZByk3hW6NzHvmdy0tmmfAOebrlD41VYAwY5W2P0OutBhgK
	x/+zXxdXqXHfTeB6xrJwQwDMlP/NekPX4pvLpeGZhd3/GFzMQ8pUd0NhjVg1eBezM6FNqcSAqm7XF
	e7FOhn7i2rQyvLN6fwcg4wEVs70Wq0ajZZR9K74u7YTzZhoNwJZK5x6Z5tp+Ye1CVqR1jceSHX5s3
	LO4IGGXJje6KhVRgqlh3PgnsCdb6QzZi/4WS+QK3wR7UfpV/cPWqBPzj5HzvVHWm7FNaMjX8qSjGC
	ebZFsmWQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1710333697; h=from : subject : to
 : message-id : date; bh=JVz+0/1IvynSUvZNYS9ttPNeUmoE4X67mo1kcxJZITE=;
 b=AzXrXVSxh3gqD8eSaS/0ARaeFJhyqGjCvNkScImyKE4rIKRcZ9yrtlfk1pwWUAkwAG+II
 +rmdIxzfyf+LQbrqAgkTS7RmCYTnAGnR/qjPNRkHhmdGYRHzzJGHmJ6d2QHQjmeumaHZsrt
 qk7BBDId3n5yDo6X/PvpnOxiYzuKIProQ9wTcFFnFLTb8sVRoUe5v4v/1VJ7vTZs3KWMJuJ
 XGKpBZSbOl5eCoMhBP96zPKrSQ0G3PTWM7VE/Ot1QZ5lM02l2+XalQScEeIYUFtS7IqPLQp
 Tg/EjfLx457qFKoKNGcu8x0J25VVr8G31LbNu6dh3rzjqdnpHAJie+Zv1b7w==
Received: from [10.45.79.71] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rkNvK-qt4DT6-JC; Wed, 13 Mar 2024 12:41:34 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rkNvJ-DuzQp3-0d;
 Wed, 13 Mar 2024 12:41:33 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Wed, 13 Mar 2024 13:41:31 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] thermal: qoriq: remove redundant TMTMIR_DEFAULT
Date: Wed, 13 Mar 2024 13:41:17 +0100
Message-Id: <20240313124117.3224601-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Mar 2024 12:41:31.0735 (UTC)
 FILETIME=[C6AD3670:01DA7543]
X-Smtpcorp-Track: 1rkNvJDIzQp30d.8l784HLT242bb
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sdazqNa4wD
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The definition of TMTMIR_DEFAULT is repeated two times in the code.
The first time is useless.
It makes more sense to leave this definition after the correspondent
REGS_TMTMIR register definition:

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/thermal/qoriq_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index ccc2eea7f9f5..c29ed179c12d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -20,7 +20,6 @@
 #define TMR_ME			0x80000000
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
-#define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
 #define TMSARA_V2		0xe
-- 
2.34.1



Return-Path: <linux-pm+bounces-4643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309086FFAE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 12:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548DC1C227D8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CC381D5;
	Mon,  4 Mar 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="uxjo5PHz";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="OHEsCi0S"
X-Original-To: linux-pm@vger.kernel.org
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3334381D0
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550081; cv=none; b=R+sT8qqz9PV2eEON1H9SXCsfwnsD6f+L3clAAMSdObNAAUmV5uVQ8WsdIMbnlUvBD0Lpytn1tJ1jVCuJzpHHnNDqoL0svlEsIJNSEaO9ID99UZqFb1iQotrALw8cI1JQ5bsJrzQ0LZw4xdmI6prH5wQ6i3sUiEJjfLvUPyTddoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550081; c=relaxed/simple;
	bh=rBFiQEB8z/lHUfa+VHj4uIsM/ByrCz1KLthEmNo8hYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muuz3DMz0sfUJoiqkQWqV+OVXRSl+TP0W7TnJMKSJlyf80ttBof54uxtlmPaj+P6m2ypD/Yr0bR38RG6wRRaAkOTzXcKwN4P2AIVQbZl2KPNNY/t//wIMpS+LkO3ar0cdBdHV7NxoeD0Esw05xN6l6J1hvPAGYLTS1o+huc83Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=uxjo5PHz; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=OHEsCi0S; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=pxSNbisWh19U3rdQiiYOgslG+MwHDfuy5ghPqFpWc4E=; b=uxjo5PHzQQ6hHClIT+/VSJLGYZ
	6XuUkkyFpPrmZ0imjnXuxFOFLiOyZGSu257yieJ0/SqiOAzr9hEcQB25VKy/tr0nx9soGsEL3r93b
	J2RnLZzYk1US8X4rNFrfmb++gXltmhx9untwgiuUzaFzixsWE11DIKb3mFQf47o/SjQhelvqtiHJ1
	SRrzAOWnRvsId0SMMLnEkKrRsBLh8At00rBBoVq9FwkpafI5CUi/EAG5gwDQHP+DjRZISGYe+Yl/Q
	i6Bw44lJ1+XGCRtFG6g4voVRvTW9WaPHgXjWA7aUq2x+fBNjvHGu+connrca96EtiKfhWjhVZwbdp
	eHUq85UQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1709550078; h=from : subject : to
 : message-id : date; bh=pxSNbisWh19U3rdQiiYOgslG+MwHDfuy5ghPqFpWc4E=;
 b=OHEsCi0SItXAZdUdnOP8WdZP0OHDnCODC2n0nWVg4W2JeQU9cKqfZa6yioy5lSEZl9s1b
 YSMGuMwff4Za8/epCyhg1N7DFjw74jtk62erJtvX4DhxtJMC5VMYXClxnXHG+Csx10HEONK
 +nTuektSQPgcUH7UzNIDBKWPJg2XXubHNsLLjTOxOyKMZsfajTVSPQX4pAhLg8FpWJQTAe0
 UZ9Q/UBg8ySSHjskcbMGiJVXqMVgrld9IYCSBnfMjEBIMmkW4t6KDOOoNrbVsAgivYet2u4
 ExswCagmdS8tFM7VDkU8DkBxcI4i8/q92+9aqPpeCL9zXBb/06bM5BfE7cwA==
Received: from [10.45.79.71] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rh64J-qt4GTh-Gc; Mon, 04 Mar 2024 11:01:15 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rh64I-Dv15V4-0A;
 Mon, 04 Mar 2024 11:01:14 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 4 Mar 2024 12:01:12 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] thermal: core: remove superfluous line in comment
Date: Mon,  4 Mar 2024 12:00:22 +0100
Message-Id: <20240304110022.2421632-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Mar 2024 11:01:12.0413 (UTC)
 FILETIME=[4529D0D0:01DA6E23]
X-Smtpcorp-Track: 1rh64mDv15V40j.5bn79EblHWlet
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sD5JYLEGfq
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The first and the third lines of the comment of function:

thermal_zone_device_set_polling()

belong to the same sentences, so they have to be joined together.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/thermal/thermal_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f7a7d43809e7..34a31bc72023 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -273,7 +273,6 @@ static int __init thermal_register_governors(void)
 
 /*
  * Zone update section: main control loop applied to each zone while monitoring
- *
  * in polling mode. The monitoring is done using a workqueue.
  * Same update may be done on a zone by calling thermal_zone_device_update().
  *
-- 
2.34.1



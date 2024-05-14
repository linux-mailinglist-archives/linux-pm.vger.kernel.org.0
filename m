Return-Path: <linux-pm+bounces-7836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3C8C4F77
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C7D2815EF
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D013FD99;
	Tue, 14 May 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcL6pWP8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BO1ii77D"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE813F45A
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681945; cv=none; b=GspgkUEVOlqHuJtm0uqyTwpQpv0srmfZt4ZJkHmb8FlzEiGyaBKA5rdOnfLh+HHYWtj4P2VpzsPtBjHWQ6LBaT4aVtRviLfDloTdFyGMdEhGe/Loowq/WOW22IKjBL7VxV0ZodxwrzUXS315PrRYXRmc7YD8EDTNM+iN+/0FHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681945; c=relaxed/simple;
	bh=P/E2ry8Zjpd/ZyvzelKV968TjHn5JrJmFIUoVOBRU/k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YWSBHnAZVLtWmh8vj1tnBJ0kBjebpH9a/9PGuxiZTcLY/JWQMybrqzUarKutyXVRlNT7KUukvV+qz0M7PKYGZUVpi3MkXijXhggE35x+hDlCr/QhdaG8NR7Ljgqoe5J9aRvudnm6FM5+XIgQAPu1HEwo9ZQKOKZlgz4U8ekZL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcL6pWP8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BO1ii77D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pOwoYt/SLx41Naaem3lEqNEAV/jB+vkT/dQTf97SpnE=;
	b=zcL6pWP8qsuRJ/752JiBWnLMS+DgHFfCZmX7tUHv8ddxCVh68QWQcpGgK2kqwk1mN6PprA
	monDs5WwF4++SgQ4FOXWKoi/mFKqMu5nJkPwyKIy78tTY06dWMdAV10wW/Dt3uP55b8j04
	+NruDl48htA1oEC/HRVIYxUhXqKPxFAwx3WX5KlSuDE9zg27gsej2MfXMKlASAaUs43aMT
	iYCF1Q7WRFp70UZ2m/sbXdPyJNbk+eba4hKBD6Yg3Ss9odVfPiU6DEkYpI6WYBeGMLDSAS
	m2M54X5VZsUcVt/bLW5ieXjBReuq/D+YDLZ0iYE2mylN2b7RvQAhwj7PXYQHMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pOwoYt/SLx41Naaem3lEqNEAV/jB+vkT/dQTf97SpnE=;
	b=BO1ii77DcpcHg38gPpgkrCC5CxQPOCEkJFG532C2RUVJqQjO+bKhyFagWzhc0XaCEqIm5/
	l4yhbe04nbLdOyBQ==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: gov_step_wise: Simplify checks
 related to passive trips
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193709.10875.10665594485985186370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     053b852c46626250b5f7da43ba8574da756db022
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//053b852c46626250b5f7da43ba8574da756db022
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Wed, 03 Apr 2024 20:12:02 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 15:57:50 +02:00

thermal: gov_step_wise: Simplify checks related to passive trips

Make it more clear from the code flow that the passive polling status
updates only take place for passive trip points.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_step_wise.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index aad98e0..ee2fb4e 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -92,15 +92,13 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
-		if (old_target == THERMAL_NO_TARGET &&
-		    instance->target != THERMAL_NO_TARGET) {
-			/* Activate a passive thermal instance */
-			if (trip->type == THERMAL_TRIP_PASSIVE)
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			/* If needed, update the status of passive polling. */
+			if (old_target == THERMAL_NO_TARGET &&
+			    instance->target != THERMAL_NO_TARGET)
 				tz->passive++;
-		} else if (old_target != THERMAL_NO_TARGET &&
-			   instance->target == THERMAL_NO_TARGET) {
-			/* Deactivate a passive thermal instance */
-			if (trip->type == THERMAL_TRIP_PASSIVE)
+			else if (old_target != THERMAL_NO_TARGET &&
+				 instance->target == THERMAL_NO_TARGET)
 				tz->passive--;
 		}
 


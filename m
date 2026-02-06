Return-Path: <linux-pm+bounces-42188-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIwUKyg2hWlf+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42188-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:30:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A06F8A40
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DF673009393
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3C22A7E6;
	Fri,  6 Feb 2026 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="20KqHhEe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8B22A4E9
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337816; cv=none; b=bIY+gSV4gJ93EqgeRegUO89xDXVnyNdBxY/0oHnhny24xmqnldtZRR3nzwMuID+aX6PoGDSMNxUz791mBPm4Cvh8atRREmnqzM+zAqoKbYEghNs9T5+UqQZS6dfk9PECslOuSOq5gwKB8U7FpNwiO2aABd2rSdawPHK7mA3uTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337816; c=relaxed/simple;
	bh=Lrz7PRjZrfxGJZGrfykrmYmJ95UQygKaDgQoqfbwJBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qd5Eg/cOPpVRp4vuIIe4VgRHlFnpt8bDS/M4CI/ebJk84XLRn8WX98c7pQL2vhK0EIaFrX6w95DE3oy9QR+dYXubAxzTGPJ8WC9OAD7V7CfvuAHRb1zh7nC4IYl+y03XsEZBPskq5iODm/D4FCVQHqtsJLGAfga8STKGtd+0u7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=20KqHhEe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so718666a91.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 16:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770337816; x=1770942616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cewjm25vyFylPVMvzSR5194JStBoD/SAV+U0NBHpisA=;
        b=20KqHhEe6aAoFLzb4Gf7se9PVXhuLjY6J/plAOXtrxfZI3aOdnE274OYTyO9y3SeDk
         HtCz0rBkttSHzmExop54HmH9pEoBERes+ZUDm4FVheL51bFkbEEXq4u8oquen1lYXcZG
         U2KD19zOsGOj7zggCICXchcrW9PEjU3J9wZt6PdqDZ7paDHPmE1Gzd7AxyF66i+cLVjt
         9542L/NoobX4nuh04x9SduaigbZsndJhqGeaiPbYv5lfO7NJcrLnugAtZx27+42Qya9d
         oeeGWD16hA8caiZmIYf1lxR93U7dFcNB07LmXfkYyPn+2pwB3avwAe+bh4Pqcs63V9co
         tVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770337816; x=1770942616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cewjm25vyFylPVMvzSR5194JStBoD/SAV+U0NBHpisA=;
        b=X4/0UDcxxwUXJYPYP3WGj62kKr3F56VGQonmpO5IpFQZ0YUBML816Yr1y5VzRVuDjg
         aqpkzux6Lx+KLABVNv5GumuGg6nSVlyF/fZU93L4VYt0x9Zt9V1fzq6p8tn2QEQ6fUJg
         T6dD07RTsILwaz2emBov2H1y6bDRx3OXNygt5FKglNpBJXddCgr0d4DrT5RJEHckgR7I
         RZirOnSYCqh/WijdLxvSInbW89njGR6tChFjebs/1oRwcBuRzFQMj/6Skv1W88881euL
         4er60bFOF8EhOmyTm7CugjcYBqI/Yy8870K86QXc++a5gfMggbEH/boe4dGKiWeuxVN+
         JSWw==
X-Forwarded-Encrypted: i=1; AJvYcCU7b0bY7ouy+Owjx4/XeVoTpI+/zdUPnrZcdbjNlGrRjo5f8mi4uZcGhM2wPGnO7jIxeKe5o1naIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDiMB8r0cA54DSJN31i30ioMmWZm+81RnLVsnrtujXCHswHF4
	yEXfpQqLvKG3HQJF2s/FDwHopx55F7k1AOGRNZ73CQsPWXFZqF75xPUehDGMlW5Uo/E=
X-Gm-Gg: AZuq6aIyOrzrr5Ybp3urR6xvLZLhcI+R3clHb+tcNlNI55eejDHU+ZhpPM8usmnMnzX
	ZNIzJs8YPEOzu7bUAiFPChX1OqVBNOoT8T8Jj92hc1wUacl2s2TijONyeLZMNhHX5bTeZi9KzCg
	GKpycda97mHziJzixPcAue2d0UbOa9agzuXzORKk+lOXSbqyfX1FsOrAiiGFCnAaHiN0TITgpZb
	IYsY/l/gMU5P3yliQ9uBT5b5Vyjn1s/hCXgighoapqnGoqhaOUC37bnseWofjV3egvdUxmWGYxU
	G+Finkpl5PYtuYWriYI/fBaZN9p6QJji1HUA7DCiOFpYdLPWT2O6JlXV1XJ53+NT4n2WHYT9rG4
	c3038rOlVyfs7bqaqVrla6owyX/thqbJ7W8AK0xww5r4uHToBVMb6+ObTgDGtvtqvIqvzRO0FRF
	volLewN5j8
X-Received: by 2002:a17:90b:384d:b0:343:7714:4ca6 with SMTP id 98e67ed59e1d1-354b3cd821emr691436a91.22.1770337815549;
        Thu, 05 Feb 2026 16:30:15 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c4d8c4sm5468995ad.7.2026.02.05.16.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 16:30:15 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 05 Feb 2026 16:29:57 -0800
Subject: [PATCH v2 3/3] pmdommain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Lrz7PRjZrfxGJZGrfykrmYmJ95UQygKaDgQoqfbwJBg=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBphTYSpIjojiZfJLEYpkS/JqjvaZsb0vuBIrNia
 rdOG++dcB2JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaYU2EgAKCRBZNxia0/vG
 ZUmFD/4gZrv07jo5HJE3PBf28gPvvrkH/2dEl99SJlKShBRdL5iM43LKZ4S3AdZf+P9P9VQYfxB
 xVqI1O52XCGXKM+ryoD7gvmCYv7Rwlfg/af3DuHe1DHy0KxDD/R6bAyx4RRYjzvaDM6OfVzuSur
 mz+7UKmmRHgGRu9d0ppvxs3UNwc5ZHiKwQiVY4DD5jzCoFO4Y1JrHZA+sZBxAraMIYxi0f9oRe3
 IKM8lk1KF0Vp+PC0SQ+xlB/LbnfBelxk4U/+EAeZhw+5fEUMwUL7Ij/ae+fwnoi5p4dhNfRkYT6
 8fjCtr8F6vubWJLKyilsSjJl9u3M+/pbh+ltCDMCn8rzLWKXz2XvOng36NoIsxS5p9EWK6dans2
 lk5DWlcoMERSIS+QQ4nVjSfKUCqVqUcMEdSli5jeOOHJC+xZWBqsXeJYs2RXMuuKxJh0Hwvx1Bx
 Y/Iz6bBpXYfybPTxBGoKcUMvFXfRLhVDs2T/Dugm1KOHDm7W9VWAj41HYuDEFF6HIqAKAArnIbB
 1wdrlsQ7xE5dvObubFOZa17+SxAw/IKk6vJ9yNXxt+z01eolCjNe3m8+fEDq8sti7y+RuF9frrO
 OBkOJ5bB9kmxOpLLjunI9Bn0AyJ0qZK6FgEiSk8j0784217tiQ9t+7Di3A+nfxIky7RZpP8AewX
 5o6k+6WLxxjkHCA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42188-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D3A06F8A40
X-Rspamd-Action: no action

In addition to checking for CPU latency constraints when checking if
OK to power down a domain, also check for QoS latency constraints in
all devices of a domain and use that in determining the final latency
constraint to use for the domain.

Since cpu_system_power_down_ok() is used for system-wide suspend, the
per-device constratints are only relevant if the LATENCY_SYS QoS flag
is set.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 96737abbb496..bbf59b93c8b6 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -13,6 +13,8 @@
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
 
+#include "core.h"
+
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
 	s64 *constraint_ns_p = data;
@@ -425,17 +427,60 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	return true;
 }
 
+/**
+ * check_device_qos_latency - Callback to check device QoS latency constraints
+ * @dev: Device to check
+ * @data: Pointer to s32 variable holding minimum latency found so far
+ *
+ * This callback checks if the device has a system-wide resume latency QoS
+ * constraint and updates the minimum latency if this device has a stricter
+ * constraint.
+ *
+ * Returns: 0 to continue iteration.
+ */
+static int check_device_qos_latency(struct device *dev, void *data)
+{
+	s32 *min_dev_latency = data;
+	enum pm_qos_flags_status flag_status;
+	s32 dev_latency;
+
+	dev_latency = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
+	if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
+	    (flag_status == PM_QOS_FLAGS_ALL)) {
+		dev_dbg(dev,
+			"has QoS system-wide resume latency=%d\n",
+			dev_latency);
+		if (dev_latency < *min_dev_latency)
+			*min_dev_latency = dev_latency;
+	}
+
+	return 0;
+}
+
 static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
 {
 	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	int state_idx = genpd->state_count - 1;
+	s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
 		genpd->state_idx = state_idx;
 		return true;
 	}
 
+	genpd_for_each_child(genpd, check_device_qos_latency,
+			     &min_dev_latency);
+
+	/* If device latency < CPU wakeup latency, use it instead */
+	if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+		min_dev_latency_ns = min_dev_latency * NSEC_PER_USEC;
+		if (min_dev_latency_ns < constraint_ns)
+			constraint_ns = min_dev_latency_ns;
+	}
+
 	/* Find the deepest state for the latency constraint. */
 	while (state_idx >= 0) {
 		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +

-- 
2.51.0



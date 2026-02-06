Return-Path: <linux-pm+bounces-42187-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNQNDHU2hWlf+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42187-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895EAF8A7C
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742D530305C7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF692236F0;
	Fri,  6 Feb 2026 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lu93CKjL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD32253A1
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337815; cv=none; b=jymNc2dA4Vc7/FxxYMiEPOWgHYlG3VvEjbzgBK6rFPftTLwtIj3yhNGYOWELqAyakoxE9rykFLardMgIbezrzoRP1VBWId0aQMISxyF8IcrJ7PhNLRj4uZVAbQV8EwQT+3aWDC7flhi9ZDn+YsY13bsZKmExWxFwiNWhKkTr0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337815; c=relaxed/simple;
	bh=Kgntq9uZyzEnQnUEouKXldKwCVaQgcJWIll2FInth/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8xNmeXJRnADObpfWaosOtm9am5jo26s97LE+1vG/+/CLMRfHmlgbdGt0uOz6yw8Qt40xup8l70r44w9mB+yvV4PnAAzuNMEujyz1qjgmrvo4bBs6RIKzipR962Fp6TL4Gv9/krXjKHYD7soaplJgql9dTeSQiqxt0g/rl57sHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lu93CKjL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7b47a5460so13104025ad.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770337814; x=1770942614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VYhisuJCgn7/wzkvegovAuOQw3aJxeJXxeQKQTcm9c=;
        b=Lu93CKjLNL+ndGCh4YZWr/Rux3rlLfyH/0Fz6Eb4hORK41ye/pqzJdZ5EiSZbTL9Jk
         cweBwjHJHTPTq5DVlhoLheWbJhx+WMY/fkJxvp5hWFjjISfVpBN8HEVjLVQPcw5VlaiH
         JU9WlGGzpOWlb8BLtzD4+UEVSZTuOCU8Gq9hVm8ck3PaZbvaN5q/39E3GpvRjrJvvzCM
         xZKu5xYFg/cqabSOUt67bGfknB5ArZ7TYOX2ol/rEiLZuXcjmbmjqfFmfohT8YEyw3KQ
         ps2F+AdeV7/CXnegdgI3iMkFkBHySCpHHjexFeonWNpKSjVW0yHAco1fVf5IKSwwemGO
         GZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770337814; x=1770942614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6VYhisuJCgn7/wzkvegovAuOQw3aJxeJXxeQKQTcm9c=;
        b=UOvX6SxWyjCn9P7nn1aXAZdSWd5Tdenrfayzvf1ddMFNcbGKvPklfNAIXTuMO2wiJ7
         L/EYbFYl8RciCEi2mXb2hJWJRJaEF7yp37k2nOd2hgs58vfukoBfpnu4W1o8muAGo2aV
         YSiW+TfAwJlJFlFKezG9jsLRiCcv7ef/DQmNhEkNxLbpVwqQD4hxEFSKvQqxv2qhmNmh
         nzJfwYh4F/NOahijRPzG8dmT05vehDJCYMLDsKTfH/KKfneP8/jn4s5IuIwPeymnzB4y
         Ty25/ds+JlbUhkqetCTblXGO6xaKqBlF6VA16HK1l3teBegjbx9nxC5YTa9v9CEmUCuN
         oODQ==
X-Forwarded-Encrypted: i=1; AJvYcCWllsUgQJG7vjPcB8jh5X5e1OWt54NQ6zgQGbN551ZywBEjC1twe5JK9ED02jc4E52e7Vjtfe/U3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKG4zON9bzIlAOeNPvZUEx5QucP4r4EG06FrejOZBUBID4UJC
	TZf1LO+qEx+FE6qYCKL2Sqbjd+Nez3HWDqQGYAhSDJVtiS0TnrtdPF1Z3kjm026QLLJWKvw3zdC
	rjViWNjM=
X-Gm-Gg: AZuq6aLXCiqHGKffVdgV6UVOfSp72EIeWJCPf4EBuOuOzvxzNAJcpN+DJmswXt6ZgN7
	A3F1/7OZgafwO9GMf/pfDM0d4kAG5fXy44RH+IE7FUU0uJ9kF77coCFec42s5u/V4My8jZbSiq3
	QtdUHtEgQXS/O4P7KKdKPD3RdJXNSLO3oeEk7+6eeTbVg4GE2mNZzpYilD+/PRPOZXS5na0GUFr
	9mQm+AuaP2UnhYkhBoX/t3ABSZpywfI45saY8z8IuYt4Rrn1+PHqs7sA8DJ69/o366kP0Hw9No3
	z8OUqdbP0o+PjR6nQJ/V88TW8jJLR4Kg56Br7bLnZIf6gd0ctD+kxiZ6M7kRJcRc35jmL2yKdtJ
	qWr3sEmyu402+h7yY8toxWUlGGUHsvsBQa2ng7+IV8s+bMml6bNhIojI6NVtfoTppOTNVYsrYvl
	0tW12ui/s9
X-Received: by 2002:a17:902:ccd1:b0:2a7:8486:ef13 with SMTP id d9443c01a7336-2a9519fe104mr9108785ad.29.1770337814137;
        Thu, 05 Feb 2026 16:30:14 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7e31esm5555665ad.28.2026.02.05.16.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 16:30:13 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 05 Feb 2026 16:29:56 -0800
Subject: [PATCH v2 2/3] pmdomain: core: add genpd_for_each_child() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-topic-lpm-pmdomain-device-constraints-v2-2-61f7be7d35ac@baylibre.com>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3526; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Kgntq9uZyzEnQnUEouKXldKwCVaQgcJWIll2FInth/k=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBphTYSOuD3/5V9Lr0GRm9Cn6aAYwd9DdjrAAtwZ
 MznTvfikK2JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaYU2EgAKCRBZNxia0/vG
 ZcowD/4uh5xOW2Otf1K6v8+eritq27XJUooDMcRBQAIXcKqi4hlBszDuUvqyTDj3xntlFvCfAu3
 0W8fYX34Owc38zxhlllXWWqYLncZzzi9PeG3qlynuIdkqeN+0A7EQkBFSUntu0o0Kw8QGWBqfrS
 8Bi4S+R6iwyCb2o6NM8BhRAoc8gbQpxNY8yJzWnOYRW8PIjU9y69eRuT0lSQmzlwNejzyxu45+b
 S12yCw6wcqc7967Y0WiwiCBGdXvKE5V7icOcU30+e9JldYAKHGGl25tFYGYcRjgVs8R+7EIqE3r
 N7yVJHQ5x9eppu64TpxgVRWUCU+AxgcFhPsB0YZZGAmi7D520aeNX2/8ObLPoQHenMf+N8qqXqz
 CNnPgdKDk356jBdz7bjE8u3pjxETNQtMM6bWpj1DF1orRIhQs4LsA/zRfga4cNJcHNlm6x9c/JL
 1fu3z/QkTEXCHrvBmlrxdvJFhLMOwmLsr5AgJhjGn4tPMkAPLloFaeok1XmmtVtfcPGaHD4ludc
 PzasCMmWMLH1eYTYCQ7FuJAgPzGbG4OVU3QntUDsRizXpWsCC1Smj4R4j/UR9UT0ugf++sQfySx
 xk/GNgox3UgONLYeoxKidzoUfxmaNlmNuGkwdJRqMu7dQPrWpltiMaQzI6injWobX2vZORtmRJ9
 eKIbuqfKIiP7REQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42187-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20230601.gappssmtp.com:dkim,baylibre.com:mid,baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sisk.pl:email]
X-Rspamd-Queue-Id: 895EAF8A7C
X-Rspamd-Action: no action

Add a new internal helper function genpd_for_each_child() that recursively
iterates over all devices in a PM domain and its child domains (subdomains).
This helper is useful for governors and other core PM domain code that needs
to examine or apply operations to all devices within a domain hierarchy.

The function takes a callback that is invoked for each device, and supports
early termination if the callback returns a non-zero value.

The helper is defined in a new internal header drivers/pmdomain/core.h and
implemented in drivers/pmdomain/core.c, making it available to other PM
domain subsystem components.

The first user of this helper is the cpu_system_power_down_ok() governor
function, which uses it to check device QoS latency constraints across the
entire domain hierarchy.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.h | 17 +++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bf82775f6a67..41c987fc5c5a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -24,6 +24,8 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+#include "core.h"
+
 /* Provides a unique ID for each genpd device */
 static DEFINE_IDA(genpd_ida);
 
@@ -281,6 +283,46 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 	smp_mb__after_atomic();
 }
 
+/**
+ * genpd_for_each_child - Recursively iterate over all devices
+ *                        in a PM domain and its subdomains.
+ * @genpd: PM domain to iterate over.
+ * @fn: Callback function to invoke for each device.
+ * @data: Data to pass to the callback function.
+ *
+ * This function recursively walks through all devices in the given PM domain
+ * and all devices in its child PM domains (subdomains). For each device found,
+ * the callback function @fn is invoked with the device and @data as arguments.
+ *
+ * Returns: 0 on success, or the first non-zero value returned by @fn.
+ */
+int genpd_for_each_child(struct generic_pm_domain *genpd,
+			 int (*fn)(struct device *dev, void *data),
+			 void *data)
+{
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+	int ret;
+
+	/* First, iterate over all devices in this domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		ret = fn(pdd->dev, data);
+		if (ret)
+			return ret;
+	}
+
+	/* Then, recursively iterate over all child domains (subdomains) */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child_pd = link->child;
+
+		ret = genpd_for_each_child(child_pd, fn, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *genpd_debugfs_dir;
 
diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
new file mode 100644
index 000000000000..7061891d31fb
--- /dev/null
+++ b/drivers/pmdomain/core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internal header for PM domain core
+ *
+ * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
+ */
+
+#ifndef __PM_DOMAIN_CORE_H__
+#define __PM_DOMAIN_CORE_H__
+
+#include <linux/pm_domain.h>
+
+int genpd_for_each_child(struct generic_pm_domain *genpd,
+			 int (*fn)(struct device *dev, void *data),
+			 void *data);
+
+#endif /* __PM_DOMAIN_CORE_H__ */

-- 
2.51.0



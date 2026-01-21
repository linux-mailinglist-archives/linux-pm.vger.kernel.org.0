Return-Path: <linux-pm+bounces-41209-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKSZCQMycGkSXAAAu9opvQ
	(envelope-from <linux-pm+bounces-41209-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA94F67B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF0F1A0DA43
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F473242CC;
	Wed, 21 Jan 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nLXFexxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A82BE058
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960498; cv=none; b=UrZDTNcfm2uZ0t+amLAejBQYWGZ34ghONWEsCz0r5tsKrAQR+HwLOhxzjfTvUuTrvy4DwEG/Msv8ym3kPUx3FcBWmLTcT8lsyxMJGIqTn/lX1L69C0Ayx7YNgLG5Q0QjJgNLoRcbiGPPs5jv+lL6OUqwxucKi68NKJIGsGMTSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960498; c=relaxed/simple;
	bh=m50F9JiuRetfBHd30wXU12P9n0yh0b4IyX91kBEVf3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHr6cSnWsRXBkV7zvqGYzBIU/9zYy9dlLRVhHiO/5OdMZE/VJt9w+Y/Ad6NIkZRsrfkUV8kYXflJ00bR416T9gjVAdOi9YMn0j+cL173roEuKTo3SrcpMBBZzH5fGh3fj1N6J8g9pJzEhsxlyOKToc8Ri0umycBmi5Z6MWl4f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nLXFexxH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81df6a302b1so4944652b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 17:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768960488; x=1769565288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEdSe9hSCornkFcn2jbum3ZEMbO3Qyjg0eU8ilBKTtI=;
        b=nLXFexxHuBWZroLU9qUurEmPzQS7Gfrg+upXZYO6lQLu4JoHzN7EPStTQEJkliM8fd
         lvXrFqNpqC8XxaA2f3wtE+ODy8mNixie9qaBXENDjL90dJfh0Fnm6kuXBeILVtRokDL9
         vukN2Qj7QUBO3TpnqsBQevEeamhAkALXPLbeypPpu3vkXAvq3uCHI9+W7VcbkhH0ZOui
         4KIPXz4VRfoqLs+nuKsJWLPntFMlmv/23WW0iCyMSBFET1/Jahw15n4KPj6D2RWjLxvK
         PLd5pYYYIXauKp5p6X0HLSlv8F6Max8a3ilMURzQW8WW6IyYiHRFeTWgaY4obbR7x+iC
         orSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960488; x=1769565288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aEdSe9hSCornkFcn2jbum3ZEMbO3Qyjg0eU8ilBKTtI=;
        b=DgZjcXxf9pc8Ka1o/qOVPg5DRxNtRS9RVEXcyX+lkm4qPuwl1bblOVd79JHmyfP49U
         t8DdNFh5UjGwf1qaFp8JNyhrEGdJH1fabuQ2paL+Uza6NdHBdHLu7Sj3vpXxyDd7lGam
         WRIam28OoSNCJ0yXzkdg1m1rXzY1kCmwQgOzMuXDudkcAUy6U3v3UGpKXDPi+dSC03D4
         4Rnf9qsKDkDkhj/Q70yTrQIigrGTJJC4ZbewLtRp6ZFou3S7A0vcXqFenWML0VBWu571
         e2Ou3xPL18ePhvLjHNYw9oSU3rJLEC15QbcLMeK6SpNlgpYmLxo/NSLWXOOngwztOVz8
         HHig==
X-Forwarded-Encrypted: i=1; AJvYcCWE2xdPm00e9bMctLqrlI/dBEjX39dTkaL+mD5aNvn/2d76dpx+49uTdgnBK61XEe+ZdIBTWeTJpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaRBG9dVwTAwyVF5IRL6fprSojhyOk9zk2Hs2ut8u9vUXKxmj
	tqcibP2xWTeAfgRE9weV9M0vEFKNfCDk5YypzDeqvIKiLKOhpxf4mMos2H1VCpAByYcvcR8qERD
	iEKyhHMM=
X-Gm-Gg: AZuq6aJN67zDWQl1bFkfEWDtkYli+Yty0qIWiFTaMJt+ffGvteitvY09aCOCJhkR4fJ
	0ajz9E6cs6Bg4xWkwqomwqYEFhG6+3oWQyONDLoVKDL6AOEnlTuORBGhIECX87IzSkz2q4642UT
	1LGHsVtncqr+t7dZo0U7G6P1GyLR9SSy1XJAvuXgN85Z8M/F9kJ9cN0jVqBvieLm3TOM79Mv44x
	t7f7an6nZUxtI96ACaejdExJlbkk7q9GxpENAlHt7vnhDNNfEaDTLzlgnxGiLVlL2JVYHEWPofP
	PYfvwvki4dRFBT0e2+OkAvu7c9kJqu8TiHVYfllbi9uhUHMY3npT63Ak3/hqNoTnfr9TKeOm3AE
	BxdnNBGOOd1JaqTd/I80C3g+/rHJ+1W54fbXnUiJBEPT6vp+WB0m++7ilRBUiPhm8QscNokPi2d
	8L2zTmGbR2
X-Received: by 2002:a05:6a20:939f:b0:38b:dd1e:ef4b with SMTP id adf61e73a8af0-38e00bf6ca7mr14314892637.12.1768960488444;
        Tue, 20 Jan 2026 17:54:48 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm134762075ad.22.2026.01.20.17.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:54:47 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Tue, 20 Jan 2026 17:54:45 -0800
Subject: [PATCH 2/2] pmdommain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-topic-lpm-pmdomain-device-constraints-v1-2-108fc4cfafce@baylibre.com>
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3792; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=m50F9JiuRetfBHd30wXU12P9n0yh0b4IyX91kBEVf3M=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcDHlxhHkg4Aur/xo9q0I0miLjCgRk5YJxSzax
 WANNtjwKxSJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXAx5QAKCRBZNxia0/vG
 ZfY5D/9vltNKG6iYdCw8hJecbXFfiX9ldAv3xUYm00yeenDCTM6NZcjlOZJXkHNu+K4RK4J9UW+
 S55NSZ3fTINdNBHgwruSmP5/dbxHOW6HPhSO7F7mnUbS8PpuP9gs9OzuD5snYZM8fPbmelH4S4x
 mVrHmk3eRoATHUIkGCwlL4bXkPuETkr9dvPds7siRbWcBs9+sqFjPI0vrll8ec1LSNP2b4hyjpm
 olUcXrHogANrrkGsCkimzGhc613qg/SXft1iJNTZjHI/7d+UVtwurohh2KiZtCYlzPPEgYCmE9J
 yemGeql+W8qlOAZnmv+JMYWmkX+GgBiB0O2QG5q7jPWWyzyVTCNCfZBXFqjaNjhbcWaTXmN7tDe
 qK1dWJgZ/DZgMf6mJewBl8pPev4wkzlYu1M64tWDepha5yApFYNxI59Qe9kt/FpJRDqaXGkSyol
 QHrC8vnrPtBVvLcvbYZkAP71vZkiHha1gdIR1jyxja4hth/GjSsQq7GF7NNlRfikbiKo00lzLWT
 kpXTXXoq9izafLM75Mcua2mvOPasm/+d7LgtzirXd5pUGa/+LAsgp8ZgbpqBP4SHZtk8rEhPS3r
 2hOcsfDpWR3lEBoWOFhHMmmnPMMgJXr5/T6Fwr8JK3dX8CpZAKhHiwYE7p30C8p3l01CI8LbLk3
 ALBZyiJTHdSj/jg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-41209-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C4CA94F67B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In addition to checking for CPU latency constraints when checking if
OK to power down a domain, also check for QoS latency constraints in
all devices of a domain and use that in determining the final latency
constraint to use for the domain.

Since cpu_system_power_down_ok() is used for system-wide suspend, the
per-device constratints are only relevant if the LATENCY_SYS QoS flag
is set.

Because this flag implies the latency constraint only applies to
system-wide suspend, also check the flag in
dev_update_qos_constraint(). If it is set, then the constraint is not
relevant for runtime PM decisions.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 96737abbb496..03802a859a78 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -31,6 +31,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		constraint_ns = td ? td->effective_constraint_ns :
 				PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 	} else {
+		enum pm_qos_flags_status flag_status;
+
 		/*
 		 * The child is not in a domain and there's no info on its
 		 * suspend/resume latencies, so assume them to be negligible and
@@ -38,7 +40,14 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		 * known at this point anyway).
 		 */
 		constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
-		constraint_ns *= NSEC_PER_USEC;
+		flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
+		if ((constraint_ns != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
+			    (flag_status == PM_QOS_FLAGS_ALL)) {
+			dev_dbg_once(dev, "resume-latency only for system-wide.  Ignoring.\n");
+			constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
+		} else {
+			constraint_ns *= NSEC_PER_USEC;
+		}
 	}
 
 	if (constraint_ns < *constraint_ns_p)
@@ -430,12 +439,43 @@ static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
 	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	int state_idx = genpd->state_count - 1;
+	struct pm_domain_data *pdd;
+	s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
+	struct gpd_link *link;
 
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
 		genpd->state_idx = state_idx;
 		return true;
 	}
 
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child_pd = link->child;
+
+		list_for_each_entry(pdd, &child_pd->dev_list, list_node) {
+			enum pm_qos_flags_status flag_status;
+			s32 dev_latency;
+
+			dev_latency = dev_pm_qos_read_value(pdd->dev, DEV_PM_QOS_RESUME_LATENCY);
+			flag_status = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_LATENCY_SYS);
+			if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
+			    (flag_status == PM_QOS_FLAGS_ALL)) {
+				dev_dbg(pdd->dev,
+					"in domain %s, has QoS system-wide resume latency=%d\n",
+					child_pd->name, dev_latency);
+				if (dev_latency < min_dev_latency)
+					min_dev_latency = dev_latency;
+			}
+		}
+	}
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



Return-Path: <linux-pm+bounces-29943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3DAF0663
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213461BC2646
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B126A0EB;
	Tue,  1 Jul 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc43EE+I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18617C91
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408084; cv=none; b=Dt+oeOaQPozDhykQaJz9+LxkCWc2/cDongmde63GEAXRssMzyDqV8Bn5Tg7yltS1uHjJIgQdCBrHlPlvnPSr/GFzFoZaK9pm1no34LA6MVMXvDJi4tyd+kMKWWXa8t6VQk+InVU0Z/mfvQsNN8UwuhZQC1R6rKT/xbOzV2zkOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408084; c=relaxed/simple;
	bh=4HTXde3wZn3e8R9vMjGA8GkBevtC7qMn9QnbaLg22KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRJGDS8CD86SDt7c9Y/py+kzJMzHdnfOUePzlMbDzvSlUR0BoJX7XVoTku+YqQu6aOrdgpcvVk7wqa1AHsuU/DBs8UU5yEjzUYbgbD2eQcxZDxGPuzddb8TumYzlBDx33RVtV54ELY9DQqTXq2ow8mMmQ2625lP0i4qtJpmGXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc43EE+I; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a522224582so3245902f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751408081; x=1752012881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiTipLh2pzGLpF7l5i+J4rDWhXcPzaLY51qoe/W5Rs8=;
        b=gc43EE+IvtQxKNpLMpmFHOngqbIZq9lVhy5ownye1CJt3Zm+5DD4FasD5M+yxMA7Vz
         dFLLunExX0dItWPtNbwu1tynMwpv6EUskok3eUcnSqg2bsmLP4e4xnZWjpD349+sVHtQ
         EhHdliOyUCccdn8ASxZfL5sgEGGpiUjU4RDkzzvWRAKoIdrwNDsZaI/CRChGFADjQzp9
         YamOSt4pVdaBlwEFTISQ81gFpMgPEujH4XG9X6y93+M+aSqiTODPQdUiIRMoFXsX2SQu
         1Z1lfnxkZtz1wKzMozBQU3uzXMYMZDPp9LwOcwFWy3vQbt8xlcrjOGUOkLFhehne1VJ1
         WuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408081; x=1752012881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiTipLh2pzGLpF7l5i+J4rDWhXcPzaLY51qoe/W5Rs8=;
        b=Omg5g+w41EDLMI83X5sLKKVuKTN5BTCWqqNmJixza0R95N4HgLKdh1m2MZvK90vyfA
         o5gWcO+LdAQnSR7X5+q0Dyrj6zg+N3wHvJloMpj93gL36uic9R+sfZqH+8BjamdAF5X5
         W+NICbmV4CK4XMDfDEdnyIdhVYpuC7b8FzUMyUHIa83D5Pb+mt7RoUiBU4KX4LMXEAA2
         a5+UD6ddm59qf4f8ji2NIPl5ya9sRo0M7qsakZUxnD9VR+INAb8LNrCZL3lbmWj5dqCy
         4oYpA/9bajapxOf1fHgj8TMTQj6g+fhO6IcWSHctvlwD7LE43gQ36f6VdLTwscL0jSCW
         W3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVGT1dE8nSfvgMpGb3WCkNqmL99WzX4oPTCdYUSnOMST1X3vvvv+UF7xvmVVn9RyuMUP+tzdA/Ytw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0bnX5wbbB0KDGpr15NBmQIPyaNWRRWhVDDs8t8Xv9ETfqoOH
	ZWMk8Tb2jEIHG5MHrChMn8kL+FVNHeTmxKWwDeWNPQVd5Us4g+JMgFJa
X-Gm-Gg: ASbGncvmJQtGXZdY60n1Ied66ZHG+a81fEf1E+lFLMOyytPXU4OBzUfkIv6Zow263EK
	ydKUJy0xlaFDvOlu/lMKHNQ7EPGSDwIazz/KpctukFsUP9+136UEquQdUZsQEzYtdT5jPeJNU9F
	93Xai+zoeo6ShaD+G51KkbO5g6cXOf6b6Y0nqXEE/TIyIL0mz3zE8X8NKvE/YoUFzksGVpKU0ZI
	ExXVcd+4beLmpf/7uKrYoE9c3aLKhESiP9Ebyr32wRnLx+KcNPPH7EfkLbJ7JGObruuGHnfqZYt
	82S2EXNEw+Xp+YGlmdpdI96M1uZRRndOb8Zcvcx8owlrybg0R/dpyxHEEk7uNQTup7ZToAf6AB9
	WsVQB2/SAuND81y24nCwDzwyPpLU=
X-Google-Smtp-Source: AGHT+IGkS5eJtYVKv1x6gdzkk/49uoPiaLLs1y432JXqBArE9x6HNHh+0ZC/SQ4Vzhqz2XCZvgwIyg==
X-Received: by 2002:a05:6000:1447:b0:3a4:ed10:c14 with SMTP id ffacd0b85a97d-3b1fe2de3f0mr154968f8f.14.1751408081006;
        Tue, 01 Jul 2025 15:14:41 -0700 (PDT)
Received: from localhost.localdomain (89-139-4-59.bb.netvision.net.il. [89.139.4.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453923a22fbsm136795215e9.34.2025.07.01.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:14:40 -0700 (PDT)
From: Sivan Zohar-Kotzer <sivany32@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: elazarl@gmail.com,
	linux-pm@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>
Subject: [PATCH v1] powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()
Date: Wed,  2 Jul 2025 01:13:55 +0300
Message-ID: <20250701221355.96916-1-sivany32@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_pd_power_uw() function can crash with a NULL pointer dereference
when em_cpu_get() returns NULL. This occurs when a CPU becomes impossible
during runtime, causing get_cpu_device() to return NULL, which propagates
through em_cpu_get() and leads to a crash when em_span_cpus() dereferences
the NULL pointer.

Add a NULL check after em_cpu_get() and return 0 if unavailable,
matching the existing fallback behavior in __dtpm_cpu_setup().

Fixes: eb82bace8931 ("powercap/drivers/dtpm: Scale the power with the load")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6b6f51b21550..0f1c19308f46 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -97,6 +97,9 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
 
+	if (!pd)
+		return 0;
+
 	pd_mask = em_span_cpus(pd);
 
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
-- 
2.45.2



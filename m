Return-Path: <linux-pm+bounces-22696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42AA40178
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF707AA928
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F4253F1C;
	Fri, 21 Feb 2025 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xihv17xM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CF253B7A;
	Fri, 21 Feb 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171419; cv=none; b=VQYWnOwV9bK588GabQsDmR9uxa9ppKYZt6B6PEwqgi7LuiXLNBjzHg2H3OwVdi0prrCi0YUKho2sfKy18pSkO14m5G1AcdXlWa7/7SIs+Vbp8+PBeHJFvkbBpwDhjOyu3UWxDFIlyXRBolnH6MhxCDOMiCq9cwcKY9vXmo04rYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171419; c=relaxed/simple;
	bh=QUMElo3V3F9zxTSpJgoR9R9PyCpJqP8Xz/KTGMho6Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZwK71xd7+KstCvoO1PdydtknrQg5ee+6GsjPPnrO5KwqqH2+YI1UJemxX4ZppA2uFQanXjmPhz2gn84C0TMIMaeIAH1+omnaOZE3LFuXoGOsAhvEs4qPUKIceDwrpjOBpSpFoglZmHvO/NlTRNDvEFvsdMC15Ti0Gi2CWYZd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xihv17xM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso56397955ad.2;
        Fri, 21 Feb 2025 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171417; x=1740776217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paCgM1bNx83qDai14zRwjLnTQ/ATfDA7bHgMh2vXV+4=;
        b=Xihv17xMkp488SXVTa1vRrK/Ta//RxD3AgKs/FI909yimVirmlYX8tKy5zP+zt02te
         Eg7cKITnSN7JnVcZpTntoj9/ESCbMu/X0ImIcDvO2wIKrtgFGJ+RLaM8le6/WcUPUyXc
         JsZMJT8nMXuh/lBCpshSgqOdsWqAp9PICTXgmXqaOHYGtrKrAGhszYN6BY7cPgLS4kA4
         /woI/E3MGNaEwPp7FFJ6kCIOOme7ED4hnLrvKUVK65RAeRtPmFbTtynxIqlUfovwNpIl
         2k6JyFmhXIlLNue4f62XWro41P2XhM6pYqTdMVRwAdm7T6Dj7xZOP9xOdGc7FUCnrUU7
         ECsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171417; x=1740776217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paCgM1bNx83qDai14zRwjLnTQ/ATfDA7bHgMh2vXV+4=;
        b=cs1WLlZoHlVl+fwyBAtUviBJQEzA5EiYdaPMwJwrRFNcDOHz2DDckT8dPQWyCFOZk8
         WD/gCwxeiii3KXPtctfEelMuncRR5YFMJ5rTe17sl45YHl/L3bNtJIPJgh5IuuQnFKlX
         FuyJ66b93y30f2cypVijMIDPMzIkuf5ysHChOCxAIuxmgyJebcax6aULARKTRYn0sIgw
         MY+pydfLiyxR1eeyb4s8XzoCdrbFZ+wHX6RqYCTgsTYQKw26k1ghRIQ2CEsZALz8V4sx
         6EGEmrdU/5yyo+R9v097bMRPfWanX5VoJerQL5p+z3B5pSSgqXEiEmBLODHDfRvNoC6D
         A9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb//NCpvS6p5z6ANeXq/gZ6k7pYaMtNsskcjs/BCI6X4aMgZKHQA9GRArRVuMTtCTFHHimwQfHGtSuSbNPe4U=@vger.kernel.org, AJvYcCW/W+9S0D+Tw4BD2ghoOnQCHgXg8FnU9/PnqwLYwUWCGUoKOS14vt8BGZ/1sSkuKLegV0wCBe6WIAGZ+yE=@vger.kernel.org, AJvYcCXISSejOlLfjPHGLAlWRzlr3sPpMyr0ALozmstmuznbv85fK9VBhpR1U0PDiHsL8mVsqT5ILgwIzjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIrMd3O9rvwZLpDBw7Xrc7zJ/BzRzmIXbYBpVMNGgzMAicyUf
	1LWWQj2Hnv4c7JqaXKsha8GCfy/sNgYwKeh2Cc/0cEQV8kZkhs02
X-Gm-Gg: ASbGncsNsdf0HEXlmJ/lz37hhCSIcWNspqzEnX7shq/xwyzuqBZ24c9mk7mFQZVBEL/
	RAYa6Cm6txFiYibrgZXrS4zIktQSSORLT13TSg73Y99nnDwFLOMu8iTfQB2+vL044KYs1CsWG+9
	4363lqESxLFf/Bk+r67xrw0XJmbBuPhIHc+FTobRO+eKJ9hpiWpOHq+BXtKvycGoql+9Oe9kLzt
	FKzi3BNx7Ts6kjCV2IHUtQfQT2jLlcxclrNSLyOV3OLloYpbPkfm0NAurP2s9M1S0Wn/lfwUEM9
	YkU7ONGckdEt6XXvljFsbVITFg==
X-Google-Smtp-Source: AGHT+IEhwcXAnqVz+vvUfY9p+2PW14yyn57NUFF7bxWfhMxbH3vkbFsnwsXHmLcMkYgcoOGbYy/Sjg==
X-Received: by 2002:a17:902:f60b:b0:216:725c:a137 with SMTP id d9443c01a7336-2219ffb8b58mr83271265ad.28.1740171417524;
        Fri, 21 Feb 2025 12:56:57 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556dc4bsm141724985ad.188.2025.02.21.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:56:56 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: Add cpumask helpers
Date: Fri, 21 Feb 2025 15:56:37 -0500
Message-ID: <20250221205649.141305-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221205649.141305-1-yury.norov@gmail.com>
References: <20250221205649.141305-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

In order to prepare for adding Rust abstractions for cpumask, add
the required helpers for inline cpumask functions that cannot be
called by rust code directly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
Yury: a bit more wording in commit description.

Question: zalloc_cpumask_war() is a convenient wrapper around
alloc_cpumask_var_node(). Maybe rust can use the latter directly as it's
a true outlined function? There's more flexibility, if you need it, but
also a higher risk that the API will change: ~40 users vs 180 for zalloc
thing. Up to you guys. I can send v2 if needed.

 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 40 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 42 insertions(+)
 create mode 100644 rust/helpers/cpumask.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..2396ca1cf8fb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
new file mode 100644
index 000000000000..df4b1a2853a9
--- /dev/null
+++ b/rust/helpers/cpumask.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpumask.h>
+
+void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+{
+	cpumask_set_cpu(cpu, dstp);
+}
+
+void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+{
+	cpumask_clear_cpu(cpu, dstp);
+}
+
+void rust_helper_cpumask_setall(struct cpumask *dstp)
+{
+	cpumask_setall(dstp);
+}
+
+unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
+{
+	return cpumask_weight(srcp);
+}
+
+void rust_helper_cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
+{
+	cpumask_copy(dstp, srcp);
+}
+
+bool rust_helper_zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return zalloc_cpumask_var(mask, flags);
+}
+
+#ifndef CONFIG_CPUMASK_OFFSTACK
+void rust_helper_free_cpumask_var(cpumask_var_t mask)
+{
+	free_cpumask_var(mask);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..de2341cfd917 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cpumask.c"
 #include "cred.c"
 #include "device.c"
 #include "err.c"
-- 
2.43.0



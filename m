Return-Path: <linux-pm+bounces-20309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B92A0B567
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC80188481C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA223DE8D;
	Mon, 13 Jan 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfRBwU6z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179823A59C
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767433; cv=none; b=CBmF2ZQSFx1GxtaxqpKyCI7kNZZftXyUaXCyJ8lsRgiodabd/tzd1Q7g8U9sjtARVwPqivZpAXNX4WSmA9SjZgeVQOeVyU0fGlr5MCm28iFjl1iOmUCoafPl3MBBGHjFuAr3pNzXVH6OYTEaM+7Gm2tfHHFY/CYYTvjqKWF1nDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767433; c=relaxed/simple;
	bh=zpYDXqsOf66H5oUlZfzc8U4T3Ym6DA5SpJV3ddgDOqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMYjev1zbuQ5QHshyPV+Vw8tcoZtwOwez9ux0dvPa6/TplsJrldeQj2OBml5RnJYGpYRRaoyDLq2QSQkqqmvx/xnDSFMqxuIeS9VqoWZxyCD0/m9oEBWEV/LKFjuyVQM73M/Epn0T5lBY5jKrSzEaa68SQKEP00fgt5z7GRKBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfRBwU6z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21644aca3a0so89656325ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767431; x=1737372231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pq5lDpyHLAZUwHZL3qfvRqj8bZ5lnU8jFdny8YX3GE=;
        b=bfRBwU6z8Kn6jFtS42kbw6bXFOLddaA5LWH0bKWeb5vLVwycl94DItaHPlemQ18CKh
         zrBAKVKpPyNEhvl3wpiHZnbDZN9TOd6cYLwIfcHbyGJVA0NPrr9DPV2YsD3nt+DhS6Cn
         a3AxVjNvRyneCani2PgMDtFZU44XzJrL+llO7qBYV0kvSwwrkhenDQrKzfrQJaHkGwnW
         TQoPqGL5PBWxFumNaKMkujGhMMtkWZ9J69+p20VvMqMaicmcFKgosfJcxBmBoWKMjhnC
         95xhRvAMxwHeFa0qReX/zJi6LRRhFrJ7n53TArofUsBfJWuWhsW9AoRFgbw/WgxS/T+t
         4wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767431; x=1737372231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pq5lDpyHLAZUwHZL3qfvRqj8bZ5lnU8jFdny8YX3GE=;
        b=cQS+NxwGeogT1em81ROFD8ngjJ1rCN3qY6G7K5wQAfVFLnVai1eKXyHULZWCAPVIWz
         UvxXL/Y1c27vIWxVP9qTDIXO/AZqmJbgODbthQNOqciqyBV7QKouquRQcnKHpnW12bvo
         NggNTqWeeL2n4YGvLTD+r/sbfBV+/6YMX3ajSwaAzHgKIRlnZ1H8O3ukTRby9dCBc7MC
         LIJxIuOylES6gbuIjuCNCOc99zs4HC9o9Its+iOucU/SpKgszQc1+S84K+AldJHc6VWy
         dcNe7K9QiFpI4jJ8jWiuNSy7+EyJEb/ipv+vxfOy0ETsL00e0E9diRgnjLhJC7OuOYHd
         KeTA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBhDNX5UOlVAXjyqEkniPDh24NiQIjqdY32gQ2+pwINvYoaj8snBaV4lCbR3yNK8i7USZnHzKhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDzg9ArTP7vK4IVL7keveLRBZMRcF4ImZdcURP2h0/KZrIbrO
	twDPNKD9ar1T4sqg9AxjTrs6V8gZRTieUDPcJxN3RPZ/sIXS825wpbeUgx7tAsg=
X-Gm-Gg: ASbGncvQXV/HrXNcz3/dPVXGZGG7fq1GwbnKQD8A6vsSsz+CIzxfn9S0nvgGmOmWgHH
	6cXMpYjYVD7roXQaX4ZCMun0WG9i9dKtdsRB7Sl3E5v0yQGD3WxYl4akxFUtYr38GAAuX3oplV4
	N3CIeXsa/rVLcW7hzY8mdal613vvrKy0VFV+qrdLabQi+GseIBk5b7Guv7vK1TqMj6lOhYt9kMD
	qJY2q2dkEoZvcxDbz5mPhkOZhQm9vq8rNAGHcatMAlMIsVfQ+RkrvuvNkE=
X-Google-Smtp-Source: AGHT+IEOjxJGVr7HBQVa0jzU1CKfFnjVBIzuSJp/j9DkYQxsSgo0CuPg7K6fdft0Ynvn0NGP+sGtsQ==
X-Received: by 2002:a05:6a00:10d2:b0:725:9d70:6ace with SMTP id d2e1a72fcca58-72d21f5c141mr27897173b3a.6.1736767431251;
        Mon, 13 Jan 2025 03:23:51 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681b3dsm5683664b3a.153.2025.01.13.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:50 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 05/16] rust: Add cpumask helpers
Date: Mon, 13 Jan 2025 16:53:00 +0530
Message-Id: <5260b6f0308b67ca5cff002e95108504f04cf923.1736766672.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736766672.git.viresh.kumar@linaro.org>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to prepare for adding Rust abstractions for cpumask, this patch
adds cpumask helpers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 35 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 37 insertions(+)
 create mode 100644 rust/helpers/cpumask.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fda1e0d8f376..59b4bc49d039 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
new file mode 100644
index 000000000000..0b371826a13c
--- /dev/null
+++ b/rust/helpers/cpumask.c
@@ -0,0 +1,35 @@
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
2.31.1.272.g89b43f80a514



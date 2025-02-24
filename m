Return-Path: <linux-pm+bounces-22851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9042A43114
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1961896C32
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A220C49C;
	Mon, 24 Feb 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gklq07Bm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46418E377;
	Mon, 24 Feb 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440388; cv=none; b=bMqpzM7AjGJweSetR5gIFBbDJrfUmZfQrv4fH7sPBq0+O1zU5Sp8HNOiEU1W7DlHFurr2nSO8k8Ym+jbnL3aGupIUdHXFpAF/xi7Io/9TCDP6GLlzFAKmKqpTtcM+E7uWxDTGQjn0ESBO76AuSgfjLbP+AJ0gbhbueg0vlEK4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440388; c=relaxed/simple;
	bh=JVMDXIQEjx/OPBpAvdxhYiWGWReKh3WO9uqZW6UxKQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkhX/yY9v6AHFn2rqRkZoFPkAJb1Rg17lv/+HQaL7itBMZryC4XqvVUNHwNair41zx5OBT34Bzc+lv2V2pAjFOTVGNL7E9yPYWDAhoiukmrhtRxTqKcPeI5+GfEycmA2OAh8N97Fe1mONrmGPsP7lgHhLfyI/1+2dbLBokEZcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gklq07Bm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5dcc411189so4406926276.0;
        Mon, 24 Feb 2025 15:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440385; x=1741045185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K563TY+K7Ju2Y4rHGIcSU7wWrY/3HYZ1BEVYH8alshA=;
        b=gklq07Bm0b83ge5mO8Uu1j+46A9KKAvOCyTd+BpNaTZplaiChduKvTdOWE5FKVeRvo
         8hMI/I5211hwyC1pO3n7m+VSU3NYyV562ynHieSUaDLmB1V19tPQmYkcz3BvGe06ai3/
         jo9zE3LU7TcovVX1SxxGy4fm+2uH4VKrPYYkNmZuq51cvlzhfjMwTJdKyHdLkjwq11Iw
         DvwNxaPh9hlK7tqvfXPrggNFNDJtQp10QQJi+WZg7pm/82ZrmxynZ0p8uvu07+1yPefJ
         I43E+dmAqQZc71v/1XZSZAcTDWqtNdKuE5arlXdvpW+iAeIag/pHpNEHBnUqH8t4kGxE
         pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440385; x=1741045185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K563TY+K7Ju2Y4rHGIcSU7wWrY/3HYZ1BEVYH8alshA=;
        b=LfASG/utenO7GlFvji5ngkOp+stmjZYunOcUcaLnmi9h5Z4bpfNVpcyYwBRtAIIbgG
         gRJp6JmE47/Np2Twm+uxi+LaPoeHYzTuodxpjVn84yDlobYoFJBz3AaUu49UhGXi6aRq
         Nj2Rbd5+6LlqQay2Tzsu80D5v01QXAAAQWOaTmKa6TyeKqfQtHdTHqWBprtiZa66vJy/
         JOSbYY2vcO7RlTr5Ay2NJrgPrpISFnUHoVcKscNELxFRxNVrRh1Bnr4i4zrPVN5anMeB
         HrpWJAnJ03ZViVIAr3/FglZeGP28DAz8epC7SVrLvPT9nGueugytF+lQXJk500xDCzpP
         PxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEKfXqhqYz9LmBNpVW6hbsQot1JApQcMX2pwN2XHToWCYsBgcUcIA2pQ9xeA19nSS7cXDDxr/sTp0lam4=@vger.kernel.org, AJvYcCXkLObjLpgMpaGP+o1qe58BVtuFww2woddkeTJgTJ8te01AJZMXrO42Vzc+NFlfb+x4FKW2K+BZlgTbBu7JkSQ=@vger.kernel.org, AJvYcCXpYl8UxDSSZ51zIlgvUDinyX8tx0gigxkenFw4PzIuQpm7GtoU5rrxVXzFueNRco+y74twVQfuhyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbQnRzvDsdZJOQrJt+1HhGhpLitXJ9/vFRFI/2v1HUFTAr9yg
	4tE1JhhYvpSeMX57rwHXiMBNZPpERgHDEN303PXKAMCIwBdJ3C1N
X-Gm-Gg: ASbGncvvNT4PEFhm0+2hGTZGmtKq6Q4pXSB814iUJrFlWxT1XBGKI45bKimTr8YWL0F
	6k1gi0OhJ2X+FZvQfEls2J5D6xvCguclYx8Jxuv4Iudf+eGHkA4FqGkZYGdxDikUxk+hdlGky/e
	C6JpVtE34mAaeBHbKfJERnqMudNP6kS+TbEJfAp9kz2SvISabw4PYCc5xO2Ak9oDmPs27vJoyAm
	KgKbzdo+iy4WkelioGusYq3XpKWQM4FsRdvuGO9Z2LWKe/Dgrw/NtZtoNIldrcpsGvRwLEP/jS9
	cPet+uavnmh672i2fOxaZ5H4crvyRzNXpXwguKCBzOG7pVXCacUj/D64BGsAcg==
X-Google-Smtp-Source: AGHT+IFJ4445c9uDMV8u/wEtPl3i6gdzxeZB0ILuVRrOtHlz4PulN9ayYnrSuEev49f3yp3ZBSP18g==
X-Received: by 2002:a05:6902:2182:b0:e58:14b:6f99 with SMTP id 3f1490d57ef6-e607a4db47cmr890129276.1.1740440385272;
        Mon, 24 Feb 2025 15:39:45 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b4c6e97sm87683276.55.2025.02.24.15.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:39:44 -0800 (PST)
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
Date: Mon, 24 Feb 2025 18:39:35 -0500
Message-ID: <20250224233938.3158-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224233938.3158-1-yury.norov@gmail.com>
References: <20250224233938.3158-1-yury.norov@gmail.com>
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
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 45 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 47 insertions(+)
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
index 000000000000..2d380a86c34a
--- /dev/null
+++ b/rust/helpers/cpumask.c
@@ -0,0 +1,45 @@
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
+bool rust_helper_alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+{
+	return alloc_cpumask_var(mask, flags);
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



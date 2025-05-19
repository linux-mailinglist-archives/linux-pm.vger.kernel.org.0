Return-Path: <linux-pm+bounces-27300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403FABB59C
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BB173AF0
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D478D266F19;
	Mon, 19 May 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LViOgfsz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D96266576
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638469; cv=none; b=TRQL6DIrD5jO32E1y5Y4TieycFtKgFMNzG5KHE9C/4A79lNnfjTYoP58arOOZrXerDASXxi3eEb3oxXytHCgz+89Lrxz7nTBAyhSViScMv7BPmsMpUI/up+/NQfZZAPr7eZTrBAqKGPlElCCc9+ZjJO3XofZgiZLSW7gEEBNVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638469; c=relaxed/simple;
	bh=oF63t+ak19BpgsJzIpsjrXfi+NV5+mUyjooqlBcukIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZ+x75+P8USPMcGCsBabnAw9FrH8A6Hr8IU6BMtgpysgIe6U94bI7QyjOQA2YGi0Sh2Kr1g+RWDbaTBTZY0V/Laok88z8p7+W7IDPBk+K2AsVcCbx3WoZ+1+jxkPlAm2D+S6dwZeT2sBGYUYsfzt+UlrDmZs9qyvQx7kz+4asRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LViOgfsz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4549157a12.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638466; x=1748243266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVn0xPDTBmI2fx/iE4ainR18Kbcm4bTM4VkXhqSdQK8=;
        b=LViOgfszVsHYWxQmmtaKerbiCNH0mn6ezN9nrJsgSEh3wG3ww9LOV6Naclk6BXwtnw
         TrU8IwDJlIOm1GnFZYyQ7khCjPUQk/zj5ikiyjAVosOdv9G2W+xw61VXZUUQijLyJXIg
         939WDszfodpLA++4lpRsdunEgLaKCVN6p4NoDGOkDuFcMUPFVUFUQGHU+X6GdIXBV/Nl
         QSxyQegCUFXZ4DcXAEEy8nOcmtbFl26R0HHp2TdzP4ntargJWoAZ0rXFMlkT9CV1AgmR
         RHJVmwGrxK7FswjYwu81Z49SA9Sq6M3Wq3cZiXEy64mmxblCOl54mIAwy3d/ADNdWVLl
         vAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638466; x=1748243266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVn0xPDTBmI2fx/iE4ainR18Kbcm4bTM4VkXhqSdQK8=;
        b=hovB4WNp99M3SGRwEsrgrOp7yPkklgQeP62X90hhmD9aWu4iDcu3YYZU6nTcPvQNdq
         s8rO0NRg5mEsiu46o9IB6V6/XcRTbHaxNAMvZgwIX1ZkuvieXzA42x7uMzaf9CCJm4AB
         9N3aF4//VppBy2QSP4FhT3CGiEvfU2ZK6v7Clg5FXa4b+hWAG9rnUJ3uAJXvtaJWxoU+
         Nn+vBYnIUKXndH2ZOMv69DTOFU0lL/vU3wYmPqQSbHQxI1m369uVnGzhhk+D8TBIhGjf
         7m5iy3FXr4SEdqJkpWeggeaPf3ZToDTx+LuGo5GWpkVjbZOTPRKlRlmUNQKy4KAWZpel
         sQpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+DDxcWvBvPFMRjbqizaCRt10Os7xP87w3yeTNEOgpRJiDzXXBJGNT4SIOuA7EoNAVRHFqYrfwLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tFOL41DHS3NNJFo+U2+0uoe5RWWZHDz2xJAX3GD4vsjJoesx
	esByFC/j4UnSSrHBlLEcKzxTsqnprb8cpttNZ52I9zOvuLAC5QxLz7o7NIqQ8IfEkq4=
X-Gm-Gg: ASbGnctzQ1IFJQT+Ivgh83iRXbqFiSeU6m6lpewLJV9q1wNFI54acSrXSbdtM+hb5+8
	vcjoVJjjm3eFll/f0eRy7ceZDW+UtpFFWlPfT1POyWjVQiQ8v0u//CXorCq9cJTyE6m3S7aUuBr
	eMqYOGW4h1FUA1hpdL6cJOJ+P4B+O3arQAIIKdvp8KE41SegtTc6gv1ztxEjCjUCn/njQqWXCPd
	cO8zEu8qmz8wLSDJ1g3/ZoXmAMc3MdYPDb2Hj7GRh4kg2oYvGI7Hi6m5nUswGLaDe54ZZ8VoTgQ
	XFTjsD1vSLirm/EFoeg/P4wDoU7urtqUdYeSanUCyEVIRXrOvRi1
X-Google-Smtp-Source: AGHT+IGvRu+V4HoqAZDkp13c8s9rr5ud0+/U0brM05Z8wTvCrpR8/as4fHNNVbCsf3eEwlXoeMdK9w==
X-Received: by 2002:a17:902:ce8f:b0:224:c46:d166 with SMTP id d9443c01a7336-231de3ae584mr173011935ad.40.1747638466407;
        Mon, 19 May 2025 00:07:46 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm53052705ad.250.2025.05.19.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:45 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 01/15] rust: cpumask: Add few more helpers
Date: Mon, 19 May 2025 12:37:06 +0530
Message-Id: <0e085055a3de84550dbe478ee95851e18b2bc5a0.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add few more cpumask helpers that are required by the Rust abstraction.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 rust/helpers/cpumask.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
index 2d380a86c34a..eb10598a0242 100644
--- a/rust/helpers/cpumask.c
+++ b/rust/helpers/cpumask.c
@@ -7,16 +7,41 @@ void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 	cpumask_set_cpu(cpu, dstp);
 }
 
+void rust_helper___cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+{
+	__cpumask_set_cpu(cpu, dstp);
+}
+
 void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 {
 	cpumask_clear_cpu(cpu, dstp);
 }
 
+void rust_helper___cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+{
+	__cpumask_clear_cpu(cpu, dstp);
+}
+
+bool rust_helper_cpumask_test_cpu(int cpu, struct cpumask *srcp)
+{
+	return cpumask_test_cpu(cpu, srcp);
+}
+
 void rust_helper_cpumask_setall(struct cpumask *dstp)
 {
 	cpumask_setall(dstp);
 }
 
+bool rust_helper_cpumask_empty(struct cpumask *srcp)
+{
+	return cpumask_empty(srcp);
+}
+
+bool rust_helper_cpumask_full(struct cpumask *srcp)
+{
+	return cpumask_full(srcp);
+}
+
 unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
 {
 	return cpumask_weight(srcp);
-- 
2.31.1.272.g89b43f80a514



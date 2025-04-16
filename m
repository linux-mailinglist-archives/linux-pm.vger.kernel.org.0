Return-Path: <linux-pm+bounces-25509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3BA8B07B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA5D170F99
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C922B8BE;
	Wed, 16 Apr 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib2FhzMV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880522539E
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785597; cv=none; b=QL55x5Zc5s++ZDwmrVVHQSrBCsQl+AxyRQSVgZsS8SC/+8ckrrTOp9lj0Yd8Jgc5Um+4XTXCPU0UDt845jvzTs/yL2Z+hCLlCTMOiNz9/cnzlVbqibyIBc0j6vaVgG/Lwb5v68omKYSq67AXPTuKn8PWJSrl8CEroX9mbo43cTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785597; c=relaxed/simple;
	bh=oQ/uumB9dZEnQv7fbXO+2/DavkdF+8BaxTejDAZiJqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVR3GtKUqXk/zuU/7X8K+7SyKGryCMKKoUsd4wZscT0xkgXCgxJJfOVj4XHCwHzDtO6eS1ODhaHhO1vL6gIv8hOJXTKpN4IwhKdcjeNnNFwxa0Jvdp4+JRb08Dbm1g9TYMHuOaB6gTJyzMXFYFNMiUaMLQ+B3X+Xn98W6Nrbdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ib2FhzMV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7398d65476eso307821b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785595; x=1745390395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br+IpXn10n+9CXIhhXnelWYoEuJ5Sc8cDeYzc7Zl6Z4=;
        b=ib2FhzMVdjhE8Ima3d9pvbNLIsGNzlzhF2/5JbBYFtPhiJu6X34TUzC5OyrjOXxYNl
         XjZAvQd8notnbNpecYZ337tWqvrmsZ0Qrl5gmXYq+ZfhO3Wxb/FkbDypFqc78hugsM7J
         wVkSntcD58FAONVG0HOQz0t+RSkB5pzy9b7b1wUT8Wpntee2pa9e/VejZ0RLUHaJAlRJ
         ffzGRo3dgTWW6suM29zduUHYDfbSWgcoIRu8q8uGwXmCHLgvEyJdh9ro86MpMN59Yg9P
         c2yKs3Su0sxTxwGnChcajqLNejHprJQzCSBG7SIRlEMRWDcEgzuoNjgJ/DZLlbg4BAf3
         /rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785595; x=1745390395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Br+IpXn10n+9CXIhhXnelWYoEuJ5Sc8cDeYzc7Zl6Z4=;
        b=RyQU+VOjCj9SxwMctWEb7r7hQlNBEhepRIORj6HbU7T68GDwb0eZXPC1RX/JtScGCR
         zuw8Zoe/ld1+YAtG4pvA8pCkQ8F0cMCxFXEHmd6z5B1Wzeopf2QmWO4nZdP/4Ue6eg5p
         0IM+j2BmKNDeIRkSZu3bJuE+sY+X91Yv2RF/tKtMbmowO0ftbLEJYPAZYngWYIpwIadZ
         fhRazAP30hCYmOS8hMxop5zYiHCly37Y4HByI0yjnqzuFSVsiE2cFKTUkGCuEPdhyF+5
         s3nGJsxt5l2PU5mddqmN0xxxWpGb19EtOlpdciIIi5JHnjKzegexptbI7VRJN8zveALa
         XVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWawTIMLS3XXAlANdPgF+P4dFbPj3x3A1iD5Ivgji/IEgvbnB3kiC+GJfD3MiAGjt2APeTVmmSqeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwerB4seUTE0TVM2i7GztGuqZZTXA1mVVNbqvbf0ijaAPIWwaKb
	Lw1Tv6Rje7PWXc8bAGspoZtpp/kAkPmPvRrnWmogCm7lOT3cYPUb05wIVe7GuCA=
X-Gm-Gg: ASbGncu3kxVw7XMLCTTwmDhMPgAZUx6V7FzLMxQK5xX/UAZ2xiDwdsyHAhLPqr0QlwS
	WwkTqmcpDwkq1oQ4pUfVkMSNRzyAQdY8ZqC68XxZ4lwKxVa1opY1fU7P2y30eatTwowm/8k7T3u
	Zs1+n/4E9q8jWCtp1bJYx2SqtrsDfZVU+wyBG8WDzAUoUSGPgAOrmc4t/AmQUtkxC9qvB2LFz8F
	Fr8tqT7mWoX6JHp/wpt8YYfJ46Bn14lmXejF3gEDye4+yxgAvPtLit+hBzv8n1MRZXa/qjS15F3
	ZIe7N65DLuRYNFCI056mpqX1rbhwINdL02n8wjSPEA==
X-Google-Smtp-Source: AGHT+IFdD6luOUWiu9XjQ7/e9KFVr+7wVcpXj2xETy5cd4GCfwB2LGWz+opg97LDR1wqgUuvWsquiA==
X-Received: by 2002:a05:6a00:4098:b0:736:b400:b58f with SMTP id d2e1a72fcca58-73c26b73c05mr1127405b3a.0.1744785595123;
        Tue, 15 Apr 2025 23:39:55 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8850sm9582141b3a.87.2025.04.15.23.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:39:54 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 01/15] rust: cpumask: Add few more helpers
Date: Wed, 16 Apr 2025 12:09:18 +0530
Message-Id: <944ee57ad1b190f6975c739802b4d93166bd00c5.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add few more cpumask helpers that are required by the Rust abstraction.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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



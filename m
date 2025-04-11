Return-Path: <linux-pm+bounces-25229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C3A85ACC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079FA1BA84A8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923D298CC6;
	Fri, 11 Apr 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1qYXtG2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35465298CB0
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369155; cv=none; b=isCtVVAjluJpkIwZ0mw1kxcVVKWDsKc3MTTT7uSwONYQfc/PY7f9cknX+e1zi7Ub4+S3N5xqa4pruyDe7UWbkGj2tEL/Xas2Igyjo0RxYE+5nft4P6uQkJ9qEY21SX//K4f5DV/dwfjm5UhUwlPPIG2fdmZGgGWw7XQZBImneQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369155; c=relaxed/simple;
	bh=pRm5rikPg836Cpaht6T2Bti6G/gsdEEiL/oreW2ehWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4pbiG/27hMuzHYg9PdPllTsbHwTgGsya/FSWZBevAjNJItRkTgD3EkuGXCUeznrK4unuSknL8XBaSrpJ0YiBca6hh3kON2jFeVvQlauWcpHBLXVfZt+Jzgz0RjoGZUaU5IwugKCLtsNHhF7XZ5KohGCSUHj+LMaOEr7ZdKA7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1qYXtG2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so1365013a12.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369153; x=1744973953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=H1qYXtG2w6A9BaStWjrBIEmiaJMoT491tdHxBC94cM/FM1hfGw05kHtxEYk//+wVkW
         PD4MANlH4dyT503CI/lm/kQwGFL1v7AvDdDIXF8leLKJngjgtYozW/GeVf8zxIxYkbj5
         TpCY30DzU40NPzn74YF3l3MSJVT1CrIIgeVocBEQPpUx+UuONzzGif2mX8dGO4Wxr4ZY
         M24ntogLefdIwgMK+IzE9w+5EJ0mlNLQeXzJbiYRO1RYYs4YkbIEqXk2FSjFW7iuIN9+
         L89wd2mXQhdmS6vsLrxotENe6obm8SrzyoWO4rPj/71TgK7BM5vWhI4ujDGK0AQGnYt0
         qeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369153; x=1744973953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=drrtYwcSxq11+A6pKf1qMh74q8w549atu6dDvT7yTMgTSJQPyVsFd/NGlh8abeRfu1
         6SHcOafC3Z5O3waEDDYGPn1LiXg7j3zEuaQtBYGb3dQU4r4FbUFAxKvFVQz7FQhK7OVF
         HJIy/+O4XIwTu9xyf6PIU/VgzA32obXMowTA5CSU5KuK9j5kLOPAd5KRB1mQ1/AqSutu
         aPDzsD2NLuHGVK+xTdZtC76e8Etf02BiRL+v1LMHC4cACMK0lxqPIKg9F0Bb21UeXzmJ
         UE2RMvmeoYa2VgIDeXAPMvIFt8KW0DL9BNhkNALPhEL3caikzgyZnsk1Xy4wH53oR71K
         7mUA==
X-Forwarded-Encrypted: i=1; AJvYcCWgH7/mXiR1xQWNTMFG5fIFaqHtTD7uuEhrO8KgelXNcjgZrzvn9XbyBdhOSdYyMNH/RR4TDxeVFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1ghVJmiyt5/UvZCe+wiVs296VIDZNI0h26Lrsv8/fF5/w7vn
	qRBLGfE7FK5UDSU5DgeLBRHh1XFHqAS9uAyeE8Y/td2ToFxH1OBH+zNmSlKU1tw=
X-Gm-Gg: ASbGnctjKUPqmJqK456gnpQIXYqM3At8kUcQ77lnxyd5L4K2GeVGmNKxvOfhYdxiWAD
	vAlwpigFYtU8KVenYmg6O3B+UrfNxOX+CgFkiBKPJgBIXAshXMMlRpDU043IFwRJAie7B3/1pg+
	Z8Fy3fKgKbbR0OEi/u4e1mJ1T1d4Y96mZ4iYfMaMbVJDlYxN6+x5IB/ZFKoqMwND+KRMctNqxsu
	pUd4iVKoWpjEffIop5B9PyBc+cHANra1Pzu9fosz65TncVvCt/zFOIj5vBvtFmY5JIW4+5YygNa
	UOlGN1+2fb3uY/F+101HS0yJj24TmPdpT+vGhxGAaoi77A2KjLyf
X-Google-Smtp-Source: AGHT+IGwEFN9ddJRuuBdJHj8RuzbOI95LYFz7Xvvsh4FpaazgcpxsU/NNRYSzTHyEh8WHWzJdCHM0Q==
X-Received: by 2002:a05:6a21:108f:b0:1ee:dded:e5b with SMTP id adf61e73a8af0-201797b1ec9mr3954789637.24.1744369153569;
        Fri, 11 Apr 2025 03:59:13 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd233787asm1222223b3a.173.2025.04.11.03.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 04/17] MAINTAINERS: Add entry for Rust cpumask API
Date: Fri, 11 Apr 2025 16:25:03 +0530
Message-Id: <69c085aa4ea2418ed400591bf9be22c215a924e6.1744366571.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MAINTAINERS file to include the Rust abstractions for cpumask
API.

Yury has indicated that he does not wish to maintain the Rust code but
would like to be listed as a reviewer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..bd7c54af4fd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6237,6 +6237,12 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/cpuidle/cpuidle-riscv-sbi.c
 
+CPUMASK API [RUST]
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/cpumask.rs
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-- 
2.31.1.272.g89b43f80a514



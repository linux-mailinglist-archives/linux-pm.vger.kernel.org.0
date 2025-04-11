Return-Path: <linux-pm+bounces-25226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E773A85AC8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D44438A2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73972238C37;
	Fri, 11 Apr 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4fL1QbZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8564238C25
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369145; cv=none; b=dnkgzL1vmuRhc0Rs826ypyfI8ZWQZA/TEuqlvuDfzg4YtGX1hYHlJAneHJMxAj6r0giVbfgjGx7EN5BhAGThqC/IDpp5KwUYFxb1C0dl44nbCN3MY3Z7K2ScrxWKJLRbL0mqOvFbUzqmK9Xwi4FgYfahszEWglVUxUBmcrEj7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369145; c=relaxed/simple;
	bh=yS8zzoAb1gzolyqRZtRGFelUspFvZ1+mTbeqhW4yRic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLuy7npchiUQ6WPRQaQe1bEC1XkzNeO7cNMK9/DT9shlThFCYRv5G+K59UiEUkYlzQ0B8vpC8g1cwTutBo0asYnRwfY+jqXq1kUSlFs3zk4HdC1mWoFX+AbShn7euSrEfo4XvlTruPCq88CfoivpJfFbrll0UtxWcYxmXPclA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4fL1QbZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b0c68092so1544354b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369143; x=1744973943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5QmLNWlEhMlbaeU7vUP5c8vKPIyuKJozs3WjW7NYUo=;
        b=s4fL1QbZ88rgE2W4qUliW4BBCp0K5GqKT2wjxutfN7g3pvg0G90uCcFWg7kF2M3KK4
         gbtQ9RjfrrGq+pomf5cYrAVSimECQdsT/SqA20GQSrDEQRUCfd1yZg3lPfm19cARug06
         m1Sg9hRV3eZyMIT4QOjlIir4OoZtWstb60/KjKcp3QL4UCk2ErJ30SWrrcJwAY5on+Fd
         iIaVakybeOZrF3bps/shhUUl5WZFYq5c/U/P+OkF+7UcFmJGG+VNezjpKieRhlukOCzY
         eMl/EtLbXfOC5wG6fotO3H5jDFtePU8nCeN9Hqrqu/Xg38EXOOK4JvgL7vUSFvKOwOz5
         te1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369143; x=1744973943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5QmLNWlEhMlbaeU7vUP5c8vKPIyuKJozs3WjW7NYUo=;
        b=QIf0liR2ney1mZYVAav3/OwFtiXqOHsVjdH6CBlAqQBwMcbNDCyd5YzL9mYF62SfpW
         fd1dbEvDc5l6aT9eO9bQvTpFiS+dELKYmq42kJKxBd5OLYngZ3XyalFnIWq4HS7Ip/O+
         6HqCCSZmhbxFUJV3SZ0HAsa9fYItYZ/3/CS6+9fkDy1lfOn8TrhSH1fRLrermO8V9/gO
         xreL6435OFUbrzM9ypSjANS2H/sY/3JurQ15Sb+FwNxoGL3Pw6XFW3kSkE34F7iTHcom
         TuIlj7L14FxFbmsEI47KJ5G8ydmqKAItx7YcWhX7kYODCXYwgdNXEsUeaDU2fkwjga1Z
         GWKA==
X-Forwarded-Encrypted: i=1; AJvYcCXjylX/i1W8RAa4RsFqG9Xulo0N7fezVZ9dYXDZ1VOLO6zZEcMJ+19XLbCf3FxWplOoHbtBUpYLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/PUaDh6aAlW03BIKaiAyTtXCGJs8LWHn8Z/bnMzUpOUoLfD0
	+z/Su8bT+3J61+WPTP+3fHUcQyIUCcB+DHE9MOJtZxmgBdCRdXC+eV4B2Si+yj8=
X-Gm-Gg: ASbGncuoBkL1Fs3WVpCNgziZHuMyCMiDfinAaRPoSKKmS1clTwY/uCHEHlkJREeFOv2
	FA9uvDYJGOEL/fwxO1BypGJA2PZ+KbG6KyqUt2+L1AP/Yo0BpGxR12XMKIYpglUQrhHK7yr1tb/
	pt99aumUwciqWk9RXUXryqEQNGjFfhxaMCTZEDM5vlm7GoED89KoTXGXVQLbCABEPjbpya16MEu
	m5XVIy0R7eCcB2d5YzIbB8Bk42Sx7JeZAgZVKPm7YOtXB5fccFbe2vHIoUhsgleRfsLGoQ5OlRg
	qxq6kd84qR4oPo0Z0Bkd0xCluH+1V4QZ9EujB4M0iw==
X-Google-Smtp-Source: AGHT+IE2OjzWyw13U8ckU/PhF26xnq5qyW/KpQps6B6mpDc5lX3qxmzsxgHjgW2+oCee8Ta27wiyxQ==
X-Received: by 2002:a05:6a00:1486:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-73bd126b973mr3107562b3a.18.1744369143132;
        Fri, 11 Apr 2025 03:59:03 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2334376sm1179973b3a.165.2025.04.11.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:02 -0700 (PDT)
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
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 01/17] rust: cpumask: Use non-atomic helpers
Date: Fri, 11 Apr 2025 16:25:00 +0530
Message-Id: <b092bbcc23529663b1a8b381efb85566453185e1.1744366571.git.viresh.kumar@linaro.org>
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

The cpumask Rust abstractions don't need the atomic variants of helpers
for now. Use the non-atomic helpers instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/helpers/cpumask.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
index 2d380a86c34a..ae964cddbd41 100644
--- a/rust/helpers/cpumask.c
+++ b/rust/helpers/cpumask.c
@@ -2,14 +2,14 @@
 
 #include <linux/cpumask.h>
 
-void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+void rust_helper___cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 {
-	cpumask_set_cpu(cpu, dstp);
+	__cpumask_set_cpu(cpu, dstp);
 }
 
-void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+void rust_helper___cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 {
-	cpumask_clear_cpu(cpu, dstp);
+	__cpumask_clear_cpu(cpu, dstp);
 }
 
 void rust_helper_cpumask_setall(struct cpumask *dstp)
-- 
2.31.1.272.g89b43f80a514



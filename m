Return-Path: <linux-pm+bounces-27674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E8AC47A8
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 07:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2581E3B57D6
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 05:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB712C544;
	Tue, 27 May 2025 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpKHKMXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BF1BF58
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324017; cv=none; b=V4UlF3SxUkD8nfiFIxZrs8HeePy4cu1Bbk6BoF3f3/QB+7okgmucFYj1MQtugutUc+QnojKTetzDa1eAn1YkTwecuDoz5bNEMRFoPgZMKNz5RR96loqjOOyRdNQSlNFogGVtYqrLVKPkRwQ7Rb3rs2J9w6b3Ez1B9cZMfk3qfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324017; c=relaxed/simple;
	bh=sKF4zz/4/zo8wIkoons3Ms5WggyqYOdPqZb5QTOICR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sL0yB49wPQd73/4QsJgqPSaPum3QDh5JlpEa+cI1VzIXMfqtPj0RMvllqeJvNLcCWGRirZmAh2tAQdJq9x2jk21103IfK9qB+oM244Aac2ekmu83g1970u/GeIByXWjAMyX4rpVgWIMXXjaD4uiVlnTlDccq27WPhP9qlypE/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpKHKMXG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2349f096605so2800615ad.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748324015; x=1748928815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8MeiKlq1phnPLJ3Wy+Q/bcsd9h4e9tZsVOSyiDWgEQ=;
        b=tpKHKMXGFMZ7Vw9cCXL9LsSgc/cqxgA9uWIt27C4CYh7Y5EqDNDBOA8zyDpb6xcjlj
         K6cKBzrnGtBXfE/WdFihSokdNkG5bFVcDiyss3o9BUy4zNt4TJcJxUZwR5FOyoI4Iqn5
         glEPjg4DKvE9ywul4TT/05LecvaRR9KsWF2zrsIhqYlDkNawCXyvKjJ5tMg+0Hdb3Dzh
         nKAGfTcnOfauuIdOemAZErGZ2X6kkRPvNGrHrVVGyDF+bD1Oly07l87uuxqlsFnR4FFa
         E1n1Qg6ROljQlHj4uGu8XFrN7TLemBotxFUq7uAGyergeaujnldBLc0Cipvp807DmAVU
         mvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748324015; x=1748928815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8MeiKlq1phnPLJ3Wy+Q/bcsd9h4e9tZsVOSyiDWgEQ=;
        b=Bc+KGC1v3vOwApWywmjQgxBK6bmKVT4U6L1xhHYsAE/sWrDTEyWsPvJ/zSCPsHucAY
         IUju9/8udLolnBAk5gMyFbfbRKRHf1Rp3dkusd3H0zuP6m4R3IJJo120Kk9mcQ7NW8Kh
         sTY3sJpAB6tI3eIFoQ6I93NxgSTx92bzPERldyY2fQzwRUq1h7ZCtmKsFRSIlHRuF6EQ
         x/WFtcG2Xd6GcaJfYOKm/W6dpfD2Dy8NPgpVu9rng5aB/A7qNYyhqWD8XpwyIUze09pU
         1vB6iOr6x1HlOoAePGNBWCxTIMbBDCNKPAgoQXAVRR2pJPpDHIUvpIq+0BbF96Xg0vJa
         CJoA==
X-Forwarded-Encrypted: i=1; AJvYcCUYsHwaYoFLrsGCnllfzKIAqPKOUIlKdI87/AXDgjVI4/sguLHkR06yLlUYxfPgWhsOdSNrpbnClA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9FNpujgZN1KoWa2yb6qkgsCFHgXwiMzbI3vO7i6vWVXgepvM
	l96yChm2WW8U1CiisSCnc3rx+DNjt6nMzCDTGoc/958hbVXD2uUfyVQY2dUGbDTOZDI=
X-Gm-Gg: ASbGncvsXL5bqa9crfQ2KQ2L8MA9EdPg1fUqXbgO67wb5zZNcDLaO3JP80f9WEIaiTy
	5Ov7Z6/QSmrfMcqcLMb0l177bB80g2wWkqEuvmkatvmrDKEgsGY/hI26hN5XnuTfJRi3lNiFWZC
	XlRzwFcAVHLJEcqa2YCxMCr0B8jj1iNDFgQ63rMXne2G1N+CxtfT6GED/m92z9VlS4WwUhgwxG7
	XdMyM4BsaepUq+2468M5jwE/MQjAJS/ZGMZDH5O4Bb0SXh24iULbKpHZohieMT6ztKR05Y3dGRU
	wSY1TS6fCnreKEmYYLEVGnD1pGZBuKOjZqp73XhIB1I3x9rZDJp+
X-Google-Smtp-Source: AGHT+IEoBXhd4uJBmeZzJI+pUQ69cLynbx10Uo0njUY2UHsLd0QLG6xZBUS+XTdwv/Joqn/Yqnc6rQ==
X-Received: by 2002:a17:903:244a:b0:231:f5a8:173a with SMTP id d9443c01a7336-23414fe82d9mr155104945ad.51.1748324012616;
        Mon, 26 May 2025 22:33:32 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3110ee8f631sm5747169a91.5.2025.05.26.22.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:33:32 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: opp: Move `cfg(CONFIG_OF)` attribute to the top of doc test
Date: Tue, 27 May 2025 11:03:26 +0530
Message-Id: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the `#[cfg(CONFIG_OF)]` attribute to the top of the documentation test
block and hide it. This applies the condition to the entire test and improves
readability.

Placing configuration flags like `CONFIG_OF` at the top serves as a clear
indicator of the conditions under which the example is valid, effectively
acting like configuration metadata for the example itself.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

Sorry for the trouble, one more patch to apply :(

 rust/kernel/opp.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index c2bdc11f3999..a566fc3e7dcb 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -575,6 +575,7 @@ extern "C" fn config_regulators(
 /// frequency.
 ///
 /// ```
+/// # #![cfg(CONFIG_OF)]
 /// use kernel::clk::Hertz;
 /// use kernel::cpumask::Cpumask;
 /// use kernel::device::Device;
@@ -582,7 +583,6 @@ extern "C" fn config_regulators(
 /// use kernel::opp::Table;
 /// use kernel::types::ARef;
 ///
-/// #[cfg(CONFIG_OF)]
 /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
 ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
 ///
-- 
2.31.1.272.g89b43f80a514



Return-Path: <linux-pm+bounces-20008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E5A03D75
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9499718850C1
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3E1EB9E5;
	Tue,  7 Jan 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+jpZ5A1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D31E7640
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248936; cv=none; b=fu1jyxVsuKtL554Fvq05ZQLIauxL2ewis6ARyFpw1bs2cM5CDVljykMP0jkudyBRBDtVZ/pwSR2+3fst50VxBIrn/HJ2U5Ay4Fk62e0SNHNagswtlLsLkgB/XnoIcT0PIj9Xh2Kil78OSdtBEGMWg+LBG4wdJFZRu8s41IdVBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248936; c=relaxed/simple;
	bh=kSyr/zPEOYQnfq0yFt49wtG6CoX7ZjHp231HyzxwSrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljtS7jFUjRffdyY2Af1kNcrpCosKpLEhtMmayPWeaLUytgWyBP+HlLw8Iz75N9ux+3mRHHVbWqnOma1MH/7tiV38Bdcbgh9DJ9FIKGuqbC6UZdpxtb6qjcYuOj7siogWQbjM9avXCHe+OEMD0y7/Cv33ApwzOY110rq5sFHq4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+jpZ5A1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso221053685ad.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248932; x=1736853732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1Qh8sT76LD4m2O071A/eQQ4fPdvfMrHbqegFbex+tE=;
        b=V+jpZ5A1Cx4h0A34rm2ncPJeJjHcG9auMbUZYwmgQGGtiEOrDXadYNHjhlfpqHKbyF
         /LYYZQ6EGM5uPZ306chf4EVJqdkPONohb16Y5KWt6a1XFFNft0PVFrOf17QMXnx/NYg7
         xfdXO+PqxvhOpWY/OccKVgXQWo6Z0Dg0ORd0HzBXai5tkqzy11Jrjsg7BeyBOgPAdVqY
         /c722kRxD/XHdztilfcyVnGs88C/Ij7CiKe0cKTwiQFdiUYost3L1gYjlNqnBnEWwxAi
         MefEhj6dYcz+UKYzD7uQPcIHSIYDm4LzArbhqY7RaE+Nq31GT1p6FSKCrfkskkMxAB9i
         7EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248932; x=1736853732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1Qh8sT76LD4m2O071A/eQQ4fPdvfMrHbqegFbex+tE=;
        b=Pu6Yrgsn2md9TrOfbsEuB1QMwvcO7WqRYvOwvHjUaWn0R53QTj5PF2Dse6UZjvwD8G
         UQBlbU/SDxUWc6YJIw9EBElqGEq5Fl+RP5vrTvunvewJzAFA+gu/Ox48WsbQIWywl9F4
         FhqkEtEitIBx9APIMSr2fpO+F0TO6RINtynebSIj+w1ZRDs7a5/bTze2C2rSncFRXlHp
         vX8M/HJvC/4VsYpzJEuNbdZlp8hsYyo3GwcRX5bRx9h9/rbRBo8fKlHhhYyCtLAUCRBm
         3T55P2pAxxKFMy69LT5XsXPaSKJPbP1VJ3DE+AtszsYzcDBoWTXYDh76pWzqKvg2hCe5
         qhjA==
X-Forwarded-Encrypted: i=1; AJvYcCUZVvVlAhd9fpvKmj4N0IK6hsWF0fOaPqvWyeMEEP1F4Kz/OLWMMaRYQGuE5cwjfeEj4RI4OjAZsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLD7aul3942DafReSPbY0wEekhz4e5Z9E2vZVyVLKuu5JrlWZ
	vhqp/sIZFuNfugykUxQlc7hxMyO5RHJc7pMkc1PErTZyByDBlfEIRizxADC3lU4=
X-Gm-Gg: ASbGncsmcGRlGfGKeCxhbVpfG5NyJE5sNrRqz0wvgtmuFKbp1Oa67jKCOHZBtH4OJLF
	pZA2vjEfZkhg1WesDpcFhVKhFz1JTRjwwyCsnHVMWBIVKY2NlSjKXzmwyY0LTrZDTUdkj4Bp6Su
	cm1L6EKXQKIjFd8tvHI85DcBqtggOmH5ZqzR2v37svY+huILjowkhoiNDxGjyqndASn4FdWll46
	kmaazT/34P7I1m6OZuFhrD3Uxm4P80J7wfhZjKKYDou9wNlym4HduspYdQ=
X-Google-Smtp-Source: AGHT+IFUue3tyzva1NWuLadU6ZpmZqRjI/dvBahOkFlLBtQ88+5ZsRNHeIAyppAHX7C4ED+6Oa+VrA==
X-Received: by 2002:a17:902:da87:b0:216:554a:212c with SMTP id d9443c01a7336-219e6f12d63mr780949005ad.46.1736248931898;
        Tue, 07 Jan 2025 03:22:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e414dbbasm25753610a12.82.2025.01.07.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:11 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 01/15] PM / OPP: Expose refcounting helpers for the Rust implementation
Date: Tue,  7 Jan 2025 16:51:34 +0530
Message-Id: <fa014791cad083ad77125cebad11a6d5ec9592df.1736248242.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736248242.git.viresh.kumar@linaro.org>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rust implementation needs these APIs for its working. Expose them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 17 ++++++++++++-----
 drivers/opp/opp.h      |  1 -
 include/linux/pm_opp.h |  6 ++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0311b18319a4..f950bf1f78ca 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1480,11 +1480,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	return ERR_PTR(ret);
 }
 
-void _get_opp_table_kref(struct opp_table *opp_table)
-{
-	kref_get(&opp_table->kref);
-}
-
 static struct opp_table *_update_opp_table_clk(struct device *dev,
 					       struct opp_table *opp_table,
 					       bool getclk)
@@ -1645,6 +1640,17 @@ static void _opp_table_kref_release(struct kref *kref)
 	kfree(opp_table);
 }
 
+void _get_opp_table_kref(struct opp_table *opp_table)
+{
+	kref_get(&opp_table->kref);
+}
+
+void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table)
+{
+	_get_opp_table_kref(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table_ref);
+
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
 {
 	kref_put_mutex(&opp_table->kref, _opp_table_kref_release,
@@ -1679,6 +1685,7 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
 {
 	kref_get(&opp->kref);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_get);
 
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 430651e7424a..5c7c81190e41 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -250,7 +250,6 @@ struct opp_table {
 };
 
 /* Routines internal to opp core */
-void dev_pm_opp_get(struct dev_pm_opp *opp);
 bool _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 568183e3e641..fd817815a0f9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -100,6 +100,7 @@ struct dev_pm_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
+void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
@@ -158,6 +159,7 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					   unsigned int *bw, int index);
 
+void dev_pm_opp_get(struct dev_pm_opp *opp);
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
@@ -203,6 +205,8 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table) {}
+
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
@@ -334,6 +338,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void dev_pm_opp_get(struct dev_pm_opp *opp) {}
+
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
 static inline int
-- 
2.31.1.272.g89b43f80a514



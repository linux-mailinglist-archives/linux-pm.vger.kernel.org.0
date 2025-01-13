Return-Path: <linux-pm+bounces-20306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797FA0B55E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F163A8A63
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833FD234972;
	Mon, 13 Jan 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoeaKhat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033522F158
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767422; cv=none; b=DocZG9qnmB0NQFrJcbXPmHmDajDevlkvYd6obD1q4m0nXtSTpITxdUkkdRO2/2nUnrrKf4Ihd6iHOrBSRLOvgSXhvrQxBSHPFYMWtFsGXZ+aMYCPbrhcLU91a+ElOjmiVwAlIunXYINb3uj59a7JRl3IKNy4m1SyGNYPJW8FvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767422; c=relaxed/simple;
	bh=56mpvPQsiCQvJ/qI37RI+kZkMobzbPxSKcp097e99C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lD7MmgtyTSQm9aU+bS7HqfFBXCTpvA/yiJGFLYA6q+y0xl5ZnKWJ4fDfJ3O3yxz9X3eO2SS+I52+i4zN9gukbYW2aB3+DZtrUaBzsHU0CtanJkXDUgVWUXEv5yD0dVYlfpnr+ebYFJtyL1pFbdwaJHmZclvL9A5J5JJJ4bC90uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoeaKhat; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso85537965ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767420; x=1737372220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmCuXoJnBUxtp5/I8iV1DHcowuAM2GwBiNr+w7VeFWg=;
        b=zoeaKhatTn+ifIZiMkiG2j3DLP9fbpPpk/U28EA1lb7I2Au78wzJLNSS3m5WKglEd2
         9dMU481X27b/tKaZ1JLrX1aw/4YILbogxGzTyXmUkpRFkdiGk/kWhjOBIb5z0cFdtN6o
         Hiy2mlXsB+f+dIQiq+ZxAie3NmU53tG6uwdi7EhvmZ6yKdqoF3M0x0SG6giN6D3wmHxN
         i89EHQ2YVicFju0SFWT8mA3piMSCQ+FKuXVXlE5up2ZVkU7wh5Wba3kmk3C1rmkdidyv
         ejUZMYUK32/rU/ybsMgmHl0KP9s9GZubI2cpdV6+X9QsLVuS+8IM2N2x33cnUfi2zLb/
         Elkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767420; x=1737372220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmCuXoJnBUxtp5/I8iV1DHcowuAM2GwBiNr+w7VeFWg=;
        b=rmNRhoQ7G5Y0oQSMzXV4ih5H4RiXKoNTdYliZsnoAjSMdKnj0l1mbykcdvnnIbw/Hh
         vckL4Yi3nSvJtf3lBKlW8PwA5XWNAvbmGBPqGTRpqJ59xpMu4/BBWCoeoCQ0qjB9J9Y4
         OPtwum0hlS5zjsxKgPiap9rbWfdibnto77keLsGe/YJCasb4GFe9AW3bk0c+pF7O1l6k
         6mO3D9PiO8AZK9Yzy3JbGaKYx49vgd/O2PV5Q45Nd/BAcOeZCr6eMAXZaw7+YUpGVOSa
         mcBNDQTSOUJl/UnVFwbDIJMKxa0NRnFXAbboOdsZqXRcWHPsQZVRUJStDoJtz+8RzQzX
         DkTw==
X-Forwarded-Encrypted: i=1; AJvYcCWFz63utlj0W4dMtaRRGj2GQWsbtb9RwJyOssdKuUZIuA7v4MKjBh+t62+0n8KjuNWK9vwRaZ5tWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDEb39xl8QDw/7uozPaLOnEKoIYY25FG/25Uj+LPbZUVEM0xA
	mzzO/zms5TAdkq44ircEMZwwReyK4iX75mbwVT562KVg32C+dIauNYCz6D17+yw=
X-Gm-Gg: ASbGncusMGrmOui1pAmVUSWF86vainhxxQtJLC/m8de47fPqlq0Uv25ZC3EQ7JZ6PqK
	90uoL/pywMB73ZBixXF9ZnZOlGhGozVe5mm422MA2i3UkxpjHn9mKF91j0zZ5RE+c90kY/JYF2R
	bL4AFpArB4BLMBt++zQWRng45MqZlX122D7BDSKR0eE0TpOm2o2ZiPWP8Otx2pa9Z8/1LjV81UH
	vnOUCJPY6oqO3XuSGMgYlnw1f7MXWn7OXdIe7hr844VsIo/wkqNZnf+gXk=
X-Google-Smtp-Source: AGHT+IEBqAU9m/Dz1cRS0HnmcowXNpNvmSNlZypDvYg39Eu5fhkkroa7r15wE1tObjFtw/U6RyJuJQ==
X-Received: by 2002:a17:902:f70f:b0:216:32ea:c84b with SMTP id d9443c01a7336-21a83fc3652mr310297025ad.37.1736767420205;
        Mon, 13 Jan 2025 03:23:40 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f860sm51777815ad.46.2025.01.13.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:39 -0800 (PST)
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
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 02/16] PM / OPP: Add reference counting helpers for Rust implementation
Date: Mon, 13 Jan 2025 16:52:57 +0530
Message-Id: <ebdf4bc5151281df7bb5f6b670302e8433076189.1736766672.git.viresh.kumar@linaro.org>
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

To ensure that resources such as OPP tables or OPP nodes are not freed
while in use by the Rust implementation, it is necessary to increment
their reference count from Rust code.

This commit introduces a new helper function,
dev_pm_opp_get_opp_table_ref(), to increment the reference count of an
OPP table and declares the existing helper dev_pm_opp_get() in pm_opp.h.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 17 ++++++++++++-----
 drivers/opp/opp.h      |  1 -
 include/linux/pm_opp.h |  6 ++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index be3291b53719..73e9a3b2f29b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1528,11 +1528,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
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
@@ -1693,6 +1688,17 @@ static void _opp_table_kref_release(struct kref *kref)
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
@@ -1727,6 +1733,7 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
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
index 414146abfe81..c247317aae38 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -100,6 +100,7 @@ struct dev_pm_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
+void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index);
@@ -160,6 +161,7 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					   unsigned int *bw, int index);
 
+void dev_pm_opp_get(struct dev_pm_opp *opp);
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
@@ -205,6 +207,8 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table) {}
+
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
 static inline unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
@@ -341,6 +345,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void dev_pm_opp_get(struct dev_pm_opp *opp) {}
+
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
 static inline int
-- 
2.31.1.272.g89b43f80a514



Return-Path: <linux-pm+bounces-26113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1CA9AA9F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F265A2E1B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18566221FDD;
	Thu, 24 Apr 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i03xX/0c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0A2367DA
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491035; cv=none; b=jNPpp15OWlQABgV9uTEzWd8o7R419Ej3OyOBMnErdOpsKiL0+CgLbU7PNdYr03mNHjrgCfQYAwaOC7yWLpaBcOxRhaXrKHoYOYV19/Xa/ei0uaE7q7HlBUbIhkjWGxBZva5GmfU/uikS2KEaqY1sY3RSWDwuhndHr68G1LT1DQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491035; c=relaxed/simple;
	bh=NeVKdcw8OCf4gupfY3nEEQyeD5Av5HUkByu8eDlPENE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYltZJGbKt9TGm3CdFZDP6jSI+oHbxTS6n+ikVpuRKqeGXADDVOdQzo3avgryXfRMF7xiIoQyOCblCIOoCu9Ah8Lr7WBRfz+gqHNE8Dym0ZGV89Rlj5t2/fUsDspm6l9DMnhqCnfrOFh1hxG3ugcXe5DbG7K7BUkL/oqx5SoBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i03xX/0c; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b34a71a1so939165b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491032; x=1746095832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vscvGKi8aZQ4AtwM5RonL3qnlEsuOoWo+Mhs+nOpbME=;
        b=i03xX/0cbq5zQVf+tCHpDlvx9PLpM9Q1lStx+3clg+CMSTzi/fq34+L891nfwfXObW
         pJ1II6byoKqGQJCOdt9E7mBhoDv6ezILDu4T/aLImuo2zK0prKrVNU/6rWFqT6BLcgP3
         j8kjAiqrUomXw6p+cbO1Oc3Td4hIBN7K2qB2QcoX/yqvbx4mgoY8FUm45v4FD/cuhi7j
         7kSz0DdCY0rmM7NKHLswQIicCVP/HWB5vOBafo/wDWOBiec2OQBd5FuS3ZxW1zSkYLqh
         YX+XWHjoASa/EZl49iiFwM6OCtHthgQ8UdonZUT1xZMC48Q2X1ecsl9NY9UYeoTuY9mi
         aaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491032; x=1746095832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vscvGKi8aZQ4AtwM5RonL3qnlEsuOoWo+Mhs+nOpbME=;
        b=nRKl0ApOZHPAI/W6W33LKhcTTZn/V4AW/kiJ3X0inLNe2WbvEG58/rGMK13ItiBjyz
         uOAdR7X+M02h0jk7VeZo1iNjxbeZfLc0U+pJU8RjTzW6h7f8lBGKglNk/71C3gXGIsKi
         lJX1tKZrvtMiqnaGnxpq8u1NKotg38D2Eb+iY/wqIfsKzACqqKm3Yui5gQ7zusy2ZZ3W
         JY47KIg07Feir8N7gFaqAESdTonRbjJKgNYPCdXSuVl0Rn6jKTq4tCY8WUykBL2DbRXF
         Qwk73XgroqZi5wcwoTDUG0f13RFhl+BCNWyKTqvOBIYKwzZ552KOiqc5srxKl2wvVjcq
         +9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4gyrgHIh/vZAyOcDfrV5NyX91CKJchFb57z3v64BRYokKL9HqwCMiHS/BWr9YpSZqVaqcpiLgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiq438wTDaUxcIKwsHc+dDZkwqrMEclE4mza7ZQd40Ld1XNKBj
	nfAy6pXHxW7qjITw2O76LYEZWkrI/jmVVmYwBE5ZcTH7dviV/DeprC4GN4So41M=
X-Gm-Gg: ASbGncuGDuXAnFlnvd6FP04gETWScEH4x7pZsIbuFksLp9wsAGTymCp72XZne5R+deS
	SmC2IEnxJnqSb70AfZ5WMZsEB7C9Q+4wVa7W9BXW6kKMWvrDAMdRKj5iN1ggvyGLZp4blevZtw1
	MPp4Yd65KERsc9fcrdv2XqeM6Enab7o14nan4C/c4sS83SANEvnzL+eHJryfsTnx0Jji6+44avv
	Vlrc+PwAmhU5FQQT+olJjS4HASi4vTkyiTkqGqDOit2I8hbyLLBRWwtOqEBHdOmhQdtLucbPGLz
	4lu5QWpjsZPFi+oDMs62HiS+cFjKYqYTjEOMylKM3Q==
X-Google-Smtp-Source: AGHT+IG2u1pypaLFiO4fsom7dy5KA1qvfxkw47AsY/FMtzeMJ0wlTMGgmr1u6k36FoY0kYO6FF+lXw==
X-Received: by 2002:a05:6a00:179e:b0:73e:359:1c86 with SMTP id d2e1a72fcca58-73e247d7cb6mr2816818b3a.18.1745491032617;
        Thu, 24 Apr 2025 03:37:12 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259414d3sm1050286b3a.47.2025.04.24.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:12 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] OPP: Return opp_table from dev_pm_opp_get_opp_table_ref()
Date: Thu, 24 Apr 2025 16:06:46 +0530
Message-Id: <ead694941686345bfd3f95100d889191cb9e3cda.1745490980.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745490980.git.viresh.kumar@linaro.org>
References: <cover.1745490980.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For convenience of users, return back the pointer to the opp_table from
dev_pm_opp_get_opp_table_ref(), so they can do:

	opp_table = dev_pm_opp_get_opp_table_ref(tmp_table);

No intentional functional impact.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 9 ++++-----
 drivers/opp/of.c       | 9 +++------
 include/linux/pm_opp.h | 7 +++++--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 150439a18b87..14fb0f43cc77 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -58,10 +58,8 @@ static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 	struct opp_table *opp_table;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		if (_find_opp_dev(dev, opp_table)) {
-			dev_pm_opp_get_opp_table_ref(opp_table);
-			return opp_table;
-		}
+		if (_find_opp_dev(dev, opp_table))
+			return dev_pm_opp_get_opp_table_ref(opp_table);
 	}
 
 	return ERR_PTR(-ENODEV);
@@ -1687,9 +1685,10 @@ static void _opp_table_kref_release(struct kref *kref)
 	kfree(opp_table);
 }
 
-void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table)
+struct opp_table *dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table)
 {
 	kref_get(&opp_table->kref);
+	return opp_table;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table_ref);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 87cb6aeb49ed..c240acc81a8d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -60,10 +60,8 @@ struct opp_table *_managed_opp(struct device *dev, int index)
 			 * But the OPPs will be considered as shared only if the
 			 * OPP table contains a "opp-shared" property.
 			 */
-			if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED) {
-				dev_pm_opp_get_opp_table_ref(opp_table);
-				managed_table = opp_table;
-			}
+			if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED)
+				managed_table = dev_pm_opp_get_opp_table_ref(opp_table);
 
 			break;
 		}
@@ -405,8 +403,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 				continue;
 			}
 
-			required_opp_tables[i] = new_table;
-			dev_pm_opp_get_opp_table_ref(new_table);
+			required_opp_tables[i] = dev_pm_opp_get_opp_table_ref(new_table);
 
 			/* Link OPPs now */
 			ret = lazy_link_required_opps(opp_table, new_table, i);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5e4c3428b139..0deddfa91aca 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -100,7 +100,7 @@ struct dev_pm_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
-void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index);
@@ -207,7 +207,10 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline void dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table) {}
+static inline struct opp_table *dev_pm_opp_get_opp_table_ref(struct opp_table *opp_table)
+{
+	return opp_table;
+}
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
-- 
2.31.1.272.g89b43f80a514



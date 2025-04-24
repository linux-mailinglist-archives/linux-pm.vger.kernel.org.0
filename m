Return-Path: <linux-pm+bounces-26112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4AA9AA9D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C16467F5A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1E2367BD;
	Thu, 24 Apr 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiOEEFyg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BD2367A2
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491031; cv=none; b=eK9rEjKwVoEgx8GirBAL87BjgjN1rfTyVG+zwF5DDq1ez3euOdV4sP5mjM9j2N8bCFEjRfq+80xcFeGx1vCyHLNawhKhW/GtTez4lWtq9ozJM0kL4mOkW7WvImhsBJT8bZ5C/59GscoBh8tYNIMtamzqdfufwWLHQgBw8mtv6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491031; c=relaxed/simple;
	bh=XV8ObqiVVogtjO5N873sKSFmTsTaRcd1IBSPiFBNL38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqAj4VkhV715DkDCD/upTiQyoOw6EUGDJx721h9JkmJl8BR4kV3vWJfaRWr5QIWJ+ZoTUbdvep4N+Xu2fNnUa2ArNjLnPuKMqnG0Q9el1mpvXtpIjmmoQTh5KNCQq/F+6yLnA+Qzi7roc6uJIpKVtpyGTPCrlBm1dYD98GXIIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiOEEFyg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so12562685ad.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491029; x=1746095829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiIG8WEszkc/dlu2pYPwLwPCyzJuamBVIXLOR35LVRk=;
        b=AiOEEFygzlPo0eLE6UUqd/uIuZaUZxcwFIR8mf/BpHB/flO+IF3k66YIuhIeABrUEq
         vgk4gd5/62JzimuXwtL0sMXNE6ZVxvuMcclxdq/1kWcLqkfv5IgcuNc0ajnzro5344Em
         tPvt6ZJmOFP+ynyEMmh9XjdQtNQYMc72RVUA1+aKYLeaimpE7X3+guyArJ6/3i/uQuD0
         H7EzrhbyMOxL8XkiesLsRTtwX3lbMzG7vGSCxAikYDeGCO/R8XK3VlnHkXdUYCFBjmZf
         s2lbU0zfqrUGETZpRmwXkn3OMvAi/zPFSeBkJFkQ69toXFL461VCTzqM7C1m4yKB9ikn
         Ctdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491029; x=1746095829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiIG8WEszkc/dlu2pYPwLwPCyzJuamBVIXLOR35LVRk=;
        b=d0/QPb72bjmBKHGEpVPAClT0WOqPlWpFOd7bvAmK8YAa1wMxehklXTdJvS075EjBV0
         MeeWuCL6lwFuuRVE3yr1YWf3BC4mTeNs6My0xhCxj5WKalf5l4CJ6C1EW2y1Q8MT2L2T
         rFvfWDsaA3dWvA9FmNiOzSr5l8D4AoEd6Mtmd2iVU0Xo4IwnKtlZITwlHH8TiFvUDOGx
         6j+WqqufrQKg9Z/BA32CfS5uCke6SXcEiHlw90JKgzm5HNqNl4fAllxCBJ8sndPPhfD2
         KA+DXBKvCUCfkrT9+35tnXbXhVTmFOGJbypduMCz7izhUequo+AYr9W1hSjaxBtzdU04
         ok5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9mko1opJscVYYyDgjwj4actOJPoDegqRPZ/64IiUcU7IyyIWazDrDpWj4To0xhDrdKbCu5Y5Tpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0XncTQ+WGQB2EwqYnBe+cFsOom95fAqtdji4iYywYbdyV2OE
	49lTxHs6p1swkGuDz0Dcrb5CXLX5LA2qwGX3wj0oohxsSxGPxTT677NdvPGKndu42dGzllUmI6X
	3
X-Gm-Gg: ASbGncuWFdtMqJImUrO0vSiMCAr1ttcuxyh+PzisdxYWnGKblAa/8rPRo5Fmo/QU4Dk
	w96grMbA7NCYvDagdiGni/F+lSHE605lMrUfHW+h797q1K24hxaMm8zagHH48EeoA7VBy7XoNzA
	HT6WqD5h0QGLlbKrZ8Ep8BN+oDnNGnc0XddGGru88TF/jZ5w+kRNmTqh+5RhSOzj6VAv27fZKoV
	u5wCceMAzrzrQFMrFB8h+U6Q4ufsst8okRCifc4GE0O2MmW0Ne1YG9/y5A/3BIaMW4tYtTwYpTi
	JWcBJdvMoblxYAUH2LUeYDYnH6Cvk5wq8T85NgAdjA==
X-Google-Smtp-Source: AGHT+IEg3HiY1hRFa0sd4VmP7cYuftC34v8NrLnxhQq8aERPS7VCcuo9i6ofali9iKtAnB6B35F9CQ==
X-Received: by 2002:a17:902:e5c6:b0:224:1219:934b with SMTP id d9443c01a7336-22db3de966dmr28392755ad.50.1745491028769;
        Thu, 24 Apr 2025 03:37:08 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77ee3sm9945165ad.2.2025.04.24.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] OPP: Return opp from dev_pm_opp_get()
Date: Thu, 24 Apr 2025 16:06:45 +0530
Message-Id: <7a3be00771aa9786c7bb4cdb0ee36fee45f67d69.1745490980.git.viresh.kumar@linaro.org>
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

For convenience of users, return back the pointer to the opp from
dev_pm_opp_get(), so they can do:

	opp = dev_pm_opp_get(tmp_opp);

No intentional functional impact.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 13 ++++++-------
 include/linux/pm_opp.h |  7 +++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e63a9b009df1..150439a18b87 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1188,8 +1188,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 	 */
 	if (IS_ERR(opp)) {
 		mutex_lock(&opp_table->lock);
-		opp = list_first_entry(&opp_table->opp_list, struct dev_pm_opp, node);
-		dev_pm_opp_get(opp);
+		opp = dev_pm_opp_get(list_first_entry(&opp_table->opp_list,
+						      struct dev_pm_opp, node));
 		mutex_unlock(&opp_table->lock);
 	}
 
@@ -1329,8 +1329,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	dev_pm_opp_put(old_opp);
 
 	/* Make sure current_opp doesn't get freed */
-	dev_pm_opp_get(opp);
-	opp_table->current_opp = opp;
+	opp_table->current_opp = dev_pm_opp_get(opp);
 
 	return ret;
 }
@@ -1724,9 +1723,10 @@ static void _opp_kref_release(struct kref *kref)
 	kfree(opp);
 }
 
-void dev_pm_opp_get(struct dev_pm_opp *opp)
+struct dev_pm_opp *dev_pm_opp_get(struct dev_pm_opp *opp)
 {
 	kref_get(&opp->kref);
+	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get);
 
@@ -2706,8 +2706,7 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 
 			list_for_each_entry(opp, &src_table->opp_list, node) {
 				if (opp == src_opp) {
-					dest_opp = opp->required_opps[i];
-					dev_pm_opp_get(dest_opp);
+					dest_opp = dev_pm_opp_get(opp->required_opps[i]);
 					break;
 				}
 			}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c247317aae38..5e4c3428b139 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -161,7 +161,7 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					   unsigned int *bw, int index);
 
-void dev_pm_opp_get(struct dev_pm_opp *opp);
+struct dev_pm_opp *dev_pm_opp_get(struct dev_pm_opp *opp);
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
@@ -345,7 +345,10 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline void dev_pm_opp_get(struct dev_pm_opp *opp) {}
+static inline struct dev_pm_opp *dev_pm_opp_get(struct dev_pm_opp *opp)
+{
+	return opp;
+}
 
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
-- 
2.31.1.272.g89b43f80a514



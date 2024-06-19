Return-Path: <linux-pm+bounces-9585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54C390EFC3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4431F22507
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB11527BF;
	Wed, 19 Jun 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ig9zOITN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAC152796
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806155; cv=none; b=GJ32/ua51WO5Ur90DMlk2+dEAzNG1rlk8O6k1XzQdXbQBnsIm3Y1OAsj6NNIGsLFW6jBGBOxeHnj6KSIHjdCJ+IFYLV5El1Z8T3lLKx+fALreV6DSetWxYNk8rrA5o+3F05ua+9x/7ong4fxeb0CiKpCB/40ceCoeLbn1hgKOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806155; c=relaxed/simple;
	bh=xVTzIOADtFMWN8HF0VXifzBdG/mUYz+OV6Ng8rERawc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcGfqxge93LO1RT8pAf2NSGr9AqxQtu3/be1/3Hrva4CK0u4jExhPjXmOZB/tIleehKc4tmSsS2uSNsOJ1nKMWfObvQxolLEaumxNed3/JVDKE/2d3mFW0HcArEH9W3naw+YJU+/TimFUojei7Mi+ZPl8SMnaHDYiibNvXKW4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ig9zOITN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c9034860dso8376261e87.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806152; x=1719410952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDWaPf7+TN9M1cnbl/7mu5+omOHy+MPUVcUqdXnYMd8=;
        b=ig9zOITN5Bv/ZTGOI7aJ4UnF62+XsCDxc5reJAm++NzDbhe/zNs8Z0pUJ2h1scak0Q
         lhLjjoEgyEOOesAr7lEjZkfmgGAM0Wy8q17MuPlbeQzPNdyu4v6aZmIAXcR8hMNhwlJC
         DCmHKj+1daWXe0/zRUsy5uB9af+7hDBBQj73Lse3PR97pUGYh011iVckBBIRWs/TNXRF
         X0D4t9AnOF+Cnjw57heRJaA9uLogTxJMJX9asOn9azpCYgRMzjpevDYYxcL2sM4JrNkl
         2d5tOX68to9dukh5VX16NbKQttW1PaIWNIfcvSgLI5dDh+VLVdYr8mK+8iYndMwIQgGv
         brqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806152; x=1719410952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDWaPf7+TN9M1cnbl/7mu5+omOHy+MPUVcUqdXnYMd8=;
        b=kKNtLtECjlcYTaZPSV1kzPIn2h4iZACHGUFeiGQOmMeIWAkNo1R8oNHH1lAWHm/DCl
         nXpZEOqeZ80qymVInU2ZclKorNPv3q1hXRf/5KyT4TiHxqUAEkoXg/aSg6TtYZrynoJK
         qsJxWc8dkxVEr7oR5q7ibDki8e1lnpU7EAR2WnEIpZoDQwiCg401BqdHCtlPGwZPCSK+
         qVodPyVrSlFUrO2jWKbLRPcyLtj+33ic4NxS8ShhMmGyo66sZRBudixbDerC+kUydNME
         95bJFytLrEpxBnXKzsypntLh0wp50MNbbOYnSzvl4Qmo6fIiPZgxJzgnOQBIgYv7Hl0B
         Aleg==
X-Forwarded-Encrypted: i=1; AJvYcCWoVB1shckHfaqX3S9rJCJc7eaj4hErHmvRhp8/00VpBvBY9jidmUuzihh9jF+zK+ryEUtP46SXn4gHPao1VRD7LQSTP1nE32g=
X-Gm-Message-State: AOJu0YwOSCJJI/h3Na1ouJHxyQ5Dy3TUgXjVdlKuObsaz0uXh+q6S8Oc
	m8ntsPOnxMoeCeyXwbGgDqiTn+AnIDck9uD9NA1iYTd25B1q56TA+T0H5+kH2ZI=
X-Google-Smtp-Source: AGHT+IFbKCEpIt59r0vwx09Jj3ZBoGPhwAYQUSf6Kkwln2POjh4upJ24OJAsVYPh1tHMRchYqc0ZgA==
X-Received: by 2002:a05:6512:e8c:b0:52c:aaa1:977e with SMTP id 2adb3069b0e04-52cca8b0e87mr2662675e87.0.1718806151472;
        Wed, 19 Jun 2024 07:09:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] OPP: Introduce an OF helper function to inform if required-opps is used
Date: Wed, 19 Jun 2024 16:08:46 +0200
Message-Id: <20240619140849.368580-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As being shown from a subsequent change to genpd, it's useful to understand
if a device's OF node has an OPP-table described and whether it contains
OPP nodes that makes use of the required-opps DT property.

For this reason, let's introduce an OPP OF helper function called
dev_pm_opp_of_has_required_opp().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/of.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 282eb5966fd0..55c8cfef97d4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1443,6 +1443,38 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
 
+/**
+ * dev_pm_opp_of_has_required_opp - Find out if a required-opps exists.
+ * @dev: The device to investigate.
+ *
+ * Returns true if the device's node has a "operating-points-v2" property and if
+ * the corresponding node for the opp-table describes opp nodes that uses the
+ * "required-opps" property.
+ *
+ * Return: True if a required-opps is present, else false.
+ */
+bool dev_pm_opp_of_has_required_opp(struct device *dev)
+{
+	struct device_node *opp_np, *np;
+	int count;
+
+	opp_np = _opp_of_get_opp_desc_node(dev->of_node, 0);
+	if (!opp_np)
+		return false;
+
+	np = of_get_next_available_child(opp_np, NULL);
+	of_node_put(opp_np);
+	if (!np) {
+		dev_warn(dev, "Empty OPP table\n");
+		return false;
+	}
+
+	count = of_count_phandle_with_args(np, "required-opps", NULL);
+	of_node_put(np);
+
+	return count > 0;
+}
+
 /**
  * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
  * @opp:	opp for which DT node has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2b6599f6037d..5fade5c4de40 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -476,6 +476,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+bool dev_pm_opp_of_has_required_opp(struct device *dev);
 int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table);
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus);
 int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
@@ -554,6 +555,11 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 	return -EOPNOTSUPP;
 }
 
+static inline bool dev_pm_opp_of_has_required_opp(struct device *dev)
+{
+	return false;
+}
+
 static inline int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1



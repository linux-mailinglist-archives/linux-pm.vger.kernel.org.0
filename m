Return-Path: <linux-pm+bounces-12778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA495C105
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D41C21C75
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3E1D1F60;
	Thu, 22 Aug 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3k6r+dH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49618308A
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366769; cv=none; b=W5d+21CEpOGA4lYIzB19fdUbl3LYDUgVWmw6JoPTxjHzgfyLsWxRKu5CwLTHMYEk/3lZO5jKBvZS80KlPA3sGwtqgsTCFFhKpSgdvkrAwoTHE8JHfqsJ6lkEG/yRNx24ePGf6vtS0GCrwGHtVw7jEcsxdSHhuCxf4ZTv6LcSGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366769; c=relaxed/simple;
	bh=6EO0O4o9JKGH4hQejEuuwX4Rpu4yTFw6q9CWeFJnSgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOtsipGGTGolwZEbJZtCBssFyMDf0VDB05Kf4eKQStnlX7f7TSuMA0kwYozmpTe+0cGDAs8gg9/D4JLyN0P5bUV2zmADymeeXZ6zWMmVWXXKfB6NzSR//liYNkE3NPMHnHUcodLX40gHdFsLz8wnEExU1sCfw+EXkwXP8sfzy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3k6r+dH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53349d3071eso1671079e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366766; x=1724971566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd4L2pq+cNv6ptoDFsJhK7t/4J9oetWQgiC2gczlRyk=;
        b=Z3k6r+dHHxeQydjJA3fj0+rgwM2Vypu9l6UL/k4maW5PVfy+R81guPoRV4cJXwCE6w
         hKufeaHLsHXAkMSPTudDcbN/BLDBGAsnwPtT+exL8QUWOqBmb6WqU7wfaupaz0tJ7FjP
         omyvnx4QOQtNe3pZtGyvLvO8zTuIX22vnJK3YSDJmc0G36cWnMmJ2WsLEiBSljuBluCb
         I3kR/RDXRaGtK1qjyn8UxeEgstLIfGLIFkSF+4qnO9YOC7suWLh2Jn/VaZ6DIetLF9Zc
         ZaBmx0LoTW350RYfh2ONT7nOJ1n/zfptILzKJrzL2HZsFzuK5MdsFOG5VsaxhG8n0wa7
         8DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366766; x=1724971566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd4L2pq+cNv6ptoDFsJhK7t/4J9oetWQgiC2gczlRyk=;
        b=vS78k6aY1raTfGOTkhK2/tNk/qPQelv392EUU8iKScuen7TqrtIxJdhdg2GGEpv2At
         eHr3riqHliPjHEZsNi14qM/NhLJR6BSILrL56GcT9ve14M5cKM0rMBVY58oc6ZSLowsv
         Zl/oZJtANc1h35K0sNjDi6IKhEMlLCTb/ubihlX+sGPc6EhUqKx5H6VPap1ct9RRyAkc
         CM1IdbNN67qdI1dVI4lVB8tOFLvsralliUhAGxJ45p7kdDkkajcsaw/KCOask9SBJngz
         i7fyC4nVYmsUh01UoBjhsszSEpTv/pBRSEVr/w2aaOO3Owl+3D8uzwCGzOZGZfDauWPs
         8nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaGpR8KvPfD47q0C73vwXshHmTuLxil0v7bUNNEZHIm5gHn1LJNMmiIjlBue7GHwWDHyX0sswXiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79KpDy6oW40U81NOZYduihroQDsixgfL9QcAz8+2ib7dEsZ6i
	vAn/6e8me3ljwaByGgchf3HXd4BLAioLCj8//VPZVNBbMAvFJIJ8mvDuiPmar04=
X-Google-Smtp-Source: AGHT+IElCYJAQaHkgKGtxiZoFimfR6Ft/lHijVpFpocO2DjQz0yBFh0jjHM8cqfvGlobtCvc9hXNsw==
X-Received: by 2002:a05:6512:33c8:b0:533:4638:d490 with SMTP id 2adb3069b0e04-534387bbf16mr242936e87.38.1724366765813;
        Thu, 22 Aug 2024 15:46:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 01/10] OPP: Fix support for required OPPs for multiple PM domains
Date: Fri, 23 Aug 2024 00:45:38 +0200
Message-Id: <20240822224547.385095-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has turned out that having _set_required_opps() to recursively call
dev_pm_opp_set_opp() to set the required OPPs, doesn't really work as well
as we expected.

More precisely, at each recursive call to dev_pm_opp_set_opp() we are
changing an OPP for a required_dev that belongs to a required-OPP table.
The problem with this, is that we may have several devices sharing the same
required-OPP table, which leads to an incorrect behaviour in regards to
aggregating the per device votes.

To fix the problem for a required-OPP table belonging to a PM domain, which
is the only existing usecase for now, let's simply replace the call to
dev_pm_opp_set_opp() in _set_required_opps() by a call to _set_opp_level().

Moving forward we may potentially need to add support for other types of
required-OPP tables. In this case, the aggregation needs to be thought of.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Clarified the commitmsg.

Changes in v2:
	- Clarified the commitmsg.
	- Addressed some comments from Viresh.
	- Drop calls to _add_opp_dev() for required_devs.

---
 drivers/opp/core.c | 56 ++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f4598246a87..494f8860220d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,27 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
+{
+	unsigned int level = 0;
+	int ret = 0;
+
+	if (opp) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			return 0;
+
+		level = opp->level;
+	}
+
+	/* Request a new performance state through the device's PM domain. */
+	ret = dev_pm_domain_set_performance_state(dev, level);
+	if (ret)
+		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+			ret);
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
@@ -1091,7 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,27 +1123,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
-{
-	unsigned int level = 0;
-	int ret = 0;
-
-	if (opp) {
-		if (opp->level == OPP_LEVEL_UNSET)
-			return 0;
-
-		level = opp->level;
-	}
-
-	/* Request a new performance state through the device's PM domain. */
-	ret = dev_pm_domain_set_performance_state(dev, level);
-	if (ret)
-		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
-			ret);
-
-	return ret;
-}
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
@@ -2457,18 +2457,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			}
 		}
 
-		/*
-		 * Add the virtual genpd device as a user of the OPP table, so
-		 * we can call dev_pm_opp_set_opp() on it directly.
-		 *
-		 * This will be automatically removed when the OPP table is
-		 * removed, don't need to handle that here.
-		 */
-		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
 		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;
-- 
2.34.1



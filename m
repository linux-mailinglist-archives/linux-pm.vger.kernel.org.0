Return-Path: <linux-pm+bounces-15059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0133C98D30F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A26B23F25
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF31D07B0;
	Wed,  2 Oct 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMaT8AC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5641D0797
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871778; cv=none; b=I8CVPR9wj3I6ujAs/y24PWJu/rJiZRw7h5w913paFdC9tp6UBV/rbxCed8VUZktpYexIhEqx2ihoSHopZ0wIO15Pf/tbWvaAfDKWneKKeDdj62jLLvU+f5x3zeXqru89gS/cA8AdnB7SdxZMBhoRyCdGjoqCR10H+4nH2lMRbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871778; c=relaxed/simple;
	bh=ymLt5GJ4WzLGmHp/1aNDFGoqylRVrycvX/KQELNdW6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceR+R/Hn2UHen603tzLfKDw0Re0coDnxKUMP+ZSQVRetrGe0pROMKMQJYylLDolEJVJf3rlCPgZLZGYJ8uMEnCpIiEBDs0Vou0UaIM6Ru8t9K72Si1PPhdMn7zLhHwYJwFCEdUG5OKnv4DooHXYK5UwlnGJDgw1PfSj2OogWTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMaT8AC5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e53ca28so4351422e87.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871775; x=1728476575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo7s8jETlda0+BRvPrZ2XPBCxDBpJQxwBMXkwhH6GW8=;
        b=gMaT8AC5iqB0I+NLajV3wkoPVkLytwhaRosYJ8dLNL+W9NI+15f2q4IYUkY4oWbyVh
         p9yHTaRB9wTKhxqKUCno1GSmm+sBulB3gK6vQvs98oxbD9WMuXZMQWPBcA3JAOYYiAfA
         Mu1HhQsZLeAONuGAHAfkXjiAizQgtEtoUDtN2IxdCXl3g4/tdAVTfK0co80J7a4yiaT6
         8iDo5H5faKXYeKTbd7Bd31rSEbbq20Nw27DpjvT394KDc2yiOi6xfvk8qWy6kjXJVupv
         BjRbzJWMPm/Qu6+FtjE8sifqyQRFDUISQQhTmd7cJqZixb3XE/YAQTWQh6pNk4vpJO0x
         CLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871775; x=1728476575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mo7s8jETlda0+BRvPrZ2XPBCxDBpJQxwBMXkwhH6GW8=;
        b=o0AY6bAohb0D3I90TlvKe7jEjJPAFSPcMjO3o4gWDfWkS+zh5m+cdUnhh0rWG+zqIe
         bLkALgudow2Wkx0/dUxpFTgBEm1agZY5lF0cBo8ZdwGcLwbC5poFHs3xEHPuWzz3uR5C
         OYNgdd4ABMGHIH+m7jcjw6pkOk2BBUJm+adnVN5mfe2PKDXK+2exJuSE59u4tzxMA6j4
         5ab6AXv47H2/Syr2eSzUTMMQUVSCvkrtPToIkE+mj1erYLBSSFPp7Rttm5LqTglvvVIC
         prQsFw17+7R8wSYAyf3nkVG933GH8OSQPeBDrKbYPpF2QVAG6mrTHNAcr0e72RmwVXQb
         +wqw==
X-Forwarded-Encrypted: i=1; AJvYcCXN3xJ5/meh8vPM459p6ip/iqamkBz62PHHoKrqRORih0+EIc7qcjVx9IiGaEPfsajJ4X24N0nvyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxakw1GcehFtHGLEPxOqL310g98I46NR57vPDz1BVeCxcs9ipYZ
	H0+YYEzdD7BBRnCAirZiL6mib5gkmV1kmtn8OKmRIZC+UxE8/dgLP8rEyp3RSPg=
X-Google-Smtp-Source: AGHT+IFh4SkJpxD6spSOu73m9HsEd5DxCdeculcsrmUe25jRNKIFNnrt0WhU+LWoCEgB2xvQ62eotg==
X-Received: by 2002:a05:6512:3b9e:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-539a065e945mr1702937e87.4.1727871774821;
        Wed, 02 Oct 2024 05:22:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:53 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 07/11] OPP: Drop redundant code in _link_required_opps()
Date: Wed,  2 Oct 2024 14:22:28 +0200
Message-Id: <20241002122232.194245-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to that the required-devs for the required OPPs are now always being
assigned, we no longer need the special treatment in _link_required_opps()
for the single PM domain case. Let's therefore drop it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- None.

---
 drivers/opp/of.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 55c8cfef97d4..fd5ed2858258 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -295,7 +295,7 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	of_node_put(opp->np);
 }
 
-static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
+static int _link_required_opps(struct dev_pm_opp *opp,
 			       struct opp_table *required_table, int index)
 {
 	struct device_node *np;
@@ -313,39 +313,6 @@ static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_tab
 		return -ENODEV;
 	}
 
-	/*
-	 * There are two genpd (as required-opp) cases that we need to handle,
-	 * devices with a single genpd and ones with multiple genpds.
-	 *
-	 * The single genpd case requires special handling as we need to use the
-	 * same `dev` structure (instead of a virtual one provided by genpd
-	 * core) for setting the performance state.
-	 *
-	 * It doesn't make sense for a device's DT entry to have both
-	 * "opp-level" and single "required-opps" entry pointing to a genpd's
-	 * OPP, as that would make the OPP core call
-	 * dev_pm_domain_set_performance_state() for two different values for
-	 * the same device structure. Lets treat single genpd configuration as a
-	 * case where the OPP's level is directly available without required-opp
-	 * link in the DT.
-	 *
-	 * Just update the `level` with the right value, which
-	 * dev_pm_opp_set_opp() will take care of in the normal path itself.
-	 *
-	 * There is another case though, where a genpd's OPP table has
-	 * required-opps set to a parent genpd. The OPP core expects the user to
-	 * set the respective required `struct device` pointer via
-	 * dev_pm_opp_set_config().
-	 */
-	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
-	    !opp_table->required_devs[0]) {
-		/* Genpd core takes care of propagation to parent genpd */
-		if (!opp_table->is_genpd) {
-			if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
-				opp->level = opp->required_opps[0]->level;
-		}
-	}
-
 	return 0;
 }
 
@@ -370,7 +337,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 		if (IS_ERR_OR_NULL(required_table))
 			continue;
 
-		ret = _link_required_opps(opp, opp_table, required_table, i);
+		ret = _link_required_opps(opp, required_table, i);
 		if (ret)
 			goto free_required_opps;
 	}
@@ -391,7 +358,7 @@ static int lazy_link_required_opps(struct opp_table *opp_table,
 	int ret;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		ret = _link_required_opps(opp, opp_table, new_table, index);
+		ret = _link_required_opps(opp, new_table, index);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1



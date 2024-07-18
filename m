Return-Path: <linux-pm+bounces-11241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D0593713B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006E0B22593
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B514882A;
	Thu, 18 Jul 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6KNyqmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1D14659C
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346215; cv=none; b=CN88Nq6zm3TyzX2bm1dLmj38sOxwZo7EHgO9VFs9W5imtZaBczr6BICD9RMHU9lqQB/tyvHYUgWmlpA+7sNptkdqdEbff2ks8Q8Mc4d+ZJX133w8J8eG1U2KjiOPjlGPu/z0gtWKccPH9t1SvZS2DRhB3xcSobpo+/wRwx7ZDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346215; c=relaxed/simple;
	bh=qimQZF+FWN9z++adsecIC/pT/coamrdDTurSaVUGTQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HweU+TK4iVmY4PAae+plIwLEFWYQqE00zI7+DF1ylFQxfTe3R0ZT8Nycg+bfprFmF4PC5JDiBH9RWPB8Cd/aM19unQnfQkBIF0T2buHx6zJxlZ7jJf26XwdvOfBy0o5izunCiugfDF/7HFNNy7swb76XIttstvWqViix0e84nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u6KNyqmN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea929ea56so1856969e87.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346212; x=1721951012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X41EpoGFTr7V+lfPhB4bKmmLvKDngcfGjNQze8E5PAc=;
        b=u6KNyqmN8TZZocJzEu4W5hIcc/qF2FtxEZXkwZcsb3hobPsqT3FXsZ2gRz0MCCVBOB
         6nndK5GyNRgkHvz1yImXOec3t+ud/8GxbZOvi+8DpoHzTiYCYPH2wBU0b5uxmY0sIT4O
         qjw7dfY0hbOt98+OmN573p+Jx37BQnr5LPg02uDPELKVg5KYhABuHa6Jc41r1HUZP6Jc
         7CnAtnC3ZukEr0meXbxGsXL181sbbgaIahUVQZXq3QZJ/MeAWG62Hu8jFvOdbgFFvlxE
         5+jejjY+JwRb0gkG6jU5fjIcTcGIAyuAcgsPhsTyot5obpr+u6S5E1URn5fxVr9GeC1K
         AxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346212; x=1721951012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X41EpoGFTr7V+lfPhB4bKmmLvKDngcfGjNQze8E5PAc=;
        b=Fbz8jKFB+0VgxDXEVrC3s+FYBPMslwB9udszwvIy/MC1v8ZDWQQobhqM5AlLGSxjaa
         HErhLg9fiQh0f77BzePjRglOGD8p8THpMALSbppzgpC9jJb+BS556Q+0mPCLOQxyuZyf
         G8WQwSVW/Oqv3blp03nyGsW3ffbG5xm5RROgUwAbcIMnzb+L5s/hNFsRfAnJcqSe5Ke2
         RBfg1txI/tpMcZohoRA+iCS1DKEhvuFH9xgOAeOZCgV4prg5JCpcrN50hR8cfsXCa2Ml
         NfqP+CW2TYi4uwhDwfgiD4fj0JNV6NrlKAqt8J4OpqUo2oqVRBNMBX1+HPkCn8LoSnZR
         d0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWl+Z+RLnLbsNnVhtw6GOmsPNdOSzmD0WvNwyH+bnr5f43Iw/86sP4fRB1+udMYVflZKNZGfnfpkqGmOUVBaShaDLjiBZOcUIU=
X-Gm-Message-State: AOJu0YyPANUEQAjIR3KoyxfyTnZT1MTtnFkoEiqqgFDfFh9nIZ/qF+ZF
	tASu7jlskmSCvpfRmiJ5w1vRcQn/Z5Vx4lZE7vJMecxbwK0r5uq7afiX+iGx1ns=
X-Google-Smtp-Source: AGHT+IE9TgIAs0CUhULlnfsv1TaESmkfsLC57MT/HQS4rq5Rt9A4FzXWOTcdoX2vwlTRiyP6cV3eIQ==
X-Received: by 2002:a05:6512:3a87:b0:52c:dd94:bda9 with SMTP id 2adb3069b0e04-52ee5452793mr5704184e87.56.1721346212081;
        Thu, 18 Jul 2024 16:43:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:31 -0700 (PDT)
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
Subject: [PATCH v2 6/6] OPP: Drop redundant code in _link_required_opps()
Date: Fri, 19 Jul 2024 01:43:19 +0200
Message-Id: <20240718234319.356451-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718234319.356451-1-ulf.hansson@linaro.org>
References: <20240718234319.356451-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to that the required-devs for the required OPPs are now always being
assigned during the attach process in genpd, we no longer need the special
treatment in _link_required_opps() for the single PM domain case. Let's
therefore drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.
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



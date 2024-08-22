Return-Path: <linux-pm+bounces-12783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FA95C110
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF76284BC5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94AD1D31AD;
	Thu, 22 Aug 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBr0PZac"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAF1D2F7F
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366776; cv=none; b=mnDe5QNp+vfKKoIq+aPPkFrgZuWc1pk5J/svWTXpYIRlLwZm4j5yf9Q2k0LYRvzeYOJkXB5SYizLfw/J1QvWXQqPtwJaDGEqMvxJfHj03s9qZSuQtXSWEm5Bf4ZGzntP5qxbdafXroV8Xabvd0fZcQYvLWzi12Jbz121c3sSNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366776; c=relaxed/simple;
	bh=DdbTGiKeukNvKrj58NdnlQsJE/mkxNsRhHB3HvpjByg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+gDYsvVwS1reLfDTqp1BacZbZO7jg6dbuYeQxe7c1/BcPNcne9TZ1wlG026DEN/88E3y3gCOEnsv1MjLFFvihZ6qX+gec9X5vm8i90I3S2wE7P22Kld0TKpPwgLI57Y1dfas4vCY16t1kexGe55ftA+d0yBeQ2IzU6Ck+nkl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBr0PZac; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-534366c1aa2so569774e87.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366773; x=1724971573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D/aVXPRU7SQfotSax/kaOpx6m/gKAibnYASkuMoMcQ=;
        b=MBr0PZaceVkmnuGhJBesuGJ7nSFgz1cZNpzKi55wgAu3/KBXy4ZCPqrr6x3nSvOR9r
         O2yJ7CjKmdhFwvODskfm8x1FeBXJDs6qCE/XgUEZx1JtPhyKxLchW+pIekzQkzuLUOQ0
         qMGFDO0boE8vZHM0B2yskT1X+uaYBECzDq0U9nci3YkwjvVV/Os/c8BwTenOiqGo04q+
         wYlQrC9q+9Bw+1fhLj1ltg/4CFfjPmmJPTpZbzcWT33/19Pd+httNAI8oe31sm6w7FcM
         62SwGp0pBb0sOdvE1/HgMvWCf1B5tioX66d+VUlYUmoEkerf8VhNhLxvKDM7QrmeLjsO
         mBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366773; x=1724971573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D/aVXPRU7SQfotSax/kaOpx6m/gKAibnYASkuMoMcQ=;
        b=uxKcYu1nxl01zpPU/ftcdZNA86OfbzkPjVTlTAEcKLtjGoAqd77DhhWSp+d3WtnTW0
         nKBYnj74AWWodrj6OkelfQP3w4zoqn/C8gg9rfEdEyh9pfiXIFaamr7jpSGs8/8OdUu0
         IXPXO/V1avY6OIaUW8zoywFjJDF2++Mbbztn1NJVYTuZnJuHqKI/DMQwHDiDyoSJhCwP
         TSQ2a7mT1E5dhlBag1zPA8oxNHzAG/X0NlspdPDjaFvq3SgUc5d0s7obvNZgisfEUJtx
         1jeqVFhB+jZZkLAQu1rpEc4AzZAm+YbHbyC4UPT3ujHkU6vBClMbfExo6n0ZDKU9w4NY
         zqGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrLdedPaV/MMwkW+6X+D7pQE4MYkeRZeWt5dhCLqGiiL0NN054niz/GhkShwAfP9j72Z1GhOv3nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkskY+x0iy1ueDzn5jdMz7eNWxkYms4PL6UGJG9OvKniNRbnH
	uGfPg30HBsI+/hTAwEzxv2b4cgdY19usUDLot+lNzAi8O3GC/Q8VY26Soz6/NGI=
X-Google-Smtp-Source: AGHT+IHhhSvatCGlzIYJAKPJG00P39imQvuyh3f4XRIvd0rEr5zWn9noMQWqj/FUZVYPNGBt3R/oLQ==
X-Received: by 2002:a05:6512:e89:b0:52e:767a:ada7 with SMTP id 2adb3069b0e04-53438868d57mr128566e87.50.1724366772836;
        Thu, 22 Aug 2024 15:46:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] OPP: Drop redundant code in _link_required_opps()
Date: Fri, 23 Aug 2024 00:45:43 +0200
Message-Id: <20240822224547.385095-7-ulf.hansson@linaro.org>
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

Due to that the required-devs for the required OPPs are now always being
assigned during the attach process in genpd, we no longer need the special
treatment in _link_required_opps() for the single PM domain case. Let's
therefore drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
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



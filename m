Return-Path: <linux-pm+bounces-9582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B676690EFB8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634D51F21846
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF5F15099B;
	Wed, 19 Jun 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aa9e9Z4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21181E51E
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806149; cv=none; b=GdTi4UyS//vdxWgAmEmG9luGPH0dkPsi3Ko6rEY1Ngiq7IideR8RFCT3pUoLQDd6lxnHfAPMrzjPGBZaieA5meZVXZOLmS8c++kag6iQTrd4NVJ0pX4FSkLiMI3S/URil0HvIPEjZ3PLbAoH8Mk1TnSakIBNEitT62ogxXWU3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806149; c=relaxed/simple;
	bh=O83FNAdgJkgnscldJT04vDrZcANIzWxDsUu1SHrFuVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3N/U1CBA3YaxewE4rLVlShfLGrERGr39w92/rhTWdAmErBA2Xp03eay+itx//jNq5gZ87Jo0dNRD2Jdx7pTB9v4ZzJjtL1AhPLwAT+Mn+bwvH2vBM4FvBtSjCZq+ocfyCkFknV33hAKYbAEchW4TNQLxy4T4G4jqS/x/16Ii5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aa9e9Z4q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so8015308e87.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806146; x=1719410946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=Aa9e9Z4qC+7FRcAJ1q2bo3powkg2C0Eji6uh/qT8BlN6pbygVtWXlC4Z1NUFWoY5Ov
         CWW9Kxr6kafVXafeZxEvTQgiJ1untXlvfuG2i8Ttd/NV+6kGhINmMTblQwWUd3tEKzLc
         vMkb/NuOjstnpFgVQa94K7Htzwmb7oE8xv4mUhHThgiyzrYrSBFZ8qqqDFeo3+Pscyvq
         QRzqfK7G8hbj/mZmBoqMYogESV50dA6KQ4sz04UNZM5g7NqtJDcwkHAviTLPJZbLcUsN
         oP6kr414Und5rnU1baOpQwzopZrD0jxCaiBcfHF1pAG8j3mLkWSh+NZeait5QzhY7xhN
         Y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806146; x=1719410946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=eAbljMMi3JEJN95fATWZvIl/Wu87zRcB71zrZGW3S6mwRlmPWgwAqxlaonJGIzmey2
         619gFlQVhDQyaPKmeYx7uenGA6Odpui37GeLz3Z8InBa1SiBg1nx2UCq88BGZRYdWAPs
         DY2pXMqaM7SDX8qo6d17tgoyIjzxVSfu3lHDT7RiBzO3c1siMvoLdeDDiSpeW3cd2ZAL
         xxR6xEBkLxX1p0wuZt+sUFOkWEU1TssgWsmyVSYV+OMbpRP8I6+h21ehuS1SO6OUcBWZ
         zH3hee69gmmMznGguP23bgOo1XV1+VjtlcqmRX8NRfB7h5FGPxLQAOQHqJd2hG82mOtF
         jU5A==
X-Forwarded-Encrypted: i=1; AJvYcCW5TvO1O18cN8pNeOzllH5JLLQ9THxpXFcqkJOm3hT5jxR6NDP7s2XgpnOyAFkbWtxgeLasXk8MLY8kDG5oiMhlVQnvzMkUh70=
X-Gm-Message-State: AOJu0Yzl7KAD4zOCTbey6aGkU2je1uEcVeaQR2ouNMGV4tkspuagrC/w
	YzoYEsSdQODKTYchJn76JB2AfbIcS/Jj7Hkt7aDzFK4JbWnoWLk7WEja1yo5sAk=
X-Google-Smtp-Source: AGHT+IGQ+IYY+K5JUtUrmVUaq99dM/Fd1SYa57uUXgyiboWmtgSst2pNGb8vCO3FJvkmSr34Pv77RQ==
X-Received: by 2002:ac2:5f93:0:b0:52b:e7ff:32b with SMTP id 2adb3069b0e04-52ccaa32fbdmr1920541e87.23.1718806145693;
        Wed, 19 Jun 2024 07:09:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:05 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/7] OPP: Fix support for required OPPs for multiple PM domains
Date: Wed, 19 Jun 2024 16:08:43 +0200
Message-Id: <20240619140849.368580-2-ulf.hansson@linaro.org>
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

In _set_opp() we are normally bailing out when trying to set an OPP that is
the current one. This make perfect sense, but becomes a problem when
_set_required_opps() calls it recursively.

More precisely, when a required OPP is being shared by multiple PM domains,
we end up skipping to request the corresponding performance-state for all
of the PM domains, but the first one. Let's fix the problem, by calling
_set_opp_level() from _set_required_opps() instead.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 47 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4611fe1b5b..45eca65f27f9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,28 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
+			  struct dev_pm_opp *opp)
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
@@ -1091,7 +1113,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], opp_table,
+					     required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,28 +1125,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
-			  struct dev_pm_opp *opp)
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
-- 
2.34.1



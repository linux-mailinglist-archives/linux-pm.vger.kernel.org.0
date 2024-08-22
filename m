Return-Path: <linux-pm+bounces-12784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272D95C113
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B781D1F24906
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2C1D3629;
	Thu, 22 Aug 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7BV5jQ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAD1D31A4
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366777; cv=none; b=SiRaMrm0tRHGIV/kpQ2ukRw1fDK2TJd0oQJ+vSMURTUlsLtE8D2QYpiDu+oxkmf+5AcmkNS451QaIZMMeYNfl3fu37JrVDpVCKbcSH94od6rL6kClmLQF5CJWJpquoclrEXGvbVsukS4niEr87Szx5F4M4SRF7TlbOHTKG649qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366777; c=relaxed/simple;
	bh=aTdXvkE8ROQKXFHFBAQ24D4NEQho2z3rdw1RpRjU0c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF+JjNgDzIekumqD1jOBwTNDKc5gwG6fZ2VmYfka+NziMaagWMD5WGHse1akILTgLoSoC3g0z16Q0SN5OHstmcxHVpNRnhawydxUsUiiWE8lX61OGXYPQEX5DohRPzJJk364+n8rnQ3PcMzAHfsImrTJo4QAJDeGyHSvKWp+fDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7BV5jQ+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f24263acso11130231fa.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366774; x=1724971574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUsoi4RcXT0izJStB+EvDnWgGn5xCm1gI9JONZb3y0=;
        b=o7BV5jQ+N0P62oXue/wvqFkHWl2zRVz5w06+d3+UNS/O6K/oFROhrWnanEvc8M97Ya
         FIbEay6117dGgDHn47H+yJScq3Lq153bbpXr6qrxb+RgS/U8zoi60hjGvFv7o2wzQYOS
         yJw0AeenZO9bMG4YAXjbjzH1TBoicW4i/iHnAn3kJrHxjQiECy0liUxIjP7c0+tDUaF2
         rTAkEcGB+jCp+Jg5IpQ4BqmrCpGLcWP6MSOqICI7mYzHE8cNPlloWK0qKVfSVMrVdkFV
         ZQTLXmoKge4Br18jaOVaGGMZ9xmHgUk+FC46T+eSDdUjf25+Y7RNdLgGhD36KnDAfhuk
         r76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366774; x=1724971574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SUsoi4RcXT0izJStB+EvDnWgGn5xCm1gI9JONZb3y0=;
        b=aG/iNoFrVXMYxn1q5Rl/tsxDfo7x+W689MBWY3zBNskTI0U1n9NciW1Qjtg907kAFU
         VDbB2obRlLWT53ZwkbdK/iJwJSb3QFafpYXHFk4f1uJx2cKM8DZU8wChaSkn9u905koB
         ai+o1xUef9JZyI8/D6cPAVlA4yq8vh0ygArTZVg8T8gZFEuMFPvsYzP+XEmeP27eVeR+
         PvvKbkyFmU8WxHvc0DXTM59lv+kqM6eWuqhYPjVeoR6Crd2Z1xZlHavzVSgz9AkDzjpS
         H7+RcnjGOApJoXuy1C2K9/mYWGhwbJmZgnC7lXpLZGX/fBi7IvDCicgXgVv0Y+xeWWep
         1IIA==
X-Forwarded-Encrypted: i=1; AJvYcCU6hY+6VwR7wPSVtwl1TD68vc1B7vVcdMVeqfw7Z+cd+PtWw8flCdq/V3WsYdrD6AdBBTalWOV7og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/kf151/dDpgYFhK/qviQChAt4BEq+l9cupGrEpFoDDS1LX8l
	uPhW73y62GO58gDA1U+ewtWU/CPvDQaTL200j0g73WCdU97j86X52FrMElm4kRc=
X-Google-Smtp-Source: AGHT+IFCCObzEZAVeGe1xfyTqYfuTrbw8eyiD2QimVszxWbvB5nuySwzUySXFi47i38a78U9YOXQGg==
X-Received: by 2002:a05:6512:3e19:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5343883d5e7mr474551e87.6.1724366774161;
        Thu, 22 Aug 2024 15:46:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:13 -0700 (PDT)
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
Subject: [PATCH v3 07/10] drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
Date: Fri, 23 Aug 2024 00:45:44 +0200
Message-Id: <20240822224547.385095-8-ulf.hansson@linaro.org>
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

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into devm_pm_domain_attach_list().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Updated commitmsg.
	- Converted to devm mangaged version of dev_pm_domain_attach_list()

---
 drivers/gpu/drm/tegra/gr3d.c | 38 +++++++-----------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 00c8564520e7..d52433cf939a 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,6 +46,7 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
+	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -369,18 +370,12 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
 	return 0;
 }
 
-static void gr3d_del_link(void *link)
-{
-	device_link_del(link);
-}
-
 static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 {
-	static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
-	const u32 link_flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
-	struct device **opp_virt_devs, *pd_dev;
-	struct device_link *link;
-	unsigned int i;
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_names = (const char *[]) { "3d0", "3d1" },
+		.num_pd_names = 2,
+	};
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -414,29 +409,10 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
-	if (err)
+	err = devm_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
+	if (err < 0)
 		return err;
 
-	for (i = 0; opp_genpd_names[i]; i++) {
-		pd_dev = opp_virt_devs[i];
-		if (!pd_dev) {
-			dev_err(dev, "failed to get %s power domain\n",
-				opp_genpd_names[i]);
-			return -EINVAL;
-		}
-
-		link = device_link_add(dev, pd_dev, link_flags);
-		if (!link) {
-			dev_err(dev, "failed to link to %s\n", dev_name(pd_dev));
-			return -EINVAL;
-		}
-
-		err = devm_add_action_or_reset(dev, gr3d_del_link, link);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1



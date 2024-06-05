Return-Path: <linux-pm+bounces-8637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23A8FCB51
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4AF28B116
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2525819D08E;
	Wed,  5 Jun 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu2djFZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DB19D08A;
	Wed,  5 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588233; cv=none; b=RdH//taMA10S7bitf7dTJY1FJLYOTI8yZVK0vE524P2hw9eq8MF81NeU+G14yxeVVZ4MHNzW3Ij2a5aDugqaEDVTnHqpgGl3nmQJVqcNwt2IHDK/KhrBz1eQVf+jZMbF73YTLPv9UnWGqYH/UQLdGPU2lsSknKdzksh46zcsk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588233; c=relaxed/simple;
	bh=2qc7xtVwI4CiT0pC9vG+7u+JDCjgqbPwOZDfWyrOU2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnUieX9QTuOpIJ90lEAV2NhZzKxh6POCs7HaGQmIc5XN60xRrZgiLIug/+5mObsWWzzLi9yXmAnuNP7972TAKeK5z/rTkah+Crg6aZkUqi/+3d78Qwt3wGz2SYkeeXEGc4taQLlsY6TKHj8ArsrhbT+FOldsbFAEMemciycyzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu2djFZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0CAC4AF0F;
	Wed,  5 Jun 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588232;
	bh=2qc7xtVwI4CiT0pC9vG+7u+JDCjgqbPwOZDfWyrOU2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu2djFZslzyp1pX50ggly1V/Tku8VS829mjcxVBOrUntXg+uOUqAGdPODmSV8Po0r
	 oL3edSrgBkkNNaA0hzAaHtg6ziEoFzPhVY6VdjSMXg5TYBXygW6amU3VNReNnDvkNj
	 lpawtQwbrIIlmAZ6EPuzbE9dYtWvDYS4cJcKuYYpeiVNHQYe1EoydP5fk7Or31gntl
	 rMjX3d+MOEn4s8mLxoN2pr2VE5FTb/MLMqWygI5RDyRnDwodfsKIOFja52ZJTGkwdQ
	 bOsCnEhmbtNXOpbI1KT1l7Y8yjq/Naanzovukg4aPb0CviQQZ7aI6cTW2boxMmCGf5
	 xHLMjtiGAL3jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 28/28] OPP: Fix required_opp_tables for multiple genpds using same table
Date: Wed,  5 Jun 2024 07:48:57 -0400
Message-ID: <20240605114927.2961639-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 2a56c462fe5a2ee61d38e2d7b772bee56115a00c ]

The required_opp_tables parsing is not perfect, as the OPP core does the
parsing solely based on the DT node pointers.

The core sets the required_opp_tables entry to the first OPP table in
the "opp_tables" list, that matches with the node pointer.

If the target DT OPP table is used by multiple devices and they all
create separate instances of 'struct opp_table' from it, then it is
possible that the required_opp_tables entry may be set to the incorrect
sibling device.

Unfortunately, there is no clear way to initialize the right values
during the initial parsing and we need to do this at a later point of
time.

Cross check the OPP table again while the genpds are attached and fix
them if required.

Also add a new API for the genpd core to fetch the device pointer for
the genpd.

Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682
Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
 drivers/pmdomain/core.c   | 10 ++++++++++
 include/linux/pm_domain.h |  6 ++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e233734b72205..cb4611fe1b5b2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev;
+	struct device *virt_dev, *gdev;
+	struct opp_table *genpd_table;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
+		/*
+		 * The required_opp_tables parsing is not perfect, as the OPP
+		 * core does the parsing solely based on the DT node pointers.
+		 * The core sets the required_opp_tables entry to the first OPP
+		 * table in the "opp_tables" list, that matches with the node
+		 * pointer.
+		 *
+		 * If the target DT OPP table is used by multiple devices and
+		 * they all create separate instances of 'struct opp_table' from
+		 * it, then it is possible that the required_opp_tables entry
+		 * may be set to the incorrect sibling device.
+		 *
+		 * Cross check it again and fix if required.
+		 */
+		gdev = dev_to_genpd_dev(virt_dev);
+		if (IS_ERR(gdev))
+			return PTR_ERR(gdev);
+
+		genpd_table = _find_opp_table(gdev);
+		if (!IS_ERR(genpd_table)) {
+			if (genpd_table != opp_table->required_opp_tables[index]) {
+				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
+				opp_table->required_opp_tables[index] = genpd_table;
+			} else {
+				dev_pm_opp_put_opp_table(genpd_table);
+			}
+		}
+
 		/*
 		 * Add the virtual genpd device as a user of the OPP table, so
 		 * we can call dev_pm_opp_set_opp() on it directly.
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c5..c40eda92a85a7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
+struct device *dev_to_genpd_dev(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	if (IS_ERR(genpd))
+		return ERR_CAST(genpd);
+
+	return &genpd->dev;
+}
+
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
 			  struct device *dev)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35fa..f24546a3d3db3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline struct device *dev_to_genpd_dev(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.43.0



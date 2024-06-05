Return-Path: <linux-pm+bounces-8639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB08FCBB7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CCC289B92
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453071A3BBC;
	Wed,  5 Jun 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGYYnkr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D31A3BB5;
	Wed,  5 Jun 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588322; cv=none; b=Qz+dfht4DKfftDm7u3mDQFjUxHSVNrGlv1nFweGyPj6kwofrUSMiaMVN/Ibn0uWbsfsYSbXk6rQXM9U7Oj7GuywBWoIKSbJ8rYwDgoOpcL0SbeuqQvPWTY79KbUiFmzlh+Hl9eDGgrw1twi0iRB58MMXZVIbO+IGSZDsHXUMmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588322; c=relaxed/simple;
	bh=7Peoo8116R+0tzMZ6eSgKcwQzl2GCBHt0w2OUN6LXds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsE3Vical8KdPkg4lldiT4cOolQ+fLGhZbFBICZ48Urh1es+Be74qhbHrkEWzk3iXQj4cltaRK5hd+0+r98SPsPtY1LT+BqbdNci3EYeLoI+9YlzD003RfJRFn9qm6cG1Tth/nEcnHaXZFTrVYyMxBgo3vQwcHJfk6KjC4HJc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGYYnkr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0A9C4AF07;
	Wed,  5 Jun 2024 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588322;
	bh=7Peoo8116R+0tzMZ6eSgKcwQzl2GCBHt0w2OUN6LXds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGYYnkr9G6oJHgJ1RZK6+by70SO0AKDow4ZSdrYHRQjPrBpI37MsaInwnC7xUnooU
	 7oZKs+jsamHyTlDW+dHDh51N6M4MKDlImDIgkDGnflDJR5FqYR2zjt7B/Xj/koErf1
	 wGuBCbhXkSeW2a2jj4w5EyDK89Ygmh/5JZ0TN+97YZbsB0mzcRkVC3h4GeSdTJYWmK
	 ZYaMwUJSAlINlKGwy0YzvxusBWqvLALbdj1SpnepmwQJb/A2x9aBGfYpxvXgwGvgbu
	 wXV/SImqHO5Mz20UvlLp0UqIzBke7JOc2uokZGpB6phehbC/GHEf0Pi60EKfRwE5/u
	 ZmWkbI7amTvLA==
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
Subject: [PATCH AUTOSEL 6.8 24/24] OPP: Fix required_opp_tables for multiple genpds using same table
Date: Wed,  5 Jun 2024 07:50:34 -0400
Message-ID: <20240605115101.2962372-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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
index c4e0432ae42a0..3f02deba4aef6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2393,7 +2393,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev;
+	struct device *virt_dev, *gdev;
+	struct opp_table *genpd_table;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2426,6 +2427,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
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
index 18e232b5ed53d..755e4d0c63224 100644
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
index b97c5e9820f97..0e18088af392d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -233,6 +233,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -280,6 +281,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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



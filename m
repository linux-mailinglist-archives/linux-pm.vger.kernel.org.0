Return-Path: <linux-pm+bounces-27562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72845AC2432
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B804A639F
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E6293B5C;
	Fri, 23 May 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5SO9le5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DA29375B
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007644; cv=none; b=ULdzVYJOzsJlsDoevIJPZwqoEe2SVYQV91oGj4lprP/Smxgb9KdF/rqOEhFgoYK8kJMf0cGa2P5SYtIE0pjs17QQQolD5euAydIy1mr9CH2gKdG9qY41z1LiC3jFAD58vSpc6Wo8pXd6GMr8q8oZ3vju+kOnptTepL44HsdkP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007644; c=relaxed/simple;
	bh=ZWuXoHRykjcQLvugNPxk6lMikozG+4QpwkTnChGz2TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE24sYJprzA/UG5pNf1G5Il5lrYAmAab8NrKKG/LA5cKKO5gy2tZReOOq3TqOAiIx7MCL/DVKztvw6Pwr/JAPUx29zTvSObM6h9T4XSMX2iZZ8WsFQdsdJid9/QnU57z0wZsJvV/oMp6mL2Ezmv7n94z2pN0+HrAresJ++aTtK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5SO9le5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-551ed563740so8326583e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007641; x=1748612441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVuyQaWXDo32LSLemr1Wiyb/FTBR994cD4zXDWOXk7w=;
        b=s5SO9le58+lcREccGO3MaZ3Nx2+KdSXzrVQbArBo4z61JHHrAOBhqqSYXX6up24zAJ
         +YcOiTuf6q4mTwzO4Xj+j1H0WZSL+YBaXmpTIiJYDw4X7PdcOpIDCbp48Vn92MKXpTR6
         Xzh5kUB1zNtEa1WzfWZQfPOlQt6Qd23OgwXIy39LqJMax2+Fcz+8OXft8e594mheGooa
         pcj3++Cjh/+IbvacuYQg2l+CeYdLndpCI088jbEPjgUt78RRTR7t41H7Tbc5v5MdZNmk
         vK5Kaum5Vyl6a82bL7Mkt2foMr7B6Mj1L/7DMcoU8RFxo/m9wI1/WYgLuen7bfJ1HkP7
         SmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007641; x=1748612441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVuyQaWXDo32LSLemr1Wiyb/FTBR994cD4zXDWOXk7w=;
        b=dv8W6b3El7DXrk1Oneh44ai/56U9vt2lcg3drGJTrXv59+8r2PFXWIBey4Qh4dKFvt
         CYrO6E60zSzJxyvVEx1mbUhd/zea0/3xIy9mWXP7dgHI8WPTVduySgK63ca4v5CqwD27
         xWtaKcXBZK+Drk/ljgjeiOK1m3NJd25Yw2/9l5UhMlVm5CafuRqJQA6iQN57adBP7xAv
         vynuGMveUTbA6OAD6ks5pFXzls0n2DHOKkbgDSu+6LtLfng9vdXGtCZ9CTBTB6ztmUgd
         NcRmLGu/4KPUZzUnjlkLKXDhi5Su3co/+VUgfwJSafrITQh07KGhfC0qWPVIbbRjPcUt
         vZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8c3v2ZWfEMmqUM5iPqpsu9n5WPWKCNmIyZRxC7vuFhgvlphYc9smdhDIzDjw4aNHmHBaR/4pJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIy/HOB9RvBpkaF7xcIGAQnzeTgL2HmV/ZkUk3rs452T+307vF
	CKfyDGJQA7jQd8tXNtdaSWpQM8BfgdrHyEoTlWyDYSEazjNEkwhQp+hAhuVyqthDG6c=
X-Gm-Gg: ASbGnctQv6IUy8/J+q7OhJaxjJTPJxhRFmi5lQFgnIMbEJx80aga0SVfJyFMpSuq6p5
	UcVABIwHCKPNCaW7q7GwfpsJLi8xVL81ez60/sANcjRAK5Is2RM7wtPlr6RC/HDZm3VugMHa96x
	20TQU1Nrl0iYubzVP2xchag0z7NHumcgAVXB2QSgM70dImFyq9+Cy3HIyLOx1fWoQxD2q49ty0f
	TaGKRzVvzNFvVp9OgbXMMk0aZiO4a+2bZszNYRqKIX07avQmHyV5uoBumNWx6rsic045GGfiLEF
	RgzbO8mRpcW1VroVl5xax3FzCb4Z9AP/50WQZZe/ZAgV8uSgj8sG42Or2HQUxMpT1Z5EPR1MkqI
	mP/0A4sXxSFyMNzyMFu2t+mL+iQ==
X-Google-Smtp-Source: AGHT+IEVIbZ36oRuBgtUIV/gY2wrVcuoRcXYW2ew4UfjOMiCZ3z4VNYKumXWYXyWKY98xtuLk0dWog==
X-Received: by 2002:a05:6512:22c9:b0:551:eb71:4aa8 with SMTP id 2adb3069b0e04-551eb714cbdmr4668192e87.25.1748007640612;
        Fri, 23 May 2025 06:40:40 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:40 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/21] pmdomain: core: Use of_fwnode_handle()
Date: Fri, 23 May 2025 15:39:58 +0200
Message-ID: <20250523134025.75130-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's avoid accessing the np->fwnode directly and use the common helper
of_fwnode_handle() instead.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ff5c7f2b69ce..9a66b728fbbf 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2557,7 +2557,7 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	cp->node = of_node_get(np);
 	cp->data = data;
 	cp->xlate = xlate;
-	fwnode_dev_initialized(&np->fwnode, true);
+	fwnode_dev_initialized(of_fwnode_handle(np), true);
 
 	mutex_lock(&of_genpd_mutex);
 	list_add(&cp->link, &of_genpd_providers);
@@ -2727,7 +2727,7 @@ void of_genpd_del_provider(struct device_node *np)
 			 * so that the PM domain can be safely removed.
 			 */
 			list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-				if (gpd->provider == &np->fwnode) {
+				if (gpd->provider == of_fwnode_handle(np)) {
 					gpd->has_provider = false;
 
 					if (gpd->opp_table) {
@@ -2737,7 +2737,7 @@ void of_genpd_del_provider(struct device_node *np)
 				}
 			}
 
-			fwnode_dev_initialized(&cp->node->fwnode, false);
+			fwnode_dev_initialized(of_fwnode_handle(cp->node), false);
 			list_del(&cp->link);
 			of_node_put(cp->node);
 			kfree(cp);
@@ -2916,7 +2916,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 
 	mutex_lock(&gpd_list_lock);
 	list_for_each_entry_safe(gpd, tmp, &gpd_list, gpd_list_node) {
-		if (gpd->provider == &np->fwnode) {
+		if (gpd->provider == of_fwnode_handle(np)) {
 			ret = genpd_remove(gpd);
 			genpd = ret ? ERR_PTR(ret) : gpd;
 			break;
@@ -3269,7 +3269,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
 	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
-	genpd_state->fwnode = &state_node->fwnode;
+	genpd_state->fwnode = of_fwnode_handle(state_node);
 
 	return 0;
 }
-- 
2.43.0



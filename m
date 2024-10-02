Return-Path: <linux-pm+bounces-15056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F99298D304
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BACC1C2130C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3261D0421;
	Wed,  2 Oct 2024 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qo1oX2nh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FB1D0407
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871771; cv=none; b=nXHcutXj0CpqJvoQqsRx6ytR88sm8dz9aEqECNoHZx4mEGm+nJvgaDromk0qtN2l0RGVlhO0Nh2vV9d9+pD3P47TicMfXc7Xe0OE1stI3u+r/f3Xw5chs6uCiO4MpOiKZcOOieQHTtD1AwKtCIR0x7UUU59P4dMIrHtTo80jztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871771; c=relaxed/simple;
	bh=TZkiMrnNMk4mmip8oR67yJAGJpfZyAECM/+jjd0fBWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRyxEZhwoE4Qxg8n0Y891aVtJ9MQuh5Jg8K2fhCv9Dm+pujf8fc8XTb2fy8A91L9Clg9AsSQquIBSU02I7ZvX0CHB5FyaK+lE3Z3soawo0gs++Py71+PIOm7BYopTDamNfmQ2FDK8186mWJk0I8EK+jlQOmfldB/o55yRiot1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qo1oX2nh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so8134534e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871767; x=1728476567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcqYYVpLlj10i0qHI4tc+kYUPF8iaIvwsza/wsplKHw=;
        b=Qo1oX2nhMe23S6V31IGIj1KZsuWR70RqPEiIvVXqcmUkpcXx6YAuRLNXC0AcdyxdQn
         9hgMf+FrXQlh1DPgwV7rWZ3X1RBvsrVodtQ6usPJRhrVJybFfmk9f8ViDDN1xTeAVV1l
         Zt9u/QmrHamxr4B9I8UmWO7RJVJoNNRcxtoelSigCX0B6N+Gy94T3HOsYa12qucrIjny
         fiarliC33WQOZWwk5e3yYXRWLvXcMGNaCXRKEtrIFV90of030MgQ13AgDS3g5B7FqSN+
         sx2iNftydZcAEeNKxAp52+qCpTMpyNfrMP7vDT2Yxc/Ts23L1qG5H6TqrQYReeKvaS/C
         Vv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871767; x=1728476567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcqYYVpLlj10i0qHI4tc+kYUPF8iaIvwsza/wsplKHw=;
        b=NhqqE9qZ6m05yMhG0l5UKUQylfq+LoRXAkruUKJY2vmDi76tpUFoUe2ws7Av7v+bmt
         9lTLBSHX35o5ZqvsNCHsndWkxGJJ7I8x6JuIsEmWaOOoe5CGt5t4FH/2/fW5VjALT2eI
         BFB+FsoBpi4iG3qyfBkd7yoMYhW2HI8FVzEFHru0eq8fJ3TqxXkcU0Cq+ht//tFJlgRD
         6G7WVgeGoUds50FYReQkrExRJsDCFxHWvapjNLvi80h7ncF1+ahOeXDGKMjPGE7wyBKU
         KSsRiCN6z8ZLc/Lx/ijVjwHzFkJoFXiGReyjfm+RSdiK7AeQr6RVC//CQsDultnyV+NW
         pO8g==
X-Forwarded-Encrypted: i=1; AJvYcCWX79XpxG+sY8u2gwIr9f1bCJodiLzJT/xkH+Dq46qQg9zD9PL9+D76X7sVxanfayNewwq2PlCTUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Yd1Snp641orlwihMDp2NBGHtOeUVxlhOWfO8po7NqYoj08i5
	NcnsF89SiEBb7NADgQUwi5kztjGbpLnsP2Hf0MbP7BGO2a5mMDz9saHRBhZAiTcIr35ANdGfGnO
	p
X-Google-Smtp-Source: AGHT+IHBll4ncIEBYGqKdaxs69HtCnmoAhR+84ep9dXSOAPhQjdXaNEiv/qua/AGSiyj5o8AWkwt0A==
X-Received: by 2002:a05:6512:12d3:b0:530:aea3:4659 with SMTP id 2adb3069b0e04-539a0658b50mr1838434e87.9.1727871767496;
        Wed, 02 Oct 2024 05:22:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:46 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/11] PM: domains: Support required OPPs in dev_pm_domain_attach_list()
Date: Wed,  2 Oct 2024 14:22:25 +0200
Message-Id: <20241002122232.194245-5-ulf.hansson@linaro.org>
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

In the multiple PM domain case we need platform code to specify the index
of the corresponding required OPP in DT for a device, which is what
*_opp_attach_genpd() is there to help us with.

However, attaching a device to its PM domains is in general better done
with dev_pm_domain_attach_list(). To avoid having two different ways to
manage this and to prepare for the removal of *_opp_attach_genpd(), let's
extend dev_pm_domain_attach|detach_list() to manage the required OPPs too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- New patch.

---
 drivers/base/power/common.c | 21 ++++++++++++++++++++-
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index cca2fd0a1aed..781968a128ff 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -11,6 +11,7 @@
 #include <linux/pm_clock.h>
 #include <linux/acpi.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 
 #include "power.h"
 
@@ -222,13 +223,15 @@ int dev_pm_domain_attach_list(struct device *dev,
 	if (!pds)
 		return -ENOMEM;
 
-	size = sizeof(*pds->pd_devs) + sizeof(*pds->pd_links);
+	size = sizeof(*pds->pd_devs) + sizeof(*pds->pd_links) +
+	       sizeof(*pds->opp_tokens);
 	pds->pd_devs = kcalloc(num_pds, size, GFP_KERNEL);
 	if (!pds->pd_devs) {
 		ret = -ENOMEM;
 		goto free_pds;
 	}
 	pds->pd_links = (void *)(pds->pd_devs + num_pds);
+	pds->opp_tokens = (void *)(pds->pd_links + num_pds);
 
 	if (link_flags && pd_flags & PD_FLAG_DEV_LINK_ON)
 		link_flags |= DL_FLAG_RPM_ACTIVE;
@@ -244,6 +247,19 @@ int dev_pm_domain_attach_list(struct device *dev,
 			goto err_attach;
 		}
 
+		if (pd_flags & PD_FLAG_REQUIRED_OPP) {
+			struct dev_pm_opp_config config = {
+				.required_dev = pd_dev,
+				.required_dev_index = i,
+			};
+
+			ret = dev_pm_opp_set_config(dev, &config);
+			if (ret < 0)
+				goto err_link;
+
+			pds->opp_tokens[i] = ret;
+		}
+
 		if (link_flags) {
 			struct device_link *link;
 
@@ -264,9 +280,11 @@ int dev_pm_domain_attach_list(struct device *dev,
 	return num_pds;
 
 err_link:
+	dev_pm_opp_clear_config(pds->opp_tokens[i]);
 	dev_pm_domain_detach(pd_dev, true);
 err_attach:
 	while (--i >= 0) {
+		dev_pm_opp_clear_config(pds->opp_tokens[i]);
 		if (pds->pd_links[i])
 			device_link_del(pds->pd_links[i]);
 		dev_pm_domain_detach(pds->pd_devs[i], true);
@@ -361,6 +379,7 @@ void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
 		return;
 
 	for (i = 0; i < list->num_pds; i++) {
+		dev_pm_opp_clear_config(list->opp_tokens[i]);
 		if (list->pd_links[i])
 			device_link_del(list->pd_links[i]);
 		dev_pm_domain_detach(list->pd_devs[i], true);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b637ec14025f..92f9d56f623d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -30,9 +30,16 @@
  *				supplier and its PM domain when creating the
  *				device-links.
  *
+ * PD_FLAG_REQUIRED_OPP:	Assign required_devs for the required OPPs. The
+ *				index of the required OPP must correspond to the
+ *				index in the array of the pd_names. If pd_names
+ *				isn't specified, the index just follows the
+ *				index for the attached PM domain.
+ *
  */
 #define PD_FLAG_NO_DEV_LINK		BIT(0)
 #define PD_FLAG_DEV_LINK_ON		BIT(1)
+#define PD_FLAG_REQUIRED_OPP		BIT(2)
 
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
@@ -43,6 +50,7 @@ struct dev_pm_domain_attach_data {
 struct dev_pm_domain_list {
 	struct device **pd_devs;
 	struct device_link **pd_links;
+	u32 *opp_tokens;
 	u32 num_pds;
 };
 
-- 
2.34.1



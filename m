Return-Path: <linux-pm+bounces-17960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C19D5FD6
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4296FB23843
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBD4C62B;
	Fri, 22 Nov 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMoMBqC0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39292AF04
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282939; cv=none; b=o07uyQoEmtf1Xw5jT6JUS1CyDC85HbV4BONzxUNwtm5VqwaHQOm8Fd6UP1zL5WyppgteqP7RiLNkaJtcYDHe1Yjc3iPUPxaOYD2ThFYYC/ddrrbLq2WHPP7JdHYrLQP4tqgy6f3yS62wkI07j+1MaRhoHWnIpmn8hpN+nDPEtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282939; c=relaxed/simple;
	bh=zkH6RmyvNVFvMmhT+5A7e3uFPfJEHUmdMgV1uxwJ3Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcuSO0OR3lRWoN+56xD8OLUYxlqyJFdtYEkgVZc8pnKFfJFC874DLOSKw/VvgOveDQnaiAOiK2w8qvmOlhEmR1qUCQqjw9LCYX4qgVxfgvNTHVRjoLnWLcJfE7ITAhEkex1BDYB+/9ixMhvC7seJMb+R4VR7SrLAicYG9l1vuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMoMBqC0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd9e853ccso184546e87.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282935; x=1732887735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4difOWFZgJjnD1C8UcBJOhNA8o5YsQWO3tN/+p0Mf1o=;
        b=OMoMBqC0dpOi6jQJ6PGGIiAvX1RFa3ltfKUDsGZDA0xythBQNop2afL8vtWrR8lOvR
         QCH6AfV12eG6shT+6Lx/nlDQYgva6+SmsEVjFnl9zihdjVKnzr4MM8KvPhnI/YknmKee
         zVH64f2V+SFyN2ovbC2a1U4sG0MELNRqfAfbGCFD8WEeoFX7W+1ZM8nLuTQrkIHAuUyq
         HKjMwCoKYUx+dTBgZCSeqG67yS8Qmrn6SxjCtnrzDMoar9IQWMXvE8KgQcgKJTubzWln
         Mwa1GQMBSNoXxbLY8qQ6fBPE6s51CocWbZqSIEZpS9ma9WjW28CXRJM0vRGa72PH7vdb
         y/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282935; x=1732887735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4difOWFZgJjnD1C8UcBJOhNA8o5YsQWO3tN/+p0Mf1o=;
        b=uoJbhX1CAn5eNaNvCyx35GkT4fdBKt+N1pYswSr5Er1xB5zi1I/lgOj/YLzBOWgmJu
         gVvFZftHoLKY1Auz6m7xb452vK6XfRP7W1vI+WMgpd15irGGZNO5PdRrLlHgte6wNN1l
         RX36H03CKqzrSXg2iQdTbjEI0yyJNZkex4s5nE+2tKJyYhTt7DD8dinIVphQAAMPRYSb
         HHQ+KBYCHQ8ni6KVUyphtmL3/oXrO2nHdlpIRpVjeA+xAFhW5TvgBlaznBY14XR4+eNP
         cNQj6Ltl4DBFPowo7vR+o6oeO9lDd/5R1BotYnCyO9DvcBL2hn4GMBKn75LZS/s1IAfO
         njrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsrqz05lwaRr++rNmaxq7VTXOG4qNCLhaV0VDzf5NKXISPPE+xw9Yf8bTozpXWqNl9qdX6TEMImg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmoyELlI0hPQxsrxm+Va+ktn/Krmdb2rR/VL2NmEwoyJmpE59
	yF4GCUJCFKf0+5vV6iUBC+MXkNKmS4Tdl8W0USj48IEwBAqXfTwQeWHvRiw8rGg=
X-Gm-Gg: ASbGncvj1+vvBGQ11bQuA/eFsV2KxyWhF0n8UhM4q+R32YFPXco5rUKPPd3C8AqLFWx
	ujZ59+bIvw0I0xti/3gXqj5cpI6pa71h17RGgohKMnYT/xCAkQeXN7ruB9aMYY0yvcOTt4QYmSv
	bjiv6gGgBeJ1MY35PHdYvLXEbASCV2AfsMzYGMCC1JfgMYACjErQoECZv215qvArTQxYDmPCS6D
	+tAwyIyaW+0rsx4GvNRw5pLSBgBc8DCjMDRkh3XsaHe9Jx4BniMZV7+2eK6qxTh6e37NvFHWgMn
	WaCEaYZo7SfkD18VQEvDwXnP
X-Google-Smtp-Source: AGHT+IFpXYUD+s/zi1m8hUlKbDnxnNx0uM97l+zyDIOWiFoCB6hbeMWDPChCxVJnNPG7XSOTrGoKsg==
X-Received: by 2002:a05:6512:3084:b0:53d:b998:b7e1 with SMTP id 2adb3069b0e04-53dd35a47ffmr1986425e87.3.1732282934904;
        Fri, 22 Nov 2024 05:42:14 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:13 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails
Date: Fri, 22 Nov 2024 14:42:03 +0100
Message-ID: <20241122134207.157283-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122134207.157283-1-ulf.hansson@linaro.org>
References: <20241122134207.157283-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ida allocation fails we need to free up the previously allocated
memory before returning the error code. Let's fix this and while at it,
let's also move the ida allocation to genpd_alloc_data() and the freeing to
genpd_free_data(), as it better belongs there.

Fixes: 899f44531fe6 ("pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4d8b0d18bb4a..bb11f467dc78 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2172,8 +2172,24 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	}
 
 	genpd->gd = gd;
-	return 0;
+	device_initialize(&genpd->dev);
+
+	if (!genpd_is_dev_name_fw(genpd)) {
+		dev_set_name(&genpd->dev, "%s", genpd->name);
+	} else {
+		ret = ida_alloc(&genpd_ida, GFP_KERNEL);
+		if (ret < 0)
+			goto put;
 
+		genpd->device_id = ret;
+		dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
+	}
+
+	return 0;
+put:
+	put_device(&genpd->dev);
+	if (genpd->free_states == genpd_free_default_power_state)
+		kfree(genpd->states);
 free:
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
@@ -2184,6 +2200,8 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
 	put_device(&genpd->dev);
+	if (genpd->device_id != -ENXIO)
+		ida_free(&genpd_ida, genpd->device_id);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
@@ -2272,20 +2290,6 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (ret)
 		return ret;
 
-	device_initialize(&genpd->dev);
-
-	if (!genpd_is_dev_name_fw(genpd)) {
-		dev_set_name(&genpd->dev, "%s", genpd->name);
-	} else {
-		ret = ida_alloc(&genpd_ida, GFP_KERNEL);
-		if (ret < 0) {
-			put_device(&genpd->dev);
-			return ret;
-		}
-		genpd->device_id = ret;
-		dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
-	}
-
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
@@ -2326,8 +2330,6 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	genpd_unlock(genpd);
 	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	if (genpd->device_id != -ENXIO)
-		ida_free(&genpd_ida, genpd->device_id);
 	genpd_free_data(genpd);
 
 	pr_debug("%s: removed %s\n", __func__, dev_name(&genpd->dev));
-- 
2.43.0



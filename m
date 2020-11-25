Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41642C4D4A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgKZCMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:38 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79DBC0613D4;
        Wed, 25 Nov 2020 18:12:37 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id y4so559031edy.5;
        Wed, 25 Nov 2020 18:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79LT5m1zaUEIWOsVIZn2npQ8OOH0dyimXZhYveTdKSk=;
        b=XMjlfsLSHHkIbEVSU0E0i78ckvqn6EHeL+XFd67OAgMdnwV8rrihYAiak99JbY0m9x
         semNdv5hZiK3+BpAwHLPB4o33pSmyyHlORAm4WnyIObyL9Ke4NEDLhFwv66XYGh605Px
         dgEqcdORufm0U5zygjKd+y/K8Ia9o5lulDOcAT6hqhEyHEJ0MYN1jvU6ZNxctCqqoCP4
         ub3OdjOjoajWHicTZ0gyAMalY3ddo1z+4/uk56AaPj0DTovHgb02uXoQrOYiXg6p2MGe
         IzJw+wk/X5tESgruWGijb+oSee3HFXp9lQZ6bUzQXgwsSTjA6NK1cfandpdhipCKiMdF
         mvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79LT5m1zaUEIWOsVIZn2npQ8OOH0dyimXZhYveTdKSk=;
        b=uAOHQGPa2Z101yFzFIXhR0G9GtJBee4JFnwLixLinke0SCJclZU6vOfbh7r6Oa1lqF
         a50yy0sppQggjZJzq/9U0LepT4NePZ3naTMZGMtAClty8v2b4WY5y96aQ9Dbao6xnu9l
         DJ2l8Z1ReEPhriJr9yIBqPJ8noLnFKx4A7GKEP2eicTCWWFZJxOY98mxzRMNFZGq6sof
         VV00h373ffW3IuH3EQwDUJ4rloLxxTulZ+xwfU5Durhgz3qlsfEO2kco10OEDwXJF0xj
         wR32auQ9m+h5ydfwuSyOoQQobNTMuRWzRa5kfSq1YYhtdILbbLnElco2t5tiRly1/51D
         R2VQ==
X-Gm-Message-State: AOAM530JkLkc1IudOD9GVoR5vceAyOerR/OYzYk/ilu8FlTF3lW9Tnw2
        vVKVUAUzSzOaUqmF/VG84LyldQ5vwigg9A==
X-Google-Smtp-Source: ABdhPJzGhIRKUFYiFTIkbfmOHWRD009oGY7oIb9i20gCyFcA8R/lMKUVvA3F8+i66aUlrvdpp1u9bQ==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr489880edt.141.1606356756395;
        Wed, 25 Nov 2020 18:12:36 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:35 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/8] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Wed, 25 Nov 2020 18:48:24 +0100
Message-Id: <20201125174826.24462-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 80551e17cdbe..cd89492385c7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1005,6 +1005,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.29.2


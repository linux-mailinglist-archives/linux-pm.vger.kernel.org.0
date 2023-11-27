Return-Path: <linux-pm+bounces-267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D77FA159
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 14:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC7F2814ED
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10FE2E413;
	Mon, 27 Nov 2023 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQ8cKdK4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10A131
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 05:50:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a0907896so5504583e87.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701093041; x=1701697841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHnnOST8qodLmJFznIgEimpV+tpqmVRkoEWPEvmIUa4=;
        b=MQ8cKdK4bNOca3G7Et1zmM77SY/Ak0sQR1ArkiUBopHtmB1i0t07vcVVL1Nzo5mtGW
         ifUoi+1N5D/a3/KpQtuWOrdHZC23Sw+8hVbW4ofE+sb6PMKGXFOYgboRIFE7u6NuLoHy
         N0hpEee8gpG1cMEOy/fpt9qYYocKAeOYjN+ivAhx7YrmJSSIU6dx5lq2Vbo87RDVXc2G
         OiORGdHLWsCDvU0zHj+WJAksifhWR7fc0xFl3mCH6S+dG6R6D36cOQMa9KgWT1COgWFM
         NeEseneDVG1neSFiEs+g3+BmJE/Tf7aUDzveGJDN9Ho2MBbQQSBgOYv3ywYzQX5rwOto
         Nzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093041; x=1701697841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHnnOST8qodLmJFznIgEimpV+tpqmVRkoEWPEvmIUa4=;
        b=RZ8ncpDhzsksHD3fQSwBSMXIREdptTkhtlHOn5KdKCiCdLaDnItsI7WHA8w9TOlPjZ
         TQy9W7VwJgUZ8wNWJ5JXPgkYLImgOOOEGYaPSdHfi2chTTwUc2fsORowICQvTy6GGe6b
         QeUNywo+KYTsWmw0uxmG4j4W6KWk3H3ZjHphsRmOGUWU0NSN+FnLmlNm6iYDH2PVhS4x
         9ZE7bjfkuCu9dJDMs2VVl/pAVaJh9a1ybLHaFnt+GjC7rwpUSAQCA60M9XdCkP2w5SIu
         KqXUjMQci+BKugpZs7etysEuOaGtCDjJAGz6GwkYpPtYjaU0q4uJ0VIP5U+5p9dys5Oh
         feLw==
X-Gm-Message-State: AOJu0YzUJZ0k6rFePwlP+NLpAkhLZxrsVIC//c1f1XoY+xZwJXlGUWtG
	beHc30vLxl69vM1zsbWNb8QZJA==
X-Google-Smtp-Source: AGHT+IGDiNX5D7/anI1R+Tudw4bfEQ/qcFxbTMxwrBkuAl4rMaVjucnEIl1eTqCSkKJvrItPiZdwTg==
X-Received: by 2002:ac2:4210:0:b0:50a:9fb9:91b with SMTP id y16-20020ac24210000000b0050a9fb9091bmr6551854lfh.64.1701093040398;
        Mon, 27 Nov 2023 05:50:40 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id t7-20020a19ad07000000b0050a71ac3f45sm1472663lfc.203.2023.11.27.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 05:50:39 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: arm: Avoid polling for scmi_perf_domain
Date: Mon, 27 Nov 2023 14:50:33 +0100
Message-Id: <20231127135033.136442-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was a mistake to prefer polling based mode when setting a performance
level for a domain. Let's instead rely on the protocol to decide what is
best and thus avoid polling when possible.

Reported-by: Nikunj Kela <nkela@quicinc.com>
Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index bc3f78abb6da..709bbc448fad 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -35,7 +35,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 	if (!state)
 		return -EINVAL;
 
-	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, true);
+	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)
 		dev_warn(&genpd->dev, "Failed with %d when trying to set %d perf level",
 			 ret, state);
-- 
2.34.1



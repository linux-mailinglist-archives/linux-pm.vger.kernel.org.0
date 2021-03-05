Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D032DF45
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 02:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCEBxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 20:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEBxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 20:53:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD98C061574;
        Thu,  4 Mar 2021 17:53:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s15so621314qtq.0;
        Thu, 04 Mar 2021 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYfAEJ7fWkQ8UQ2mRUbZHr7wUFmDZtF6/2zKh9pN6Wk=;
        b=hNLv39f5qF4XPo6yUqn8fH1B2MToNlKICvGn3yh5ve42PRs8gWcpqppHtoclZdkVaa
         3neRQqHYRNC1xbgrbkmORGdMF1auW4ctxJCGQ1VY+pKVCdApFNpDIxB44wVjNg0B84Jw
         KsuemL1uCLJ7JQ3JMlOMu7O4czwInI1isq35ATqrR4peRR8K5jyOK5PZWV1ZQbHuQd9X
         mztXQKxj1xL3S1Gf6NL1TEqQ5HEjLR6HuSizb/1S37unA4wNYUg6s3wKm6JGokY6ttVG
         zkddNSiAXEnPf8M8hLSaCTdwim4amSk8fwbgJk+ujBcXYT6vIiWyH1uDLYLqoRsmcTbX
         aNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYfAEJ7fWkQ8UQ2mRUbZHr7wUFmDZtF6/2zKh9pN6Wk=;
        b=qw2fYOxts4j9pTUaV1sCwKFIGGPDXXWHfYRH7AguDniqO+C1mp00/VP3YhXR7DtKs+
         EEo6rXGYtYzYDlhBTzKTZA8Nd69ZiRkIgTaQV07dsrTMQ29B77ERI7xxEJRaGzyHNZgK
         WV3ipHTvro0o6T49io/0bhI6pm4lpMXRkmDfpP2PVueMe9eYWDTnxcuYHAj0oFSBP/cr
         zkjyAq8hSXW42dAfmdgHErq/SOcNJdLzYRavT+snROzfkKBiY8htzExck10wepftdxSa
         QwRghJ1eg1n0v2PZ5+ODkMsKqrUF5fgzrZNrWpw71lIkNwoKKDKW3Mn+AH9upRNU93K8
         qCFw==
X-Gm-Message-State: AOAM532L3OqtdpatzJhVf+bOkAMtyKZyTlrZ911t6q0UB4Ug/oSlRUuH
        8zMnjRTOCssGqHyVjEdFGkU=
X-Google-Smtp-Source: ABdhPJyt6oHeTYvBH3jQB4uQbB3/vyS03EW2YR+MqZSR0QvY3kxLOdUlmHQd79DhInb5VoOIENbecw==
X-Received: by 2002:ac8:578f:: with SMTP id v15mr6609232qta.172.1614909216076;
        Thu, 04 Mar 2021 17:53:36 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.138])
        by smtp.gmail.com with ESMTPSA id i9sm839832qko.69.2021.03.04.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 17:53:35 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] thermal: Fix a typo in the file soctherm.c
Date:   Fri,  5 Mar 2021 07:23:20 +0530
Message-Id: <20210305015320.7614-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/calibaration/calibration/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 66e0639da4bf..8b8fbd49679b 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2195,7 +2195,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;

-	/* calculate tsensor calibaration data */
+	/* calculate tsensor calibration data */
 	for (i = 0; i < soc->num_tsensors; ++i) {
 		err = tegra_calc_tsensor_calib(&soc->tsensors[i],
 					       &shared_calib,
--
2.30.1


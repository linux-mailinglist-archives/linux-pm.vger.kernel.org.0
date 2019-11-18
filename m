Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F1100CB7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKRUGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46338 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKRUFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so20424301ljp.13;
        Mon, 18 Nov 2019 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P674bIxJrMaTZu7WyWHeQk7pl1v4jGgsVqyyVx6alBQ=;
        b=spiEJtRIV5saMeUpajYCQ5oFHAjxhJPP+sC9mcTDqqMXdvDsRBxagGqA6yQnG618qQ
         XC4+PxPoTxlyPBp/5A+idjFiS0nrSgSWBoJhfDLc6Rm6YANYXFe3De9iuz/A7RLEJQRw
         WNY45/rfTpIWcYm6SyktkPyILs5/L6/31tZsNnKF5MvEq0eA/JBla9drANtkjwkO/Z5e
         w2g+bCWaog9t0AJ5fYkpre9fVpuQ3ht2zlDO/4L5waoBCl7WJqbkAcF0EISMMNvlnTAb
         48Dp5EcEQiP2c0Nf+JUabeSlQznSSusiA3QfmJUcyT8XOf/muOwSb8hNEVIuIbRHnMle
         vzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P674bIxJrMaTZu7WyWHeQk7pl1v4jGgsVqyyVx6alBQ=;
        b=RlqhNHzoXG7QDpIbb6E0X9V8U9lX1i7Y627I0a23MdxMBtytUI1GUWKRmBhiJglKZz
         0ezQAqY0Tfw2b3xQXdG2EzP8a79bomyeiNhnM8qXrGDeSbzmOiannm4pVJN4l0Qwy6Gh
         xB67ny6/CK+g07CkfHnf2bdhxVo8LSPebJXTFMYFIo/mr4yzy5daaJrGCile19NTvr+8
         H20qnMTOekdCNjtTZQkP2C5e7YYt0TUxvgXblObwmXTGRORib5Z5CEbLh/LEimOAuc+t
         /GjmyaUTQrxQmyupp5p+E0obYyn33shoAvrqKVXa7OK0cI9HtFWyg8rSttm3m818o+S5
         2BQw==
X-Gm-Message-State: APjAAAXBobppj/SoKKHW75x8cgtbPesHggJCD5TtKSkqqZp6sejT6/Yj
        xXXa5CsmdhV4Bh2tUe6fmDg=
X-Google-Smtp-Source: APXvYqyKNwb0ymffe6l7/ypszOjAW/NlNd5Bh84no3B7//dxfUL3Cs9VsuYJNsZUe/qA+1C2WhvqfQ==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr935708ljk.118.1574107551702;
        Mon, 18 Nov 2019 12:05:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 21/29] memory: tegra30-emc: Register as interconnect provider
Date:   Mon, 18 Nov 2019 23:02:39 +0300
Message-Id: <20191118200247.3567-22-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC now provides MC with memory bandwidth using interconnect API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index ee194e8ed521..7316ab50511b 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1171,6 +1171,11 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, emc);
 
+	/* Tegra30 has DRAM channel fixed at 32bit width */
+	err = tegra_icc_emc_setup_interconnect(&pdev->dev, 32 / 8);
+	if (err)
+		dev_err(&pdev->dev, "failed to initialize ICC: %d\n", err);
+
 	return 0;
 
 unset_cb:
-- 
2.23.0


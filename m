Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F9E2DB5FB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 22:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgLOVog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 16:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLOVoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 16:44:17 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5EC0617A6
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 13:43:37 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so15282732pfb.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4z2eTeF++MnGa1+aI6OPjywuPtpQngbRP/4e+JKTe3U=;
        b=EDgifev1scRfoEd2Cn1mDYaEr7hxwVyXbrAr5p/3Lymea0WQTrc8KlvOOwmV16A8Wz
         9ePYE0P3TVc9ef1YWrk46BAaNxhGj+AlhGDalipHTv4nX9iTJeXUTMdlvfrZQ5eBeVaO
         Y30J8puxdE5T6fEy/GvgVmYWjnQS8xisoEJ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4z2eTeF++MnGa1+aI6OPjywuPtpQngbRP/4e+JKTe3U=;
        b=Wiv435sRuFs4kfNQOxtlCniGJA7U0gwPn70WMN9DXJ3rcAUfioegZJHgDAOjiCDbGE
         7Mrcob+T6W7mupAfMfMpZ0GfxRdNVp5hCu2zAX7JCLsr0EXkIbxPhYDuOuuQYjRelNhW
         EDHnFlWjgrH+4RMmBQLfCsl2XLRtEw5FqhcLrFaHvNeVfcSQPiTlCJ576ZVzh0sWAoG/
         MAm52DFHh1dbaUn4CGUReITwIMkZdRyp4mCLBz9MhPldLGk4TCsWVO1FLqdtL17W8efu
         2LW/OEJGC3D5AiQeBlKAMuc3Akm69/BRGMBBRq0LLUXW4cIV+M+JCFWr1T0R4WZDnhgy
         0JBQ==
X-Gm-Message-State: AOAM533i30/zaH6Uo9cgosphxX8FDw6XnK7utq88ogRmOr6uMU0tHri+
        N6Gm87X0RTnVZnHxGRa8B1Qt/Q==
X-Google-Smtp-Source: ABdhPJwAUOllWbeqrrD779T72VoCd6tnv2Yrngm6wsgyD8phc8r53kqL22AzamUEN0pVKB17nqDC/w==
X-Received: by 2002:aa7:954b:0:b029:19e:cb57:f3c with SMTP id w11-20020aa7954b0000b029019ecb570f3cmr24646149pfq.51.1608068617183;
        Tue, 15 Dec 2020 13:43:37 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id p16sm50877pju.47.2020.12.15.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:43:36 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Alex Levin <levinale@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Tue, 15 Dec 2020 13:43:01 -0800
Message-Id: <20201215214303.2825937-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201215214303.2825937-1-dnojiri@chromium.org>
References: <20201215023120.2514920-1-dnojiri@chromium.org>
 <20201215214303.2825937-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.29.2.684.gfbc64c5ab5-goog


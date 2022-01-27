Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1738F49EE86
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 00:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiA0XIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 18:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiA0XIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 18:08:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D2C061753
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p37so4372782pfh.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7JkzSF7lxJgCpd6ZXDkhdvjrfqNJJ5Wge2dT4ZFw7o=;
        b=QkHrDYVuucq5tGrwY+7ofVKvafE8N1vG6K7wssS8MFOLQ8A+qT44Pw8OkxznULsPLE
         fU0ppcxIbnnoe3DkKlONgnWitZdR6bHPjT1zDXJKdypl9iivtwyPlKX/9eCq/YqaK+Iu
         BWm6b0pbXYtrWPXRj7GPsRq0ghVWt5Gr/dEag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7JkzSF7lxJgCpd6ZXDkhdvjrfqNJJ5Wge2dT4ZFw7o=;
        b=hFYKUIW0FI0rPZTzxHGgjYv3kSnZXn9L0h5cj99JTd+yN6PXjljybbGr2QtjJG5EnD
         aJUZk5L34cqpZ17wd+Uq34+tDaJr/7qK1u1AxDLXfUTiPFTW077Od7Uv4Gs8S2+QuJuM
         VC/4t/GJFFZo40hTDo9xAKSAO+kcbP17XKHN3rZz1kMV43sa29NinZfCLeYfUmK8Cixh
         uPBZNd5Io6qvOFbXKkIZJw2iX8Xz3PUUOTloe34gtyEN7yWkh8KeBTtgczqjWbYU9Pyp
         G68E9RTeLKcSvXA95e7aUBR9RDG3CvJug+dg4njk5aoiKzX+0P6AGUKw0A4hWdDW8S9T
         V4TA==
X-Gm-Message-State: AOAM531GvkeNwo0FHc3NeZYWgzJrwUBH5UdQE+920qq8Xj0BH11ZMrkF
        LeyFOvuoau0MPHzO2M6B7HfDOQ==
X-Google-Smtp-Source: ABdhPJxGSe8Or1J7VdvMjjKei+W+lXlkhGyA7m0Vzqh1YDxZLw6gaRpY1PqHnE/am+HMGfaQbFydiw==
X-Received: by 2002:a63:6c44:: with SMTP id h65mr4438729pgc.100.1643324915912;
        Thu, 27 Jan 2022 15:08:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id f8sm4740841pfe.204.2022.01.27.15.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:35 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 06/15] PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
Date:   Thu, 27 Jan 2022 15:07:17 -0800
Message-Id: <20220127150615.v2.6.I4bd77eb751d5bfce8346bfed576bcacb28e4550f@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These properties are:

* undocumented
* directly representing software properties, not hardware properties
* unused (no in-tree users, yet; this IP block has so far only been used
  in downstream kernels)

Let's just stick the values that downstream users have been using
directly in the driver and call it a day.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/devfreq/rk3399_dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 293857ebfd75..e982862f6ac2 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -430,10 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		goto err_edev;
 	}
 
-	of_property_read_u32(np, "upthreshold",
-			     &data->ondemand_data.upthreshold);
-	of_property_read_u32(np, "downdifferential",
-			     &data->ondemand_data.downdifferential);
+	data->ondemand_data.upthreshold = 25;
+	data->ondemand_data.downdifferential = 15;
 
 	data->rate = clk_get_rate(data->dmc_clk);
 
-- 
2.35.0.rc0.227.g00780c9af4-goog


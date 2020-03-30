Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8111971C7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgC3BKa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33697 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgC3BJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id x200so5559416lff.0;
        Sun, 29 Mar 2020 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9E7zI2IZnXV4YyjveISOsemm9R4xu7EUE6WXPbYZj5s=;
        b=SHY9Z0NgudDm+L5mpyLB00o4AL/yhAoKr3QhYv/uGqvjwF4WtUVJvJNV4sfPZp4VYL
         gQ+u862RKGhEHlNflC6XRFa34GlMpKu7biU4hVlvoZHgIlYg9/0jNqr8zWTVgN/fD+G5
         17chke2o76960p5eSNsbEF2fvD5ycrj+Ev4wEpl/k4OCU+JO65D6adaYNKF82XQjdMeV
         EiVy40M+MMGcC82Z4m+p9h1t5h+REMeOl+LLhVgSz8MDVIJD/RaihQmdSsD7ssnUvOwN
         i71Pw9XhUawf2Zz+MNMEz+qWo1g2srkUAlnyP1M/sFKBa8wCE+AB2T33wYureSb1X/K7
         BkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9E7zI2IZnXV4YyjveISOsemm9R4xu7EUE6WXPbYZj5s=;
        b=bSgyBvoQ3aqIYUz/pAQHTl2cdrglX780L9RTCIPv8hruxwYym5Z/GNzAtmY4Qy4FB7
         3y7vg4sDO7afm68xhpsMEcZDduz3Grb5pSaV6mKJz2wgyeXc7lLflpgvjEPM703Oc87q
         kkb/+DD7367rGj3dmzh5AXGa1lDKQ4P5QcAX6PXpVHugbC/b6qOLwKWRu8htWDZ/d7Gc
         1TcifQS2e0fw+QHyI2M5Mo//KSbekhu6azpqfen7Z444kJhul86JzWP23AyUJ1UT7byw
         ZyRLP6U8FwWPt6IyMNdRPFlCHIJfwNkcluc7noIeDGGe5a8QJWPl11+MhafcRQ7nNgve
         pLkw==
X-Gm-Message-State: AGi0PubzB084BeULJoK/piyiELUqTDd9kO2naTG+aGbjWVTygtEBrV6s
        ygRqhXh3Q04m0/03yUu2vf8=
X-Google-Smtp-Source: APiQypJb/KYN7Ausy9RzxNHKtBOMbGpnF36P6KkLPqb8j8gQzwiIUSVwL00ZzzFM4pP1djvb07ArDg==
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr6551417lfe.178.1585530597501;
        Sun, 29 Mar 2020 18:09:57 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 22/22] ARM: multi_v7_defconfig: Enable interconnect API
Date:   Mon, 30 Mar 2020 04:09:04 +0300
Message-Id: <20200330010904.27643-23-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra now has interconnect providers that are used for memory
bandwidth allocation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f8e45351c3f9..658b5c1892eb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1085,6 +1085,7 @@ CONFIG_FSI_MASTER_ASPEED=m
 CONFIG_FSI_SCOM=m
 CONFIG_FSI_SBEFIFO=m
 CONFIG_FSI_OCC=m
+CONFIG_INTERCONNECT=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44A61971C2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgC3BKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33182 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgC3BJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so16336312ljm.0;
        Sun, 29 Mar 2020 18:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzPcH2Zw8s/lvusSJ+NeMT9K6QE3NO3BQ3OrhGxd84A=;
        b=dAAbaMon+3/bSqoIuYfuwHx2KG8hghvSLrRSU22QfeV59mfGE+K6Fbxqmy75QxyRCz
         vzG5MdQuMDqHNheti6KOwuAC/+GF7vBVf/jEwWYS0JpHBODi64d+2WUXzJ80dVgPaNbe
         E2DmsKwTAP1jGTMw1ptNsZIEqJS4WhOcV9lNCgeUkDl9yc9Qhfifpe56l1OBc8mmkQVV
         /NvfFxStOa1MuTM+BiVP1h8E8A+35d/0zkbSj9rlEX3Q2stjrqJdoJTxDE5PJap/Nf7q
         zK7VvXq/44tRZFis67kdqpwYT1THGvNz40nr1jawM5e5NgNtwBdl8KhlaQDO66t+wvDQ
         tlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzPcH2Zw8s/lvusSJ+NeMT9K6QE3NO3BQ3OrhGxd84A=;
        b=qDnu+kPWV/9ND+LKejEZmAqor6MfzIhuWpFppmsiCp3RGCOW9TsKaHsV4+VjMjYdYd
         cCAZZ/Ay3YM21d9A1dL/Vmxd+5uykj5XmnVzK8A7IHMYnSk2Rj+kJMKCkEuMeQE8iWVb
         0IZ0R6VJNUd3Dv+xluudgsxI68nABjhjj9SvAtWqHDue8O+eJ7UVHczpv7BmHt6wF0qK
         Q+yXIITQDlUEWCmRwYs/0PxUOgKzmFwmdQre0UlgTtrhUAWiVk8looe9S9sT17ELQdjY
         44ruHFIvrIrNGeT86Fqvmq33Ccka1MWcdEsOKwB3r3SS87mQWpiqTYZ06K8/DK9skHzR
         ny/Q==
X-Gm-Message-State: AGi0PubxDCJkYL5oYiRk7eCnVCo8DKFJttw5pyfuSfY+8thAhEYjg6af
        fCIX+G1uhFxy0wNqQSEvonM=
X-Google-Smtp-Source: APiQypIYV+VJ2BotiGVJkdVXlprPFDGmyLuF/8w8UIlmHETYi4iZ9H/wP0ZGxE/ac47Mtz3QpiVAvg==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr5726081ljj.145.1585530596562;
        Sun, 29 Mar 2020 18:09:56 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 21/22] ARM: tegra: Enable interconnect API in tegra_defconfig
Date:   Mon, 30 Mar 2020 04:09:03 +0300
Message-Id: <20200330010904.27643-22-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra now has interconnect providers that are used for memory bandwidth
allocation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index aa94369bdd0f..0029259a6bf5 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -268,6 +268,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_INTERCONNECT=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.25.1


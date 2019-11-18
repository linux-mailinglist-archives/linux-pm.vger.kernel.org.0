Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D394100C98
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKRUGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36255 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfKRUGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:06:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so20442789lja.3;
        Mon, 18 Nov 2019 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgBM+uLJzoi65GUvGQFaYj+Mc0O6qp6cGsFHcfSLMpM=;
        b=BJ4fv0AwnApXCJ/jzU5KhwRXyOGjsTvs6Mjqo8PeutmkRPOV9rVFv8VtjRT1Ktniec
         Dt7kfpJNBeslPkg98uTYJA9Sw3O43bAD6SbTKcztfhjKY+F2/gko1DR3Ln2KCmQK911q
         WEKQlxYeeW1b+ZbBTGakvw5mOC4zr9RIAIJDhVFasyx/YTsmqSg4WO/Be2z9vOmEKZK6
         Vj0LAPaIYyqehAMAPob+y6AMWPUZTLd6xE80C0rixvgo8Ameqz+NIU5Te3r1x8vF49A8
         C5D7VRT6rUMiFuqceETgcghI2iejY4HASEus2rOUoe6anWfQkEWU2egEy5Eg7oiy6fAE
         CVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgBM+uLJzoi65GUvGQFaYj+Mc0O6qp6cGsFHcfSLMpM=;
        b=FB/+NwHhU5DsduZQarTNwFD/evkb1076MrbLPgkkZ2kR/s6N1RcKlbhjxDNqOaG3hT
         jb4bQBO/bQ6MZIDZ+L7IPvHOcaIthQsURLx4BQGzpKCQOvdGAUHfAWVMowC6QiEmuRhL
         5W2YMGdHJ3y8FBMuIPwh7lbr6TjS0Meo/ZLRByuqE1Amk0UsIrB+SNxa3A5ptUxmrbdH
         rFvQpnKu3x2eXeXkHQSxXuq3oLbbMvVDHjFnoWAx2Gpt97KOX38bdTJ7Zar7a8czDlA8
         LDxYNQbXNdEzn49D4z9/VK44dSJHL5iMYoV6TyQf5Kzro3K/W/8xrtZCuskuXev2lTsj
         oTRQ==
X-Gm-Message-State: APjAAAU0MtjVgRg6qaqLvkyC9nsz7eMsDap+LK/nfOHlgXa2z2b8C8Rr
        7hc9eWpDikHcgS0hKq0PzMI=
X-Google-Smtp-Source: APXvYqyfW0WKhD1uVA2rVUoy/KYxAGfvlAfMguWfPRJtCNfwA2lZLJ/fI3hIYDfY/IysuOAaUSc38g==
X-Received: by 2002:a2e:3313:: with SMTP id d19mr931296ljc.240.1574107557638;
        Mon, 18 Nov 2019 12:05:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:57 -0800 (PST)
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
Subject: [PATCH v1 27/29] ARM: tegra: Enable interconnect API in tegra_defconfig
Date:   Mon, 18 Nov 2019 23:02:45 +0300
Message-Id: <20191118200247.3567-28-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra now has interconnect providers that are used for memory bandwidth
allocation by display driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index aa94369bdd0f..02e3a987f69f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -268,6 +268,8 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_TEGRA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.23.0


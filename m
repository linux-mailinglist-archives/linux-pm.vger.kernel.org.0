Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A973100C9C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKRUGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45944 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfKRUGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:06:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so20394241ljg.12;
        Mon, 18 Nov 2019 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+FC1Ebz4V/tdD/aZtuLhFg4JYDJSNGd7mh8RgwKtsY=;
        b=H8d5vixAZh3pIcUcjoKGYvCRv2xI8bcCjulrLFsiJ3Wnxxj3JVyE2TbRbpPt/X0fLf
         Gw2IRXMWWl5aYik28WIzedXrgIqCkfE+8/DOUXrp3RBO2bTvguPPX4iR/fgY+12bsk+d
         QCpu4/m6YyjR5NA/cQ87YB4L9Yabr23tItQ9tL4pe7VFD9jGp8+DRxfMgXQDJCfoZPjO
         TJiOsZZPxdbBT1dXFyMoS7zd1hWzY2lcQHDEj6xjK8nl0x2HnxFiGU3GgfToVo3bZ1+R
         EcAIbIC2bOQB005pnu7W8gtDxRa+btulmpGLbEdXSLPMJ0rwwYatXZ2nlS5ww5Wlhud2
         MUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+FC1Ebz4V/tdD/aZtuLhFg4JYDJSNGd7mh8RgwKtsY=;
        b=gnk/x4as1nZ9NlbU5CzbhpOMCAIcdwwn17FY1Z8TM08BtP02pI4BTIgPpm0sBZEL3/
         SmDTzVBjW5mO7gMnktymkYuIR1ijf51249DTukv+H/xEodoTC3vGdEfVmMK9VBE8Zye+
         josnLnVMIjIPkHwD8Yk0kl4W9DeBevHQBv2pvqzycT/4SlJzPQ5hZJ4KgkJDB1ywvnNc
         6J9CS7UuunBmM6tdI8DKDKoydKpPUyLj6Fg4HiwFj7e3UdGAcuUKqSb6YHf9pW683QzE
         bdIFhR/1kA+o1nnNHsCpKuz1XLorT6DSX9vUABSwGYAfk0fe23/owyrSao5DPgaTwlfg
         lsmQ==
X-Gm-Message-State: APjAAAUp4IT5X5SfhtQP+1XAocYx0/GNRhHas+WnpIhk9w7GzobxmwEx
        vro45tXZAtiEbuXu1tnVokY=
X-Google-Smtp-Source: APXvYqxUTBrjlS5fpAxANC6wrqNZBFzKWst5uBs3YxOhqljqy1cqcRm52+irbhLhBkB22FMaIFMs2w==
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr890330ljn.31.1574107558631;
        Mon, 18 Nov 2019 12:05:58 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:58 -0800 (PST)
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
Subject: [PATCH v1 28/29] ARM: multi_v7_defconfig: Enable NVIDIA Tegra interconnect providers
Date:   Mon, 18 Nov 2019 23:02:46 +0300
Message-Id: <20191118200247.3567-29-digetx@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 293f0cea076c..c131d7969aa3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1085,6 +1085,8 @@ CONFIG_FSI_MASTER_ASPEED=m
 CONFIG_FSI_SCOM=m
 CONFIG_FSI_SBEFIFO=m
 CONFIG_FSI_OCC=m
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_TEGRA=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.23.0


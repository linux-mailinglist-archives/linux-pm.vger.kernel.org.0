Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69370396B03
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhFAC0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhFACZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:25:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BFC061574;
        Mon, 31 May 2021 19:24:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p20so17152760ljj.8;
        Mon, 31 May 2021 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qQFEWJjGeOPYXiDAusSsUop8XHEeCJbzRrrXiwgnWE=;
        b=a8cJKXfDeX7Ze1yeqJKOaFrS3hc+cQwFsuvJp9Blga+IBFmY+/3ojywdEcjS41O4r0
         K6+ZpQnKlSVRXyJ01c/HwidRgORrOERx4XfPceUIrxJfSEeP50Thej4Aogs2uA6XA6/+
         OY9ICvzeDdEwzKWCgpbGWTLRCealXrXcU6ZiQpm/KExZy2QwiGf1mf25zdUyFANAb5B1
         IL+WLtZbr21nb9l3brxUGLsybMCk4kO+7RXyTHYDTkzkAQtOnt9oS1782CmEMz0H3XeG
         Fuy7LWYZbpZhEzqyTD+tHthpCy5Vr10JhmQnsKqzwoxib1hQvdflgrZYbrMSivnn7RnN
         x/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qQFEWJjGeOPYXiDAusSsUop8XHEeCJbzRrrXiwgnWE=;
        b=dxUTWgb5NzxnDyR08Qzowj8n+vn81aXiFUC7vXw8rFJRmi0ubnXBDncngYomJCeK65
         3YWnuGdQDSa9VDL2uds+O+vloUDbV5WVmQgUrFjj/PqoPizLNLRcwH03BWpOMRyhx6gT
         6zvQPCxQUpCmlWAKOvemdIiszK2cEvNbbfz5kf790vOY5FWZhWpqT0QtWR/vk2dl3zs2
         9uGook9ezPdBT7PzB9Iy7JtXgEqKXtu9iQ6ED9Yh7hJG3ZYR6mFNssEMKXVLNaUAoa7z
         bj6L4D7EOx+87W/gWeQptdwr+ODg1GflQSE7nOJllbf+uUQpg17pw+3Pf8KaSMVwAPLH
         fj+g==
X-Gm-Message-State: AOAM531Nhxa8nG73iaazAJ4huue1K2SZ/BgrTh2csLEszdZJXv4yuDHd
        ZiMZIsxelvE/D4PAIPqyWdE=
X-Google-Smtp-Source: ABdhPJwl8n/6p9e/WFPvMHySQ3sXeLs4e+V8RT6pICPgw3pCXsZGIqESFgxS6g/rBztowwSTXs1xJA==
X-Received: by 2002:a2e:a374:: with SMTP id i20mr18705719ljn.149.1622514255521;
        Mon, 31 May 2021 19:24:15 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id g34sm1524207lfv.59.2021.05.31.19.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:24:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add thermal cooling support to NVIDIA Tegra devfreq
Date:   Tue,  1 Jun 2021 05:23:17 +0300
Message-Id: <20210601022319.17938-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds two remaining patches of the ACTMON cooling support
series, converting the DT binding to schema and adding cooling properties.
The rest of the patches are already applied.

Changelog:

v2: - Added back the "MEMORY CONTROLLER" section to the description of the
      interconnect-names property, which was suggested by Thierry Reding.

    - Added r-b from Rob Herring and acks from Chanwoo Choi and
      Thierry Reding.

Dmitry Osipenko (2):
  dt-bindings: devfreq: tegra30-actmon: Convert to schema
  dt-bindings: devfreq: tegra30-actmon: Add cooling-cells

 .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 --------
 .../devfreq/nvidia,tegra30-actmon.yaml        | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml

-- 
2.30.2


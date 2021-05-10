Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9943798DC
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhEJVNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhEJVM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:12:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F8C061574;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so25504308lft.1;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBAm2iOPFtBU1EQ3FoVf86OUQxRZHO3MtZ2jWbUEqLE=;
        b=hKEct6kjw8GRNg4ylFQMwPa5APMX/VlM2FvBfZPZLdb0r3wPdV7I1R4dA0nv0FV6Vr
         rDxMbGg3+8WpfW3b7cWJLtKMSjxJeuR51lQzc/GP4jJ5ykeyNE3Uapuns4NhSXWChNpD
         k8vrfxBQzadlvXL/7Y99zT5YJXSg8tSS3bDdT7/QJGcXSSUgwSkJbsbBNczKqXq3fACu
         LsWY6pixqUle394GeSTa0piyV8cJJAslmDrGR5+0rsEP2egunRStqv4EtEu+SOB0zNgr
         Pjf9boV9vvEnIcuZwZRjTUSwdpWHf8Oe7FX/FJ+HbZqySl2qPjiU8uTKuDevuDgdRp9y
         sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBAm2iOPFtBU1EQ3FoVf86OUQxRZHO3MtZ2jWbUEqLE=;
        b=UKsYTfdTX5rsKeWunmQttqT8fezsaoM0CNgEqVPymtTayTVr4KpoETPhZ7dBhVFH9g
         aWMZTJcB4FejmgrrUWIWnGb5PWdmS0XqwAmoAsaMBAJZyl825QtNiq0juaHynKOOw4oz
         1CYKunmGrjZifsQfxPDFFJHvY8Oi9kd2I65p8Ze5h3PHi9z6DaIpFh/pTcwGRsOqU6vb
         NcQHiB20YULwQfBMetjsejJRr00v59nfzlpisxmxxiSHGNcq2rHCzKZp/3bcmNno2k+6
         KW/r+OorhdmdrFg9eVN93Bp3BkKNnLWaJVufSUpjqSbCfDQ7LUQe3f9kfP167RoW5oAM
         DCKQ==
X-Gm-Message-State: AOAM532/0qdThYkBDzhPs/Hk2Ntfc4PcovOLJh7vtOS+4nup9Ahp0F+B
        TVqs3UmYzCeO9q3a9ELYY/vYInRAi7g=
X-Google-Smtp-Source: ABdhPJyV7zP366mGr6WNyz63P58fRyLeCqVhcXnVCcluMkzItlsjx+2rHBimuqY/7/mKCM2Lgnk5/g==
X-Received: by 2002:a19:e21d:: with SMTP id z29mr18343711lfg.175.1620681111900;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 4/7] dt-bindings: devfreq: tegra30-actmon: Add cooling-cells
Date:   Tue, 11 May 2021 00:10:05 +0300
Message-Id: <20210510211008.30300-5-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACTMON watches activity of memory clients. Decisions about a minimum
required frequency are made based on the info from ACTMON. We can use
ACTMON as a thermal cooling device by limiting the required frequency.
Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
index 2a940d5d7ab4..0aa9459b7751 100644
--- a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
+++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
@@ -63,6 +63,9 @@ properties:
       Should contain freqs and voltages and opp-supported-hw property, which
       is a bitfield indicating SoC speedo ID mask.
 
+  "#cooling-cells":
+    const: 2
+
 required:
   - compatible
   - reg
@@ -74,6 +77,7 @@ required:
   - interconnects
   - interconnect-names
   - operating-points-v2
+  - "#cooling-cells"
 
 additionalProperties: false
 
@@ -118,4 +122,5 @@ examples:
         operating-points-v2 = <&dvfs_opp_table>;
         interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
         interconnect-names = "cpu-read";
+        #cooling-cells = <2>;
     };
-- 
2.30.2


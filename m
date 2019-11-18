Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9D100C83
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKRUFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36383 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfKRUFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so8264449lff.3;
        Mon, 18 Nov 2019 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCdUNbrdRJjqVla5VJjyVdTCmGe/PoyPIjNb52FlJnk=;
        b=VO9OtD2ST829EMBXrnBhCLymPMvO5eLmi1XuG9Kq0emJTuz3Pp5e0NvrJYc1SUPoka
         AF1PGZKQfjTbYAZhoFZ50zoB2xacpcdGFEGpgyFNdDphIvJGIK8J56WpsXeLS3CNwp8m
         IsVhTcLaQi+wgi111Ed/fVQ0xvvkWpqS9s+5RFXCd6UxW50mWzgDkMN7ZiOIxDZtFU3t
         +C2WWbFXX5BiZZC06BSR0j+xZvzb0oPnhZjHf4RVUdHwzpCQIcWwyti++QR53AW9vSeb
         GDm6ETNP3AEQjrYFVIAyg0DFnYQ1Ce3axJLg3miALUOElX0Pm08YDk4ZowZiYbXy/wi6
         J9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCdUNbrdRJjqVla5VJjyVdTCmGe/PoyPIjNb52FlJnk=;
        b=sTA2XgTv0gE/Kiabgqyjhxoznb+5nMGqFydqRJoNeKYn1uq2ChDTJvBfS3chjLs8s3
         m+E3eBtURyEW9+g+Hy4d71EJCHvsYprdRrFTrYSxbtHLGJ/lm2UYTv7ztyUUsvjaL0L2
         ohKnzucEOTmJ/B5/CLWMmq2NCGBA+4CTqy1k0bXYRL06OOPQsuhPwScjanOmsNn4KzZz
         QrhWhQqzjrZAw12cDxS8JD57/qo+tdLceUc6lHH6sgNI9DVEs8VVnuqC2EsQh8H/2x9T
         nKuLTNqdO+ju66NMRt2+7YXFHACRBWdDccyICQLz5TwHqOyY6i1uFfKy4UKAqpOresnv
         5CcQ==
X-Gm-Message-State: APjAAAVoQq1BQKX4dOvtbzkAlusip3SMPyuVUJJww5zx+cCD7Mt078WN
        9Gr0K5P5rGSgKiA7dtWhBqY=
X-Google-Smtp-Source: APXvYqzD+qc9/bHBgWnn6IDSjtu+yoi+QPOguZvwpPZLJh+aN5o5KBjsxeq8NRupazScBaAsGiI2VA==
X-Received: by 2002:a19:ee17:: with SMTP id g23mr833981lfb.121.1574107535994;
        Mon, 18 Nov 2019 12:05:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:35 -0800 (PST)
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
Subject: [PATCH v1 06/29] dt-bindings: memory: tegra124: emc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:24 +0300
Message-Id: <20191118200247.3567-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which designates
external memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-emc.txt        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.txt
index ba0bc3f12419..ff48b46604e6 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.txt
@@ -5,6 +5,7 @@ Required properties :
 - compatible : Should be "nvidia,tegra124-emc".
 - reg : physical base address and length of the controller's registers.
 - nvidia,memory-controller : phandle of the MC driver.
+- #interconnect-cells : Should be 1.
 
 The node should contain a "emc-timings" subnode for each supported RAM type
 (see field RAM_CODE in register PMC_STRAPPING_OPT_A), with its unit address
@@ -195,6 +196,8 @@ Example SoC include file:
 		reg = <0x0 0x7001b000 0x0 0x1000>;
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <1>;
 	};
 };
 
-- 
2.23.0


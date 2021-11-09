Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB944AB88
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbhKIKeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 05:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbhKIKeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 05:34:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD7C061766
        for <linux-pm@vger.kernel.org>; Tue,  9 Nov 2021 02:31:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso1489484wmd.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Nov 2021 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+euuTZvhkOnDgMjmppHViulHDx6zSAfM+VRF7TWz+pU=;
        b=6vlRBXlYnB1c6bx4RKXZbqt8HKPSAqnWbj2TvKybRcWeUXa7/oN8cYlRkihwHE+4Ip
         x7AzQ/JOkZviajlspvGZkRNtwiU+cFZAGVjdqG+GGLwlu9jCQ8eeX1Gvo9XNd2BaOgDi
         uKaNyKNfy2DyuKFZjQyspVA5GOJ5SfgIZRgADH5VYaU2n7yCJkw0QsuFI72lPUqMvRCC
         oTmy1LmoV0onweWoq33Nv/e4y8lFcorin8OV3+snScnXG2+xsrFCHTaBuGjlYXdcoben
         wFx2/TrUQqs74hWSMG85fQAiGmICurTz6o7IDwfCbpDnucI4edvVjI0OvrWqjfcyEvtF
         ExjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+euuTZvhkOnDgMjmppHViulHDx6zSAfM+VRF7TWz+pU=;
        b=CiIRE2H9OU1Xr8EqX1IXM9FWJjNBKzvqj+GOlfKhc8kfhJlf35ahpLL4euqbd0cN6o
         8xRGFwLBKyybkRg3mYtGQVPfvXnPlMh91a8udoA9vlBcH8//yH0fkKukVWyYUJFe3r2J
         CKNVnfr6N3/6Qkrku3snEmd3VNuSb2JLOOgJiTwSR1s3XjuwJaaQzmBeA8dG2KMmfbnV
         0+9W0xb8GwD2cbCSO5o1+JQL1XQ9CK+CjLWI4F+H/LMSCyPrj3itMT9oqGwePYBdqCAY
         ZE1FMDrBDzSZ7XcS47EOgU+i2WRl07qbkOojG6urhRHW45Q9LOhtu/L0Bf+wih4NP9fn
         Fkkg==
X-Gm-Message-State: AOAM532UOs9Y5nb2bnznqt3BtJ7Ryhu8gf9fJlBGTSLKU7QDyZVCIK+X
        BIThbwR8Zyjg4QSLdrh9YG4qfA==
X-Google-Smtp-Source: ABdhPJyV47u02wpkyTo3KrS7mQ6sP8YiFdmifCrPzyDUmffqXQuzEvPPEmuR6tyPfSh8+G5RVTJTWw==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr5861721wmd.184.1636453884902;
        Tue, 09 Nov 2021 02:31:24 -0800 (PST)
Received: from bismarck.berto.se (p54ac5892.dip0.t-ipconnect.de. [84.172.88.146])
        by smtp.googlemail.com with ESMTPSA id t11sm19381936wrz.97.2021.11.09.02.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 02:31:24 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] dt-bindings: thermal: Fix definition of cooling-maps contribution property
Date:   Tue,  9 Nov 2021 11:30:45 +0100
Message-Id: <20211109103045.1403686-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When converting the thermal-zones bindings to yaml the definition of the
contribution property changed. The intention is the same, an integer
value expressing a ratio of a sum on how much cooling is provided by the
device to the zone. But after the conversion the integer value is
limited to the range 0 to 100 and expressed as a percentage.

This is problematic for two reasons.

- This do not match how the binding is used. Out of the 18 files that
  make use of the property only two (ste-dbx5x0.dtsi and
  ste-hrefv60plus.dtsi) sets it at a value that satisfy the binding,
  100. The remaining 16 files set the value higher and fail to validate.

- Expressing the value as a percentage instead of a ratio of the sum is
  confusing as there is nothing to enforce the sum in the zone is not
  greater then 100.

This patch restore the pre yaml conversion description and removes the
value limitation allowing the usage of the bindings to validate.

Fixes: 1202a442a31fd2e5 ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index a07de5ed0ca6ae2d..2d34f3ccb2572ddb 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -199,12 +199,11 @@ patternProperties:
 
               contribution:
                 $ref: /schemas/types.yaml#/definitions/uint32
-                minimum: 0
-                maximum: 100
                 description:
-                  The percentage contribution of the cooling devices at the
-                  specific trip temperature referenced in this map
-                  to this thermal zone
+                  The cooling contribution to the thermal zone of the referred
+                  cooling device at the referred trip point. The contribution is
+                  a ratio of the sum of all cooling contributions within a
+                  thermal zone.
 
             required:
               - trip
-- 
2.33.1


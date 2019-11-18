Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D938100CED
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKRUFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41389 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRUFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so14866850lfb.8;
        Mon, 18 Nov 2019 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cN+cTWmw5IKMObEA3Y8HAg9N2AlhbhuoYmAREYZlw/4=;
        b=gKpR3deFRHA9H6ebC9kq34DBn0/xxJSWvPVo3+J7x4cjq8pqJK5o6LsjRx7NySw4FD
         BrOFnOqghNGiDsg2KrHCg+TI3DIIX6GiMeEIEQQ+snUi6B6O0ZOHhtNIrZPBskzLiDPu
         7ZxX+VrcMINUEQ9jmxUPjJ/FZP2o3uEfcGIbJO+BqXZB2KsZwxKlXKtu5l7yvCksMCXR
         jo7P3bhnHMSqE5eVuYsTyBJAC9xDWicmBbnnA31isZWe5MfiLeSdugeXgEf0gE04p62Z
         au42a/HgriX8s4ini4zGtXm84ircbKlRZD13Ag12spQcku6Qqz5JZVqSWldGS8BuFdtp
         wTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cN+cTWmw5IKMObEA3Y8HAg9N2AlhbhuoYmAREYZlw/4=;
        b=nrKDh34QLE1wfiOymHP6t9xY2U1Zz8YuBeS0AkspXq5XRXdhPfR81DMSLANefhYedo
         /5S7yavvVjsHneNyNVKX5CZxAOiDA2RggVOTG8rRaA1PZaOUmbcQPiX196xVGSanC9iJ
         QT6ISGCO1gERojMSA3MX7PPFgTK+jeB9+wydzW5M0mLjDi38nIFQMMVf01/NUPHIbK/7
         r3GdgYDzlddih8uQmbab3QL9I/S9nkfOm0F59QQKg0MWpZT+T4nWn3jBaXumIYJ75pLa
         bUnzAGKS5avjRz79se17A5NlagCY6JkH2AGUpGzmblIycxQJGSZjwDDVomPRTO7m4Ck2
         EUVA==
X-Gm-Message-State: APjAAAVxWrEB0VoskfrXeATFOpi5q80ADwiAbx5xLqtYu9190jgAH8Py
        Xl5XdweYamKBn6YZsuJaCS4=
X-Google-Smtp-Source: APXvYqzB8U5iYQKp+sDOt/38fnNxpmw9MZAc1mV8GBofStkZ8gBPo5XdpUpQbn0VIyJos6GrWdV34A==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr840663lfd.105.1574107533034;
        Mon, 18 Nov 2019 12:05:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:32 -0800 (PST)
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
Subject: [PATCH v1 03/29] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:21 +0300
Message-Id: <20191118200247.3567-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
designates memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 84fd57bcf0dc..5436e6d420bc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -57,6 +57,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -120,6 +123,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -135,6 +139,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.23.0


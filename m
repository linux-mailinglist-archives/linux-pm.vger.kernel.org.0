Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9019F1971E2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgC3BJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33675 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgC3BJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id x200so5558818lff.0;
        Sun, 29 Mar 2020 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGhshIQ08W/fF40FAntS+cxcTBW0fRcj4eZ28EWAmTE=;
        b=XxBzBB8C/ouLvpvhWv1tCGRnvopFMnR02tvWDdHXE34VMJoFRNre/opbCtXicTKrzV
         qZyMxdHtx9nh3QfyBBDUF5WO0UAdCOtboU2OXh8FvVLeOHYffG/yVfjb33pkfyFATTP2
         GScNvvzwf9E9GE8Mw5OT7LAkm/VwTyoLDmyKs3QR0jsH4X6PbVSK0cEP60Lzy3HC/ADd
         948zayzTPaM/FaB4TU8EkObczi75mj8ZAMirY/qlyv5PwPXL3w0JVCf0Zqqb7IF8tcxz
         zixt0HJclbyM7lNFFQx3qn8AsoyuOE5n3mg8k1IeFQCBuMZ6AlihowbLymymM5a4YsGt
         kUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGhshIQ08W/fF40FAntS+cxcTBW0fRcj4eZ28EWAmTE=;
        b=cloU/Nzc4nXGMZr+2LVPRNEnIrUSCt1ccrsZ2zHMEC/nq3WnfDk1sjiw8lKiOF6mIE
         XE+b+sI3lovSZwN1k0J/3eq33pKfV2j6RsdD3sLjjG0cJ3RRM9qjHe0pMuOa0GNpCyBg
         r7+OoXw8hBuSn4TJu/U8OOqrjJ0YCUF3jK1hQFEXkJtnjm1eE0OSqTJ7wocoovuPQJ5m
         uPzQt5PPXkl8QA5WXjK3trEogtdJ1uShfrqTxAW9c4fU7LysdZ1JVT1/e6ednFOzC6Lm
         CEsSrp9j3buH+lJGWWanJyxhSltqyHhuatrd7voJHUxIAnnEkc20RNy2WqrJawReqHsr
         YeNA==
X-Gm-Message-State: AGi0PuZXwdSt5pPmDhBTUw+HxFzurmh603KLyi9ltBbdZVKAotSl9/4w
        v8KO8cKOZCEn5ad1jcHgaZ4=
X-Google-Smtp-Source: APiQypLyzsbk89h1xbagVghUO7mdmiHIeONm1fV88bNjfaxU8lIGGhlh4l/LkO7c6iKxzJDhMtB4yA==
X-Received: by 2002:a19:4a50:: with SMTP id x77mr6474950lfa.159.1585530577323;
        Sun, 29 Mar 2020 18:09:37 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/22] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Mon, 30 Mar 2020 04:08:45 +0300
Message-Id: <20200330010904.27643-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 4b9196c83291..083676676d0d 100644
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
@@ -121,6 +124,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -136,6 +140,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3010E185156
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 22:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMVpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 17:45:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46514 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVpy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 17:45:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id a22so11024591oid.13;
        Fri, 13 Mar 2020 14:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHVZ/MVN4MkikL6P8XpPLOgIoNofB5rMgh0x+DSqo0M=;
        b=Ipu7PgZRQYfjWNAM0e92rujfoau6kZPKhYTLhH31kQ0DR1B7KwFT5kdGksEoheWpN2
         antwYw+VNveWi2KyKMummjrc4VxrtoJozvo2WgndAahRvGtylvADcPCHLpcoNvI30V8M
         har3HX/79uHBrv1Y0uhQeFUS2opebafY1G9BMPA+dFzZDgZXLBiYwdvNdMv2b9HPe8iG
         /0g9PhX/EXHyq4x5P3dzQDuKLIV1xR0vNwvxxkKNgR2XkooiRQCbD1XweHulU/zBiyos
         gCJqpAz1DWjlMicZUvh3U3I3FiBoAYALDlXColQJmgPpN6lqS/b6Ku2b5tirinbCqLlZ
         PcAQ==
X-Gm-Message-State: ANhLgQ2ZHKczM2r9W9xDACxb0Hxf95qAcvWz87on4B1gyW3z4StfA4oA
        0RGgkNRgcaXsCm9mXpTDCw==
X-Google-Smtp-Source: ADFU+vsnutFgP6sP9j7b1KawMS+RS77c+BhpcW4w6cMLMF5gOqCA/FTvHFZSMG3MoBHDoDMuXNIgTw==
X-Received: by 2002:aca:ab4b:: with SMTP id u72mr8931474oie.26.1584135953998;
        Fri, 13 Mar 2020 14:45:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h6sm11518707otq.63.2020.03.13.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:45:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: thermal: sprd: Remove redundant 'maxItems'
Date:   Fri, 13 Mar 2020 16:45:51 -0500
Message-Id: <20200313214552.845-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There's no need to specify 'maxItems' with the same value as the number
of entries in 'items'. A meta-schema update will catch future cases.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
index 3bfe05504456..058c4cc06ba6 100644
--- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -31,7 +31,6 @@ properties:
       Reference to nvmem nodes for the calibration data.
 
   nvmem-cell-names:
-    maxItems: 2
     items:
       - const: thm_sign_cal
       - const: thm_ratio_cal
-- 
2.20.1


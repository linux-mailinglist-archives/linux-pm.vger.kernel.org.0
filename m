Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D512D001B
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 02:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgLFB2B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 20:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgLFB2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 20:28:00 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DCC0613D1;
        Sat,  5 Dec 2020 17:27:13 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so9882113edt.9;
        Sat, 05 Dec 2020 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPG7I94+/QN09u6tcNOJ9aMJs68vqEk/+MGkrZyA5EM=;
        b=PPSUi4O82+DHXmfjU0fP/fIr8vxTd8n3w+FDYEE12MbXBUXJ289OimMRTXcmv8rZJX
         ViB0aWip4rpRad3FQBNuphpG2OJgP3GLDqUHhhZgMtfe/LK+cqhgg0z4k1HoPPqyoLpA
         qW+ubWyCeVtWB+gWOEyZn5YYQnWjOMH9fgRTgLBekYxdC9IAWYnKQqinw5Bb+haYtgxW
         3bgEQPtNQdcph4nWHT5j44EX+gJmHRYW/vg5ZA9hpZKsgIW8fHTwcF2dp41eONl8tGrh
         YV2t448ZiW4F2fcpVDYIlCejjynmjt3a6SUSTrMW4bpvlmmduFP7NiAMMPgxpevosmL8
         H+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPG7I94+/QN09u6tcNOJ9aMJs68vqEk/+MGkrZyA5EM=;
        b=aRxR99w3TG2HZrWtcsPtfd/ttANmmF7CWWp8kAYW2nt1EpslGET1k4zu7IfWe3fP1E
         z3pYIr/mf3jX8jUY3m+JYVpHnGGnnPhZ0z1JF2elnyJF7hKAHUgkV6uId3Sjr5fpYdB2
         qwZbuEWE7RU1aHGcXvM2rpNOMRiCwyNW6DXfs9es7lKg1iPg2lAN3UtgBg/EyWxrx9Em
         mNAb5NjdyytKOuqTyYKW6GWlwkl9BWB4fF2rtKS56duV7jHcpbpMEr6DMMymKoP3hijJ
         a9KLwmnpsFwKk2XzE/hp6XMAZS6VBfDoScqTNTOszULvibUxzrMuM8knfVOky6DLTYTk
         MuVA==
X-Gm-Message-State: AOAM530Di8ppVeJxOXH6PB5j7/bdy/bPS/kd1TbKTnG6AWTy+/9fVliR
        lW9Z14Tq5MZbp1xTBRqSVx8=
X-Google-Smtp-Source: ABdhPJyMjwflIxVc40xS6IWekDsncBwdhvWDVyNBdH9ls2z7yq2I6vpLhY69rvCLzrCYRWTLY9TxdQ==
X-Received: by 2002:a50:8a44:: with SMTP id i62mr11208511edi.97.1607218032493;
        Sat, 05 Dec 2020 17:27:12 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id a10sm6157023ejk.92.2020.12.05.17.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 17:27:11 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: input: Add reset-time-sec common property
Date:   Sun,  6 Dec 2020 03:27:01 +0200
Message-Id: <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new common property 'reset-time-sec' to be used in conjunction
with the devices supporting the key pressed reset feature.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - This patch was not present in v2

 Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index ab407f266bef..caba93209ae7 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -34,4 +34,11 @@ properties:
       specify this property.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  reset-time-sec:
+    description:
+      Duration in seconds which the key should be kept pressed for device to
+      reset automatically. Device with key pressed reset feature can specify
+      this property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 additionalProperties: true
-- 
2.29.2


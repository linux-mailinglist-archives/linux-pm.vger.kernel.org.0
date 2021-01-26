Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF43039A5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391720AbhAZJ5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 04:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391668AbhAZJ4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 04:56:47 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114FC0613ED;
        Tue, 26 Jan 2021 01:56:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d22so19012401edy.1;
        Tue, 26 Jan 2021 01:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UsIhDknBiOfKaHxlibyvi4CoRT/UMiyIJnEzMxKA54=;
        b=GlCl3UUuoFUofdZDn1iAkD5eyc4n3aXXLWWr0qiJeNawAFwYNSHBzrjZkxaCnJzUam
         GI/v17kL2K1pQNn+CKkd69IGVzKI/6WpPEhzZxe3Q8d6opnKvlwEHBQEPlffqyHxe7AM
         8vH0NshDb7zQpQZP0/dUT6hDEXaW5HsVtN/XWGa6vSdXN6nbeWxryzIkQ/vPiNuXo7OW
         dFP/15HZaj4rK8FylAHLr3vAkcNcQYGSEekIx4OUlF3EoxsTuxVcf7IATOddkxZMWToB
         AOpmQzvN/v/u0Eg4zZsmPa+Ax0b8FBSf0THhHT9IpwI7zgaJxdx8HqmU2I+PiogmkOhc
         0s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UsIhDknBiOfKaHxlibyvi4CoRT/UMiyIJnEzMxKA54=;
        b=MNwSzx5gcpFWzvA5nnclIttm+vFpPZBgNBj70qpIP3Q6jlQ0dmo6Vdt6m8AiqYlYJa
         71wDN6BCMZk2cRHa3zhdTa5olBreXk8vO8Hkr9LHj182Z9R5G51sZFKK/ZXdljKdRf2z
         y2JO4JMut1my9HhgR+SXltDkV2Q2zUPKYSmYsP0W+/VifPc//H91TIWUBOQhFVBnyIfV
         N8VDHO+tn9qBdBA/5vV8QsrxA5JUEN6tN54OT8yVD4mppEt9y8NEJ54h24bFeM6Ju5Oc
         XFaiGyWI83sMQXbsxryah/L1806WsVc8b9Ugkn6aKIjcIstW9AVl7yYbaO9BibtORvWV
         i+7A==
X-Gm-Message-State: AOAM531l6CHIshltlyvy16jAbkFNne5j870u4FplKh9CJW6tDTFQJrv5
        xj4tk7VyMHx/TIX0UHK/NTg=
X-Google-Smtp-Source: ABdhPJxXw262UWxvqZSJJbq37L8AjipjIsWacP2dsHP6OeJ22s+4h47FFkBrfjDhI81iNHy/JPlpGw==
X-Received: by 2002:a50:fc8c:: with SMTP id f12mr3878101edq.225.1611654965227;
        Tue, 26 Jan 2021 01:56:05 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id h12sm11648310edb.16.2021.01.26.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:56:04 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: input: Add reset-time-sec common property
Date:   Tue, 26 Jan 2021 11:55:57 +0200
Message-Id: <a87f8a5421cee1c19f38a52fdfcd48a05502087f.1611653995.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new common property 'reset-time-sec' to be used in conjunction
with the devices supporting the key pressed reset feature.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
 - None

Changes in v6:
 - None

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by from Rob

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
2.30.0


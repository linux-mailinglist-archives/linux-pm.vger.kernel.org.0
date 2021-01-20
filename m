Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8263B2FD8A5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbhATSoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404230AbhATSYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 13:24:20 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DDC061757;
        Wed, 20 Jan 2021 10:23:39 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hs11so32550644ejc.1;
        Wed, 20 Jan 2021 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rf1zhzHss3fv8z3siAe1uxwT/75TPGUph7fK4mm6NDQ=;
        b=Onq3xsOqXWllHjCWaOtIt4YwaZNKeXg+hlsaSKNjRImSx0eiD4DBeERQdJ1yH3uknL
         zDHBnoEARQ3IeWTbUS5Ai66PkJMBlCShjSc+8G3hx2J+w4tEUDwM6zw4rV53SFTwbNkq
         6tU6D7Jl8A0oKePFjehN8SQgVkTAVGvTHcRuphgiqV8kyS1t/n4klf3sXfptpKqkup57
         nLhsxdyofilz/1WhMPniC96U2+bXHAJ1TiO1iN08c46ZvZ7gC+q8ZELeCvZiauZy4RJU
         Mv0PNwdjJ1c0kFFrj686Sx4vJqqB32XrnyaLMN5+1Qrn4zUOpW8PZzizBmyad6DY2ZIM
         dgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rf1zhzHss3fv8z3siAe1uxwT/75TPGUph7fK4mm6NDQ=;
        b=nJm4rpFMG76jJdlyImQh281EFr868pUjoyNSES00dtS9pVB/5sDLvqc4GGkMXRm48o
         zts+4t9fLihPZZrnJZROLYVm/km11NniTGfOQNIRjHp8Gstao9qbXr/vM4ifVt90KcNw
         FLftdHTNFR/srRpnqzArIujrmg+5sE38I7xT4IbzlVof+9d4bThCikW2UKgQr4H9v1ep
         wURfWuDUhtVrmXJQqZrcxsnJSE5i4fPsWIwofMPmeTqFQR6Ic3KVhMW9BgfB9G0HKeX1
         8BDsKs6cLZnH3GKg+61XFTekNgNNT6uvDPVYEs375a/+gd7Sv5LfVIpmYX807OFxL5r4
         klmA==
X-Gm-Message-State: AOAM532ZzGOXtBud1EVSSjM57CIjKkz32L8kVTyXWAPuCSEcF/NZNGrT
        MuoOrg+C0LjwRMhPTEbWfjs=
X-Google-Smtp-Source: ABdhPJwKXPXbtxuh877PlK2sNEAq3FR6qrjz70E02yETxzQgUrkOl3pEpMC2BnQ5ZTwF+5J3FQpcSA==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr6992475ejt.384.1611167018188;
        Wed, 20 Jan 2021 10:23:38 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id hr31sm1158332ejc.125.2021.01.20.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:23:37 -0800 (PST)
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
Subject: [PATCH v6 1/7] dt-bindings: input: Add reset-time-sec common property
Date:   Wed, 20 Jan 2021 20:23:26 +0200
Message-Id: <dfa2b49142ed00835050f4ccfd80b1f48e4aa71d.1611165200.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
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


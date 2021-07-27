Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6592D3D71E3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhG0J0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhG0J0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 05:26:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94AC061764;
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gs8so7527120ejc.13;
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBKXCsHfwip4Rwb+DfNH2Tu2tuIAQDn6p9m9ppniW64=;
        b=PaYQREomEDTfoBTOeayOvSQUZPuLugWj1zJJ3wgIho7cyBxghUd8rdo9sVvOBnyA70
         p5VOpxCCd2KFsoeDfFqFcAV1oz9W7gJSI3LAg2WHBWR3p9B++pUpKeB6cmHfjroTiBCe
         GVe/xMCT4Gfjlt7Sv1LqKIkhRtAY++SiJfVm8yV+eETgm4harn/An0dZOrEEmFgrmC2Q
         gcLTmUGA745v9kb2rRpi+QL3EpUvw1HLw+haR7lDitUBfXJc7k9BKuy5XRSk71D7DC+H
         T4sbKSUCvCtKV56MpI0rPopwky3D725DWFncVDAgwpFD38pJDZR+CnNCVrJDpqn2yO1Z
         uGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mBKXCsHfwip4Rwb+DfNH2Tu2tuIAQDn6p9m9ppniW64=;
        b=Il4pj0tsWsv+hvtmCUEBTLzmLljJVqpa6S7vt27YeI2bNUejbnovLyf9tlBPjTGjUU
         22nkEe7YZQwNYwu1NkIUDCY65MOIfRbww37c+bAzj8N8tg3Um8tnKVZKAL34uIgHxFcL
         kkqFkNa1m2qMZNmaioS2VR+vgTvhQH8npZ+RV23gAqZ0jK1+iOLoHJ5SKWWpyU28e4y5
         iuE4TjbFhQ7JwSNcGLr+NzS7Ihs1FpOQzihmDeWMd8j79l0Z9JpfF2GHRJdidAs5Rww2
         fn5G8AilfXfgIwWagnSpECXeIT0BysEx53wY9pMOvm90rqjU5jlujaqEKXY/DqONJOy9
         f+qw==
X-Gm-Message-State: AOAM532fy15CZYJU3e8658IpP2DS7fFHaSZD5OcPAz4dkvvINcpMs6t3
        O3oGg4QJyAItv1vKfvlxkYw=
X-Google-Smtp-Source: ABdhPJzTtskTMc5QZec5ZUvY3TDl4N0+dAB9ON6+fTzXzORIu58twTG7edWEwy6LylQVcHNEbgY6/g==
X-Received: by 2002:a17:906:dbd9:: with SMTP id yc25mr21126510ejb.367.1627377967400;
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id g3sm692369ejp.2.2021.07.27.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] mfd: tps65086: Make interrupt line optional
Date:   Tue, 27 Jul 2021 11:25:52 +0200
Message-Id: <20210727092554.1059305-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727092554.1059305-1-kernel@esmil.dk>
References: <20210727092554.1059305-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
the SoC, but it is still useful to be able to reach the PMIC over I2C
for the other functionality it provides such as GPIOs and regulator
settings.

[1] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
 drivers/mfd/tps65086.c                        | 21 ++++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
index 9f6e1349eadc..6aeedda3be15 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
@@ -87,9 +87,6 @@ additionalProperties: false
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
   - gpio-controller
   - '#gpio-cells'
   - regulators
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 341466ef20cc..cc3478ee9a64 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -100,29 +100,30 @@ static int tps65086_probe(struct i2c_client *client,
 		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
 		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
-				  &tps65086_irq_chip, &tps->irq_data);
-	if (ret) {
-		dev_err(tps->dev, "Failed to register IRQ chip\n");
-		return ret;
+	if (tps->irq > 0) {
+		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
+					  &tps65086_irq_chip, &tps->irq_data);
+		if (ret) {
+			dev_err(tps->dev, "Failed to register IRQ chip\n");
+			return ret;
+		}
 	}
 
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65086_cells,
 			      ARRAY_SIZE(tps65086_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
-	if (ret) {
+	if (ret && tps->irq > 0)
 		regmap_del_irq_chip(tps->irq, tps->irq_data);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int tps65086_remove(struct i2c_client *client)
 {
 	struct tps65086 *tps = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
+	if (tps->irq > 0)
+		regmap_del_irq_chip(tps->irq, tps->irq_data);
 
 	return 0;
 }
-- 
2.32.0


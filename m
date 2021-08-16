Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12F3EDBC1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhHPQx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:53:28 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:47120 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhHPQx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YEFXgphQpy5dvskbW+W1LG0upFA4dxyxW1IOyxNAIzM=; b=W88whJudH8C132IuyB3hUzOJG6
        vctr5Kuz/iC2nHICkMFxsN2180gH7i5sLvbkU/qfKGNI8IZqsfw7Pyv+mp+bLJlIZNs9ANgza+mtk
        qc1J53EF8/N9J/YHuhf+zAw2HWuwg9lmZXADVmHAZS0BTkimsuA+gBsPioDcNoqZETkMSZOO7f43F
        GK3Gom5bYaaK/DPIryQncYoKwUttT6lttBbuq7fH+3CDahXln3uApYt47n1PNkknoMt1vf7hQZTRH
        n82U27Ka1FjM95OBB+PJCLH2VEZ2+h+k2Gv3OIV954rwWFHqv0KDEFrsxbzh8h7SOdGEpaAKRbbhW
        Rv/VGeBg==;
Received: from [177.220.172.187] (port=34285 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1mFfr1-00Gtag-AH; Mon, 16 Aug 2021 13:52:51 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     sre@kernel.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bruno Meneguele <bruno.meneguele@smartgreen.net>
Subject: [PATCH v4 2/2] dt-bindings: power: supply: bq24735: document the watchdog timer delay feature
Date:   Mon, 16 Aug 2021 13:52:45 -0300
Message-Id: <20210816165245.40416-3-bruno.meneguele@smartgreen.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
References: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new watchdog timer delay support in BQ24735 allow the user to set four
different options, ranging from 0 to 3. With that, add this new property and
its values and description to the BQ24735 DT binding documentation.

Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
---
Changelog:
  v3 - create specific patch for dt bindings changes
     - add minimum and maximum values

 .../devicetree/bindings/power/supply/bq24735.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
index 131be6782c4b..93a125359ec7 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
@@ -56,6 +56,21 @@ properties:
       The POR value is 0x1000h. This number is in mA (e.g. 8064).
       See the spec for more information about the InputCurrent (0x3fh) register.
 
+  ti,wdt-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: |
+      Used to control and set the charger watchdog delay between consecutive
+      charge voltage and charge current commands.
+      This value must be:
+        0 - disabled
+        1 - 44 seconds
+        2 - 88 seconds
+        3 - 175 seconds
+      The POR value is 0x11 (3).
+      See the spec for more information about the ChargeOptions(0x12h) register.
+
   ti,external-control:
     type: boolean
     description: |
-- 
2.31.1


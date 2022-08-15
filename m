Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423F55939ED
	for <lists+linux-pm@lfdr.de>; Mon, 15 Aug 2022 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbiHOT3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Aug 2022 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbiHOT1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 15:27:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079495C9C0
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 11:43:44 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660589016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f74qhKcPnLkUsJ7GW1atuoiKWwt3kDgJ1kdJE0xigmw=;
        b=JIr+x4iov31JsaRTeJIikNKUbKGqTvsGkFXgzHlcDTFUG5wDdFjYaZRp1AGK1yFiywP++C
        EX2TAeMpzyrsU6k8C/Q5k9UgfRjwqgvGYafacMW5iH8B54soPIN+DSUkkSyFK/RUPcrRbk
        BK3lUUA1ERlQYn6nlga5m5BClEbEXV6SbcjyZYqywMJU+X0Zev0W/hxnbXZUEdNVY9NdLD
        WLprFR3j6ef9yqoBzhID6k17uuNQcwky/f9S8j5hwJC+gNg1RkKtyX2/J+UFnXv7HHXy60
        wR1pnk6DOw2c7wy3emr8vcPJ30Dkm4bwfQGECv81VMcDBcCh0jqFXDsWDN9zxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660589016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f74qhKcPnLkUsJ7GW1atuoiKWwt3kDgJ1kdJE0xigmw=;
        b=QnTQCS+8yfkRbgpIUeb/HsWRSewhl14g1cB+3FF7mshr8QoJKCw0RP+Hc7YImPoucPiuZ2
        72/8QNOR/1Wfw1Bg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: Fix missing required property
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220809085629.509116-3-daniel.lezcano@linaro.org>
References: <20220809085629.509116-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166058901445.401.3386107829903243146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     8c596324232d22e19f8df59ba03410b9b5b0f3d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8c596324232d22e19f8df59ba03410b9b5b0f3d7
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 09 Aug 2022 10:56:28 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Aug 2022 20:38:40 +02:00

dt-bindings: thermal: Fix missing required property

When the thermal zone description was converted to yaml schema, the
required 'trips' property was forgotten.

The initial text bindings was describing:

"
[ ... ]

* Thermal zone nodes

The thermal zone node is the node containing all the required info
for describing a thermal zone, including its cooling device bindings. The
thermal zone node must contain, apart from its own properties, one sub-node
containing trip nodes and one sub-node containing all the zone cooling maps.

Required properties:
- polling-delay:        The maximum number of milliseconds to wait between polls
  Type: unsigned        when checking this thermal zone.
  Size: one cell

- polling-delay-passive: The maximum number of milliseconds to wait
  Type: unsigned        between polls when performing passive cooling.
  Size: one cell

- thermal-sensors:      A list of thermal sensor phandles and sensor specifier
  Type: list of         used while monitoring the thermal zone.
  phandles + sensor
  specifier

- trips:                A sub-node which is a container of only trip point nodes
  Type: sub-node        required to describe the thermal zone.

Optional property:
- cooling-maps:         A sub-node which is a container of only cooling device
  Type: sub-node        map nodes, used to describe the relation between trips
                        and cooling devices.
  [ ... ]

"

Now the schema describes:

"
    [ ... ]

    required:
      - polling-delay
      - polling-delay-passive
      - thermal-sensors

    [ ... ]
"

Add the missing 'trips' property in the required properties.

Fixed: 1202a442a31fd ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220809085629.509116-3-daniel.lezcano@linaro.org
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 2d34f3c..8d2c6d7 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -214,6 +214,7 @@ patternProperties:
       - polling-delay
       - polling-delay-passive
       - thermal-sensors
+      - trips
 
     additionalProperties: false
 

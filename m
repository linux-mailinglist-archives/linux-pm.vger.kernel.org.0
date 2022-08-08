Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805CD58CD5B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiHHSJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbiHHSJh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 14:09:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB5B62EA
        for <linux-pm@vger.kernel.org>; Mon,  8 Aug 2022 11:09:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so11775206wrf.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Aug 2022 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bXLpXmWL+T2aMJD2mxacKkNa6+tQMtWwj5lWrNrsUB4=;
        b=sTQk0D9ap6qPXsbbc6gc9Lwix4N6t5K3zjEXm6UMlU8kddKs0CZT5uccYMQ0U1u7J5
         jRhlVXq1FJHridxx5BWhG1nuGPeF80RjBDmWq1KOYhXRYiuQZNu/pKQwcrVO2TbAU6K8
         djQQ6Fj4OF7lHYI72Tg3mj+yjCNYYtFya6S+MINazNvDJ+zCubNKMv90RsO6tW9nyRLJ
         oMykHF50/umhW9nwZOb9FMvTJVTkzKLUTlkn+9KngOM8fLoVswOB6I70sp1MpnkqjA7O
         AuWc1cKM5yAxbwMdGoPXHJ0aYejlezI0Mko8xzhL6ljI1MAe7bFR6Om4ozwLnAIuTDLr
         RDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bXLpXmWL+T2aMJD2mxacKkNa6+tQMtWwj5lWrNrsUB4=;
        b=OOO5/Uc8Annf6jKQxE2hCNIJWX/JKoVaaOu0D6MwNuuFsWimztcGpXOGLclHkLj1VL
         AMdOW2YxFmblNYWGAPeRNCmU8MAbV5Gtkb/nMc3Y2a8tXmq3fvObCEA91PxyHCo4bgF6
         vADi32Pa251Zi+6ZcJlijff8xj5ZdfWlnCRrOSj8zp5SXA6bmZ8om7EECISuwgZJOBs0
         kCXn8dF2+1WP2mSbENzfoJt+QUX1POV1Jfn25SRZWKYwOzMEbDVaqC9tGbsfxYMgnHTt
         q5BPiSR41E9KGUw8oFFFasFyO0w5A8lO4Z5OnfiZtCYD2u/QGYpiI232roMFmIQavSBI
         oanQ==
X-Gm-Message-State: ACgBeo2o9PIKw1nrva929eQjDvlfMN7MTdYwr6ZEkx4MdmljORTWncw4
        gS+4wImtW3PDKt0KPmgiPYTMZw==
X-Google-Smtp-Source: AA6agR4I/bXgBepeo1o0a13B/Jri3xvGvMkTdvdZ65KGJj/SdJVqx28l6X62d2QaLrBXhMPB2hV1qA==
X-Received: by 2002:a05:6000:1f07:b0:21f:1403:a59d with SMTP id bv7-20020a0560001f0700b0021f1403a59dmr11833777wrb.46.1659982175729;
        Mon, 08 Aug 2022 11:09:35 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b002205a5de337sm11937309wru.102.2022.08.08.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:09:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 3/4] dt-bindings: thermal: Fix missing required property
Date:   Mon,  8 Aug 2022 20:09:14 +0200
Message-Id: <20220808180915.446053-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808180915.446053-1-daniel.lezcano@linaro.org>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 2d34f3ccb257..8d2c6d74b605 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -214,6 +214,7 @@ patternProperties:
       - polling-delay
       - polling-delay-passive
       - thermal-sensors
+      - trips
 
     additionalProperties: false
 
-- 
2.34.1


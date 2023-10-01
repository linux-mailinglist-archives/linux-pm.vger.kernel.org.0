Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F297B44FA
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJADA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 23:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJADA2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 23:00:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D8DA;
        Sat, 30 Sep 2023 20:00:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2773b10bd05so2446084a91.0;
        Sat, 30 Sep 2023 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696129224; x=1696734024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlYn5Ui0Tk2IR6HLELfl3LoEP9WwtCST+Q3mwNvk8yQ=;
        b=j5KQvNgOXVxWqflyGhd7YeZHfsXLf5ED66q1jPqIYvQGik+NLm3r8GZBcnqSA4sSA1
         YwZuQHUNHjiN5gZUTW4ClV+s9zhEoA7Ctmjbtiys3XDzaTpcb2/oAaPbe/zyhlt2MAoZ
         6hcDDoZSndnHvcR9nvdWIqrSJ99LMSIl9ue4Wnp5mnjQnl16rHiDN+kKJ3LNQiRQURzX
         fVdUk7nWd0PhDZ8s5XXMnYaF7QWXcr/jcWqJnCWUcHS36dN18gjO/uKn7DqheaXNdX62
         550pnbvv5mq/T8l9In56jmU9NIhN3xH+7exfBrikfbs1KctP+GXRi/UJd9tUoTmyVvxj
         1NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696129224; x=1696734024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlYn5Ui0Tk2IR6HLELfl3LoEP9WwtCST+Q3mwNvk8yQ=;
        b=tPcsLnPhrUMY8EUrm7MSQ5AXa3CpogljQOjLP5SKpmOnpI0byqGkydV9qR9JuKhfQP
         wx8memSpMv/ZUqBq0DPtC/qEfY2E5XBRu21h4P9VZVsnWZ8s22jI2sA2/hnbdUQyjhjv
         Ck4P9zjax8tBA93IqSbSt7ewrCw96jao5rd6jL8L4Xc3DQnEnIZwef63yVJ9iVqbGSpF
         zcoTtNgXuev5KT3YP5Wo+6BzOUXuW1/UZg7TKKhW5Kp2LEpKMIQrHTvkWsa/fQrQP7/+
         /H00Z4jTbxXcQBc49fj+Rz2DxZEeIwifuu3NATKL+VYoPKcv0MNL9tf6qQmII9spUYR0
         IRog==
X-Gm-Message-State: AOJu0YzzPJdTpg2hKlQ8707KEVg0MfULeRVTzfDVrXQmbPP5JVAQg2xV
        6qhH0UXnjMwCqm9iuHognyA=
X-Google-Smtp-Source: AGHT+IH/fHBWP1yyCOiGydat5dgxvLrcfnKOdZidkfksbrcw6wMGnjfKWodEDHEgg6UHuN29UmTpaA==
X-Received: by 2002:a17:902:e5c1:b0:1c3:6d97:e897 with SMTP id u1-20020a170902e5c100b001c36d97e897mr9401038plf.5.1696129224140;
        Sat, 30 Sep 2023 20:00:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:355a:d2a5:90:39d5])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b8baa83639sm6801788plb.200.2023.09.30.20.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 20:00:23 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/3] dt-bindings: thermal-zones: Document critical-action
Date:   Sun,  1 Oct 2023 00:00:12 -0300
Message-Id: <20231001030014.1244633-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Document the critical-action property to describe the thermal action
the OS should perform after the critical temperature is reached.

The possible values are "shutdown" and "reboot".

The motivation for introducing the critical-action property is that
different systems may need different thermal actions when the critical
temperature is reached.

For example, a desktop PC may want the OS to trigger a shutdown
when the critical temperature is reached.

However, in some embedded cases, such behavior does not suit well,
as the board may be unattended in the field and rebooting may be a
better approach.

The bootloader may also benefit from this new property as it can check
the SoC temperature and in case the temperature is above the critical
point, it can trigger a shutdown or reboot accordingly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v8:
- Go back to putting critical-action as a thermal-zone property. (Daniel)

 .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4f3acdc4dec0..c2e4d28f885b 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,15 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The action the OS should perform after the critical temperature is reached.
+
+        enum:
+          - shutdown
+          - reboot
+
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.34.1


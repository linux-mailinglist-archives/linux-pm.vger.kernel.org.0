Return-Path: <linux-pm+bounces-469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964227FD705
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D3E1C2048F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF31B287;
	Wed, 29 Nov 2023 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmOp5RuF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64719D44;
	Wed, 29 Nov 2023 04:43:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso1718425b3a.0;
        Wed, 29 Nov 2023 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261837; x=1701866637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99akWKbL/dr3OMyUe936f8PphzhTHLmmt/wOQM8LOn4=;
        b=fmOp5RuFlGC8GcfcwvirX/NMb/Nw03iN04jFsQ32q74pzt5x5ZHyOjrAeSdfeAfRov
         bAOepgRVcSEh3zZGUTL92KBtsxCmaJxCtbowLuPtpp6Igr7otIf1CalTpQRgi8HFriUh
         y7+W6dl8VVaLaoMfDYkMaPEn49AtW1X352RBejyM98r9WCNL/SEi0rhMPp3mwEKq0xL+
         9J/bImvZ31UsFNoJurspsEZR3+4Gv089bJdjrjoJIXcXhWR7Lpeo2IZD02Z1IzU5D9rL
         XYnHgqUh6Inw4ClQejOKUgJAS8orkJzgBkKxhyZeq+1gW4L4fKVTTUoXFBCmCDf8m6FF
         rSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261837; x=1701866637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99akWKbL/dr3OMyUe936f8PphzhTHLmmt/wOQM8LOn4=;
        b=TbNmoPFf9loGqpLUn6n+tnkGr4tWTQg13Fz1pLC3I3Bl8qxR2uXS1M/hcVnqsEFdUv
         PrjwjIKt+LesdSnKAWtA7KKhawLTr8oUUXZ10sD51CbtSOCF2LkuQ4Y3MVvItp/35EfU
         MVOCoLM0TwNbaFnaK4TcArjKQ15okX46DS35krfRk46Kt7Nymswc5sUELy6o6MCQCO7F
         TRF3lUfI6dKA9L46grwM+oYCnFmf826ox/2UgZ0tlFkNLZd3E2jyM7g8e48AJIUt/g7m
         N71r5C5Hk2Eq/QyUgTCjIAJJp9qRE4TEoStSdS13NJjLf42tzxptiYEmHVp9VVB69D59
         tSuw==
X-Gm-Message-State: AOJu0YwipD1ZFnOdp6l6Zyl3DV932uAUYQXY8DqvthPmRklnDKEZ3Zxo
	geOVubaOOkfGYcfQfNwy5GpocSQ07SI=
X-Google-Smtp-Source: AGHT+IGtQtpdMfjUxd3dgi+rLem+nVoDhqcv+UwBIoAxkzEBqCcsYFwaoE0vDKwqDV6nS6gC0X8/IA==
X-Received: by 2002:a05:6a20:da91:b0:187:df59:5c43 with SMTP id iy17-20020a056a20da9100b00187df595c43mr24079385pzb.2.1701261836741;
        Wed, 29 Nov 2023 04:43:56 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5db0:20f8:912:48b])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0068bbd43a6e2sm11028416pfb.10.2023.11.29.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:43:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/4] dt-bindings: thermal-zones: Document critical-action
Date: Wed, 29 Nov 2023 09:43:27 -0300
Message-Id: <20231129124330.519423-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Document the critical-action property to describe the thermal action
the OS should perform after the critical temperature is reached.

The possible values are "shutdown" and "reboot".

The motivation for introducing the critical-action property is that
different systems may need different thermal actions when the critical
temperature is reached.

For example, in a desktop PC, it is desired that a shutdown happens
after the critical temperature is reached.

However, in some embedded cases, such behavior does not suit well,
as the board may be unattended in the field and rebooting may be a
better approach.

The bootloader may also benefit from this new property as it can check
the SoC temperature and in case the temperature is above the critical
point, it can trigger a shutdown or reboot accordingly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v11:
- None

 .../bindings/thermal/thermal-zones.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4a8dabc48170..dbd52620d293 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,22 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.
 
+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          The action the OS should perform after the critical temperature is reached.
+          By default the system will shutdown as a safe action to prevent damage
+          to the hardware, if the property is not set.
+          The shutdown action should be always the default and preferred one.
+          Choose 'reboot' with care, as the hardware may be in thermal stress,
+          thus leading to infinite reboots that may cause damage to the hardware.
+          Make sure the firmware/bootloader will act as the last resort and take
+          over the thermal control.
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



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2FEA331
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfJ3SWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:22:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41111 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:22:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id p26so2142133pfq.8;
        Wed, 30 Oct 2019 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qs16A5XyOAvgOkcD2b8j2UzYSbjI5cdVJZowNpSGRxs=;
        b=VCaF9eufWMcvjXboob2XP8nc+6A40oSy1ga0OjH59Joe+C6zRTYakwyuFGcY9kkPBq
         Em9YGm8M5lYuzsgBne1SD+GuPLDjHsn7IjqI7+LWZaFd3gP6RG/nwdvS2jqMcEcL5gQa
         yVYQUQZ18//BhVG03Ee0b++GrI7BVRpPnBZwK71ksvqNKefdZ6GTGE/dpfjerF52lU9d
         lUetRBA5v28fErEpZHzuowK3loVssYtyCW1GCCX6xgimut/cToiDHsutQ9IHU9A1uR9+
         im2vtSCaFSpIBsBJa/yjjq6gsbvyoHPf/P2mmox514K9tyXPKinubsdPg8M6WloolGe6
         wqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qs16A5XyOAvgOkcD2b8j2UzYSbjI5cdVJZowNpSGRxs=;
        b=JhaFXkWvvMRk5v5etwCKN0cMhcjLXD7WsEKy2dCQpFmSltMOZWbgWwnddO63j2iqTu
         Z6UwQglYxupLcH3Qtyis3o+nTt6KaoYVfKcDZfk7M7kBahGJLKiDKcat00P+dM/3sScs
         S/Kxbh2Sa+Kos3MuYCmIvwOgjB8F+nJuDjX80LbXUKowSLNEi7jxWN6QzqaFWs+kzl2x
         IBTeK68h4csmkEuw9FNfDbmjni7DEndbwr21OrhRG/WJ67Imon8qgw7I/rqdPuzM5HS6
         zX94xZkhLGK8jShifFOm5s4dYWGEXw2dt/tJlA4uGZAeBfDV4AVuze+T4G4SaUIZuCIm
         jiRA==
X-Gm-Message-State: APjAAAWUeQ60deXZnPpvv88tJ7dM+mPWJBywhUo6Y7R6k08v4/kYFuJN
        On4uu3zZUlVNSzOosV8BWnS0Obcr
X-Google-Smtp-Source: APXvYqwvjX/ThoRXznb5SgYpZuHrY59zaN3xyWXKgjoQvOXAPltKe0a3xjdBk/FnBbZsK4E9peBmXw==
X-Received: by 2002:a62:5216:: with SMTP id g22mr750778pfb.78.1572459723302;
        Wed, 30 Oct 2019 11:22:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:22:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 3/6] dt-bindings: thermal: Define BCM7216 thermal sensor compatible
Date:   Wed, 30 Oct 2019 11:21:29 -0700
Message-Id: <20191030182132.25763-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BCM7216 is a 16nm process STB chip, which requires a different
compatible string to differentiate different temperature formulas.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
index 43a9ed545944..74a9ef09db8b 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
@@ -3,9 +3,13 @@
 Thermal management core, provided by the AVS TMON hardware block.
 
 Required properties:
-- compatible: must be "brcm,avs-tmon" and/or "brcm,avs-tmon-bcm7445"
+- compatible: must be one of:
+	"brcm,avs-tmon-bcm7216"
+	"brcm,avs-tmon-bcm7445"
+	"brcm,avs-tmon"
 - reg: address range for the AVS TMON registers
-- interrupts: temperature monitor interrupt, for high/low threshold triggers
+- interrupts: temperature monitor interrupt, for high/low threshold triggers,
+	      required except for "brcm,avs-tmon-bcm7216"
 - interrupt-names: should be "tmon"
 
 Example:
-- 
2.17.1


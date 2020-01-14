Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8235313B2AC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgANTGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38633 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgANTG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so6818657pgm.5;
        Tue, 14 Jan 2020 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SGLTAdZJn5EJy2JzHgzjK5/AJ+qkCVgDvB3ahQxnHQ=;
        b=Qm5G9CSi8hE6nPnKB0JHoF1ksIp45JPX3HX9vssDTwlZF4Rfy8IWq8WZsIfGUaH9sv
         ZcXt/RoOwAMNw0W+DBimcFz0NHHlEnQjS7yrOba4yZe20ynilMcPvk5aqRF45lXWLZqy
         jZtMMYTV6PHX4WUY+frShmcXUven7WUPwoW36tLU8UVW3noBGff2vxG63s5XrjaXppnB
         hXlqvCjH16cL+ouJBOc87NujrFKXlQ68QlCGDNesz8niUqRtCESi7BQQlwQmEoGdBbSt
         t5iCHJ/WDcw1FOO7PnDvGne5r9CkWnWxx2KVeS9GKtLAwFnYjmfcGyJxkodCXdiJaIhn
         /cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SGLTAdZJn5EJy2JzHgzjK5/AJ+qkCVgDvB3ahQxnHQ=;
        b=e+Mh/RW+T5UGSV5vs9aDsOyszlS7OeO+W3/bSoRWnskyT5fcTULO3fm+Ea+faNHb7P
         Z5y/3dXFzPMRkNGHBhY30ekaoEPZ/L7EoOHHzomE/it5p0JL9D7rfRrfTkAWUzCtP4P2
         qHMaoyThx2hQ7KQrdCF1XpEy+NgRly3jIuFTgAx512NzwpXTaOWqUrwswFOHSCe6uuk6
         bW21n880DWabTyy4ABaECxYI1uMMPZJ0Z94FXBhqjX9zh8QOC+PM/QAcOP9mU7X/6lLf
         e6fpV6JqZ0KUik/v5pATuBOAsvvVbpWaEKs3OEGCsQEHBYumvQI3U1JUcc4amEtLx8ob
         6TKA==
X-Gm-Message-State: APjAAAWU3fESTS7olFeeA3zQG/YQLMhB/k5uigcRE0BJkLj632SUo7Np
        Rlz7T9MXU9uuk7sjh2oQ+TTt0Xam
X-Google-Smtp-Source: APXvYqxW4WEv33MceQhvOoDvCOyqNa0lcjz4YBr8Xi3MM+oBNXj+5uUCXiO6j87tYXtC2qT/dxYIrw==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr26927807pfc.42.1579028786488;
        Tue, 14 Jan 2020 11:06:26 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:25 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 3/6] dt-bindings: thermal: Define BCM7216 thermal sensor compatible
Date:   Tue, 14 Jan 2020 11:06:04 -0800
Message-Id: <20200114190607.29339-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BCM7216 is a 16nm process STB chip, which requires a different
compatible string to differentiate different temperature formulas.

Reviewed-by: Rob Herring <robh@kernel.org>
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


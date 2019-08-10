Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452F28888A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfHJFaE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:30:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45088 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfHJFaD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:30:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so1848440pfq.12;
        Fri, 09 Aug 2019 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDKOJXA/ys1npDjXBTQ2s0rGwBbMEHrF7ffvpNaphqY=;
        b=rsarVL0KdYe7Il/Tpaw1MIVKtFiR0Y2kuIrFSMBz5fojZCq1sgccTdo1ozHTVdD8y1
         mfMc9r955mHTdwEeKcbiyCugDa6k7IC3GoTyvxUqkEeEl+h0unaFWnC+QjvpLgxHtXX0
         99C42B+QCDpqqwwQcgn1jBc3UlwLB/KAqVTJS4THZPjKa2fQPzGa/yhfjwxb9LngoAkc
         4JGi4JCJ1jdb2+2+oCMlrs1LOc66trOuznPVR4bE0EoM9TGXilRjQ0yG1KcSR1qBrG8B
         ra+er8sAtFIPxl6HNIoKJq42HGwRe6rFx8silSqCqs+OoiOZA7TixdSAPDum+RgMN1Uo
         EcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDKOJXA/ys1npDjXBTQ2s0rGwBbMEHrF7ffvpNaphqY=;
        b=r3skL4ms+p4slcK6xxKVk7jawnaW1WD8a3GAryfgnPfbhbeH/TpY+sD43/wljHQUBo
         7fL/NzPTHTzh8cg3iFoCVMQdr7Z/vciFEa9IOQwCdNPfqa336bXuH75baFgUkXu+nrQF
         1dMczxeyvG4IfGFCDqu0dswY7yfXBEVBNARMvSA9IyMG+L0goZyPT6r+jhJ1DdbR6M2M
         NSreMHx8R+L/5Cp+aWxeXAU3TaZ+LNTi4p2PDZyFQe9kwH9o93ty4f/EBiaUbJ2cG6w0
         vslffvSHegVr6EIDxjKHjg31NGQOHf8dLz9bJMgq3nbZEene/EGg/EstdcLPliwB2H4w
         wCNQ==
X-Gm-Message-State: APjAAAW8Bqy+Igi7DENPwhfRidr9Sk3Z1JS+pLb0JFHtOPWr0ZIe5mmu
        lsf2Yt5u6GRGFmz1SzaSU4Q=
X-Google-Smtp-Source: APXvYqwAkVuLdow5oO8itFrdem+xM/Zhwse/76vid6q2uk8MGOkz2hXbK0XNT0eZiUWzl0KdwWjjtw==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr20690940pgc.328.1565415002991;
        Fri, 09 Aug 2019 22:30:02 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id n128sm55019042pfn.46.2019.08.09.22.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:02 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 12/18] dt-bindings: thermal: add binding document for a64 thermal controller
Date:   Sat, 10 Aug 2019 05:28:23 +0000
Message-Id: <20190810052829.6032-13-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner a64 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
index 6624cf6b1ce8..f935b4fab8ec 100644
--- a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun8i-h3-ths
+      - allwinner,sun50i-a64-ths
       - allwinner,sun50i-h6-ths
 
   reg:
-- 
2.17.1


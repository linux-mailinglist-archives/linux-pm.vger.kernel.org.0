Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C412E0DD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgAAWqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 17:46:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36680 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAAWqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 17:46:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so37786493wru.3;
        Wed, 01 Jan 2020 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MI/tWq/Gzav8YeHpXimLDhMeUUqjTlJBv5ibEwQi8xE=;
        b=epBNrle4o5FUh7dzSw/vOnNQNvCHEkYRdQLnxysrviz32eRhAVoJyCfzASDtnydDbV
         t5F8737A5ZkJjbAxbCAmfWkbfxx6w2ApWmUlvc2aX8aTNbYxb3RBWADnt71h5nOzTr11
         WGwD4SAJAbuTBIU31gpP/1WSh16aX582xjw9dbrgtqRRpj6k4xKYfHhhfcyWnB2ZgZrA
         3V5JV4J9bR6bAJ2ThVg9dN28bnSCMoLW7wKoSQV/694CPR/1SXYG2cZhoTLOW8yo9hfu
         IosvyyRrkS5PGkuyfQxqOFaxsgXv3FLtOzP+F4M8EL1pw3laCZkLfSB5m/oB0EqF5DXJ
         1SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MI/tWq/Gzav8YeHpXimLDhMeUUqjTlJBv5ibEwQi8xE=;
        b=QrHNH6ka4FDJXAW2Y+zjwgbMkOx3bYHI5LQItnN1y5loVe3/IhIcZJKczGRfNIJBvD
         3TAG/LFnlPcPbbr/aJVek9QbuBvN/HuDDg2NlI5v3WadwEyIInl4ddrHLh3O9bKTgPd0
         axjjcOQJCanWydotUDnjQKFBPsE2Jj7iceE7UmYXlnNT5l0+/xTHMZlujCbBbn34q16H
         HNjnw8mqHodegnQD0gO7rcIIWv+DYOz6oZm+HVyTdRMQ8aMj5F1AXd7y9x5iUO9rszwZ
         /Z+yjRuoezqBySK7oPYpyPVW3LJ71pXJJ1cND27PZKAm658kOLRUelvVA0RrbO5cz95Q
         isnw==
X-Gm-Message-State: APjAAAXJ/UTTkJBzrUffPqGekfHifWXRz0mYIr5K7jHYBmJB/SQyd3kS
        mF/fAG6OD8sMlDzgOtnK2Pg=
X-Google-Smtp-Source: APXvYqyXayEuzuOgusavWD4amHShTrshaoO9KUHtpQPZ2eqr+mOF3pZIQNnyAYkfwUMSn3aaPZU+yw==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr76405874wro.352.1577918794120;
        Wed, 01 Jan 2020 14:46:34 -0800 (PST)
Received: from localhost.localdomain ([46.216.160.87])
        by smtp.gmail.com with ESMTPSA id c195sm7053995wmd.45.2020.01.01.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:46:33 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.93)
        (envelope-from <jekhor@gmail.com>)
        id 1imml6-00039w-73; Thu, 02 Jan 2020 01:46:32 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 3/3] dt-bindings: Add new chips to bq25890 binding documentation
Date:   Thu,  2 Jan 2020 01:46:27 +0300
Message-Id: <20200101224627.12093-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200101224627.12093-1-jekhor@gmail.com>
References: <20200101224627.12093-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bq25892, bq25895 and bq25896 to list of supported device IDs in the
bq25890 DT binding document.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/bq25890.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index dc0568933359..dc9c8f76e06c 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -1,11 +1,14 @@
 Binding for TI bq25890 Li-Ion Charger
 
-This driver will support the bq25896 and the bq25890. There are other ICs
-in the same family but those have not been tested.
+This driver will support the bq25892, the bq25896 and the bq25890. There are
+other ICs in the same family but those have not been tested.
 
 Required properties:
 - compatible: Should contain one of the following:
     * "ti,bq25890"
+    * "ti,bq25892"
+    * "ti,bq25895"
+    * "ti,bq25896"
 - reg: integer, i2c address of the device.
 - ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
 - ti,charge-current: integer, maximum charging current (in uA);
-- 
2.25.0.rc0


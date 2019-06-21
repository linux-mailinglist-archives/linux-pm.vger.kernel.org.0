Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14994E76E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 13:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfFUL4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 07:56:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45789 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFUL4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 07:56:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so4848159lfm.12;
        Fri, 21 Jun 2019 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCsNSIhjCg2UmLajKiPXkdtHAurjo1ODjNh3/mWoClA=;
        b=t6XLQK+21pUtRXc7cF53j9Jq3VtzW+ROxWWda0+c7ksrFBHTdz8iD1jgNN1UucJgOR
         cy5F40eiIbhTg1StMkkocZlnVZyvdJDu8g9JiZjqKnRt2xDWB1Fx7W9bhhC1skRJoimc
         CRxR1ZjllvBKZPzowD1n2HwVprm2bmBk4xQN9fX5SLLZQ9Q6nUVcGWTHSdtrSZkpE5RU
         FKh1CO2EjUUek+3yQVs6Rw1KrDIAMYS15XhaTOHZt5zUGO/jhbZMYhXAZkusi4jpsHMt
         gKIAYbODe/HkOl9Qjg7xx050nVAwt8lF2xVfCec70ljVQe4kb3df5lNsOtsJOcbdFTpV
         uAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCsNSIhjCg2UmLajKiPXkdtHAurjo1ODjNh3/mWoClA=;
        b=ai5Lfqwk6mqH4rsVecJHhOwuOcYwAx+RCvhKNjQ0yY0202a1ItIMDHHuJLZJhx2ksK
         qdUZmEQ3dVYoGU+nhBpb4/xcUmdngA8sWCergIxa61hQEuIDy7/2mZuI8EpkVotYPQQ1
         qMuml11noKjCt8cx83qVq0nOiAzBM3GFRYDvdT7B/zU5N9roUO6TUEh3h0fGAIcwuCjI
         NefIjXKsgBS/xGvPlLSlVg7aU1erkYWEhECOUXkwINNbR7osjnm2v3ZScrw7k20zti06
         5EizbdC+znldFH3WaL37V8FMurnLso+6Sx0crMDsIQ9FoLJGYzwhfjONX4QpCGp87kzo
         +Ndw==
X-Gm-Message-State: APjAAAXSmHAg70kgOYIfIm6V4q4/62Q9cbACzJz6BHRVVoCMnuB71hmN
        jy4Fyi/re/JJf1ju0dGw/WQ=
X-Google-Smtp-Source: APXvYqwm0zb8cKHdWTip+O/MfIH2WGl+lLZVyzk7rsIfknm+CFaWo6YdBbHwK8FAbWRlqBDECOKUow==
X-Received: by 2002:ac2:54ae:: with SMTP id w14mr4069909lfk.124.1561118171386;
        Fri, 21 Jun 2019 04:56:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id s14sm356791ljd.88.2019.06.21.04.56.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:56:10 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     sre@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Fri, 21 Jun 2019 13:56:02 +0200
Message-Id: <20190621115602.17559-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds devicetree bindings documentation for
battery charging controller as the subnode of MAX8998 PMIC.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v3:
  - Property prefix should be maxim, not max8998
  - Describe what End of Charge in percent means

Changes from v2:
  - Make charge-restart-level-microvolt optional.
  - Make charge-timeout-hours optional.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit
---
 .../devicetree/bindings/mfd/max8998.txt       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
index 5f2f07c09c90..368f787d6079 100644
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ b/Documentation/devicetree/bindings/mfd/max8998.txt
@@ -48,6 +48,25 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
 - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
   for buck2 regulator that can be selected using dvs gpio.
 
+Charger: Configuration for battery charging controller should be added
+inside a child node named 'charger'.
+  Required properties:
+  - maxim,end-of-charge-percentage: End of Charge in percent.
+    When the charge current in constant-voltage phase drops below
+    end-of-charge-percentage of it's start value, charging is terminated.
+    If value equals 0, leave it unchanged. Otherwise it should be value
+    from 10 to 45 by 5 step.
+
+  Optional properties:
+  - maxim,charge-restart-threshold: Charge restart threshold in millivolts.
+    If property is not present, this will be disabled.
+    Valid values are: 0, 100, 150, 200. If the value equals 0, leave it
+    unchanged.
+
+  - maxim,charge-timeout: Charge timeout in hours. If property is not
+    present, this will be disabled. Valid values are: 0, 5, 6, 7.
+    If the value equals 0, leave it unchanged.
+
 Regulators: All the regulators of MAX8998 to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
@@ -97,6 +116,13 @@ Example:
 		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
 		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
 
+		/* Charger configuration */
+		charger {
+			maxim,end-of-charge-percentage = <20>;
+			maxim,charge-restart-threshold = <100>;
+			maxim,charge-timeout = <7>;
+		};
+
 		/* Regulators to instantiate */
 		regulators {
 			ldo2_reg: LDO2 {
-- 
2.17.1


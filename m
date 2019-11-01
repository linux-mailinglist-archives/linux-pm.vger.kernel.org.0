Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC309EC8E1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKATHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34821 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id i19so2564148qki.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKHiOGYnLpZff5oFAVLb69iuOICybW4S004M0YpS0iY=;
        b=V1B5jnhp8ReqjDQpQk8uW5ceGGJhaATSk0z+IUvr5z6Vs2WidTGmu9Gad/3dWUCmbA
         tT/dgBrEpwueF+TXHXTaQ/2Y3Mv30YsZ1Je3eli3dNpbZou1Zi1bx1hV9VnUTP/1mhqW
         VVAUB8mT6z+pLRAa8ooua/j4GMxgnvhaTc5tmQOfDO4j4aRh75uRO3VuEQ/3dWJJqFbH
         8dddFSVeSMii2542TMuU1qCVkX0Dd2YErtHm0F3HkUTKQHcP30ywdJCCGJ//gs6wEI33
         KNsRmVIs9Qi2qRztAF220+zKl+H4qjfNryltS2Yc7YPKEuJgYRiLGG0JvycGpdDV0fbY
         RQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKHiOGYnLpZff5oFAVLb69iuOICybW4S004M0YpS0iY=;
        b=HHisaPbo48cJWA7ynsjgwXZ3iCPb0T0PrUvytXHogXVcK3rRxT6B/SDJbzBPB0sCDN
         Hl9/+mWRxqOwETL2cBa5DS1LlJ0aRaE9hiixw1gNUR6pLekziBiR/eala5NeIkaXkGfO
         +uM/a9hvmd+hregFtyFCorXgitcInwg8QcD7H0qDgQthYt8/j9tXTQvb2boUAqWlDf2n
         naqj29iDs+APXtn0obNKX3VoDN8lMn2QXadNDJS8K7kUJOoXufJytAsi0hDXWrPouDTh
         jOY2n3aOmsouI2LhWggsi+reHVfJgWiK+GVMJLGUmudSZic5Pm3EHzuiNYlNsULo3NY1
         +jrg==
X-Gm-Message-State: APjAAAX2q8Nj5AXLHIyq2pr273aZ53XEJhoHQoQ1iet+tnsmR0wEldkx
        nBzilnyKpjhVqcR4T2d0ay8=
X-Google-Smtp-Source: APXvYqyJHIGzeRfF0VVdnYMWAH0inD4u8+N02Y2C24uzbRb1O2JhllFjUqu9+DQr2n7e/tfSkBYPtw==
X-Received: by 2002:a37:70c3:: with SMTP id l186mr11690945qkc.190.1572635260918;
        Fri, 01 Nov 2019 12:07:40 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:40 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 7/7] dt-bindings: power: sbs-battery: add disable-charger-broadcasts doc
Date:   Fri,  1 Nov 2019 15:07:05 -0400
Message-Id: <20191101190705.13393-7-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index 62ec842325b4..578643f49b0a 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -17,6 +17,7 @@ Optional properties :
    a flag specifying its polarity.
  - sbs,force-load : Same as the module param, makes the probe skip the
    detection of the battery and assume it is (or will be) present.
+ - sbs,disable-charger-broadcasts: for systems without sbs compliant chargers
 
 Example:
 
@@ -27,4 +28,5 @@ Example:
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
 		sbs,force-load;
+		sbs,disable-charger-broadcasts;
 	}
-- 
2.23.0


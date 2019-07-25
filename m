Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1635E74BF0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbfGYKmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 06:42:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38298 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388657AbfGYKmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 06:42:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so34144043lfj.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCZt3kPOpetUJel0mQo8gQ4T9AKw5U16SpvhhYzlabk=;
        b=dPjlq6A2lvWvgrMNJdWXllzHpmLL0eSjAKl3p11X8gAO1Yvl99cnY+xirJks9vbb13
         6nCvLEzGEA+2Mg8BA/VSM4x4lPIC4J3FPTKrWy/NmUUST4mSkbSrrw4h/Htc1lt3k9wG
         c2E2gKHIQKGr6YPf5me3iOR9WO3A3pxO2gOPg7kQqbJpotHyCEZ065jJ9upAazCdKAa+
         Hkv6dhJkQvDN6NIXUh+c8CnF1I9EDZW0xg4Y1ThnQCMHCW7nXjOdeN8YAjOSI7FDKZyz
         HwGJ+jvUU2QgFbEP+6Kxw6TmQYkwHxlRRLRuwVPtdM5ifpOujExT0iq02CSofXx4/moQ
         SRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCZt3kPOpetUJel0mQo8gQ4T9AKw5U16SpvhhYzlabk=;
        b=lpcoBRFBdDvog3hPl/VPEpBH6DNi8DGMpwqE5/dottVQAbj0IIKRkcL3g81aXrbTV0
         w8uJeeKXDv9XBTrc++H8mx964IGvZr36vwDZCqcBe1IL07+tNx9s1FtoPDuNujNJIvXi
         gDVE6+f+ylZpOFyXyBIMD4we0gBBAOxPp/CaqlFlWI+aQzDgbjcSbrRb3RbRnR5f30dc
         ndmbhBgn2bDPe6G0oH8pCvWVpZXaY4lRJoavhR6oHS972ibkr2+SYA8GbtN9jtqaRwZ3
         2Wy8XHaqb2erfkX/27af3uV5oC4y/k/TCBwtbSCaL7d9tWf+kq/N+Bs5FQqELYTpoxoS
         uBfg==
X-Gm-Message-State: APjAAAUtK98yx4BNGs6CpEw9KkTgpt+ytxyJ9AC435lQTFsLQigVCpH9
        4o+0g3bH720VLDefuAE6EumPPQ==
X-Google-Smtp-Source: APXvYqyHYEAnKCQigACGznav4uCxvOKhm8HycAN3Cp3gSen5Bex3GSkUOUEJni/ors317BJHT6r5Mw==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr5914293lfn.169.1564051369379;
        Thu, 25 Jul 2019 03:42:49 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id e62sm9035045ljf.82.2019.07.25.03.42.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:42:48 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
Date:   Thu, 25 Jul 2019 12:41:37 +0200
Message-Id: <20190725104144.22924-10-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add qcom-opp bindings with properties needed for Core Power Reduction
(CPR).

CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
msm8996. CPR was first introduced in msm8974.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..f204685d029c
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,19 @@
+Qualcomm OPP bindings to describe OPP nodes
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-qcom-level"
+
+* OPP Node
+
+Optional properties:
+- qcom,opp-fuse-level: A positive value representing the fuse corner/level
+  associated with this OPP node. Sometimes several corners/levels shares
+  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
+  min uV, and max uV.
-- 
2.21.0


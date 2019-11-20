Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C540103A7D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfKTM5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:57:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46141 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfKTM5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:57:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so21073747qka.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4ssK7JBCpbD6bi+mRUWzSmv0ifU6DEy28XSn5k5sZs=;
        b=hNV6ICs5UGYvgFnOyufx/4UHKvv5yVwhD9gYoCz8z+Y9+JIGFkmp+2BQLpVz6GSbZO
         wI1uN9CrEXJ9q+bYeF0657TDzwMRsgQ0ig6oE5fyDIelnNuNvI3kBKpppEsSW44ZaTyr
         AQesMDm9xX/9Hdgz3xn/TvEqHQ25xPu4WqHTBTtDSix50d1nClk5FqjKfYQaorn54zNj
         vWv47tvOelxdJxhPeB176mvNbCjFGZged8aZK1mghaaV3qZ+IxtzEigBK5yfkDz7fWz9
         diaqXjNjfCvsGJ6pIfO8mZPqYDEThb20/l5O3+bMe44zeLXeiqPfT+TmafIezKOVejtl
         QnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4ssK7JBCpbD6bi+mRUWzSmv0ifU6DEy28XSn5k5sZs=;
        b=QJalBjpjEoStqptWKiXXRBxFacNna6jMrrnOIdHyXgQfGQw+WsZ2jSGU0ms0KRp+6t
         FmnobJJ2b3vPp1DP02VCL71EqtZdlZvsdDcEobBpFhZUEgrbbVhcm/7go1efRigZVNm6
         h0afFZ0vYLvcS2MAzB2x8iIGj4gEmFZ6UCsop5iLws69Lu6+7CHNJySH18+LApZtfR5t
         OAW3OPEdgvQAc3TLQ01EtRn76O9ngWBtxRdUHHcTYpb76dHCqZCBdxdkdQO/1KKWeE/q
         6Z98XJWevwDuXFtGG5L5ireLWTFr/ysj0dJujugS7ymTCUmbEA7kzsUckJTTpotezX3i
         Y2pQ==
X-Gm-Message-State: APjAAAWgdEgCQWVLFtyfoxnOqof0WdQUgLJCVAymLKplTyLfj8ypH2mO
        0FAnu8qrjjw/ejRPa38G4lV9ew==
X-Google-Smtp-Source: APXvYqx/E5etm3hWvVlli7RF8886y86fqgHfkP0XBa0wut8QU/VTWJx86gXNc8XIyaSYy4rLEq1uXg==
X-Received: by 2002:ae9:ef0b:: with SMTP id d11mr2206623qkg.68.1574254620425;
        Wed, 20 Nov 2019 04:57:00 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:58 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 6/7] dt-bindings: soc: qcom: Extend RPMh power controller binding to describe thermal warming device
Date:   Wed, 20 Nov 2019 07:56:32 -0500
Message-Id: <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh power controller hosts mx domain that can be used as thermal warming
device. Add #cooling-cells property to the power domain provider node to
indicate this.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

 Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index bc75bf4..a193d33 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -19,6 +19,11 @@ Required Properties:
 Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
 various OPPs for different platforms as well as Power domain indexes
 
+Optional Properties
+ - #cooling-cells: must be 2
+	RPMh also hosts power domains that can behave as thermal warming
+	device. If so, indicate this by specifying #cooling-cells.
+
 Example: rpmh power domain controller and OPP table
 
 #include <dt-bindings/power/qcom-rpmhpd.h>
-- 
2.1.4


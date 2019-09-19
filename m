Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57360B717D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 04:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbfISCS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 22:18:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39497 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbfISCS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 22:18:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so2316583qtb.6
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52eCI/kas6xom7Dj3zgl21pE1+QiZowqYoPJUf9JBJw=;
        b=zY1e9tgp+KNn071A68ETzMJY2odHuTdOA6ZRY0Ba7Aa1GwQyxNrmTVjDWaBOA6RLue
         jpycjbNaTJwhHUVaD+D6jtC3jfXmyUexkaOLbAhHgmFokCsrw7EvyjkCmgxuTiOHOT4M
         MTSAoo+SUBvRorrz38ttRD3IXGVN8aA8akljob5MXV85aOD9G5DtAzaTF8JefNLS53FI
         S1hK7TpzdWUmUVrsOZAnowftnyeS5PCfjj5zmz9eWhdLblHJUMpCewpg6dCcc8d7YzQ1
         f0C63F2Iyl4zn+DNR5ctqT8/ce+U7NmIGqXK0wibhZGU6ImrwjU+XGf0r3HzNopx5gGF
         X3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52eCI/kas6xom7Dj3zgl21pE1+QiZowqYoPJUf9JBJw=;
        b=s/8fKiUP7E7yjHmaaWIS1Z1C2sSxWKQowp5PlAmFZLz2rwHBjjNrubfMua2inYnx9f
         +LsAY+JtZWRT8/qDhyxUWy0tjs8LcpgxVzvZNESCXw7TILoli2E2AvDrsoMgpymodYED
         3mJ3pbVsNjoQqzBZg5nBFe7Kh8lDCbZnSQqQQ7NVhNgt/ibFNCBxtXSuLW1avT0+RqtK
         9WmtKDMRQWMeZ7AzFdVgFbMMb6lyT6QAAlPmewBIrydaaCn8+0Rq05EyL0B4kcNwRtpn
         TXGzQVG9AuGI2r5qEG5fv1ItFVO3aaQccgP/BmdVMARzk66nZ3xpnJW61xkk0rABS+o/
         51eQ==
X-Gm-Message-State: APjAAAVi4XrZC4vinuf3drbnbMXZqtHdlgxRwDeIpVGGEUH/FkS/B7yy
        HbyC0VJNy86ptyOAkarfN5tx5Q==
X-Google-Smtp-Source: APXvYqymGq1NficwmHv7+EyBMSvUuu+o4iNyhE+oM8mRWDG9Bux64SzcaxFHRJP5uOH34KqZNNp7mg==
X-Received: by 2002:a0c:91ce:: with SMTP id r14mr880353qvr.119.1568859505943;
        Wed, 18 Sep 2019 19:18:25 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id o52sm5261275qtf.56.2019.09.18.19.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 19:18:25 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: thermal: Introduce monitor-falling parameter to thermal trip point binding
Date:   Wed, 18 Sep 2019 22:18:20 -0400
Message-Id: <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new binding parameter to thermal trip point description
to indicate whether the temperature level specified by the trip point
is monitored for a rise or fall in temperature.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index ca14ba9..849a2a9 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -90,6 +90,14 @@ Required properties:
 	"critical":	Hardware not reliable.
   Type: string
 
+Optional property:
+- monitor-falling: 	Indicate whether the system action is kick
+  Type: boolean		started when the temperature falls below or rises
+			above the trip temperature level indicated in
+			"temperature".If true, the trip point is monitored
+			for falling temperature else the trip point is
+			monitored for rising temperature.
+
 * Cooling device maps
 
 The cooling device maps node is a node to describe how cooling devices
-- 
2.1.4


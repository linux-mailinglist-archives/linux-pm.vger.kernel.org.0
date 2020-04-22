Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0A1B46D8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgDVOIi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVOIh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 10:08:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8AC03C1A9;
        Wed, 22 Apr 2020 07:08:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so2571158wrq.2;
        Wed, 22 Apr 2020 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5seySNK4hDDxpkyp20i2oYy5PSF73LNYovBB3BodsdY=;
        b=E/0pd5edymyvaj47xBUYZpOZ4bLjv2UW1STlse0uImx7/yQtKEdpnZUgRogcjvia+7
         HSheHhSZNHyf6KktPA/breNZnh48Jk9SR1SGCUEfRSlAWDLXCIbOR0GNzje3mnFEMQI8
         3IMFjoa10qcper65UGJIsf1+eD4NBDyMjoNVNvoG6oxXrE69qnH4AC2Ihu7W/qlId/hv
         h1aRY5t55tqecKYj5wC4wRLHHs+GxJu0R6g1vIhtCvvIm5rjPDwbqd09n7KbaAVmfbp2
         wOhDHKo2SYs2LIyBne71hUh5xlaMvA/JyVgOAI9xlEamQIysIriPVWGwu9xp9aqxxXH/
         akGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5seySNK4hDDxpkyp20i2oYy5PSF73LNYovBB3BodsdY=;
        b=LHO1FEerU9bVJD9ttSluoKazGyFymanO5kB68xoOSbqVmhBpjCCJABsxMXgB0GqdvE
         YDWQfH2Q0ckxCzflbJeDB661wCey3yE2437Sz8Qjoq2A2lpW2Z5cj2QMEvHre8t30wXa
         4YbpHespM17rEko9C9Ij2hW2r1Gd8XQAwJau9T3uBp0k6qBF5H23mX/tEWaVmY2LmXpS
         m1KSn7oTqHaHEgnui+0ivFtI+QpK+ZQsQODK3V95pNGqSQTaMX5ofyl6rMQSN8mYJJ/v
         GTVQPkTHyiI32LfkOsbgkVet8/KuZC+sNSfgwemxBchOSCce4lPvnOtlKpgXbDKzESq/
         OVRg==
X-Gm-Message-State: AGi0PuZVUgcrtyDOKP2AVWsVSEmjeYNR090QBk+sLUGmlmYh9v/G46rX
        J2YAaaqz3xacwpKGutHtLSc=
X-Google-Smtp-Source: APiQypJ0a6P5BC4d0K3z0Zq1NGFX9e8zmK21/U1fXuAlAJYYzL+Pc8udhC+MUPVQHOhmt99FJHrxcw==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr29022424wrx.62.1587564514700;
        Wed, 22 Apr 2020 07:08:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host36-18-dynamic.45-213-r.retail.telecomitalia.it. [213.45.18.36])
        by smtp.googlemail.com with ESMTPSA id a9sm7526790wmm.38.2020.04.22.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:08:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: qcom: fix  compatibility issue with old binding
Date:   Wed, 22 Apr 2020 16:08:26 +0200
Message-Id: <20200422140827.1726-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Binding has changed from operating-points-v2-kryo-cpu to
operating-points-v2-qcom-cpu. Also check for old binding in driver
probe.

Fixes: a8811ec764f9 cpufreq: qcom: Add support for krait based socs
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a1b8238872a2..8a0411efc79a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -278,6 +278,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
+	if (!ret)
+		ret = of_device_is_compatible(np,
+					      "operating-points-v2-kyro-cpu");
+
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.25.1


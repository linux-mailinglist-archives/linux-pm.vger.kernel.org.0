Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AA2A7FFC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgKENwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKENwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:52:12 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C687C0613D3
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 05:52:12 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a3so1699888wrx.13
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhmVl6pKH58mc5ZE+7CUGBcwsFA40PZ3itcLExg+u5c=;
        b=JkuUCZh6IA5iY059NHQMyGdYhNZ+Hq/TJYeapKdolU41BkISmKJzkMe1fcsBbJ7W4v
         vLRmx7GcZPBuSTCzvnLvpu1/kKAhB2u/rjxzN4hNCqGvyYCknLpdqzdZ2NouZm/KAL7+
         9qtXGfOdKBzDxv5ROsX9kK+YmWaYNCNi/++n/eCScRvrZLKfnDDdH6fxuEf5p2gb/Fky
         nDJJnThz89Hb3NKsXrjCif0vuKozBeStlmfii4gQIgzjEVdbTyxmc+YmC4XZ/q2I1b5w
         NHRn4P54e+ZjcC8XcXE3uxde9GqBzu161eMa3z91lx//yd5A7stCJULbyjk95cJs2Fjn
         x6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhmVl6pKH58mc5ZE+7CUGBcwsFA40PZ3itcLExg+u5c=;
        b=jn0KF5tP5LP+l6yiNOlkIZpYY3PN65hzxhiiwZHaobbkUQYCFr2U9EpxrqtHXwaHa4
         0kuqk/w4E1Ba/VXWam6N1iHC/z97sVvf40U0a+GInx0Vrx5Ac9IRjKuNQkASzAPtFlth
         KDwj2+9pTItqoDeM47ktRyQQlAe68vmf8YzYOyXgcCP9mdjqcSOwMpgEOBTgThb1JLMn
         px4fRBoXvt3ndVjCYg98tw6dUeZxDgVSNLsMtCjmP8uMPrSqbDq+UDq/zsE/Ivsaz1uB
         878Ux5N6Qeu2x411Cf7z9WbTaG08/5+LxXZsoBxqWrK4mT5bboyQLif/NkLyPQ15er9C
         oHLQ==
X-Gm-Message-State: AOAM530iZLoC1bq5tG2ADnjXCb56KFaPKzQA9BoJeTLd38mHDR67+zId
        UQK05enRFc/T5M1ze7bst3RfR9JEtcK4XA==
X-Google-Smtp-Source: ABdhPJwmvHKNJov/2BVpFq10F2Na1KUGphbOUkkN35QRPUo3OVpq2uebDe4i8Ol+uzRRutXK/6hgZQ==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr3256609wrp.207.1604584330630;
        Thu, 05 Nov 2020 05:52:10 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h4sm2648541wrq.3.2020.11.05.05.52.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:52:10 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        mdtipton@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        akashast@codeaurora.org, georgi.djakov@linaro.org
Subject: [PATCH 1/3] dt-bindings: interconnect: sdm845: Add IDs for the QUP ports
Date:   Thu,  5 Nov 2020 15:52:09 +0200
Message-Id: <20201105135211.7160-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The QUP ports exist in the topology, but are not exposed as an
endpoints in DT. Fix this by creating IDs and attach them to their
NoCs, so that the various QUP drivers (i2c/spi/uart etc.) are able
to request their interconnect paths and scale their bandwidth.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/dt-bindings/interconnect/qcom,sdm845.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bindings/interconnect/qcom,sdm845.h
index 290be38f40e6..67b500e24915 100644
--- a/include/dt-bindings/interconnect/qcom,sdm845.h
+++ b/include/dt-bindings/interconnect/qcom,sdm845.h
@@ -19,6 +19,7 @@
 #define SLAVE_A1NOC_SNOC		7
 #define SLAVE_SERVICE_A1NOC		8
 #define SLAVE_ANOC_PCIE_A1NOC_SNOC	9
+#define MASTER_QUP_1			10
 
 #define MASTER_A2NOC_CFG		0
 #define MASTER_QDSS_BAM			1
@@ -32,6 +33,7 @@
 #define SLAVE_A2NOC_SNOC		9
 #define SLAVE_ANOC_PCIE_SNOC		10
 #define SLAVE_SERVICE_A2NOC		11
+#define MASTER_QUP_2			12
 
 #define MASTER_SPDM			0
 #define MASTER_TIC			1

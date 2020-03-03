Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6F177A1A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgCCPKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:10:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38826 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgCCPII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:08:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id x22so2000266lff.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmdxrNPqRhCx8T5wcSzQTrBCxn8/ALpsH7EvN6e+rcc=;
        b=XFi/4LPo2OfYwuVN5CWBRpU29SrlNMjIRW1NRij8bUn9DUbnq6PCL/bXw6942V9pDQ
         5y4NbSDkEWtjrxzP6LBvVnvqwl2MCgT+QWL/YyueH0hLLtDn3CkYFwGq6CUbT9i35HMJ
         i0630BwC2DfAL9VAE35s4JDpDlITTSvRacUXxC4fMmCOyDZTDp8U0uUsfA44uVHRZuA1
         7SXkSm8dOsm+xASb36uvfpoI9IhGcU1CRz1bfMOh6WC+YZn9IXs3zKQtpBkLqAN+A0f7
         VsjO08W6iPMo4Zot/dFX3zH7jL4uEGJM33zwue3WJf3AlJbfvKsAIrh0+fEX6aJOcMSf
         sWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmdxrNPqRhCx8T5wcSzQTrBCxn8/ALpsH7EvN6e+rcc=;
        b=OoYtyCoxsWpdxjr6eNySdMqGqDZz42V+UWjTbicNAh2g7OG8wHWxuYIEG9oxlxJuqt
         u7+HsZu4Q2rbZymlQv3obdFxsGl50CnQGc7Kger05xmFlaFBKPveFgl+baeTrUe8slmC
         9KoYZPYbtmPvBfMtjuR0qbJpXnyW2oVbfq5fAUT2TlNJncsqj4fBWVB7Qjkyy7so92od
         8lxwkmbOF6SPtTNhVX1wphKuNVjShCl+PRJk3FRFCFRi1sN0Ac3fuBBrXcZHKBDL7ei2
         HsuqdUM84fdQ0uNgbXZGuxh6k1RxYjmghfkpzPtXiQUGzC5Tzt+PS3CPuGy/Q/WVhxO7
         oEhg==
X-Gm-Message-State: ANhLgQ3iJ/APhwHhJ5gyLGysx0gM5aZqzjwnCSVJWlFzWknhe4cffy8E
        4UONOVSk1msbXyyJWe2CCPQtsg==
X-Google-Smtp-Source: ADFU+vtYMFpz4xq/Y+Z1yD5NXc4xTEM614mywDZd5gOuzw8D6lWBSnbrl4gYYgje/jlKd797xH2l6w==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr3071738lfe.212.1583248086473;
        Tue, 03 Mar 2020 07:08:06 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:08:05 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: msm8916: Conform to the nodename pattern for power-domain
Date:   Tue,  3 Mar 2020 16:07:49 +0100
Message-Id: <20200303150749.30566-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150749.30566-1-ulf.hansson@linaro.org>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The nodename should either start with "power-controller" or "power-domain",
so let's fix this.

Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8f3f19e66cd8..1dd8da481709 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -191,31 +191,31 @@
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: cpu-pd0 {
+		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD1: cpu-pd1 {
+		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD2: cpu-pd2 {
+		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD3: cpu-pd3 {
+		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CLUSTER_PD: cluster-pd {
+		CLUSTER_PD: power-domain-cluster {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
 		};
-- 
2.20.1


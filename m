Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15229847D
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418442AbgJYWVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419227AbgJYWSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E256C0613D1;
        Sun, 25 Oct 2020 15:18:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j30so9423285lfp.4;
        Sun, 25 Oct 2020 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eN3ruYqKrfAyq4fQITxNWZN/YF+MM8QbZauHCJzUFj8=;
        b=e8j1vcVbsn//921VHzcG4Z13o0XdteNjufi6m/hcVkJxyjh8uGT8Vdo9h8f9eJD/Ol
         GzctN2Ns9ukBEaURMG7X9/J7VCLYvTwR8+caX5QjIuX4P01pf8ZZUUZ1EDf4uP7+QBDx
         qzgpq74XsDqsLz1y8uVoBXanfVK1ySzaNKYDMMfjI6XhFieR2Peg2PcEOpwXD+XBnCOO
         goZLgQQu6J5+24ZaiBHnXg7AmWtIGHhXZBfWPztHa4OCj3QjOo4eOnMqiB2g3gpi5pyf
         wBN58I0GmRNrlbd5t3pNHzEV3ho0Wcl2t7urJAjrwZckszMg7NZlOj2D7805nPdYDLVq
         RR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eN3ruYqKrfAyq4fQITxNWZN/YF+MM8QbZauHCJzUFj8=;
        b=grnVVNtqHuYFQtPvbCYAI7Cmaoe952yxc7t9f6ZkYM1inik5fiCA3m4c2CwD8a+2ts
         DlSGnzMhaSoVxtoG9+EkLTiLSIxLAst7whbi5QZjM7Ix1YV82MFvIXVAdO6LRBpwv+CV
         3KdkHyz8qPG2PZ/xeQIS+p4/oIAdrudgeoVx8hlbtcct7bFIGJApRw+eVNvi+Xx+084N
         sRMWP1sWTnYP+KuGRD9Q7DrZNH/yg0AY1PMzivaHIZ4l7xpzGEu2f/upK0pwr71gYrBE
         OIioIVGTwZrQPUakPjtZ6K8knNbnE7lcLFeResDE67DW79+e1zVXY3VtRetO/X/R4tl6
         Sp2Q==
X-Gm-Message-State: AOAM5307svvnR5oOB3vSFR/zNd8gcjP0zmfErJLALm17YH5ZlC1dOfCZ
        0k/WixeLELHEH39U3DSZZW0=
X-Google-Smtp-Source: ABdhPJyt7uQyGsis9xfuuxeNLDgYDdshhwcrGF5O56+tlL2oxr/7k/JBtfJhNzvtT1KvfyYMebNVGg==
X-Received: by 2002:a19:754:: with SMTP id 81mr4360935lfh.120.1603664295847;
        Sun, 25 Oct 2020 15:18:15 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 24/52] ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC device-tree
Date:   Mon, 26 Oct 2020 01:17:07 +0300
Message-Id: <20201025221735.3062-25-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add nvidia,memory-controller to the Tegra20 External Memory Controller
node. This allows to perform a direct lookup of the Memory Controller
instead of walking up the whole tree. This puts Tegra20 device-tree on
par with Tegra30+.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 2e1304493f7d..8f8ad81916e7 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -663,6 +663,8 @@ emc: memory-controller@7000f400 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interconnect-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
 	};
 
 	fuse@7000f800 {
-- 
2.27.0


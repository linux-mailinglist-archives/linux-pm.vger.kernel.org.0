Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85E1F3BDA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgFINQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgFINO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CCC08C5C4;
        Tue,  9 Jun 2020 06:14:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c17so24952601lji.11;
        Tue, 09 Jun 2020 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THFCg3hKPmLC0meEu1tU7N3iWwUxXusX7wxKM7keO5E=;
        b=mNlr5JOg4ibZJbPR/QoS0NVbhOoZg7qhUMAg+LkPxA4lVqfJ3ScEB+lf2kYh1vUwdj
         Y/qqbIaEvcCTPMWpbMKKcYGsvBa2T1Nigt9WiU1Tcp9BhNqjw9n+d69/A8FsT/A3Am7T
         qAXuETV1u6j6b7b04350uUeyijVY28l2Tb0lUOczxEWxRMwS2SNN8tEyTh1XOZIacZSa
         B/SYiF2LQB9KhUIrtuGkyt/GJgmY0fL1KbQVsR6nXutGPaHzoOB8loMjs0Z1IL3bF4+c
         s8mPif9RvF40lCpuB+EHW6cs5IzdiFgU2UjHy+/soGVHcy8tEfmpym2GcoW0FFFDJiLD
         SHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THFCg3hKPmLC0meEu1tU7N3iWwUxXusX7wxKM7keO5E=;
        b=E5NB2jniTp9XouDYy2uHmTMc1PtBf8w1zPUZNjKv3Jm4746W1X0kQMUR65bc6E7k5H
         KQMv8PzbPVGiYz3PyguMZq5mDkNX/mRUPybUh9w7rDB5xjQlhr7GkFsG43lFuyLMKKlA
         bl5VnsjAqns41IYr2ENj+ZqNzRKcaEqB94fCxZxJg3RqJPKU457MeVkk4ZtQJmDXBRms
         zgy6RgT+9cCtaOKqiZQdH26M6/sH7Z5G3eh3kNyhsjKsi2escRzw1BTVwjcdnrZ7j0kH
         xbN5XMgHBEv2DUTaqz2tbwX3ooImPXQlldZlK5L0YqNx68vPsYkCbi46e0mmD/sz3xh7
         JvRA==
X-Gm-Message-State: AOAM53218wU1ekPuHYTa9S+w8rR+OxYVcnI7g8WGno43dU9lhFa7A4XO
        vV7W7+PbVSnN3Irwwtq/fqc=
X-Google-Smtp-Source: ABdhPJzLpzFZbkSq5sri0+eLAtETFypE21d1qeDpAKvqDBb2E5Hi2u+SEX/f9NwdBl903TmDUO6FMw==
X-Received: by 2002:a2e:860d:: with SMTP id a13mr11153440lji.344.1591708495561;
        Tue, 09 Jun 2020 06:14:55 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:55 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 25/37] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Tue,  9 Jun 2020 16:13:52 +0300
Message-Id: <20200609131404.17523-26-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the memory controller, external memory
controller and the display controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index c3b8ad53b967..974048e83541 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -109,6 +109,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -126,6 +135,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -626,15 +644,17 @@ mc: memory-controller@7000f000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.26.0


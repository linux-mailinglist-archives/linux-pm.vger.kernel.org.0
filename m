Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82E1F0EA1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgFGS7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgFGS5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608FC061A0E;
        Sun,  7 Jun 2020 11:57:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so17735557lji.10;
        Sun, 07 Jun 2020 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYJTTF8rWAxRJdQ4tpKkvqb5inrmde6SNOd9Wsb86uU=;
        b=M1OyI1BobX9/9LpEyl22fsRNK130NEOqmz32VAHPzSM1Jn0Jgeu+H0s0r2TeRcePle
         h9Is+YKeOhPizw0mpkiwJ3bB7FhpqJoPLtkpTUt+b0ss6gSBYfBvbgv63COEx8+GNrMa
         9nEGUA9oostXE77s8kjPn3LzX5ZUdm79qr1Tmv0GPNFbayzfPxFE398B0XQ6r7Lifw9I
         T8LOy3FrPoBOlH+CEGWNBTfBif7g48muxQpid56Kj3+8BwtY8VHeLeivMLYcIOcehC54
         MJ+mLF7s2GP9WvscYfNJE9FMO6KxtBgVDQbQC7ulsn/cmUL5YZQkRcICDW6v11nbbqnq
         Nmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYJTTF8rWAxRJdQ4tpKkvqb5inrmde6SNOd9Wsb86uU=;
        b=fUWhkFbPJY1uHlKLqquuPNvW/+XsvDBXtqvSmmAnK91JeqzGLNQBouRS3caIEjM80i
         bl1fXtxxiBu3EGHrZQHcA0IGX9PSLpiYQ85w4gyOj5vcHuC5ggH0oclSMza65sU308bV
         XaIVi0UIUthJQiwae+55RR/PnU4IlRcyOeycnEJLRTfupkZ+6hir3kcDaDYb4nbkS/Sf
         wgj0Dmaa0MwNhezFYLb+glLctF5z9EqDUn8Y+827mqyCrxML6kLbzLoVugrujCk9jGxU
         GEbY+30uo9gmOtxG8NJAPneSrnTH/2Z2ZOLQYYfGv9Ib1TcB7m6Y5S1D6Brn1alfelgH
         WScg==
X-Gm-Message-State: AOAM53374YtfmQfgAOv1+vXuAuEvK1ImMcyzal8/cfWKwKKOTk2zcTjo
        y+jnRH7FoJzpWW9/Dg3Iirg=
X-Google-Smtp-Source: ABdhPJx2csaExXW3XWL310NKGsrymfkpOB1JCiNFzP5oJ3MJ+j++QdDd02RZi3yI9m4WaFuHTaTeUw==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr7425214ljn.246.1591556253743;
        Sun, 07 Jun 2020 11:57:33 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:33 -0700 (PDT)
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
Subject: [PATCH v3 18/39] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Sun,  7 Jun 2020 21:55:09 +0300
Message-Id: <20200607185530.18113-19-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index e55328237df4..739b7c6f2e26 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -16,6 +16,8 @@ Required properties:
   IOMMU specifier needed to encode an address. GART supports only a single
   address space that is shared by all devices, therefore no additional
   information needed for the address encoding.
+- #interconnect-cells : Should be 1. This cell represents memory client.
+  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.
 
 Example:
 	mc: memory-controller@7000f000 {
@@ -27,6 +29,7 @@ Example:
 		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
 	video-codec@6001a000 {
-- 
2.26.0


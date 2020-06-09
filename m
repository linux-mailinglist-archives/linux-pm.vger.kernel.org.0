Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B121F3B99
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgFINPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgFINOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F82C08C5C5;
        Tue,  9 Jun 2020 06:14:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so12471611lfd.4;
        Tue, 09 Jun 2020 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYJTTF8rWAxRJdQ4tpKkvqb5inrmde6SNOd9Wsb86uU=;
        b=FyU3xezRgYRLH4TYd7XYiDFM6LXHBEelQLK0NGdETaX6WKkyE9SUCxdnXF1tKr/Qca
         Y48mQSDFBW18u0dkUbwwNnyfMOGvf+dq/QGBOZmOespFOndPPnCdwZ/jV2sNbZvwl2nz
         kgFTDOum0p3zBMWWBv7Jzuwm68g92qmFIDdovSC1GBF/dhxlxtKTInzW6tUYmXxqD5/y
         J+5pqklvO55a5VcWmscU8zgcuExscaIAJgNkxh4mWiIEQFnERuFZZPhEuzavsSOJ4I4N
         5UlFRi+emAPxbG0h7CHHAhf+sWPexhOEgTqTIPzcOTmcH5KJC/C5fq236fVzqs/xyDW9
         RN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYJTTF8rWAxRJdQ4tpKkvqb5inrmde6SNOd9Wsb86uU=;
        b=hYbt0g1X0cJsKkoxqXe9YYnNMhNsOu1WsHNjtm0hiGMroL6Iqye4Zbq0xeksKTSpfH
         1lzqGOFOjFA61qXvQf8AQlg8GuKQ06sWZwl6uV0fkakkkmgNK8bLZEeZo4bGji4PawYE
         EphGbw+33xcyuQ79j8DcspQnOAsej5kv71iP5o1Xu0Q0lmky1/Yi7PkfGXpEsCTXIWcp
         w1Q5NP6reh0EKm+7nPTmrK0Iy5RaYuUBKRErh/mCg46lODAGLm5USybfSvSLXaewSQkm
         Lm/wdB6gzX8xKn2utSLe+ihCWVVOjU36/l89Y5i7yP0ohH658Inzb4GgtOoEpmmXL6P+
         ESWw==
X-Gm-Message-State: AOAM531lJxMeNxHhAxupofyFSD79RDPfvlSdl1JjxBmSjbB3ZpuN3vGH
        IVuHpO3+in93TWpwIG9xPCtPyaHd
X-Google-Smtp-Source: ABdhPJzEfsQbWQzCGvZqXQMeMC3xMP4vYYgAN1eofLkOvEDdkLppDoquu0V/j5apzqmH5PdMteSdUA==
X-Received: by 2002:a19:642:: with SMTP id 63mr15648100lfg.173.1591708487296;
        Tue, 09 Jun 2020 06:14:47 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:46 -0700 (PDT)
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
Subject: [PATCH v4 18/37] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Tue,  9 Jun 2020 16:13:45 +0300
Message-Id: <20200609131404.17523-19-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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


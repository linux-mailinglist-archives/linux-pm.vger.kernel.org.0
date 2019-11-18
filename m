Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47736100CF4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKRUFe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43465 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfKRUFd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id l14so8211446lfh.10;
        Mon, 18 Nov 2019 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+LP/oqYLNI/WjFbU+/NZQj8FBgrncVTG91u48nmPhw=;
        b=J7gO1jvnzvd2hzgw2WlUrI12hvo+RAUFlxPNMOtMmAHWMN9YtS+lfkgjTAxy2CJ1xt
         aLyGBb3tprQmNFCMQzoS3nUUUx7d6bDsx9sm537i1ybwKHRTJS8JcL5qtJj/piMtzx9I
         gAci62RFvH76iewW0RPzUPL5OdJZqSlv9OSI6L1V5Yx28GNVRGGUGErxSYUXnKq3EJ9l
         AzreYAuwgSnlEg9sydIm0X2Av44DA0zz0SFUQ7mRAVWIbxqLUt4Fu+ubXm46An4w4t25
         /lMVvKOrnEbiP21FKe0F3f9CVtP5ZNc9bSZg0mk9XW//f9tgMNV1gxGjLi4T7uJXiH35
         nYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+LP/oqYLNI/WjFbU+/NZQj8FBgrncVTG91u48nmPhw=;
        b=NbC3rbUk9zbJ59ZsmBwB85u1KSKjhqTILZyLnL9fGCTsnLaKIIPAu0njSug0aX8mBK
         ZJ34p4B2WmeLLCbVDSouqfawUeFM1kT0yKFFTzourUCo/DRBzJF4CeNxHl2bXjgRV3Lz
         R87uc15K4sUTdGcyQYi/8pi91YiM/f2JX9QbCjrVjvN0/kQVnX68TBsW++HsCbrm9WAQ
         vfe5wZ3+V4jqDwaGbACzUfd6fAQopjfCujfOjTh8k6LbPcjuJoJPfIFUxj0LMMuLN2X1
         h8BqRDyMnwCEzI3Poj5jrJBFvF07xCqij3azQh1Rd/1l/K44tv+H9Kki2EOX7Z97ZY9Q
         pCDA==
X-Gm-Message-State: APjAAAWqOGM+DAJ0oByy0uBBfSJ6JNMB1z3nEX2dwhuLBTH0XMV9jfSo
        Rqd1d8u6uEpNWNYDFFZiUnk=
X-Google-Smtp-Source: APXvYqxOWxh/C2yG+0v+6CTM3jtniOCxIbWzkA4MxVnyi7RbbNMgB8/QIqmT44xuJVCgU5F6/zJgQA==
X-Received: by 2002:a19:7510:: with SMTP id y16mr885929lfe.24.1574107530519;
        Mon, 18 Nov 2019 12:05:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 01/29] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:19 +0300
Message-Id: <20191118200247.3567-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
designates memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-mc.txt         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index e55328237df4..b0765d5cb124 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -16,6 +16,9 @@ Required properties:
   IOMMU specifier needed to encode an address. GART supports only a single
   address space that is shared by all devices, therefore no additional
   information needed for the address encoding.
+- #interconnect-cells : Should be 1. This cell represents memory client
+  interconnect. The assignments may be found in header file
+  <dt-bindings/interconnect/tegra-icc.h>.
 
 Example:
 	mc: memory-controller@7000f000 {
@@ -27,6 +30,7 @@ Example:
 		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
 	video-codec@6001a000 {
-- 
2.23.0


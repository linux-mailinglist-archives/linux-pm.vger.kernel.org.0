Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF62100CF2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKRUHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:07:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKRUFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so14894325lfa.5;
        Mon, 18 Nov 2019 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfRQS8FRsreLwU82cR0lmVr72UzAKLB+Ti08zkiWA2g=;
        b=gzNXLwLzE6umljasXje0Th90a21x+svtaa3a0cHtRBOrZwKf2Fh8ILCS2QMfM1A8je
         quppks4fV35q39gw/tZySz51c4s6ZKUJ4o6IAq9YO4ENOQwUrIdrEE7o2M/5WQDmJ+fa
         MARto3dREx4NeuJ1Cq2hnreh7ejZShlBtDAv+S/2aTjh3M8D8FcN+FRvaykTehq8K6I5
         c11fAeSiRzbN1JKwfMUJIpk9PqispbeDAnbukjaKsjRIjNvAJZ/BLvF8ygm0cg0tUK+J
         +u/rNQC3ymN/s+Vt24rsGP2S12B7PUpj+kq5NrJj8nXm/RnNl7i+zV3+0zKHsJu9Cfqy
         jt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfRQS8FRsreLwU82cR0lmVr72UzAKLB+Ti08zkiWA2g=;
        b=ibH3QoyEcjSMPuY841F9KWUcFQhomS7LygAwv4ZK/9zD9/EMuvqtSYJMBTXGHta2FK
         VIxfFAvaxW8iNgg8Ob6EiDQYCQt3t5kZjxi+vqX1R7oLBEmcexPiPRO7s2EcwNPe3oM9
         X+ROysO3C5ggzhyf5svn63/SjMRRZWVy62Xz6YNacnC3frmScDu5xbmI5T/1Qio040ji
         trFwuTKdZptdr9WS1W8RCuiGfCmLhOxqCrkTyl0SabHtpmHVOWKDDbsf8M47qJjMdBXu
         Ho3vQZ6HNWL4WTXu6ooZEJaS/w2MWTDvzCV9emzX7lOZNtOSZt4O3UYVtHyNLOVipBFD
         FjQw==
X-Gm-Message-State: APjAAAWJYZSWIybafKz9FUdXTSE2UzeGtCfuTUQ522Jlwwn9ME8tBm6a
        PdrcX2WZDDFsEvfxhJ3XnuBklV1T
X-Google-Smtp-Source: APXvYqw/CNkRKTWQcvTgT1y2MDU/N7d5RKCQec2znR/p7a4NaamXmNcG0FHRmTUehsLlMo7c8uJOvQ==
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr802357lfq.177.1574107531785;
        Mon, 18 Nov 2019 12:05:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:31 -0800 (PST)
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
Subject: [PATCH v1 02/29] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:20 +0300
Message-Id: <20191118200247.3567-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which designates
external memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index add95367640b..7566d883f921 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -12,6 +12,9 @@ Properties:
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
+- #interconnect-cells : Should be 1. This cell represents external memory
+  interconnect. The assignments may be found in header file
+  <dt-bindings/interconnect/tegra-icc.h>.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +23,7 @@ Example:
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
+		#interconnect-cells = < 1 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
-- 
2.23.0


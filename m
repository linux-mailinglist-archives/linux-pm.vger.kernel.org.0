Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3371971EE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgC3BJi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44882 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgC3BJi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so16282742lji.11;
        Sun, 29 Mar 2020 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyPm2KUzhH4yj1dDse11pz3n8NBqlBEAYiobqyRVKu0=;
        b=KP9TxrfH1Yf2u0M+Qtac+pS0JF1w7wo582/b4iHBGbtBNizsLtp/XIKOhtjx1hlfvL
         R6t/LkbP+19Yq1EXACCNsU+pkMNzVT4AiHeHn/0lr4pEKcJuPzvoFZ/wxAPjKYR757Ho
         a5PvbKFSiO3kOk24Yvx2hSWeACsEowJuj/Ub6d7ov70sS9Xbv9XPLdDICyRYEbiAUBj6
         S4NuHgx2bM/09Q8WZ8qLgPNP0j9TzqOJajKK7y0Gm0gcGh4ZHlNMhv7R4N872aiyRql6
         k5NMBWn9V+dwJ5HXs/lF6jcJ7NZaXjejWFecR//GK+8G8bhe2w94UnhZdEuzhkiLYSCx
         P4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyPm2KUzhH4yj1dDse11pz3n8NBqlBEAYiobqyRVKu0=;
        b=DXGYEOOeLGdyw2vJ43owk79mJ5pwzlsfJhHie/45RCYRNYNG0Snuvuu/fpAWTqyItu
         6Z3EL6uTkpfrM+cGYZCGvb5vgRBgaPEo/sMd8p+qNZvDBQny88mWmdhu9FUc4I+BKWlo
         q5pj7jHpY6Njmst++PnEBtieqSz6ljYrKGUQMlT9BiecA+zKs9k2Ig7dRWKD0mpbvARz
         /T3meIDsipDfC4qQnEzPxw4/MFbfx/pM2UZFzqS6G4qu0Ls25YfD6x+wpLdOgkjziLke
         cHN2w+e4F+NIegqx1gkZcRMigiq9UBKw+JaANVNyk8Zo3CicNsyuKYvo5UiAzz8V7ngp
         NpVQ==
X-Gm-Message-State: AGi0Pub6TotPWsZaT+CN+Ran+pGkO6s1JFM9WMhAnPXyXXDOR7quyot/
        cJjT23/eNPxgQGejn7z/Dew=
X-Google-Smtp-Source: APiQypLbylsFxaY2bHTyqNbB0g8en9J+rivsuZCDeT0HmvlMHYmh+tF0t5nYIOiPUvnJQ/+pK6AF9A==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr5341055ljp.275.1585530575210;
        Sun, 29 Mar 2020 18:09:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/22] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Mon, 30 Mar 2020 04:08:43 +0300
Message-Id: <20200330010904.27643-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

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
2.25.1


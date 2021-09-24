Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F24175F8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbhIXNgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 09:36:50 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59882
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346430AbhIXNgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 09:36:49 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 847F940783
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490515;
        bh=v0f97v842v9qYVokMipR6acxJb0mTvy8VEiat1GXDFk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ce8C7P9jVwUn+jtdegCxntPN8raVAx3eLU09lsXvfwRuarIIXKHLOF6DlkkOFzXhp
         J6DLCXvw5qkCBLrf4qefcTB0wzmYzsAuRca/pmCx379cp6tCAMhIGc8zKkYoO+NPl3
         SBn+369iVUIrdjjn7n3dt9BS9MFyybJirxTod0RJjNxYF5yiFSdFWnALdoXgRmEnOT
         e1biCM0AnkdOtM2eo5Y/dYjgz8jra0yfJL7BvH2zjZcDB4NHYZkmTIlqJ6KO2MjKfL
         pqlkq+sK0PyqEZrrhEKEd8/clI0CiwL3KSAGwyjaBokKwCvbnHXyJUowmsjzlQdUom
         OnK00eDMkbAYw==
Received: by mail-wr1-f69.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so8088916wrn.12
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0f97v842v9qYVokMipR6acxJb0mTvy8VEiat1GXDFk=;
        b=i1U98RN/32m2usuAkkDbViceFy5rfkU4oTG4H/DqbSj9OCTZj8smYsKGZHfGZPc4UE
         bPkKgmDkaIQAR7ITJ2hkVn7CvxtSySnMaqKPGdvASRaSvYDrQ8HjtQiWdnzibFSvNcJE
         qJVNCnyrJ+Ts9VfdJjcoPC5OZuq8SpwqybQ3DQFeWUB+HYtb6w+khs6ot5NgS9K2N3zM
         Kpqy99itHjCOfWZ3LJvH9so5L8JOYzcWKzwpNScCNKz4lODxkRIeLWAOREXk5Mtx6Ika
         gQFd8mcXzBgffVZg+Sa0vuR09uCwbyNxg0l/s6UwuS2UV2vmcMswladN4UW3xmnihjpX
         J2Uw==
X-Gm-Message-State: AOAM533lr4Up9swkScr4Gof+mVXVW824Pw8kjI7koQ9v/zr0Jk9Z0bSN
        UJcvowr+55CbG/ixxNGPKPqwPW9VkEFxvA0/0qV+zM/cFbM8g5Oj7qQVMa8XR6sE9ZHKyD9asc0
        OnaBHbKn7KuyNMfqAdpr0BWdN2S0+g6RECt72
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr866975wrp.397.1632490515240;
        Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi7xEv8Tz6BmCOASozjNG+54R6CSmRxyu2Kax3cZe6Cg23rAYqOmgddnFPEdP4Opy5ulirIw==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr866952wrp.397.1632490515106;
        Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 5sm8709997wmb.37.2021.09.24.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:35:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: samsung: describe drivers in KConfig
Date:   Fri, 24 Sep 2021 15:34:40 +0200
Message-Id: <20210924133441.112263-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/interconnect/samsung/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
index 6820e4f772cc..fbee87e379d0 100644
--- a/drivers/interconnect/samsung/Kconfig
+++ b/drivers/interconnect/samsung/Kconfig
@@ -6,8 +6,10 @@ config INTERCONNECT_SAMSUNG
 	  Interconnect drivers for Samsung SoCs.
 
 config INTERCONNECT_EXYNOS
-	tristate "Exynos generic interconnect driver"
+	tristate "Exynos SoC generic interconnect driver"
 	depends on INTERCONNECT_SAMSUNG
 	default y if ARCH_EXYNOS
 	help
-	  Generic interconnect driver for Exynos SoCs.
+	  Generic interconnect driver for Samsung Exynos SoCs (e.g. Exynos3250,
+	  Exynos4210, Exynos4412, Exynos542x, Exynos5433).
+	  Choose Y here only if you build for such Samsung SoC.
-- 
2.30.2


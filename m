Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D871103D
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEAXmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33200 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfEAXmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:16 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so499298iop.0;
        Wed, 01 May 2019 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wI1Y30GzShQIq71Qmpx4lrEpWFmLVF7D2Tq0E543U/s=;
        b=vaw1xlEHSML4J6bW2R5FBSjkY1foolBfKx8oOvWGRONk/4mu7VVRhWodVTgQ8SIqR1
         dmvmZ+4HPpsaCuMpssaMliqxsh0U/Cqt44whz0qvZATJriEKvWubhgs4p1P4Zclz66oB
         dB9bW9NhJGzOnNmmcN45xypFxnzgYYmNRqhHcn2Kr1L1kbyHtgm7h0AWB0MpBdPjLgYD
         uGnz4RL620na6aDtK9Rmu+U3oPjDkfTCKpgKgWsKIVmIbfgqZavWaNXlilC8ANMHmvx9
         Ieph3PFBZf/eMhh5dq3m8LX9h6V2kLA/dixRKMwiuA/tb9s71x7Ah2N6+gixUo3XH4UJ
         h3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wI1Y30GzShQIq71Qmpx4lrEpWFmLVF7D2Tq0E543U/s=;
        b=s0I/ny+jDYS32dqaPH3Ag/pB/WGWKwxHltqQomHnaAmDycCORfPWGR7bzzp984h28O
         oYCGAom9kK93w+oymRAFqtOq3VWwggFoaZ4RU5nFS3mecGZcwJPIryIVUW2kZxfwmolN
         QBNmFMtiGJ9zbXoSHht0wIAKA8C9wNQxcovFgNE3YZyfLkzbZjlhzA4ieeeWzKNaU7iD
         uXHKVrP2SzVH3TFsgmvslSiZwLlXwrGqgj3RW3eax5hIepJ09/EDNsjxAHn4SwlwRzUj
         1M7O1XJYN9nqkc6aNgHpiQqDud5/tTw9gg5bW5TOPVg1WuCrwbpXar4z/a2HtmNIIPPC
         idhA==
X-Gm-Message-State: APjAAAVOMBjFAqB0CF8AqZBW8jeAJRCdE3a84Jv3Dt4ef7Ja/pLfAocv
        mSo7ndLVD096n4M0A4v/Isw=
X-Google-Smtp-Source: APXvYqy4JATXCderBIJyjzPkj0k+UguEPoulWWcCcDkJgPd3ruqEtvpA1dMcKCbWEGqyCkqq7ztMqA==
X-Received: by 2002:a5d:8f82:: with SMTP id l2mr437660iol.110.1556754135130;
        Wed, 01 May 2019 16:42:15 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for the driver
Date:   Thu,  2 May 2019 02:38:13 +0300
Message-Id: <20190501233815.32643-15-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver's compilation doesn't have any specific dependencies, hence
the COMPILE_TEST option can be supported in Kconfig.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 56db9dc05edb..a6bba6e1e7d9 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
-- 
2.21.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAF396B3B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhFACfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhFACfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A5C061574;
        Mon, 31 May 2021 19:33:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn21so9880048ljb.1;
        Mon, 31 May 2021 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=k/pMzHgG8hATlQQ+ok7gsve0AhesGFTrdUwA7wPJtgsSWc42ty+QmB6qy7PqiaZLu2
         hF++84na4qbiZvNL663+FbDANKfVc0204sE8g8gAKzh04QmIZCBdQxUANyNQ2Nbtw5ri
         iJdGx2azUU2CriRkaxTQ8ruo0d+2GnuLUz51UolAK6Pm97hzBtGdLhOAyyJo8WS98/qK
         b+P5Cang85Vgjg7O/TBRZjZLXeUg3wwlWfmnMco2gXvB8w/1bgEUvEumdq1JmFGNUdrD
         LsoC97RTTuaWcFZB9XK8yLD9/CioFHzGvkmYjjZxg7wT6bznf0j3uA8Mhg/IRw5sc6HO
         haHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnHT/nk8CJodgkwuBSRTekimstD88D/By8a3gAk3kxw=;
        b=TlENU4gwy+84/W02aulSz2tAQrt+tmPLYeZouoPOcIMynevrziaFVaMlBHxujpvi2B
         jUDzhb9ngCmmRw46PfZ573TcfbRnWSN+Ns4iEmohsWAxLe9kT7iVNOchr6rk1qQugDbq
         AXakyFfRs6E53IeGmxDowSYbuQitCe/bBgW5XRBaUXtK1w+kUxAgQVeRMkwS8GWgZ+kw
         9E1YpErXm+t99bVgw395r/KryvQaK4kACnGB/9tv72p2vhvHj7yYRMXRRsJaqc7z6CQC
         lvGAonUeNy8wvwYzMQUjXMYuw6woMpQBNPzgx5h966aeljn9OpxVnAqbLPB5I3Bbbb3l
         OSdA==
X-Gm-Message-State: AOAM530a/VuU9K11LMS+El3a89kUkkRUI8PTpUtxdcCFJZxCN9X3w/QL
        O29kAhAmDIZbUz+D/6fCRBA=
X-Google-Smtp-Source: ABdhPJxBnzJ//qQTiZyjhsMUjoiChvAsrs9NG52I4Fd0TKkWTwm4SPzvR8WVOeKEFs8xpuyMVQukXQ==
X-Received: by 2002:a2e:908e:: with SMTP id l14mr18933182ljg.372.1622514810502;
        Mon, 31 May 2021 19:33:30 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 07/14] memory: tegra: Fix compilation warnings on 64bit platforms
Date:   Tue,  1 Jun 2021 05:31:12 +0300
Message-Id: <20210601023119.22044-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix compilation warning on 64bit platforms caused by implicit promotion
of 32bit signed integer to a 64bit unsigned value which happens after
enabling compile-testing of the EMC drivers.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 4 ++--
 drivers/memory/tegra/tegra30-emc.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 5699d909abc2..a21ca8e0841a 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -272,8 +272,8 @@
 #define EMC_PUTERM_ADJ				0x574
 
 #define DRAM_DEV_SEL_ALL			0
-#define DRAM_DEV_SEL_0				(2 << 30)
-#define DRAM_DEV_SEL_1				(1 << 30)
+#define DRAM_DEV_SEL_0				BIT(31)
+#define DRAM_DEV_SEL_1				BIT(30)
 
 #define EMC_CFG_POWER_FEATURES_MASK		\
 	(EMC_CFG_DYN_SREF | EMC_CFG_DRAM_ACPD | EMC_CFG_DRAM_CLKSTOP_SR | \
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 829f6d673c96..a2f2738ccb94 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -150,8 +150,8 @@
 #define EMC_SELF_REF_CMD_ENABLED		BIT(0)
 
 #define DRAM_DEV_SEL_ALL			(0 << 30)
-#define DRAM_DEV_SEL_0				(2 << 30)
-#define DRAM_DEV_SEL_1				(1 << 30)
+#define DRAM_DEV_SEL_0				BIT(31)
+#define DRAM_DEV_SEL_1				BIT(30)
 #define DRAM_BROADCAST(num) \
 	((num) > 1 ? DRAM_DEV_SEL_ALL : DRAM_DEV_SEL_0)
 
-- 
2.30.2


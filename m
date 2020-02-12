Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD57615B50E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgBLXqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36106 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgBLXqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so2881700lfh.3;
        Wed, 12 Feb 2020 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=in1mRNkjLcyyYGag86XElSgSWN+iJpBlkF4Log7IZjI=;
        b=BZfNMtHL4EON+QIVZKp9H3DOAf3pJc3Rut8Sw+EzQ8usS29TMEyxzjLrXSwRyYxopo
         Giet3OnUNB/Mxxo6HFqaZu9YYt5g8abHYYw9IsSA1FDJ3gIwUqDyBLYMQMYa6uK8FUhX
         qwBXml7hbCkKHcw92P/OLCAvB6XGoQfP2Hw17EkYXgDsiK08oqmVt7nHPuxzAhtOaaaI
         oRMtbYQx1c970izfXKXpWD/A6D/x1c0ipO0kf+HJg4niCjiVU7RJS5dU/+FZdn+gMp3B
         eZkPzwybLNFZTzZJVZEOp8MM/kEdfaPnxb4mEJmt6TRTZwi510QEi5+xFYsmOxBQxEAz
         /nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=in1mRNkjLcyyYGag86XElSgSWN+iJpBlkF4Log7IZjI=;
        b=Jo5PTNvxKDXNSwnee5k6PEtcjc3JDEKy8OJNWgAm1ilJ4nAB9qNgZagLyfr32a1AXw
         IGS1njk7dpORTqXhyVRa331gfJ7tP5ypVgXs3NW0Vdi1FIk4KRiRHRDSLMSw5bz1tL5n
         GHbY7T8v9OK3XKtzu6AmueDh/uWCi7Sw22T5Up15omgy+QsT4D79rkY7suZNKIT8Ng3w
         tBK1bW9u1JmgQSUvbSWTBx0hInbvLkmnLLOSMY46h+9uxfQE8iTUb0rk1YK3kYNzsEBc
         O57pBeR4ctLTTaIg0jbiSqsUQ5b+0xBGVtpAsxB8dr2hx2Fx3FToUfwePMD1124/myQU
         Eydg==
X-Gm-Message-State: APjAAAVi6ixbfjyvk4R931VfKtL7FPoaTlFh+/lwByDCPjM6RsGjQPli
        aIEjYXVxtXfD2YoXBu8KWS8=
X-Google-Smtp-Source: APXvYqzntfbVx97j/Z7e6kSKTVpWU4U3kdKugoWUHnk8rqK4kk/+zxsHZLtA/ZrCJVFTxnvFI6J/0A==
X-Received: by 2002:ac2:522f:: with SMTP id i15mr7712045lfl.138.1581551201191;
        Wed, 12 Feb 2020 15:46:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Thu, 13 Feb 2020 02:46:05 +0300
Message-Id: <20200212234607.11521-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-cpufreq now instantiates cpufreq-dt and Tegra30 is fully
supported by that driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e512e606eabd..1e3b85923ca3 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -95,6 +95,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.24.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8A125348
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLRUWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46871 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfLRUWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so2606052lfl.13;
        Wed, 18 Dec 2019 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOvh1jiKDepC3yJC5nY3q65+eBnyGCERyjo984OFVEE=;
        b=PNJZuPEz2g/6rZevWNKJRoOXVwhYsAWGbX3DcjYbUt1JI3gTqN1W8HDFJMFQZFh+Xz
         Xvpx5N4a9p2nb0+Tf780ZuZzUeu7GU14ZzC/1vpkshZRCbGI3LmNl97NcanZlkF7fKmf
         DLv/q0s+enln1FsK/lxadSasOLBW/PRQfEdyqBZbRGUSFHs0Ei8GaVOZdFg7gVIPtXFe
         9zFKr4V5qWC9annujvm0ZFY4InP68coqA7/dBUQJMtQmghQl7mGT+CpqZ7XQ3wRLrzfE
         FPHzLRKtj8LmvNNfE9NsVmiPggyrShtdaUzWCWh7XojI/s5goKLI+TlAZ6VR31R80Pet
         uN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOvh1jiKDepC3yJC5nY3q65+eBnyGCERyjo984OFVEE=;
        b=dToWB2PQkPPnqBJ4hLUTI9bX+newX5fnyrrkLPBEZlf3IHCa9CQLuv2f9BVJl1rnJS
         /nQzoyRqQ4/2e01dgQsZ+CfbXk4pwmGkrnYEtTt3I0rLdmCnJq6gilVRWMghTIJlfqtn
         BjbAsN9iMXNeeJVhzvEoiDDEF/0K9l/fXkwjZ1Z1BTldd3nxWEjbZJiEIy8eRvncytas
         zz+MCJusr087uButrhbjjvF2gRcWzVgtFh8pTNfj8G+T6Oa6Aa0PUNftWAs+NsFSEWgS
         4mskanpNRPoTZJAzv/+D04u6M+sFg++RiNlsNE5fPbZUgqdghvYm03VcaJkUwJ9MgUiN
         cJUg==
X-Gm-Message-State: APjAAAVTSZK7xlA+0Zh4ZclUx5q8uOdvVzwsBU1qIHlj7ctra5NJydeC
        lPhTZUW+SN/H8SgVDnoQ0xw=
X-Google-Smtp-Source: APXvYqywGSO74/vMKn0pZYHkm86dgV5cIW701c5aIJUh139oXzIl20t8c1aGR9jBM4nNfXjCEVuxpg==
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr2998954lfq.147.1576700525243;
        Wed, 18 Dec 2019 12:22:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:04 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/12] ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
Date:   Wed, 18 Dec 2019 23:21:37 +0300
Message-Id: <20191218202142.11717-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PLLX may be kept disabled if cpufreq driver selects some other clock for
CPU. In that case PLLX will be disabled later in the resume path by the
CLK driver, which also can enable PLLX if necessary by itself. Thus there
is no need to enable PLLX early during resume. Tegra114/124 CLK drivers do
not manage PLLX on resume and thus they are left untouched by this patch.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 9a20c93abe48..4f073869b8ac 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -358,7 +358,6 @@ _no_pll_iddq_exit:
 
 	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
 	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
-	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
 
 _pll_m_c_x_done:
 	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
@@ -368,8 +367,18 @@ _pll_m_c_x_done:
 	pll_locked r1, r0, CLK_RESET_PLLP_BASE
 	pll_locked r1, r0, CLK_RESET_PLLA_BASE
 	pll_locked r1, r0, CLK_RESET_PLLC_BASE
+
+	/*
+	 * CPUFreq driver could select other PLL for CPU. PLLX will be
+	 * enabled by the Tegra30 CLK driver on an as-needed basis, see
+	 * tegra30_cpu_clock_resume().
+	 */
+	cmp	r10, #TEGRA30
+	beq	_pll_m_c_x_locked
+
 	pll_locked r1, r0, CLK_RESET_PLLX_BASE
 
+_pll_m_c_x_locked:
 	mov32	r7, TEGRA_TMRUS_BASE
 	ldr	r1, [r7]
 	add	r1, r1, #LOCK_DELAY
-- 
2.24.0


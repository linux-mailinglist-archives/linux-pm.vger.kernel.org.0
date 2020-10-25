Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D72983FE
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419376AbgJYWSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419365AbgJYWSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FD2C0613CE;
        Sun, 25 Oct 2020 15:18:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so9444770lfk.0;
        Sun, 25 Oct 2020 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PH48KfFXPwOSFrtxH/nqQ6/PkMkkNmgzsjXGDZ87+I=;
        b=NU8o04tLt1lEwiomFhKoT9cvrlR4P/69J4LCKbKBeOq8ftqqFhtH/wKXbuKi+IREf+
         PbE/lmPcNo3gCjHGaWDSZX4LEcIv1u3oG2PQqB3X1KW3pR92MMZ8rYE9u9gxmWXoEDIS
         /Rdfeh4QSXZxtV5Rp1E029mhH56g9IAgUI1nozGp5tos2vVxy7iaTJlKn3V7I1ZDJK+W
         iZ5IWBC77EqAxZ8XzcHeHMJT32SVAGwMgKwkbI9+MSx/1L15bQm3JGdSXVDFBCBYndAx
         rbeUE+H9T+xIgto1QwDRnY0eE2kySXok2xwho32fMe3VvEzNs53FKm+1Mrtke21+FmKf
         Dotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PH48KfFXPwOSFrtxH/nqQ6/PkMkkNmgzsjXGDZ87+I=;
        b=boXkhWCmx/79JoKrAsmyDi7uCOIpJPx+bkVNHCGEKpmP3r1ZMnjAsH6zHEW0Lr5Pup
         Xroc1wXYZYoxeVUocgPFYIJrhpXIsuN5mSMzihzWH2jx9g3JWW2zzl3dGPVrTedcA4od
         TRCJw8v0dzRogihq+9Wsy2xFOX2KMNXpYqgTKxwgsGaUIhDXc0yNLwaRyHnmX+vst56O
         uBQvknsHKDlt4+oAirtmP9i3dcYoEjb4e8uzOOLfvuoEQK15SnBS8loO4FYyxnst7Z6z
         3zniIXJBrNbPGhdWQOglBWoW979kbQBInBPWjvyysbUmxrdvQolJnHADXIEZVksvejiA
         IwmQ==
X-Gm-Message-State: AOAM532h6EvLrm9/K7zjLwLdJL36N6B/xULpkm/pztI2gIhgwdHuVxcd
        9ht3Ann66tHtb3xeyNSP/ktTHAlpUqQ=
X-Google-Smtp-Source: ABdhPJyCump6Q8GEh7VpGfsg/snta/sTN25f5fywvrLs7iGoc5nw2s4PlMJvhieIjbEaatJQrUpZTQ==
X-Received: by 2002:a19:957:: with SMTP id 84mr3699671lfj.342.1603664321823;
        Sun, 25 Oct 2020 15:18:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:41 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 47/52] PM / devfreq: tegra20: Silence deferred probe error
Date:   Mon, 26 Oct 2020 01:17:30 +0300
Message-Id: <20201025221735.3062-48-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra EMC driver was turned into a regular kernel driver, meaning that it
could be compiled as a loadable kernel module now. Hence EMC clock isn't
guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER.
Let's silence the deferred probe error.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index ff82bac9ee4e..fd801534771d 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -141,11 +141,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	/* EMC is a system-critical clock that is always enabled */
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		err = PTR_ERR(tegra->emc_clock);
-		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(tegra->emc_clock))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->emc_clock),
+				     "failed to get emc clock\n");
 
 	tegra->regs = mc->regs;
 
-- 
2.27.0


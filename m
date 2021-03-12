Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4540338C6B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 13:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCLMLD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCLMKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 07:10:37 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABACC061574;
        Fri, 12 Mar 2021 04:10:37 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x10so23941540qkm.8;
        Fri, 12 Mar 2021 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoVnp0DkBC7jB2MiPXZW3s9oPZeAX8j9xE9dtxYukcY=;
        b=V/USh5P8hlz71luyJffL4QRDlR3TU5yZO3+csN4iFScvbrvoUDCzg676xEUIc9OjwY
         G4islVP0N38OenyXfuqi80C3J2Bh/dY6ukbZx0741Zg1Psc5JC6vN0tCgfIMPXiXjKSg
         1K4+GPWlFyCqFKgOXE62PNfqLjw7bYnvTgLTUS5Wb1kHnUDeryXxKGD4AflnsT9O1zqN
         eT15sVXe8ZBfb73hX2jVZ3nZYa5HQlbpsV/rYsg5GTJ1O+WHKWeJVaoCJ5mAEy3oCQml
         PEAEDxrEXjMcp8JGz5bML2ME6ZntrQOvgGfnYpNDadTH1CjMmdJUmjSDv72vNP4uMH9v
         Mw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoVnp0DkBC7jB2MiPXZW3s9oPZeAX8j9xE9dtxYukcY=;
        b=ot8AWP9JfLdrsi28nwBvJ6gUAMUxPcdtdBK9vuz5Wo2003wriozcFqu9+MLWGtyNUU
         CztT/s/B4HS6svGn1PoXMyLzdLaTWbvUNLG5o0ZZEot6JK1SwxFslax8OkuzsiIjXtUP
         m15Ve87/ZVBZhpZKqk8rpOfIepetkipUFis0Y1NR8aqz9auvZgpyLhxfOvPe62NzF0Ky
         ZgstOhRvXqNszW5tIY+TvRsJBuXPtQsjZKjzh9Jnk9D7nyNz90GPEG3gAUKLaQT4GLHP
         qSUnxEEsa/Bg4KK9DcQX+k5g83JC6ROtv/1XWhZyGZ5oal+4iSQ8VJ/XxH/aFD2jYzlV
         5ckw==
X-Gm-Message-State: AOAM531jR+8OKzlYrDh9HaxQp2p7kRTmvc3l0VM/M8zzCLpf4VZ+zEu+
        0H3vl7EL9zkqsv42zPU5Wlg=
X-Google-Smtp-Source: ABdhPJyL8pPZ72zIkZa2rO6toFwR6cVRQAZSI9tOJgrXT6VRTFWiNEApeODostsAsP8XmLac6AC2VA==
X-Received: by 2002:a05:620a:16ad:: with SMTP id s13mr12232028qkj.68.1615551036578;
        Fri, 12 Mar 2021 04:10:36 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id i89sm2227154qtb.95.2021.03.12.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:10:36 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] cpufreq: Rudimentary typos fix in the file s5pv210-cpufreq.c
Date:   Fri, 12 Mar 2021 17:38:17 +0530
Message-Id: <20210312120817.12604-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/untile/until/
s/souce/source/
s/divier/divider/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index bed496cf8d24..1cfea5339beb 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		/*
 		 * 6. Turn on APLL
 		 * 6-1. Set PMS values
-		 * 6-2. Wait untile the PLL is locked
+		 * 6-2. Wait until the PLL is locked
 		 */
 		if (index == L0)
 			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
@@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		} while (!(reg & (0x1 << 29)));

 		/*
-		 * 7. Change souce clock from SCLKMPLL(667Mhz)
+		 * 7. Change source clock from SCLKMPLL(667Mhz)
 		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
 		 * (667/4=166)->(200/4=50)Mhz
 		 */
@@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	}

 	/*
-	 * L4 level need to change memory bus speed, hence onedram clock divier
+	 * L4 level need to change memory bus speed, hence onedram clock divider
 	 * and memory refresh parameter should be changed
 	 */
 	if (bus_speed_changing) {
--
2.26.2


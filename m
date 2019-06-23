Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2264FD69
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFWRvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 13:51:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44039 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFWRvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 13:51:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so10349132ljc.11;
        Sun, 23 Jun 2019 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2qjKuaK2bAC6HwMuzdrbSEtzdln2IR0U/1QHxDJnig=;
        b=vHKP5U/b4Y5fe87aMnMbnhNneSbOQNKMAR/ogmA9aVTaiHiFbM+029R6fUcnbgjHTa
         rpsPci6nFQkCrzcD1S7nbwStAzGhBy6e0GcsNjuu9Rrg8Zf/LYljujokdwUmIKgQfQVu
         1tkmlX/ekPOkTzeb/akWGuQv3DNBqO5G7A43N7wlcIgk+/lOYiJ5tJpO79wa69pcsWhz
         zhTcPOeJE83pQGuDmDFGqTnzPkBZrb8F4tKIgO9L6kkkZpYE8pxsEqEdWTsqc/3h0VD2
         6Tvs/fpZSgsRjtbkOyDrnw78bz3+IKTiC32jkXLc9ZVsIwRPbYaQRspyubYi7CPQg6kw
         pVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2qjKuaK2bAC6HwMuzdrbSEtzdln2IR0U/1QHxDJnig=;
        b=uHvuTnAK5bVPG3BY2oUb7jOqpM2xdjRpYp1cyCdWO8dYXwJusBFNJvsoGX2KGWuAaD
         MTK2SIm3rRTy12B1prv+CVAN5v07o8QEMFozfY2DbANiVmT/IAvDtf3F43KpEEQauknr
         VLP2TZnC5ohmyfiMkkwVOgZjcLczGjNtNt7ex4rH2nR7j8+syQ2KG9dJ9jX4FOmz/RZc
         zTLW58Cb3KSxmWz7BJeCQ4jrFCtB26iONMVQ4BSiO03r65kPuQ+2CeQQLkxQgKaC6tiV
         Gm6LuqkswutHz4luCmuRqDYlpYNQ3YcpFje5GeknpGv29hakkkEpMMr/W5lIITDat9R0
         8FhQ==
X-Gm-Message-State: APjAAAWclCo5Y8ysRHCEK7TjMm967ua9Vk/wjpbTsdSFswPmcQeZcmaf
        O9MyrPVLfhqpKllJfOZn9yS2nYbP
X-Google-Smtp-Source: APXvYqwN3ULDWGn/ez52l0K+WbE83Ki8B/PRvoeJM9DvUa1T3I9jvVc6qVJCf6amPevExY5hdKuStw==
X-Received: by 2002:a2e:3013:: with SMTP id w19mr66938891ljw.73.1561312300308;
        Sun, 23 Jun 2019 10:51:40 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id l22sm417693ljc.4.2019.06.23.10.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:51:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] OPP: Fix crashing when current OPP has unsupportable voltage
Date:   Sun, 23 Jun 2019 20:50:53 +0300
Message-Id: <20190623175053.26167-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix NULL dereference caused by a typo in the code. In particular it
happens when CPU is running on a frequency which has unsupportable voltage
(by regulator) defined in the OPP table and a custom set_opp() callback is
being used. The problem was spotted during of testing of upcoming update
for the NVIDIA Tegra CPUFreq driver.

Cc: stable <stable@vger.kernel.org>
Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9fda9a0ec016..89ec6aa220cf 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -685,7 +685,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 
 	data->old_opp.rate = old_freq;
 	size = sizeof(*old_supply) * opp_table->regulator_count;
-	if (IS_ERR(old_supply))
+	if (!old_supply)
 		memset(data->old_opp.supplies, 0, size);
 	else
 		memcpy(data->old_opp.supplies, old_supply, size);
-- 
2.22.0


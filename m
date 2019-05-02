Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B126110E1
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 03:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEBB2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 21:28:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38473 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfEBB2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 21:28:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so296956pfo.5;
        Wed, 01 May 2019 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phRIMmYflgZfcBCKyZBekM9N7nqlxyMrFktT8H7bj/g=;
        b=SRcsMvPFbeG5f/i+HYue0NAlkY4H5dDGVbVQkIo3G55R9KKkMvE18oZxLPAquZQciy
         0Bv1RdCGvWkFAhCIAZxcn8r7rdo9m96MgyH4IsRViBCYRxy6QrgbdtDigY71CsBxUzPw
         wNRunHxztue++rSq52ob9QMRs1Uc3ojskKt5+ul2uYX/7VxfEotopbOrRRnRxlky79l0
         H60lK6QYozS7Y9DTq047UQ/bqCZ1bmKnKXTOA90Sy4qH5pdyjHyrZaUFsOYtqAZBOlQg
         IuGAJa1Jf2yTjQTetIsFkZTSbJI8e//6QEbuY2BJBGbZWtbJDdTZF9N4EuMcgtww1yrv
         AlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phRIMmYflgZfcBCKyZBekM9N7nqlxyMrFktT8H7bj/g=;
        b=A6QQiSyN/AI1cIlZetTTG33GSBo2Qelc0694A+geIjCf2kSrJYdGIaImjIy/L1U62c
         bUNqg+OEMi3KYwFBX0sadK8GnFOZ25g9lSqegJTURd4hCrG7KcfM8VtDSB22Z8xoRndn
         Va+dljOgH6nAH6V7CHjpJG7O0IDA80cGrdv7iMXz5B8XhLcOctaoRx649kx4ARHKfYco
         wwSNfTdXy3SpXX1t2uvBb8vLYxwRbtHnvjBntH82MrOvisDlGbgHem5315JGA8O+jor2
         gZP8R0djlGCwSqu01/DLpMsxEh8rXAYEIPMOPNByZ3D4f8WaJWgBQdtqWUYN3ZQoR1Hb
         EjuA==
X-Gm-Message-State: APjAAAUOGtAm8UjKs0uFdQz0IbDudIlGg/eK6kZ+oZJhv56bQZ/pIqFb
        gtZPwiffTNhopmXb0+2WLGY=
X-Google-Smtp-Source: APXvYqwNVSAQpOxLtgWlqQd/72L1IhMEV16HeGwcAYSLquTMU+jTJpbm7BrsycrG8DZpWTjgSrRApA==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr1111291pfa.200.1556760495454;
        Wed, 01 May 2019 18:28:15 -0700 (PDT)
Received: from debian.net.fpt ([42.114.18.133])
        by smtp.gmail.com with ESMTPSA id 10sm53728342pfh.14.2019.05.01.18.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 18:28:14 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     sre@kernel.org
Cc:     ndesaulniers@google.com, natechancellor@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] power: supply: core: fix clang -Wunsequenced
Date:   Thu,  2 May 2019 08:27:06 +0700
Message-Id: <20190502012704.12505-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The increment operator of  pointer in be32_to_cpu() is not explicitly.
It made the warning from clang:

drivers/power/supply/power_supply_core.c:674:36: error: multiple
unsequenced modifications to 'list' [-Werror,-Wunsequenced]
drivers/power/supply/power_supply_core.c:675:41: error: multiple
unsequenced modifications to 'list' [-Werror,-Wunsequenced]

Link: https://github.com/ClangBuiltLinux/linux/issues/460

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c917a8b43b2b..7cc6f5fac0d0 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -665,8 +665,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		}
 
 		for (i = 0; i < tab_len; i++) {
-			table[i].ocv = be32_to_cpu(*list++);
-			table[i].capacity = be32_to_cpu(*list++);
+			table[i].ocv = be32_to_cpu(*list);
+			list++;
+			table[i].capacity = be32_to_cpu(*list);
+			list++;
 		}
 	}
 
-- 
2.21.0


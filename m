Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CD1E43D5
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgE0Nft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 09:35:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbgE0Nft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 09:35:49 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTfgb-1jS00D30If-00TzYS; Wed, 27 May 2020 15:35:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: avoid open-coded 64-bit division
Date:   Wed, 27 May 2020 15:35:38 +0200
Message-Id: <20200527133543.599948-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mqnHLGtnwdSmTna9APPKP+9uliCpSII5zeeZjnDuho4W4vNK7nQ
 oLmnxdtfBfNu4AvFeP/z8xXgGIwR6KGBpoxrfH9m8s/WCmY4n5tTouYLWl4LDTXe3AeRR1F
 FSxKUCF69JY5QCbpT9sSuS2KFD5xH3HBR7kU2GuMW2Zmq9zzBgjaAa8nDJyFiCr9vzI2uhm
 hkld/BVyqXvcafGjQ9Uyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:owMpeyhSvWY=:MMGYpVppPn0/vP5ID8hWFH
 yNjdAo4s0kI2qvRUluIAhC2kUJ6/LjFJ1AJRQrTevVbHs+c9REC7oo9kxbztUSKj3vK4XsPz0
 5m6hhDzJjqHLdUjTPYVejmItjNaIjkrmNV+Kj5vlt9kifmV4/NmommriN/hPfbBHaOE++BWXF
 +I/ItYudsPEolW4zG7u6+fXIHmP0+c2T3AUwoxL47qk/g4fxCa3Z8LX4jDFUM1JTGfcXXSnWs
 ExasdGqWewPUPlI7eRl/epf9bjxt3j8sm+86lmSPQPFWsgJdNOa/CfkGyX2zXRMFOfSxBO0OQ
 JhLXoEwleGQM+bM18eu5XCws7DZ1AsFeOQd1Ipcsj1vWJG88NJmZTMV7q7IoDqg9oIuonT8nz
 dlQbZhxJxvai5Lnq74oxNGxvUQxLFn4O3TG1rFQU/3hE12FqQAbL49/6RNRENRlIHL2nJ96Nj
 a/5wi+bFf8qyAMOQa4/mmIv51egtF6sQQ9MGtLLKgusUiiwbZRh0lCe9pI0I5S/ZlkfjPzqU2
 J/lpqAzeF79pCNI/RkctvcUjj5blYw16xl1FEEy7fP3WF86nKCCiMGonbfCq4597tzz2jXLQR
 AYlevKQvHYiEnl3JJ1ttHoGw6zRqvwAWrNZz22Yi8+9izNnprjB9uNKIjE/cHSyjgGnKG98fx
 WzLdR+WIfQbaJ5121FC2Hst+8vkhfhv8j/92BPvhNBk4zODWIy8DPgoEUYGJABCS1n+/PcaD6
 WTAnhQKnprg1P2zAspok7PLv6T2OeLIwn41kGTAUmYV4+WTVrg5Yw/5yp3dI4gigMsR5vpztP
 Olr/1Sq+iqBX57qtbUOyfuD8SwG6bd2oRTKUGV3MNzlSqkXXJU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

64-bit integer division is normally not allowed in the kernel
because of the large overhead on 32-bit machines:

drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.o: in function `_dpu_core_perf_crtc_update_bus':
dpu_core_perf.c:(.text+0x810): undefined reference to `__aeabi_uldivmod'

The function already contains a call to do_div(), so I assume this
is never called in a performance critical context, and we can
use div_u64 for the second one as well.

Fixes: 04d9044f6c57 ("drm/msm/dpu: add support for clk and bw scaling for display")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/interconnect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 3a63d98613fc..8279fe9b2082 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 /* macros for converting to icc units */
-#define Bps_to_icc(x)	((x) / 1000)
+#define Bps_to_icc(x)	div_u64((x), 1000)
 #define kBps_to_icc(x)	(x)
 #define MBps_to_icc(x)	((x) * 1000)
 #define GBps_to_icc(x)	((x) * 1000 * 1000)
-- 
2.26.2


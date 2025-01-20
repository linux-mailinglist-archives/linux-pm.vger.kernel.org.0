Return-Path: <linux-pm+bounces-20697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB003A16F5C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9B43A8491
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29121E98EB;
	Mon, 20 Jan 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv42iZ4J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED91E885A;
	Mon, 20 Jan 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387536; cv=none; b=jlHLxcy8YoPKGaBVBb+w+JGEeOHKgjC4jbACNXM7Cl0DoAvfvv68St24atHSmLBxa98s7iRaeBRcF4ElvEBNaBPmteOMCl5h9elqEDyaTSND9u7yP3HkY5V4ELyISyrxBukgWezpOn85M2owjmPf8aDE7B0fJ4vUsH/3kcnt3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387536; c=relaxed/simple;
	bh=l+YYGTm2zzIcbCgqHlNlez++LIbLtqhh+Pn409TvJho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esyYprRJtRs7jF9XZdHIaN/hOF+89O3/L7ArjoVR1avCPTYEcbvuMYt23Asny81E4f6eFs4ti794h8PeUiJtuTIwc83lsvs8XIKqeRyvKatwJxGDX+IvpmPfXEMHcCnFWS0QerKfRiAnNNCzbkE61Rdore4YK8p4Tjk2/ztqC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv42iZ4J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso33124535e9.1;
        Mon, 20 Jan 2025 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737387533; x=1737992333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUNH5OV+WC/QzjXwldloXCvwJvNBFYqSY2qbuibPXTY=;
        b=hv42iZ4JJIYTTZYrSz1RNRNNBpviWs9/OgJu1Ip6YGLzx5wrihHzxjgmCNxdArDZpH
         svg8Yca6Bu94peccrADVrPA7EB1Big4ukvFiWfH5xBJJC6yAad4hGY/hGflo97i4GLMY
         h18c0ZRcwEeOhNgBuatObZlQGJOAHvtK/hPkMVWS9OaDJb4/x+PHxf8HfKq4+7Aas36f
         xp8tEUCutHntpQ6tXigJrfvqGSQBxnSMhyiPWnV6RDcYRnfoqEgRtFuTRPQkMlw3lIgS
         1sQDrkKeKjqiKEr8gR9f21FWkGK0imiouNBtxi+w3j5JRaZ5Xsju5WtQjexHTvrek3PL
         dtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387533; x=1737992333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUNH5OV+WC/QzjXwldloXCvwJvNBFYqSY2qbuibPXTY=;
        b=F047UjFlGUeYwrhOvNxol1IFvPNIjknywi6x5nbj+OQvR+6ntVRmpoTlFxVt6mN5hc
         PRUkiFuCD8Zt0uDDJjONCjpTgO4yyD2Y+AVoiHa16p4Qwtr8+jgR9+rA9eI8z7UsmygV
         0OXRp9kvtBZxVZpgTfZY0Wjd2juKscF+5GTLWxPocwHW5uYbSUuapjRa9ktB1Ovd3xEg
         S7uw11frgimWx+KuiGhbcgjKnBwV3ZbFsoUsyRW3HZJrBzUo/vUFtFIxX+hFBCMD+Dp1
         ScxjMN+kmSoC4zs5cXpjU0l+WKnQ6oTjzboks9wbOK4gmmy8jUa8tEPRWYgz6R8ivrj1
         qJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7+61bw/B760YsbzZX0M8hoY8wybTRzOJi1cy00TZ3/D6vyIdF+foSBrFjftu3f56za3oeGZc3H+sxCw=@vger.kernel.org, AJvYcCVg8a4ZagkDzsmWA+I30djdv3Jd2leFyJw3SBEVHHDoEPyS5L++w7nbdm/6e5p55wYDQWk/ievOnNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjzubqWWHa4FuIgaelDty2ADtYxMElh4uFN6g0Q1FmXUIAg2g
	NgAP9qzd8BFJd4tDs8Y5/8dDO5MLbd6mTwEAHFiHWJBGvHLO83Rf
X-Gm-Gg: ASbGncvsun4gYo/MKsDhFRE2mCm6ZLQ9hT3ezGOxbqylEBYS6GupDKQWLvMLg2N/WK2
	bs2wzk1Flku91Iv8g2JQvJak3Qf80cICNes02YkLKU/SHaXPYtCPHTfuck9/sB4QLTt8rLAQleb
	srr37UFWkXjjffQZpFFEw6cjfc01gMggp1bb7Z1pu7B9PjIwzLtqoFk5zec4KkKlSoj2+EltEiX
	EODgYtntWzml4lcwcTsro9P83hjjKu3u0vYKi8ngJ1t8uCYVtRq/i4GszN6F5iEvld1VNzpPHgL
	fmscuHY6XTLaEl67KltZeSIeLQq9dt1WGRk7vFI=
X-Google-Smtp-Source: AGHT+IFq/N1M/Fzfqtl5Tsax6f2eFNQebWQPzXxA/LFVpMMquGf/Nb5tqY6jgvqwOtRwfXgtC13vBQ==
X-Received: by 2002:a05:600c:4508:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-438913e1c00mr147505135e9.11.1737387532941;
        Mon, 20 Jan 2025 07:38:52 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-438904084e7sm144141375e9.6.2025.01.20.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:38:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pmdomain: airoha: Fix compilation error with Clang-20 and Thumb2 mode
Date: Mon, 20 Jan 2025 16:38:09 +0100
Message-ID: <20250120153817.11807-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
pointer in Thumb2 mode, which is forcibly enabled by Clang when profiling
hooks are inserted via the -pg switch.

This is a known issue and similar driver workaround this with a Makefile
ifdef. Exact workaround are applied in
drivers/firmware/arm_scmi/transports/Makefile and other similar driver.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501201840.XmpHXpQ4-lkp@intel.com/
Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pmdomain/mediatek/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/mediatek/Makefile b/drivers/pmdomain/mediatek/Makefile
index 0f6edce9239b..18ba92e3c418 100644
--- a/drivers/pmdomain/mediatek/Makefile
+++ b/drivers/pmdomain/mediatek/Makefile
@@ -2,3 +2,10 @@
 obj-$(CONFIG_MTK_SCPSYS)		+= mtk-scpsys.o
 obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) 	+= mtk-pm-domains.o
 obj-$(CONFIG_AIROHA_CPU_PM_DOMAIN) 	+= airoha-cpu-pmdomain.o
+
+ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
+# The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
+# pointer in Thumb2 mode, which is forcibly enabled by Clang when profiling
+# hooks are inserted via the -pg switch.
+CFLAGS_REMOVE_airoha-cpu-pmdomain.o += $(CC_FLAGS_FTRACE)
+endif
-- 
2.47.1



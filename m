Return-Path: <linux-pm+bounces-21559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6DA2CA89
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCECE18869EE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2821991B2;
	Fri,  7 Feb 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5XihiZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC33192590;
	Fri,  7 Feb 2025 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950672; cv=none; b=afZPEjnoqeLx82XbjCHLsoMuVcz2Ky1sUdCveNUiHHdnbCZ6A3JUB3pQppVLmcF+Was32BAE7EPp9lrBrnSMRwYuSe+Yb/UjHMS6E9W/E7BoLjfgYjD8XNnzfuLjWX5wUZGXWTU8j0YTbdMDsPBl1QWcW+YhnesLneRfWsvAGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950672; c=relaxed/simple;
	bh=pqczq43LpbSA3CT/HD+7MZiv+8Bcwe2G0ZZF/QFuS6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKxrWbDbOw79Xa0njyJHZ5FBldHw0zV3x9NV5ONOWnHAZHPtV1Ifp7bQAAPu8FvZRsM/BZhGedptsxOcV2hsuWeYqPkoY/mVwr+OsVJFcncDS5xaoYNSamUeuTY2cINwZ/f7MnR1p+VsUXK16GeOU5Sd9B7jMhFUajU+sqmbX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5XihiZE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be6fdeee35so389888185a.1;
        Fri, 07 Feb 2025 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738950669; x=1739555469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/93fpw68fWcW+DcrP5O/aiX1Id4V9BT6qntICk6OEis=;
        b=A5XihiZEyg1mjWHYhU8b2VZCgfJ2HKqpHtcIAosbh06dcRkHvXcAqNgXwx+PIApJrf
         XEsuF2+5NwWJAKQzq3bIQf3P/KkXKL4xoSf8GpcURcXzo5OZ2C7LMuuE9prmXanajwqw
         H2F69fYc85jczXGZ/7sezginrk9xySXKChLf3MIWTrbfV+rRjeuB4RZfdLIEruwFgVfc
         UbeRXGWreWIGrR8ZExPJKF2sQMq67upim1GT6hOCNPK+SXjBESckwwutB99KAu7DWQZQ
         CUutD5IQ7Bk82g1cYAGPprRAE3639w2auhLE+rwYW4LRXqQPRDWlhaqCqrJvgjPCLD7P
         8H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950669; x=1739555469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/93fpw68fWcW+DcrP5O/aiX1Id4V9BT6qntICk6OEis=;
        b=ULeU41JIqp9bssN+5AlqQwpnZEqkK/G6KuBgWsH59RHmLNmCYpzHfeQ06eeAB0n3MW
         8EOk2BQXqZ2Tp6tr89p4VovFTrSx2Ejqm4NQ5B0bquqXRoVdfe5ycwpuDseVLzJm4FzW
         8kGxlbwxzpOIRvjaDdfBVN/J3TkNE9GBIvY7wIxMAaGb7sDbvvr71SSqmXcBcSZeHd+q
         hUmmPmeK5RRx+OJgbh9VgKFsDdfRotm8/yYTyMXPLpuk9kNjZ9DuHHpGFb2KMooXO8Th
         TpF9706cJEgf6qKx+dnW77Gzc6CFZBmW5jcmj90Fxn3MrJ+MpLR3jD1YNM97/FB1PYtP
         HLLA==
X-Forwarded-Encrypted: i=1; AJvYcCXAtqK8bz25J7Na/m2Bv0NMO/itjcMUpSgOSmYARORHI9YbJxrLjHikFnUC6Cc6cDuFHC/3b3yHIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkiaiwFZxzc/J9HKrc1UrZoiM2mn6IJOkfHCgrRFhV84pv9wLO
	da1bXATkO0SCs1EAjbIIiUxcAcuIRJ/feeoz9fGagoeheXm1xsDpAkdihvNi
X-Gm-Gg: ASbGnculj+90/mS8C2p8xYc9pzg0ViYMMw6D4/TMVj8qYuBeX2cKCrE3qUM7My+7RxK
	QGcdTDvs/IxixHuX4GayHm2thQ0XX2k5tpcejxK+7Ak8TKyTps3Rco37tTSmbkbrJC5GOb/g7Mo
	F9MOMEVFrTi57ubkyQd9Mce6jYrnP4nptABQVw67OpIWLccPAW/JNjht0nRxuW/kNbSxZHufgpi
	08mn6KU2S8QuuO19iOPZpxWokpmWxnVqVVQF6IKJU/J1kUygzIOg7j8d/9GF8pK/EI+DrCDxFbG
	+Hu6v73+3DjfaMNaZK2fUSpEseJmXAohv7gBu0Cvy5dVKvnD0x2dMwRWKA8=
X-Google-Smtp-Source: AGHT+IH5tTCU4j64XQ4F4wjfiG3qYOH2jmpjJmMKHXE/ZZKsEer/8T4dfoO0EiAxA0tixUxKnduYEw==
X-Received: by 2002:a05:620a:f0b:b0:7b6:d6ff:86ba with SMTP id af79cd13be357-7c047c4acb2mr596123985a.52.1738950668737;
        Fri, 07 Feb 2025 09:51:08 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f901sm215674785a.87.2025.02.07.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:51:07 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caesar Wang <wxt@rock-chips.com>,
	Rocky Hao <rocky.hao@rock-chips.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Cc: stable@vger.kernel.org
Subject: [PATCH v2] thermal/drivers/rockchip: add missing rk3328 mapping entry
Date: Fri,  7 Feb 2025 12:50:47 -0500
Message-ID: <20250207175048.35959-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mapping table for the rk3328 is missing the entry for -25C which is
found in the TRM section 9.5.2 "Temperature-to-code mapping".

NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
      4096-<code in table>. Whereas the table in the TRM gives the code
      "3774" for -25C, the kernel uses 4096-3774=322.

Link: https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
Cc: stable@vger.kernel.org
Fixes: eda519d5f73e ("thermal: rockchip: Support the RK3328 SOC in thermal driver")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- remove non-ascii characters in commit message
- remove dangling [1] reference in commit message
- include "Fixes:"
- add request for stable backport
---
 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f551df48eef9..a8ad85feb68f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -386,6 +386,7 @@ static const struct tsadc_table rk3328_code_table[] = {
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},
-- 
2.44.0.501.g19981daefd7c



Return-Path: <linux-pm+bounces-12811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497EA95C989
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0020E1F252EF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4114F9F5;
	Fri, 23 Aug 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wCkrQvby"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1402144D0C
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406395; cv=none; b=MG1AE9BHwIp/xh/V1klaRoKdDlmZH4j8JXd5SkeN62TeiM6aNLEhA/wgCac4BdC9RkjZR4UiZtc+FO9S2f4jzOx91cCxjFOMRzVtTGSvdWwmjc3zdCWlHw+9krkgl+DO0r37NIUpjGoGOb80deAN581YGriazQeVlDDtVbHEdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406395; c=relaxed/simple;
	bh=Ap/x27+7809718JeEKye8qMyoPqWfzWvIeTeDRcXon8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGiRBkIqnj56HUJZXmq71/VG9bBBas6ESzwFJij0xamfEwomyMouZItCSIHTjKsqUCP6U384EQzlx5XkExNY9w8997xFHpK9dBQQWtAXNXVkq49pfHxkDmR/cDLQvfrp12eWZIIJ4uCT3Isi7DHIpDs1BrcDqJBeRn1LRltENVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wCkrQvby; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso13297935e9.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724406392; x=1725011192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGPaDjhAkHGO8KGQapFP+sDknrfRWsCW7Ql+/R3WyIU=;
        b=wCkrQvbyJrMHvxWsW2j/P2C3cxvAtITq6WEBEdPbb6qMrwn8T6J3v3p3nV2GhjsJED
         Dj6nMEysVK1/sbUSUzE+xjSACDocfSVai7SApG0m091aQbx2l77ukmBzQHCi36KufSKX
         UocWkyJc1cZtifhAww39AVQ2Ds8OGbYOPf1FClrqhkM8ONp8vGgWtXe32WK5QjxqozzE
         2RPgbnpMzwjv0P2Nzt+SrgjqyjuPHogFcWVqXDAzjFt0fbkiMK5X7AwLlGT9gri3blM1
         BFb/V0TWTnuJzou25EvfDZYXGYwlsnu7AJehBIv2MOujqIVppBSsMhoncGKcjdxc4jI/
         oMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724406392; x=1725011192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGPaDjhAkHGO8KGQapFP+sDknrfRWsCW7Ql+/R3WyIU=;
        b=Wf/91iEj6G89itz10i1OY1uXTkkmaK8N2kI0QUZjpshKZ6aGJQ9RySZNXlI1WlsGj1
         cPghNtsELbbbYKy7BCPwbgLXXJoDvkp2Of6AWyvuWOUT+3I2XQvjnI2QXCsv/Sw91DS8
         v/Ff5onVL95BUFI8VgoeAbUACujX/cP3BeW+7MRsi7e2zut6J1A2pEiFAAjc9i6/h0jG
         ADWoylAPD/JvxmK2/xxEIWW5Qg/VLPVteWvyneCyEfyueZXCj28+ODi5lLtuM/mo/GLG
         dYuB2pgjxyOwrSuPEhgKXhZFWbMZJSNm5lNU6b7qpV6hC49sQygnSFMzR1l2U53oDsPB
         KPlg==
X-Gm-Message-State: AOJu0Yzl19UNR45Et3kMkn5hBc+XO/9E9VbMxRl6bF79zVYp0x28IBOr
	FlIdXO3+YHkMgk7MRePiS6meMxA1vpBEc9BFUfDmy6JSmajJA6KB9ktRayrqxBY=
X-Google-Smtp-Source: AGHT+IHYsgKtUoCDnzdH6uD5d0NfJ3+hk3bYjAi0XoXU+y4pxwIErAgW9mmzqM5S5l2DkXxJhwf0Og==
X-Received: by 2002:a05:600c:3ba9:b0:429:991:dd71 with SMTP id 5b1f17b1804b1-42acc8d4bd5mr10318805e9.11.1724406391448;
        Fri, 23 Aug 2024 02:46:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e1f7sm53640585e9.5.2024.08.23.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:46:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing fixes for v6.11-rc5
Date: Fri, 23 Aug 2024 11:46:28 +0200
Message-ID: <20240823094628.34085-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fix to the QCom WCN power sequencing driver for
the next RC.

Thanks,
Bartosz

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v6.11-rc5

for you to fetch changes up to a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10:

  power: sequencing: request the WLAN enable GPIO as-is (2024-08-19 09:55:53 +0200)

----------------------------------------------------------------
power sequencing fixed for v6.11-rc5

- request the wlan-enable GPIO "as-is" to fix an issue with the wifi
  module being already powered up before linux boots

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: request the WLAN enable GPIO as-is

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


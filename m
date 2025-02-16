Return-Path: <linux-pm+bounces-22171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4EA3774F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 20:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0937A3AEC06
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9219F421;
	Sun, 16 Feb 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpGsK7HK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7919A288;
	Sun, 16 Feb 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735949; cv=none; b=Q0wcfab0rRUa4Fq34qxf91fDwYVS4zk8RtEm3erU4HgtXUDeGHIhucDflcfqxu0KdWWqNu/J4Fyj5vLiokZ2InOJT9mX0gidLc0EcpwzWiQL0xfSdn0IXG1YFiAzOgckOUdndozbzeXpC8rltrpzxWFn0eMlYUYJCYNgrIFiVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735949; c=relaxed/simple;
	bh=cTMuuylMI862Cc++KtvKBCfdFHJAlVM1DcH159YbnMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWSJL+wH/Svzsjld+8wEyLX6RImeihHxJVqe2XsuGcZHrpmmaIRnyKBcQtEUyGKAUBLrZ3zsoW3PjmEFbn0sV0jFPADkfy4xNG9Auu+7bijjf7n3JO/CFIU9nw3+skZ5jy2wx7ZLc1/x2cBr9N6jzXL8WlOuhwjSAVUzcHWcjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpGsK7HK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211cd4463cso10391905ad.2;
        Sun, 16 Feb 2025 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735947; x=1740340747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Re0gzQApO9EfPmEDRqpFe0xqY2fs/XQmv0KA/vyOfOw=;
        b=KpGsK7HK3GGN43z0XTz3TXh72HZF3RICh75IhbHIfUuKUmcWdMUfIvsqVOv46eqmXo
         MnoIbjmev1wI+8ZpHAPTPy/1CCM6Z7019WCIFgxu8vmYLGq5j5zAZH9KzcYVylX2Jcmh
         vYN5LEm+vlDJj2XcmjRj2WVAGRlXu7m7DP7QtTKfZIq/1icRQHqZToCgFnGwe6dyyk6M
         sJs22A3Rr9xI7zEDTSHr5+TuaCte/iYIy/J9olEHP+TL0Pe67acvMThlcSLAMbymDu97
         jx+jtqI4SCf4d0aC0hAJtOeH66NJ4oW/upbzPD3HNhNEcvl7jv+95jgvWrXxSEkr4ZnS
         PGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735947; x=1740340747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Re0gzQApO9EfPmEDRqpFe0xqY2fs/XQmv0KA/vyOfOw=;
        b=I00VkLfIWwrVeVnSSU8k4LxWSyjYP/yOt4CYknciYqRjAPNjjkiRThnVKzwRhoP9DR
         u3Z8K/WlaIsQG1QC/+4VZiJViOxM/3wjXiojxoSWNXrK3BxHoh3QvoddKVHQ9UMMsVxq
         PW+SJk+Csb27jlnxHr9KbV5jWRLJPnSn7W4C6sFDQxvyKN4/KB+BS4tBMJbWGfjJs1Qs
         kiaTUUBSPxXbA1VfGwiDepQo06E1kD6SS5788Lc+WM0G3P8W0+NxupexeyNyFSuuRDbP
         oOIv7fkGhcTWWPyIP/FP5t5TeTmL14fLbfBA4wLcjXQXye1cJx1JfTJgUQ70MizK58GE
         kW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVN5+0eyuICYf4he2YhjX2kUF9YvCv9OXB1N4yrKeGRTbFHUpsJ5tX2h4cJpJ2rUJ2mC6VP2bKjEi4=@vger.kernel.org, AJvYcCWUfgn/T7eHBEwxn0cgQ0MFV1TnuRTnH5YvvqaLVFp4sVEMwqqP1HDTIP1NBCkrF7wgBBZUdy6sghutNYmK3DMY2hA=@vger.kernel.org, AJvYcCX4tCxB9iXaN8OQsXeHJMdUL1qJ34X4gpmpuIRTcupvCDKVtc8Lz1h/cZiVYDxkIVrRyLcI7+awvFBaODU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEhp4VJxaqKYnf57g1/AEgZXloSI0moz1ElxgjmFIqxVp16Fi
	EAg4Fomz5ewmKQLn42lUbC91eS2yWEqMt4gNGGhUEsehVLjbgfyM
X-Gm-Gg: ASbGnctiMKCeMX/ohyJqorYA8VSLAsTLszsup1M5ENKkpTmur/MohZDgmHNkXP8yTNU
	wjmZxKC8y6Ml7ykkgqsRk8opkFPQWv/TTxb+44wV8rUpr6YnVmhhnxuvpTLxKRchY8vSQiAD7sM
	d+/HlO8daV8WH39MhY2MSZvGCO96ToXskxAlSBdpP5uaSXrnFsHLzQIrSWxgzvMmqk71ZqzSH2Y
	x25dx+Aopj1z5C7lYTGkwiH2sEFSMYTexrEikAoX2eiG5Eb3vo7lpma2FlRhiqkR5pNWhxUbtvo
	HI5W6v9mTfO8ZOc6K8sXfswj/hEg+Q==
X-Google-Smtp-Source: AGHT+IFpRIUUjMumU1yZigYYXeQpl6ouiiG6kA3Wzy5akHaiQ9Q9WMcDvpoWIzUd5821ktni1tvZvw==
X-Received: by 2002:a05:6a21:b97:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1ee8cb098cbmr11194774637.10.1739735947571;
        Sun, 16 Feb 2025 11:59:07 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm3023559b3a.22.2025.02.16.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:59:07 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 0/4] Exynos Thermal code improvement
Date: Mon, 17 Feb 2025 01:28:33 +0530
Message-ID: <20250216195850.5352-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patch series is a rework of my previous patch series [1],
where the code changes were not adequately justified.

In this new series, I have improved the commit subject
and commit message to better explain the changes.

Tested on Odroid U3 amd XU4 SoC boards.

[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (4):
  drivers/thermal/exynos: Refactor clk_sec initialization inside
    SOC-specific case
  drivers/thermal/exymos: Remove redundant IS_ERR() checks for clk_sec
    clock
  drivers/thermal/exymos: Fixed the efuse min max value for exynos5422
  drivers/thermal/exymos: Use guard notation when acquiring mutex

 drivers/thermal/samsung/exynos_tmu.c | 78 ++++++++++++++--------------
 1 file changed, 39 insertions(+), 39 deletions(-)


base-commit: ba643b6d84409e8a9057d5bdd6dd99255b1a88fe
-- 
2.48.1



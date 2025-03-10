Return-Path: <linux-pm+bounces-23765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AEEA597A6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D3E16D348
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0B229B23;
	Mon, 10 Mar 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9oC1qZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886591B4140;
	Mon, 10 Mar 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617306; cv=none; b=LJGeeCed3+1mKJzWc2RjkAa7Xz6TK9P3kQZtvxO6AUcdEnGYGF7ufimXJIsrhPxgTQ5qfvSLjQc1TAhym4QXZA4dGLT4L0aGWERC33pvCBqEZeztnorbCmX12w0Fx2mdsXqx7oTAyIgPsv18Ldv+ACT7kQJCl1i/9rkqlBorPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617306; c=relaxed/simple;
	bh=2QfSqbq4dWj0u/QBFuvXfEGWcWC/EFuxOpqYylFkN7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDDmM7bSNVuBNFJkerYEl5h9IoHsCoe5XRxPq5ZjS7wjNiw2YTK79X3Y0kgh8tSCBoQjKkRMiXD2OuGE97M4yWk1eVkJ7X2Y/dnPRHXBzLDbXKPyLRZw3VflRAnemVTXy9npQ6vpR78bcDJ479YHobTvWY9BmVootDoX9r7slSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9oC1qZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso80799215ad.0;
        Mon, 10 Mar 2025 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617305; x=1742222105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma81+6yDVsQ/IjAHSfeuv7Yhl0CtA9j86woJnhcbnGU=;
        b=Lv9oC1qZYE+RmBKItMrEsdSrK5YKwbknRIvd6FDN8QX6ukF9u40gWZ9g0Rvv1gHWlD
         5XYbNo+nmhVvtaCPJ+BVSbd+SHtEFWlpm8HnO1lNs52ZE9hfAeuqRYwhgxH++nyDxajd
         zw9VfPnBS4D9NnMWp8Lmp25v0QaL1HrXPvxqDJqshOcjG/DZEIweGlaDXpcseomWv034
         9gJe8/R4NwR8CLCAlSybsrYf7Xq2oqb6QoBrpWXZRZ8rxLpSyA9NWMLxf6biuzSJxLrA
         UeZu17QlE2bCzfVUSj3B69FMvkMPOTxwGtfj4qZMztVnqWFZFOOcXJtYh/bCgM+0YNWd
         Cx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617305; x=1742222105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma81+6yDVsQ/IjAHSfeuv7Yhl0CtA9j86woJnhcbnGU=;
        b=XLYhO+BCQ+lC3uaYQeQyOPtNr39psjFfGJ7hJWSxdf0fGBHRUa8uALMvRVQl3OoMcL
         PA/FffnPJ+rmEYK0atF6GJIrQQkjH9GSaQcD79yCWBQInjXV4n2DKXf+3TEjUFatAkA7
         sCJ/fX6EgaU3w9GJ5GEBFuepCjOkrOb61yqZf8b5y3Gbipoq7n4LkhYoIyEJm1iH1c1j
         nRmhHVUVa5i/Zlv6ogK21VCIikFS1JGoiZgXCD1WWisgC7xfVKr+ulSo/yqCu9Vq00Sq
         CcesMCc4pWNO7Q8lQW49M7dwHhyUf0DIEfIQuGoG05i7tM1NsU+mw9EyjyodHn4fcbf0
         EckA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHpThLS879YMTSfEObOLkJQqeSJuLZNBnv62wd7MpJ5YKAE019unanpPgEre6PC2KQuPH9y8AsS8P2Y4=@vger.kernel.org, AJvYcCUrW7UnnC/BxsQL5xFfpn7rhwzSFgk8sY/ga78amSG3noAj6C4EIg5GfFfqIKENXHYxmcer8ofRnnkhxzo52w0bJZ8=@vger.kernel.org, AJvYcCWnfhrq/EKzgmxnw+tFA9euupxS+hhYQ7jxFigpH/+PIx0Xso0kZv6C+WOjHzcQVn4ZTbXsi8eSCJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQCnP8hXgjaM+a5FItt2TBFfuGnmcXvUnbF0bWHGkGe7Uy6oB
	ArjaFpBtJWh+BdpqNEoK4Uoq8zCgJEEj0lp7wNxcYgYa5xwKPQRc
X-Gm-Gg: ASbGncvlDCVL6uQbz2dU1TOR4PYDwvtbq23Vd0UBQtI6z1LEMSkelUqEOsb5cLe9QQy
	iMZ18ED/m6dGyrigqEiVsYoDM03li3DsGzEy9siItjnurqmw7U64Cl1Rv4VwNajgAl1kbQE8UMG
	76iPHo1j4p16gxV2oXHxgrdreBPhCopFM+Yz+gvAN5W9c78LR+JvNgmZGYMxRkNI6zKrHnMZz2b
	8u5CyUFleNHpNKre3z4pG4wWdaLFoTgsuJz9KOQmCKtUWx1nqY7H4rz9hbNqwagtVMjRQlCwZs/
	shco+NAwo65YIU3ywLWKAKdgnndbLBvxBSWamsroDQ0YR8Vpn/E63lSZlSM=
X-Google-Smtp-Source: AGHT+IGhTdTIdVP7HB+PvUYMd+2NW/R90CRsL9UGSx6Uhzt1y34i69B3QZbu3IQFoa4tpOU5W+GfhA==
X-Received: by 2002:a05:6300:197:b0:1f3:3cc9:29f7 with SMTP id adf61e73a8af0-1f544af86e2mr23515419637.12.1741617304667;
        Mon, 10 Mar 2025 07:35:04 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096763sm7785900a12.30.2025.03.10.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:04 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Exynos Thermal code improvement
Date: Mon, 10 Mar 2025 20:04:41 +0530
Message-ID: <20250310143450.8276-1-linux.amoon@gmail.com>
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

v4: Tried to address Lukasz review coments.

Tested on Odroid U3 amd XU4 SoC boards.

[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
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

 drivers/thermal/samsung/exynos_tmu.c | 87 +++++++++++++++-------------
 1 file changed, 46 insertions(+), 41 deletions(-)


base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.48.1



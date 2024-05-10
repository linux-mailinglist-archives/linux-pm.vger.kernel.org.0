Return-Path: <linux-pm+bounces-7715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721338C22F3
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34E11C20ADB
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53916D4F5;
	Fri, 10 May 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HZCP8mkU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43216DEAA
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339858; cv=none; b=BhUnbQLvEXV3aj0Z/z+WHgLv/X+ck/4/pJH1q3bP6T2Hqkn8Wg5nbXHcoT5M2c5dHn3yMwn6F9fHmCdAxfvdfFpaSi1wG4AoflN2yVkJUvidqPEsHmxfyn/qQXQ1OgTAcea2mdf0WwoBuTKxiCNql9jRPFDr16UQY33gJb2w/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339858; c=relaxed/simple;
	bh=KDtGGXYG4AmtKyoCjpQi7/V9u4bPrev2husRY9LlwaM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=MaXLUCQFWVgzLsxQBC1a6c5mOoTm1bn3zZIkJAvgCliBLZ0NJGgQrrzX2/1dhdlsI3UpACYB9rdbHr7jTThAJXnKJNuYxGhWB0PkhWBmRLjW9FVgGxH7p6/OPXypwoyR9pqHekiKIdvEP905HASEI+RN0gmWgeDmck0ZSo09joQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HZCP8mkU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee42b97b32so15280755ad.2
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715339856; x=1715944656; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KDtGGXYG4AmtKyoCjpQi7/V9u4bPrev2husRY9LlwaM=;
        b=HZCP8mkU+LObc21S6ZSZm5DIgscGvfue6LCchb6BqnOPprIF6tDJZOfDeXs66SG56f
         inDkosdzX8UecS6LmUQKq5oSuyS/KuI5uNmqNttvh1oEkxCHhrS207XTh+nLGo6/sE2Y
         6aeD4bm5zAZEkzxSAD7dc4o35qgP2tKHLt7UWbDgb8+2tfzuXJTw+Z0Rb9rjSMqRkODL
         Y1H6pt+FnvxT13lQ53IMSdATb5C0FU4X4C1RVyHX6IPiFJapOHC+nnkYxhwuW1xWmfKI
         eXXwFPo+3/NOcD9ZU10od7gYp/+wrxypcboavsXNHdKKq3wxeiN1YV2ViE/SCodrVhKr
         C5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339856; x=1715944656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDtGGXYG4AmtKyoCjpQi7/V9u4bPrev2husRY9LlwaM=;
        b=LMqz1ADVFoVEz7/oOwajAvcJ0EP988xf4/Rq0eW4WlIIhzFdrIYta9sdE+A8GdA3Kl
         J2JXwb3lGrf+bWrAJwU92WA0zW24xZUSMKaZbBQRx0Grnx51e73MvQYTejI6vFuAFmYl
         s+T+E852YSuX5vMv+vflSTd93YS5T6uLDIHXADp63UyhzH1ocDsslJx1nN3UDeaDvIsW
         CNGLT4/HO7cjCzAouuu/mTFCn2y4Kub3wpQBxzNMIKeWOfC5a+QyrLlHid1CJa+LSOkz
         1m7oDAWcvEPSUQvBgFB6YeZQf5AJXQySCoFENX1WrJvuepuq8Zs9eISp18FfLtcICOjI
         8iCA==
X-Forwarded-Encrypted: i=1; AJvYcCVV08MVtU0NbBsPS9NDl02TxEsP3JdTVgVp0Z/vHH2r5IjYc8NcLNoknwfBRiC80QBrDViVpzkNm8rmINgz9dytBb9n25r21Q8=
X-Gm-Message-State: AOJu0YxuVUWgTCy/P/icIcNRw02BAcdce41aQNlyLZv/9SCk+5FI4uKE
	JzN1iZBPYGXnhLEnqR+Z6UpXO7MFHjJHuNB+S34MPtOE8pKqJ+Da9W3Y2Yf6ATA=
X-Google-Smtp-Source: AGHT+IHvK4d1GEJQU62zX43oO/1blK88oGTi7y0Qyh/QkHje8ZzYZsTlMJGu/c+k7vfE1+JExWTP6w==
X-Received: by 2002:a17:902:ecc7:b0:1ee:fc5e:5cfb with SMTP id d9443c01a7336-1ef43d185f5mr29732905ad.19.1715339856178;
        Fri, 10 May 2024 04:17:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c7asm29629665ad.171.2024.05.10.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:17:35 -0700 (PDT)
Message-ID: <663e024f.170a0220.32f38.78b0@mx.google.com>
Date: Fri, 10 May 2024 04:17:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.9-rc7-242-g9b0087147da0
X-Kernelci-Report-Type: build
Subject: pm/testing build: 1 build: 0 failed,
 1 passed (v6.9-rc7-242-g9b0087147da0)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 1 build: 0 failed, 1 passed (v6.9-rc7-242-g9b0087147da0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
9-rc7-242-g9b0087147da0/

Tree: pm
Branch: testing
Git Describe: v6.9-rc7-242-g9b0087147da0
Git Commit: 9b0087147da0a0175d376cd636bc795f2e943f95
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---
For more info write to <info@kernelci.org>


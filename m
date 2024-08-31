Return-Path: <linux-pm+bounces-13292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05B967323
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDDB1C21133
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68C149DFD;
	Sat, 31 Aug 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MXTSPoyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E0219EB
	for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725133247; cv=none; b=MGITFeE7cNEw+EF/+0181bsQXcYrlwtyWx0UeGkxzxNJccO8xIjVKKdCdGA+DxONF8z4AE0lWXvQJcQRYkOSZtybcuoirYd6vMJGpv3DphEHq9KcJ+HTLt08LOUnXvi0cFZ0pCQ09WxE8GCC/5sgziBwXRGVuMgSZKsJFiVkyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725133247; c=relaxed/simple;
	bh=0zBqQcQWGQH6QT+Zs59gfm6nXvQOLfs6t1Z3jMdHjSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnNkFSKHmtxCkRCJyfgsZCYoQDqIeGcUDbtsKJqJfJBDHBUBB4uqSnOUAi7rq8h8zjzfCrQpN7i/N4aC4/aRyCJwNfdcmtkEm35xj2N5O74YSGIdH0DIUE2VciHkYLNxOnd8TJ+AwNcTC3FcLsSS+KNVbmi8A6gmQJALnscJs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MXTSPoyr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280bca3960so25151565e9.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2024 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725133244; x=1725738044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CtfmoH02/knNQfvPe1y43TpSI75G5Zoj3oZBNUmpzE=;
        b=MXTSPoyr92imhXo8QqorP8Tg1SrdVdBmlkVqFaDkhOMygnYk8wiRhF1XcXlw+uV56R
         CBTU87n/kJRikB+hiRfMbqbUORxdklARB71yA9DspeieVDzUxwyO7/tEpgdJITSeKR3p
         NIDNXBg8zF7X1kvix2Pst9wfXwaLDKP/Gff55y5rrKWKUq01+bIcdLsbN6tqp5rpCb2v
         p2MCAnVfsyDQBMzZ6v4fhZzjNqxHEQqQg0MjF33GsCJQQEGmbplRepfpMgSsHQAUx6F7
         frs/0pMb27tdp4VIH1U8cgfi6sZB7gLpjw6SVnHbN2YC1OEB50G2JlzoAaTUIfTRgHc6
         EeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725133244; x=1725738044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CtfmoH02/knNQfvPe1y43TpSI75G5Zoj3oZBNUmpzE=;
        b=vywrgJHBORCh7sXxAhRMkVaQGH90hnVQAAAM9q1E2La8j4+fofHbpYz95C9jfwOnSY
         HTepI4JeUfV6RrWfoOGVk32abZH69e//mjEsTbTlCgLLdl8wXgQVVe+dhui/4z6OSqJs
         ZTSUmXZ9g7/zevGDjT6qhC1Sr84D7gWy/jlwASgx127F4fmg4qbxMofGHXIMNKMPBc9I
         aQYXbMQK9r4C6Gf820XM3hwUVInD2c/f2TZxW5qNuBMjMxR7P93Z5NQbXo4NEcERSeAp
         +NHLLU1XxQ7yvBm3Uwp+nZo/GMqIIGUPn77Y8QlPXa7Ou+ZG9J9ai6f7NMtFduhHJHi5
         5vSw==
X-Gm-Message-State: AOJu0YwERFVrr0zS4XlAHp4QbIglbK98FjY8EraqNxS67qtFw2rglP2g
	OCLuUwT3bT0N+QywMHgS21h9GtICzAABG1pWVuiikxeBaJu0owM+AEYbCXnAmlI=
X-Google-Smtp-Source: AGHT+IGMPsKGvi8ik9qWKFA0pPgByI5GVS4lUuTCFIOR8+o1o/wJszc9rxEhmR+5anMa6INMYGb15g==
X-Received: by 2002:a05:600c:4452:b0:428:1090:cfd4 with SMTP id 5b1f17b1804b1-42be48faa4emr19435215e9.33.1725133243464;
        Sat, 31 Aug 2024 12:40:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:48d1:4cac:fd8a:956c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df936dsm84597655e9.28.2024.08.31.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 12:40:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing fixes for v6.11-rc6
Date: Sat, 31 Aug 2024 21:40:38 +0200
Message-ID: <20240831194038.557316-1-brgl@bgdev.pl>
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

Please pull the following follow-up fix for the power sequencing
subsystem. It turned out the previous fix for this driver was incomplete
and broke the WLAN support on some platforms. This addresses the issue.

Thanks,
Bartosz

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc6

for you to fetch changes up to d8b762070c3fde224f8b9ea3cf59bc41a5a3eb57:

  power: sequencing: qcom-wcn: set the wlan-enable GPIO to output (2024-08-31 21:32:19 +0200)

----------------------------------------------------------------
power sequencing fixes for v6.11-rc6

- set the direction of the wlan-enable GPIO to output after requesting
  it as-is

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: qcom-wcn: set the wlan-enable GPIO to output

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 7 +++++++
 1 file changed, 7 insertions(+)


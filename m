Return-Path: <linux-pm+bounces-3686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89084F549
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 13:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE262861BF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08D3717B;
	Fri,  9 Feb 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BecCwYMF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162AD2562E
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482303; cv=none; b=Dx9sAXNiqvC4vQfW0Kl/cyKPwf0ixsFz9qA2DJSA09BgBa1I8RAjP+qwU+KMyu2XTxIuDXbYFxELqSQQBblhEwLUIA/WKVSA+f5S8v3Mq0fCjkKFDdxVYu23firDVeU7A58dy0rip/JgvAFjmcY6WqmbMK6IOJ/LXQZo1EaSxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482303; c=relaxed/simple;
	bh=GOG2nYkdteZmrYFmgXB4/gat7JRNJKSRHb98MEiJKEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OSJT3EAis9tp7bXykQ/Ya4DIwzcOHxGxbRNxWltFoE6W5HgLqlWMTcPUplPOrecCWo2JxT41GAo6sj1WhyKDaiIgrnD+M2pfn4Jc4c9oQwYWHSUZUX0ghyHx5m3nxNJaM4Iyvasu70MpXtuN6WziNQzg1ZBnJG3D9RUAzKwp7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BecCwYMF; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-511570b2f49so1711798e87.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707482300; x=1708087100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hghv8RWEYkqbKHu78uG/hy1eRvJ/3D3s/lXXGyndttA=;
        b=BecCwYMFp/nU7i6fbQReJupj+zlc53hDvvV/jchq8/6IlFoP4ZQzSAXvN5wxrcn57o
         A9WQ2dl9vWhlpOOnKPwhUoSQOXePQFGpUf30406Qqtc1aEFclQLi88AwsxaM1NF/5Gbk
         a9NDElZP73X7vAejhFqtEHD7xkGJWXKrVJKcWidrkmTGliBPGtLS7CuQIev0Bn38amOi
         IoPFyuLAGnEyoDsvUgbKh6+E/joL59O+BXmnZ88eZ7Xu+vv4D+LGZpe9qn35O3zbRzQj
         iWtovpaf3NKoJVXDUOVQQY9trckOBI6KGnTExW7aTteyiwcWVzaQIuAQi8fYdz/d2DFM
         BR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707482300; x=1708087100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hghv8RWEYkqbKHu78uG/hy1eRvJ/3D3s/lXXGyndttA=;
        b=IiitP/73uTUlo8CfZvEq0ySZJqLdvZQCsfiI2Qx8zDKhcWOaQtYkJjVCiS6cCqSiUR
         R5EjMPFSv95vLRF9j32YrUj5XcYO33BvbYGQ87bqWaLBaSI/RS2PUXzlT4U1m0pruIDC
         qm+0g2KKdNbxH2+mPMbDJeBKzp0Xege9DoOlcfXr5Q9iNCwZrO0sD+6AqNVeakOXmaVv
         pJFECt1huf2sxJhPX/osPCqascotJxMQqXv1dgR4HaxCjQh6tspjDgV0XgL3S+oTKz7s
         hbUhDhQbJaUxk3PJy5YTGqqavL+zx86/WF2DGcF/+LRB9tWuAMAFTu1upxDsCQbNAX2S
         6cFg==
X-Forwarded-Encrypted: i=1; AJvYcCUsltzjnApMkiIZedhWHoGKRd5AyFTkaxZ7SvPx/EKApwe2aIdZ/e5G2ax/g9uklax57o2coiD5QKZgr2hJ83kObvNkhVhPM0o=
X-Gm-Message-State: AOJu0YwYwdnAybabyMVrV281QCp5taqAlGgmTX1QixGAvka9iIZckV7/
	rhKXHK/GxX8iMHJEeCV0rNdElWrLNzoojvhIvLqmnu1cBjizZu552v8pZS+90FNHwn77fHCW7VB
	/v+EhxA==
X-Google-Smtp-Source: AGHT+IGZudZDTLHp+qB3cOxqsoefbel6LC6I+qqYoO2My+iVVsqp2CiJNN2e+z//txr1Iqydgdpc4A==
X-Received: by 2002:ac2:42c8:0:b0:50e:7f5c:6c7f with SMTP id n8-20020ac242c8000000b0050e7f5c6c7fmr383546lfl.17.1707482300163;
        Fri, 09 Feb 2024 04:38:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaR60Bb84kVpqdQmukVCkxZMvERJtgiJ0RPe5wiborHnTCG7v18+VuApA52AE09iQXaWaRZ66BZUe7b2cs/Fp9G+Qxk68FizHWupI0ghecHByec/SY12V5AYDrBXlRt3PZxEbpWetgjdomR3568/LF0RP89CJz4zTFqXRXZn/mWkTdQVwHSREFVDwVUQ==
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id f20-20020a0565123b1400b0051176549047sm216864lfv.32.2024.02.09.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:38:19 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.8-rc4
Date: Fri,  9 Feb 2024 13:38:18 +0100
Message-Id: <20240209123818.768037-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes for v6.8-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc1

for you to fetch changes up to c41336f4d69057cbf88fed47951379b384540df5:

  pmdomain: mediatek: fix race conditions with genpd (2024-01-23 13:19:15 +0100)

----------------------------------------------------------------
Core:
 - Move the unused cleanup to a _sync initcall

Providers:
 - mediatek: Fix race conditions at probe/remove with genpd
 - renesas: r8a77980-sysc: CR7 must be always on

----------------------------------------------------------------
Eugen Hristev (1):
      pmdomain: mediatek: fix race conditions with genpd

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Konrad Dybcio (1):
      pmdomain: core: Move the unused cleanup to a _sync initcall

 drivers/pmdomain/core.c                    |  2 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 15 +++++++--------
 drivers/pmdomain/renesas/r8a77980-sysc.c   |  3 ++-
 3 files changed, 10 insertions(+), 10 deletions(-)


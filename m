Return-Path: <linux-pm+bounces-29817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468DAED547
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 09:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489F416FBDC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370020D4E1;
	Mon, 30 Jun 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bA5XElZ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408F1514E4
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267482; cv=none; b=msNyanVcI1GEPZjzOtE5sf+xSmkp7+TkW/QuM0BSW8FtVzXRRxYKC8Y4UPTW12tsdm5wAnMFwtsAfcxF936np4BY9f+avvb7BfdirfqNkY8rA7wl1oJqkhHTYFq65GxEKVj98AkD72CfoTRpMD9pbIvcs4Ag/RLo95D/Qw867J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267482; c=relaxed/simple;
	bh=BbncrQR33gGTRQBqxnEXDNwRGG/SDwVRLRNPyxR0KV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnfsixsdiJov9sDyTWGU+G7d8ECdaJxNhX4Bj9w8xEueYl0inGcKL2cnCu3Opo87jG8LCGPSzeAgvS6WCjjlGtT6bdBWTf2Qkpfp2TbPUAKRPBhfYsfmvHCvxWnVH+I4n8mgvipHqwTYjw0qywaXgMFosqgGw7/39rbmP1hSIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bA5XElZ3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4537deebb01so7979035e9.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751267479; x=1751872279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M33IweNKB23NoNM33aEFltvshX1Eakka7go5CXq6iQ=;
        b=bA5XElZ3m0oMh5IuOdlH3O2a7rjarrGAbkbNrOlqdzzUVAwctLK2lkZb89fN0uwU/b
         jdTwzQJ+NjWeFOLsF9vxtipMGQC/6UVTYDN8tb+NsFdzw+bhW37ZpmNfThi+nkEfoJL/
         Fc13NAnjDreKGAjbYzFwOdwGLrStlZu0eeVPmi4JxT8bSoC2CYCazveLyGjKsK/drgYZ
         pWGw85AscU6RlbOkQ2fP+xrDBvbIbXivklI6mIvvzLxmDxG9Mg0SOQfupIV0TOuAL6nw
         YRkkFy/EotCqx8qS2MlBBKRUmD5B/7CNCoLS6LTd6RAdKiliOOTnngTGilYZv+RZ0Xyg
         1PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267479; x=1751872279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M33IweNKB23NoNM33aEFltvshX1Eakka7go5CXq6iQ=;
        b=AzQAINa+RvaT2mpNywjRcs8IaddQnDvNbDeC8VIpyhhAOLctQrkOkn4AjWBhFgkqLs
         G1H5IEW8VbeGMIFv3zcecZowq5V3B5EQ7ZjyGHZ+klHkYbVystJZUe3XnOcVE60RQwZJ
         WY1A42X1sn/EG4jwjKvq5DGPaHOR0GpVrHQRy8gLXmwk0/Ch8kONIWIvZj8B6EBN02N0
         sJ6rpoLan39/EIIXauBTzESUED0vMQKNzsUTzSWONk7jjmQYe2Y+JZ0q+r0GYRWpXgDS
         lNIz38qQ/BzvCxtWt3ahYh2vIMD+40XxYmXPjJ8m7hOwUEROZC9Fbc1Md5ak9P6r2Jp1
         D+dg==
X-Forwarded-Encrypted: i=1; AJvYcCXPRIsQTbpWPVZTF8vgLEv7cd8tMXeVnbpwcK3NuQG2UHPKCYbfDatJjZHH5xygP2X+5c6DlNBP+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpmmn6QPsE8b1Sn8kGcTFTlPeKEVrPMB2Rv97w7Z7OKG9U1XUi
	H9qlK2Y4hLVijW9dhPXDAZvP1sR7U8QRYuywdPdF0Ul6RQZ3x1ndIiKzeK6Y3Mlj4hg=
X-Gm-Gg: ASbGnct7Qc2HynMEpr7oVZQhTFtMbqyejLtTQVrp4BMPwFprbRx+Eq6ksjeIwv9moV7
	fnQDKK+dzagkQThzgbgjYMgsQZrJgsclLGdjwa3lrOvEUPpMO5P32MEakJMDtvnF7Pmx7o0oYVg
	cHPGou6rAP6gCB2Ist6wa5iUPEeNPcGDrrEIuBHrz8MA+qx63+kVtF/XGrfRLiRSmiXsz3Vy/Ep
	vgEDgnKZOoMO5XRjYDgJZNF5IZn+9uc18uGQvHzOwdqA6ORhLm2ZwEFI7b1eMCY3Qa1I2tw9/ij
	pyOvPp3W91+dIAXsSGBW+foPUJ6etfTQ53Mj8IRBrMR4HcwoWKLAFkmgnBkpNbE=
X-Google-Smtp-Source: AGHT+IG/R7CC+U7ZRabx/kXZa5HP+oumZGvsCP9NRHqQD9Rwf30kvmvGtsy7NTEikbNMBjYRtI/+qA==
X-Received: by 2002:a05:600c:1389:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4539b3f67c8mr54429725e9.16.1751267478977;
        Mon, 30 Jun 2025 00:11:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:19e3:6e9c:f7cd:ff6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c5fasm157989535e9.8.2025.06.30.00.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:11:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] pwrseq: replace magic numbers with defines for match() return values
Date: Mon, 30 Jun 2025 09:11:17 +0200
Message-ID: <175126743944.9502.1874026392338721581.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 24 Jun 2025 16:32:17 +0200, Bartosz Golaszewski wrote:
> We currently use 0 or 1 as magic numbers returned from the match()
> callback. It's more readable to replace them with proper defines whose
> names indicate the meaning. While at it: fix a build issue with the
> thead-gpu driver I noticed and extend build coverage for the drivers.
> 
> 

Applied with commit subjects tweaked to say "power: sequencing: ...", thanks!

[1/5] pwrseq: thead-gpu: add missing header
      https://git.kernel.org/brgl/linux/c/5bcfc4ef40dabcd16a0b736fea7f0d00a9efdbfb
[2/5] pwrseq: extend build coverage for pwrseq drivers with COMPILE_TEST=y
      https://git.kernel.org/brgl/linux/c/1a7312b93ab023f68b48a1550049a4f850c2c808
[3/5] pwrseq: add defines for return values of the match() callback
      https://git.kernel.org/brgl/linux/c/62b5848f73dd4f8ae17304dae54562d0c9ecdd3d
[4/5] pwrseq: qcom-wcn: use new defines for match() return values
      https://git.kernel.org/brgl/linux/c/f698155029efc708349126c8944fa8c95b28098c
[5/5] pwrseq: thead-gpu: use new defines for match() return values
      https://git.kernel.org/brgl/linux/c/385b735c90ae44dbde65fab76e356a96ff8f67be

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


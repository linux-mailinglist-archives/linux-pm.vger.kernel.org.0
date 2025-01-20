Return-Path: <linux-pm+bounces-20661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292AA165C0
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 04:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8F7A037C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D4145A18;
	Mon, 20 Jan 2025 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZH6mue2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950507E1
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344423; cv=none; b=CbLFEZ9D3zLk7zpajt7YayV7Oq2Uv6DCHNhSiGzaL/9sKKKL80JnW4MwvP14S+RDErc3sBb6fspUockWqayqRO33/xH+0eV4cC8+HtYxIkamntE081qLRJRpdqrty9tuEnq62h1ZBkDOj3imSRXy+2J688hlon2/GjhZ/BxxvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344423; c=relaxed/simple;
	bh=PD/dmYJW5/pc5YILLXGBHgfou0/1pWskfn6yPO3ItLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hvhaHoG3DV4ElenDJLtDTUxgmZKaUi0AOYGtgEmnwQ+8HhYz0OHtbkN5X9ozghv3Dh6N6s8dtjclz4oIgv1ybigVewNhtx7aItCIT8holVb8baBMOfHgl221CG/LZjZ88XL55peMHH16we3v8PnOUoahWXuKr4UyMdxIu0ii/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZH6mue2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso50801895ad.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737344421; x=1737949221; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORmdz2VVQXdOn8jx/g5Ql7pCOzGrbDNsTQkd6QjE4Xw=;
        b=NZH6mue2K15XEIMDqD314h3zUpsyya2jNQJlwOeIDSu01/n8eUCFQjPv7vuWHe0G4t
         tUOMvy61zdmmWT9LItT4CjAMg9FR19Eh9dICSInk2St9cZuATrcqw5kfZPCKBqvB2FDy
         HcMsm5vdQ6jUGjDdgPEt7H+jk8o8tSk+TAoyoQncD3b/9/4Llc21o0LgYaoSLyY5BijK
         0uAc5K/ZUOVfmak5bbL7xOZ6VLZDpRN5+h4eeB/iGqRg7kquFKv7hJSbqU7+pLrI+iig
         2yCQOeeJs3KkGI9+Obsx7hyGqdsAot+1z0rs9yqMZT20BhRtVwPgAHzgvE3jFa9TcqpF
         uh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737344421; x=1737949221;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORmdz2VVQXdOn8jx/g5Ql7pCOzGrbDNsTQkd6QjE4Xw=;
        b=lhCvmATfXIfv2AF/HgNof0lvrOqyafarEMTV2HRdfFPGAS/8xvs0j7j4ZD+znxH0o+
         Dy3iZmpGE9A6I+4OQrHM1EJtdLiBxhsG1o4UIMktwtPGY/+nhPs6sjCdB97SnUTlfsio
         2d+RjhmDeaiO/CnnoHMU4wvRucghYq9mGrH3xQG9enLZN+25SNcvEcocmRCmDQsg4t7v
         rtnxA2tVdGz2Q7fPOJ/VGzUFUOJhyaT8YgwjDro22CMCSBqo28g3qJhu5tdCDSkyW1JS
         NvXnkWK35NUEMnJ77MWU4X33c397rKJ/LVhPMWxKCT6VlWZMi7lCzcQ+ulF09lHy38Bg
         sTPQ==
X-Gm-Message-State: AOJu0YwlQrAEKx/PzJI8VSsPX98Yog49lD0a+KVVO86c+hr5dArvZx7a
	vdyu5N0UulUgxaBQbZ+hY+0iAKg+3b/lGi8gaRyC3qX2G1UqoyZ22/OZCiICMIXnMNIlRaSrtrQ
	a
X-Gm-Gg: ASbGncuLtjuxzRtycjQFTwwtna6CtifAPht+K0m+fTF+dksWGG8fr9oedObKjZFh8BT
	GRu+LE+G75+VSmMLIzHiHk2J6HJ8gCRytc49YooZ5VWXVeAnikDyOxPaHd2PcKZoaUEuM1+NDhF
	PdqnBs1kYL5LXNwQp3Ewh2M/X1ImbtZndnh38wh0OX4uupwUZhtKaXN+oXNHxtK6kmYjRZ/Msx8
	YsCyAQgNWfFtBxxA+LdKLQaCY85SDXqSzed61sE7dfcwZ/6S2Jra+EUNdF2iFcuz1VT0eB3
X-Google-Smtp-Source: AGHT+IHmheyI6XP9PeZO9Ti+853cNznD1Rfeus640tnMRoHp5Ezb9ZKSdtep2XTQ0QlBDnkNRZlT2A==
X-Received: by 2002:a17:903:244c:b0:216:2426:767f with SMTP id d9443c01a7336-21c35618c3bmr179494615ad.49.1737344420904;
        Sun, 19 Jan 2025 19:40:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4027fcsm50944455ad.214.2025.01.19.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 19:40:20 -0800 (PST)
Date: Mon, 20 Jan 2025 09:10:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.14
Message-ID: <20250120034018.ay5j3xsb3747zezc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.14

for you to fetch changes up to b489e7946656ed67fea1a30f5103eb62a8686e04:

  PM / OPP: Add reference counting helpers for Rust implementation (2025-01-20 09:05:51 +0530)

----------------------------------------------------------------
OPP Updates for 6.14

- Minor cleanups / fixes (Dan Carpenter, Neil Armstrong, and Joe
  Hattori).

- Implement dev_pm_opp_get_bw (Neil Armstrong).

- Expose reference counting helpers  (Viresh Kumar).

----------------------------------------------------------------
Dan Carpenter (1):
      opp: core: Fix off by one in dev_pm_opp_get_bw()

Joe Hattori (1):
      OPP: OF: Fix an OF node leak in _opp_add_static_v2()

Neil Armstrong (3):
      opp: core: implement dev_pm_opp_get_bw
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

Viresh Kumar (1):
      PM / OPP: Add reference counting helpers for Rust implementation

 drivers/opp/core.c     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/opp/of.c       |  4 +++-
 drivers/opp/opp.h      |  1 -
 include/linux/pm_opp.h | 13 +++++++++++++
 4 files changed, 93 insertions(+), 24 deletions(-)

-- 
viresh


Return-Path: <linux-pm+bounces-7933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB28C84EE
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1595281086
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B828134BF;
	Fri, 17 May 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7gBPE0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF9282FB
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942087; cv=none; b=mItkmO5vqVNSVV08uzIBFzLAvhBW760KvthLDfa7UG0owD58NqQK58tP4T0SYW0FGVqOd5bvB0oQ5JJiQI5ZyyxZLDTYcVrAB89nvKfbq6AGDZ7rawzJO0B9WrWlzjKwFB3uQazuyL6ftED2J2qgF+Kq7C9UVUaFdD6qmUE3xI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942087; c=relaxed/simple;
	bh=DC1JfrU+y0WCfid8J6lB6psRFxQrSNp2hUjCgZuzkHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLEl4PnS9OeQKsui8Kv1UGYHcQ1sKacu44dcXLbXihY4cgatepsElNpfiZUxYPyKiFVqP9eesXSOuq8dX5N9NVEsUjRmNAX0V6Fqx0fAupuvOTIId9OUzd2Q46yZmmgtg70mnsgHBv8KXWguYNgGvJOCV+QHY2ckOcvWmpk8Zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7gBPE0E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c448b44aso446997266b.2
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715942084; x=1716546884; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74OCuFSfJYPZklSbssiMGFodlyWfsiRW9fSWN1NjjPs=;
        b=d7gBPE0EiYwedqpQpwBmS6TtxDlAp5zVM6bfyAVdgl73ddjqugmrFhWijAs6vlxMKU
         A57UCDHym4wtzGIHiG6ZxnbNLjpniJ9ek5eiIBseqsovzcc5aY4F1HlQ8iH5dCEa/A5/
         cOazj/cmDiyr6UQtqDF7A8PwbipXavA7dfiqDrAKdwO9QZ8WZ87dVsUuCUUx/5nBsplz
         q357oj2W5iywWnOYn/e96Lckm3BvFE8KuDHwLVU4TtcsHU81RPK7lnG4wsMM0YahXcjD
         0Rhi28zR8ocS0FSSZRHMXGWpAxYkGYhJI/ATbbvaEd8DvWS54DLdpDX8+AUd/HTvW4xs
         tE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715942084; x=1716546884;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74OCuFSfJYPZklSbssiMGFodlyWfsiRW9fSWN1NjjPs=;
        b=clXUSdic6Ye1rtvAkCsNnTmZReeCZZujsLYghd8TDahKyZM1r8F4olVFOlTMnDlcin
         MiOjkMG8PyMmV/DSuvYwP2et5cHXVFHwmWYCvVkMizeFjfJalgUYCOzFBHyXCLvNPS9f
         NshU3MlLs8tRELWhHxmUtNUT1uL7jVVYcj7d1JaW2k8W8D1g2q0u833WycyVKcSyn5yx
         TwsQgH5scvHaobbMXnVL2/7FqtQNFCqLFYvzLXl/U15vnvc1ej722ITNh9V1gyY6e8al
         3NqAMQTzCe8GdqXg5AgbV477CckU3t8xfLa6Jo3dP+kfvhO+emnYu2d5R11zlqLlIJLL
         zsgg==
X-Gm-Message-State: AOJu0Yye0N2x4VvHnwgql3Sub83uxw5TGr0ByxIlbQN9MMCH3P9DCWL5
	ix/1f07cYnKISht9BlNzv1d7UcUuST4mHT5WRWFGGP8A1jXVO3qY8RcZm3vuxJQ=
X-Google-Smtp-Source: AGHT+IH8a8wKS7WPfuCevEnGME0SzYbiJBZJriC9fhug3tEWZ9vpStUbsuM0KAIOBNhbS2yrMf9ENg==
X-Received: by 2002:a17:906:aad1:b0:a59:c23d:85d2 with SMTP id a640c23a62f3a-a5a2d66b4b8mr1358225566b.55.1715942083756;
        Fri, 17 May 2024 03:34:43 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17fdesm1104290466b.220.2024.05.17.03.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:34:43 -0700 (PDT)
Date: Fri, 17 May 2024 12:34:40 +0200
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] OPP updates for 6.10
Message-ID: <20240517103440.p7tlrthhy4mc6n6o@viresh-thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.10

for you to fetch changes up to 2a56c462fe5a2ee61d38e2d7b772bee56115a00c:

  OPP: Fix required_opp_tables for multiple genpds using same table (2024-05-17 12:22:46 +0200)

----------------------------------------------------------------
OPP Updates for 6.10

- Fix required_opp_tables for multiple genpds using same table (Viresh
  Kumar).

----------------------------------------------------------------
Viresh Kumar (1):
      OPP: Fix required_opp_tables for multiple genpds using same table

 drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
 drivers/pmdomain/core.c   | 10 ++++++++++
 include/linux/pm_domain.h |  6 ++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

--
Viresh


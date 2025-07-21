Return-Path: <linux-pm+bounces-31164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C594AB0BE13
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069C416CCF2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D427E7EA;
	Mon, 21 Jul 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTdPWLAJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065A222590
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084303; cv=none; b=Ibh1OJgJU1ZXB1VpPIh95VuuN3BDAws87BrmmEJfkvZj+0sWbILvV+5LO4Z4sMgLIA6E17qqDi/pkHXP3eaavBAfDwikTaZtc+5WT9LhN0pp3mD19S04L33MyWr48ixOO39p3d0mn/Jz+PG0DY71/vLz3zmUfrv111zq+8AF4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084303; c=relaxed/simple;
	bh=SrUQl87aZKxSh0dAXh2+sDFrxOOShdJN4rPLufysdGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r4VXI7nSiY9CszGRy4ZRFtSYhUUDRvCMxlD+t2dR3jDfKy8q+Rxw610+q+3wrOfaiIfMMnyd5z3mFqTE5uRKHrMhu8CVInytcpIF1g0e1+D+FVd3h1dUKTvtr+Q5lnz28UOvAqxCd+gehl9H4AeBUmOmeE+aPZRiJVFXOR8jgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTdPWLAJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23dea2e01e4so45068165ad.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753084301; x=1753689101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQTZnJ3U7H+zfeb/LvM6Xjc4gElcQShTdjYcut1qMmA=;
        b=RTdPWLAJamEm3B2tCYN42sSc+Lq1o0KzzYDEjQjvnuRlEDJhKZvxtLdYHZXhBkVSad
         8NRpho4i3JskymOVbYItuEkSjBq/tWFzw6KDlStTgjOlaGdQgximJKhBO4mt1gYU082I
         keX4USk8wofUI461bqmLUurFFfl/xQJYOdltyV/S+dquM2MTRvxO8G1oCztFnQKiauvQ
         2U3G0kc6fXFnHPrp7cJjaSXBysbms1D2YPjK1XkHJgous0w6jGCgWTCP3Y7a8zWLf5Ge
         M9Xb/ppPJn8DgED9XZm1PJwVc7zZKZ7SZqkHgUJcGSPOMwQwIV2JCxZziF2xHUrL6eQh
         BwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084301; x=1753689101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQTZnJ3U7H+zfeb/LvM6Xjc4gElcQShTdjYcut1qMmA=;
        b=WEHKGMRKZnBz2WbL/P2zpX6Z/fpLPXlIb5Kb/RB406ipIn+xfUuTuiOiChPjrcdSfF
         FUBCbNdVzmWeqK8YQikq23bCh1WtwsrD4lpqMZRG5p+zTqgEcl6573JritiZha4b2sM/
         jCINb4LJUCJ3D6MshVRFYzfXUqCaG95iEOZAnj6shEj6AdhMsOX+Jh1fVveSaXyv89Jp
         Z7e0803zZeujfuUWdw65jMQdP+WWgP0eBHF2rY/XwcNMdarOrG4Ze+5euKeiAaFgg+P2
         0PWDgsDqOLXYwjR/UBgZwJeJnQzFnsTCo6ksj1UnM5AMkexZ5XIUmUOAaToOJWTDe5Mu
         mQhQ==
X-Gm-Message-State: AOJu0YzlbytYkadxjbyTN2WK19DCdOiTuAYw1Y7HcCm2GUREBkw9mHSR
	U7AhRPUhEYI5JARW0qycXtSmL7i1FC5PKMgna5QA2pMDPpxpQ8/HrzX6R5ZUytu0yOk=
X-Gm-Gg: ASbGncs0qEJ8CNJbrJ30PEROi6kuDu2afA6Xw7Bn8RfJ4wR8oFiBrdnEIrWXeQyVdRw
	HZM1yfEos00gHXTV5l4aDVewbt3kFsGk9UaNf60U/J3SYVx5vocE/D2sglH16QHV8wu8vnXSiga
	/vlHlpTFZDRibPYHbxSMp5964UmTvKZZHzHh5NaH2RPcXJOXBX7d3YKyNcuIPyTYV/bZYbIhTtr
	zvN9gxhArpuD4XnrTlVdmuJiqD1XF5+i5Cq93FVh5YEN/8hT/EopXDo8Pw9UHb5quUhjNGcXBRp
	kkrRtViv1/FFhwelLI8e8TUF3pFoRAgSE0NJS6ItP3ZQGU6Q2+c1JG3qJcBzn0ULqZ83lYGSUaB
	Wbubr7exTz/h/ga4KBbbUb7Q=
X-Google-Smtp-Source: AGHT+IEnnQRGDjf7a1MZOGC9nf6ZpHFSvaRU1V7qiDf/z20pDtUnwwasfCCubXExlhpk/OnpIE/F/w==
X-Received: by 2002:a17:903:1aeb:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23e2572af07mr261937665ad.30.1753084301133;
        Mon, 21 Jul 2025 00:51:41 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2e69sm52267145ad.172.2025.07.21.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:51:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:21:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.17
Message-ID: <20250721075138.nibnp2nje6vlcdq5@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.17

for you to fetch changes up to 22679d807dea5c065d8019acfce48f20e87ba5ca:

  rust: opp: use c_* types via kernel prelude (2025-06-23 09:52:45 +0530)

----------------------------------------------------------------
OPP Updates for 6.17

- Minor cleanup in Rust bindings (Abhinav Ananthu).

----------------------------------------------------------------
Abhinav Ananthu (1):
      rust: opp: use c_* types via kernel prelude

 rust/kernel/opp.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
viresh


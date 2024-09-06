Return-Path: <linux-pm+bounces-13748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2096E988
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D6E283D19
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525283A18;
	Fri,  6 Sep 2024 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKwPSra9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A157149C57
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601971; cv=none; b=I+Fjdbxjn5WWYHKS9h7RCQ2y6+5BCtp7yJ9u944YYHt98EPMgvODm54AqZJgYas2wh/2NqvhA4pEuPXzW/h6ANSi9DiR+AS7/Fw1O92tKIgHqHN7k7flmWQwqHcOG7vx4IbwFDQQIaibS1T7S2Os68Mum/EdNjP64oRVRchPW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601971; c=relaxed/simple;
	bh=2LeFfIr0V/GAa7FmKHakFp2lIemkgHOY/07KaYi76ts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SniZiAGhwCY9Ut4rd2EWHRPPdyOgHPu9Ri5p3Si2ihBwdZFc4tXQH4ZG5ITyOdocQAFe+IqXERk0j2PhRrslk0va/4yOvirv2pBsBn4RzF8MPTxnb8ugPuOrWzP4EfaB2veSTBKie9jKU/kWRFSwVi35mlo4gK7SwedwPa7F/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKwPSra9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7142e002aceso1271533b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725601969; x=1726206769; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQyUJ9NmXgjbubW/PtM4pxEpllQ88MMQGruKTuribv4=;
        b=aKwPSra9Dd7GS7ch8uJEuflgbEc6+e5yepnfJdrZ2iLhW/B2ic51jmdJ7ljUcfISEH
         gjheMQnXksncGYjuoSO0P9M54IAuaJgD4CvYTyNOCmE/BhBh2pg7CYsrpXNiq8MFm64i
         ciIwd4gN8dAtJmGDR7Z2Q56SE/J3OfohPqY8NPOUI1mKThqUILlTtFsADzdfRkx2+4xd
         OdTyIN6haW/ex/if1ls3C8dBImsU9+62xS7jeAMfdlVWpgs6x3ugId85PCYP/c6o5vC9
         4yYgQdsHo6hzdUnLfATXqhTVP9+qNlju2AD7gV72ctk/e6caC0yYJ+CDyXanDiRF+suL
         9m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725601969; x=1726206769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQyUJ9NmXgjbubW/PtM4pxEpllQ88MMQGruKTuribv4=;
        b=wd7/conIxRaKtwD/BXkGNJ9sxU9K5mxGt/yHx3t+Q4mN8gSf/8+q2CC0pk+OBfSvmU
         XW/ZyF9dw6f7CEAnFX+op1r15nMorhZnH0PRL+hyOsZcn/97D0jlu0dh0Bpi1j2hHVsM
         NMKtJTGgIQRmBrB/IE/+G42KtVKXW/5oLRE6ztBjz80DZpM3AYRd3ERPQ4+VyyitCdJ9
         juqES7YhIfGMGyJZJ/7MqEP93ZsCQ+fD4sLrnytADJTJ05qf5gmqj0VZ9hfcW3jdaAK+
         6q2VBrvT+yUftACUoibcodQRkUEvTUBe1l4vKaQ3J0rQMYEYnmRFJUgUkZ2zlCMwtIbZ
         LS7Q==
X-Gm-Message-State: AOJu0YytAfY7Iqsqmp/Dlk+BYbR6uOd9J0iOXxPtwAgv1jB9HH4WuMEB
	YjNnLzllPtI2ou8QyUjyQ6TneN/IgeaisA1NxkVNVO1+7OfVH5ZCXJ04oPwTQa2thOYG5I0fco/
	E
X-Google-Smtp-Source: AGHT+IE7p63gmPCLnvKaf3jM6oY0sjwtGObn75k8DxZi6mP6+25DxjCH72EefKOsyhNCCgDyQxwRrg==
X-Received: by 2002:a05:6a20:2d22:b0:1ce:f2f2:71df with SMTP id adf61e73a8af0-1cf1d0599ccmr1559662637.3.1725601968735;
        Thu, 05 Sep 2024 22:52:48 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbff3c6dsm613398a91.3.2024.09.05.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:52:48 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:22:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.12
Message-ID: <20240906055246.exjgfkrqesllh45z@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.12

for you to fetch changes up to a84372012e9329daba8082efac98f3bc0b443aa2:

  dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers (2024-09-04 20:43:43 +0530)

----------------------------------------------------------------
OPP Updates for 6.12

- Update maintainers for operating-points-v2-ti-cpu file (Dhruva Gole).

- Drop unnecessary of_match_ptr() for TI driver (Rob Herring).

----------------------------------------------------------------
Dhruva Gole (1):
      dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers

Rob Herring (Arm) (1):
      opp: ti: Drop unnecessary of_match_ptr()

 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | 2 +-
 drivers/opp/ti-opp-supply.c                                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
viresh


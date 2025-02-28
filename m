Return-Path: <linux-pm+bounces-23202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50388A4A4D5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E303AD6CC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65E1CCB40;
	Fri, 28 Feb 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqDwF/66"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C11CAA82;
	Fri, 28 Feb 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777437; cv=none; b=FFp9+nQRCCgGMDcJkOxAcPKUMasyCP1VC1XC9PBBr/BbHuYAtGsstpZGXExaM91vQezj/iRTx0J9VTtyZOwaS5qbPueuLkIf4NY1mc8PxLDOSdDjuBPJd95qBYmW1StVYhMsv225WWY1FSZS9S0DLOmIk6ulIRMqNPOZXLfsI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777437; c=relaxed/simple;
	bh=3JWDbAnPR6V8hpdBs7sUzDU3GCxn9zBstWzrQdBYl+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NexZET+3rEvZRM60ytDO3n1hTHjyvLeH5YCm+tLbWBCFGLiLx5VPFZPMmP271OGALqLvmAlxii1QZgijOoVJmEqHNxmUhg6SmdSIRXX3s82S8Ij8G8Iajlh7PNUJXIOY3+47Pm0dGnPw7TGz0FQb1syyJ3bNMVzystpgInqJtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqDwF/66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6751C4CEE2;
	Fri, 28 Feb 2025 21:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777436;
	bh=3JWDbAnPR6V8hpdBs7sUzDU3GCxn9zBstWzrQdBYl+8=;
	h=From:Date:Subject:To:Cc:From;
	b=cqDwF/66N4MW2RfwnL5j213/mBR5wp3/EPiQL0cwX7/+KmB+gyjdk3wIwHztIiDp6
	 OzZp8G1NLUd1lx/bP6TmANPXJ/3sx00hZYh+sKWJLkYrf8gbufNiRJEAHPFIpoDZDo
	 9WzU9YkkLr7HPKw7hALDrI9Z6dMmnCOABlwB9M4Ui6cxd3NQi3QbURE8gja+cjASBl
	 p1pBoM6wIy+NspaKWRsKh3y/6ANThk72cbim9pM21nnqb6RgpFKKD6JVPGBt6+aGon
	 K3iSde3aDmJ7gxl16lncqGSov2QSk7pUD+fb20VGe4A6uFKlzwfFHnBr1KdyIa0OMh
	 KBEi5rNFtCFUA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fea43da18aso676051eaf.1;
        Fri, 28 Feb 2025 13:17:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUX2f/KaDWGRxfhR4V4gg6HUFgMZ8J2XLtDc8Akqdu0YdePPmi0ETp6WvxfAAZ+uOwOgu4YXMgcoe9/EhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/q3SNtJV3Saqm+/8WmPrCGXIfI294ujq+zTU0jubaQKlxTVrA
	ruy+Q/+bPZsnSSZRwb2kvXJYFCA4AqX2o4kukfynaUdj+EBAn4ci/4ZPzT/RiMMCA28Uecl1P/V
	H/4/5g/5dpr5eysHYu/q1Hfmuk/I=
X-Google-Smtp-Source: AGHT+IHTPJfpgvJ+sdQYK/AJoOmr8565qG+FIA2T1ntgbt6pLUhGQonYcJP+Yw0f6yVC/xfEdBq8K+sYtnhkImaChXo=
X-Received: by 2002:a05:6808:1898:b0:3f3:fb4e:f5b6 with SMTP id
 5614622812f47-3f55851bd5dmr2843536b6e.15.1740777436086; Fri, 28 Feb 2025
 13:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Feb 2025 22:17:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4D=-gGWPaVSFBAYinRpobVeX0owRX70jZ0vaS8V9pLg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqj7yDVTu2NUJtKTY6iIWACsjuJkBnbTenb3rnN7MVe-lNhr6JPgp6cT-w
Message-ID: <CAJZ5v0h4D=-gGWPaVSFBAYinRpobVeX0owRX70jZ0vaS8V9pLg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.14-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.14-rc5

with top-most commit 0cde378a10c1cbfaa8dd2b89672d42f36c2809c3

 thermal: gov_power_allocator: Update total_weight on bind and cdev updates

on top of commit 0ad2507d5d93f39619fc42372c347d6006b64319

 Linux 6.14-rc3

to receive thermal control fixes for 6.14-rc5.

These fix the processing of DT thermal properties and the Power
Allocator thermal governor:

 - Fix parsing cooling-maps in DT for trip points with more than one
   cooling device (Rafael Wysocki).

 - Fix granted_power computation in the Power Allocator thermal
   governor and make it update total_weight on configuration changes
   after the thermal zone has been registered (Yu-Che Cheng).

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal/of: Fix cdev lookup in thermal_of_should_bind()

Yu-Che Cheng (2):
      thermal: gov_power_allocator: Fix incorrect calculation in
divvy_up_power()
      thermal: gov_power_allocator: Update total_weight on bind and cdev updates

---------------

 drivers/thermal/gov_power_allocator.c | 32 +++++++++++++++-------
 drivers/thermal/thermal_of.c          | 50 ++++++++++++++++++++---------------
 2 files changed, 52 insertions(+), 30 deletions(-)


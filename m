Return-Path: <linux-pm+bounces-40544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDBD0ADD5
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9FD301274F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB8320A1F;
	Fri,  9 Jan 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHVh2KDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED563305048
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972202; cv=none; b=VF0oG1Om+e2Wq5u6LVkpnMOXtABMLluPsjAsKBUTbhr1cQ417VY1zLAzGEn1cKLmLRKWxStvyScRzJO50k9FV1V4YD8aTE5aCMKntdb8RUe1pTHkBhqS2gQUqCdUizk6GOd0ThrdguDi90rTYqg0fTfpHBiPZmAT4HZw8BGv3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972202; c=relaxed/simple;
	bh=e5cpCTt5l7GxlefL3qEhiJEDRie6LIp3C2IWYfkghJc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H42VPdCCP/MgzgH/NIXu9s2tGFoMuW9Fq0gXIhvSEjagQFekErY60Sy3UwBtEWXcYgHdW/fmEn4DKoLaEvssmJq04XaWmW3rTF6akVPWp64XQZv+pSEwWbegxnT3+cAX0T9Ir9AAcB5u/Xeh19vIJB5MJXrpZUl/0h3FTlatHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHVh2KDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E3C19423
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972201;
	bh=e5cpCTt5l7GxlefL3qEhiJEDRie6LIp3C2IWYfkghJc=;
	h=From:Date:Subject:To:Cc:From;
	b=kHVh2KDSSdisAlFk0LT/uBtvUaxcQ+fduCR9wVv/Ia6dqz3H68/Gsr0IQfBPkbYS4
	 A4ue5SqhWwHmEIX7pkwffmi0GFcSmibf/xWzCm+iTYvNy01rEag8bqrmFAJKnyPmvS
	 pQjlIiOAANs+FzUMtoJCO+jP8wMLfa3eCszZvdL/so2jI/LHkr9XDbBp2cVh+lyUTc
	 AWyTKnp1mLklW0JLyTlbwlX3osqbO2bcY2iRsBFMJQIyIAgocqVycphFsZNgHM9gRl
	 654cAeujduHTyyw/Uy61MJ4Vm3xVfHGBoLjikY/s30BveckRZn8MqrbD+3FXCMbE4R
	 /dNU5QhJY1kSQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso2812193fac.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 07:23:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzksDDJ3+quPyGPODuzxPwIWOdm3Dxn4W6RP0nnZJiNBMGy3w/1
	TWYAtx1XtU9uI8B1TbjcdL3RiRsYMyYawm0b3uchql68sLwZUrmw9c20fry++PwjFDky9LBuf+b
	S793VNYmqQw6ug2SZZOuj5mz7BFz87VE=
X-Google-Smtp-Source: AGHT+IFj+/1n0+RgyyHNy03W+cFXI1Sdo50PIwjjeqgUWy3cbGITj9A51ujrbGXx4MOYqAikI4IGWfFSbXJyIDHlIWg=
X-Received: by 2002:a05:6870:168d:b0:3e0:9188:8f10 with SMTP id
 586e51a60fabf-3ffc065d825mr6202373fac.0.1767972200628; Fri, 09 Jan 2026
 07:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 16:23:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXqA+owjDVs+qZb8s4KddbxXda5_s59ito2YCJo-A_+A@mail.gmail.com>
X-Gm-Features: AQt7F2rOI5vUPpCJGlla2REoG-3ykJ0d0QIFfwgda4WdLsPPzT56N32jhKF836Y
Message-ID: <CAJZ5v0hXqA+owjDVs+qZb8s4KddbxXda5_s59ito2YCJo-A_+A@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.19-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc5

with top-most commit 7966cf0ebe32c981bfa3db252cb5fc3bb1bf2e77

 PM: hibernate: Fix crash when freeing invalid crypto compressor

on top of commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb

 Linux 6.19-rc4

to receive a power management fix for 6.19-rc5.

This fixes a crash in the hibernation image saving code that can be
triggered when the given compression algorithm is unavailable (Malaya
Kumar Rout).

Thanks!


---------------

Malaya Kumar Rout (1):
      PM: hibernate: Fix crash when freeing invalid crypto compressor

---------------

 kernel/power/swap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


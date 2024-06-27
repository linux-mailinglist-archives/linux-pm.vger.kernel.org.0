Return-Path: <linux-pm+bounces-10138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49E91AF80
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD4F1C21613
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92E19B3FD;
	Thu, 27 Jun 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZCYurfw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC81E4A4;
	Thu, 27 Jun 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515568; cv=none; b=GPH6yB7MUdkdGtQ85JenN2SeSyEtlVvcxNokbWruqbKmfM5wMKBJXneT0BYD2wfyPtDH/k8w7eo+FXY2kQst7nPf5RVaw2WFIB/J5OUdrzCsHZWXIWJqRzwSdemer1zKS3RVxlpUdkijaGMNRs5z2E+ECZffE+WPf7vWyQ8ftzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515568; c=relaxed/simple;
	bh=hVMQ5fiX+jqC1eZl0WVk1UD/3csmD4EnK4DextBs0MU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s0H69NFFrokTsYAB6ck1JRNugrBsrCaRAMJ4dspVokClCQRCMZhdV9wwLSfRlt7vj7eADrddUCkl0w2WYULqQ4eF3lSmHZ4hPw1WyX8PbV64wSB5gZBWVtmvSFB/j5uoPlWb0h2eV2UbPHBkTMVL3Kkzve+Nv9G3TDwgaawdm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZCYurfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACE8C4AF09;
	Thu, 27 Jun 2024 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515567;
	bh=hVMQ5fiX+jqC1eZl0WVk1UD/3csmD4EnK4DextBs0MU=;
	h=From:Date:Subject:To:Cc:From;
	b=qZCYurfwbEnjCy338Xo1re+x8bOIfo6vSzLHRh/0X8RTWQ1D50rM8M5qYK5g5zPzd
	 iTyY7JVSXVfdtiTrzGpndnpssRrqAnb0egkwfZUyOm4B0zKChUqbj+9JM9dNgbhzVF
	 LQe7wx+cntz+MM4gM1/2ia7jZ712T6bnyF5QGYBWpqEBbcI4Vt30KDWoq9xghU/wl6
	 vRg1nusAGKr5Vzw6NNhi65S1ZT6skSEwKxat6UyeA5GCAr5kqoOofhoCL/JxUaJ2xN
	 S85DE/Kqjh5lE3bAfh3gCnimyjg4XJkn9gm1T5fYWF/U+AQ+ptOYjCfM2/zMrDwiN1
	 wYgnfSyi2SV5A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c229104335so58203eaf.3;
        Thu, 27 Jun 2024 12:12:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+gxX4y2Xjv1itSV5HzkQC+Fup6HprFv3JC6Dh1dGLY7JXvIYv5z1LtJd/PPCJpwGOyAZZCfAubjwgJwmmgSOUa9YH6mAqqZcJLOVC
X-Gm-Message-State: AOJu0YziLViG8N8D6RYsMMsdD2qiGgiooA1FhXArglL5fjamfmaDMpUw
	EvdSJPfYbMPjPzPtju7WIJig1ExVqgp7DI13Lp4Haai/lh6GPqc646CQMt1WMzMDJBlIONIiGDQ
	ei/BZKqlg3ySmimfCcuJIrJZmQXs=
X-Google-Smtp-Source: AGHT+IEjco9Pkkj/l2s1n4hsXcp/7lVSFJ1KobBdqD/XlG9LSO9W5ka7Y6lHUohUEvvS/r5HbfcxsGOcN+SKFyaUN2g=
X-Received: by 2002:a05:6820:41:b0:5c2:1b26:926e with SMTP id
 006d021491bc7-5c21b269493mr8481130eaf.0.1719515567113; Thu, 27 Jun 2024
 12:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 21:12:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jM5kFeijcSf+UrCsX9L3mNY-p4FQ880x7theVX-ObCEw@mail.gmail.com>
Message-ID: <CAJZ5v0jM5kFeijcSf+UrCsX9L3mNY-p4FQ880x7theVX-ObCEw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc6

with top-most commit 529038146ba189f7551d64faf4f4871e4ab97538

 thermal: gov_step_wise: Go straight to instance->lower when mitigation is over

on top of commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454

 Linux 6.10-rc5

to receive a thermal control fix for 6.10-rc6.

This replaces an earlier fix for a recent regression in the Step-Wise
thermal governor that was not effective in all of the relevant cases.

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: gov_step_wise: Go straight to instance->lower when
mitigation is over

---------------

 drivers/thermal/gov_step_wise.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)


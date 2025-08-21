Return-Path: <linux-pm+bounces-32834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DEB302A4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B618AC5498
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7013451DE;
	Thu, 21 Aug 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk89Ynmu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5756BFCE;
	Thu, 21 Aug 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803365; cv=none; b=RU7VMLOs7+0VIk/5d/EJFEnOpLLCrCthOtJftcK3nkLDngmdIQ/HbNAmc1wm5Zg4FFVW/NrgkxmEJfgTsxpDgbZMKlwzeLYcF6j7i5V8eotgYvS4+wsJ9iCpnBCYlIcdPTqElLasdTJdsG1Esb9cPXGaB1vzRU3A2ryRCz1tk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803365; c=relaxed/simple;
	bh=UOQo4a8Ro/c/MWAZmaXD5XOQU6wzAf7ZCw0MOUFR5ek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HOgcej67KSnmiptJzRMZH5N50kt2PuI9hK+1hwIUnq1wHkNNFYeeKffIOqmgfo1XKYmfMqYwRbzZtRi/WTZQwcSGIdCbwlWi1GHJCXq8woX395yLMGmhgyK5bJ3ZvXEgT8UMYbJlS6qIuMQ0cfL8EeVJ/RPsaCegbjOAPXVnbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk89Ynmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53540C4CEEB;
	Thu, 21 Aug 2025 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803365;
	bh=UOQo4a8Ro/c/MWAZmaXD5XOQU6wzAf7ZCw0MOUFR5ek=;
	h=From:Date:Subject:To:Cc:From;
	b=Gk89Ynmu2gok6u8iKVqhmKTOdFGwsJUfIPtFgKf3yE//dcan62iBDvQzWVLSZHtF7
	 67m3UoQOgnlBuCa2uR+6gFglgbDmLBA8rC/QwqatlXYBwQbhwXaOLaR37Q2UI0OY63
	 pQIFBl7+ZLjz0MDjDNN8FzcU6B3T1uBK+7s3LtV6RYG7Ot1Qwg+cka4H1soSSh0DuE
	 W719/mv0uc9BiPDrC/5B5gRqxRAIXLJ4+nj461F3ngagXDEQY1dVw/vrSH7LfaWMa0
	 sS2tKz+F02KiSGMoDVzRDez6QUu4+5tIZzXxJ7yUnKwFlS/s4DL2lbUoScZSMajBtT
	 opKW02ARaTpLw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce83fb5fso966253fac.1;
        Thu, 21 Aug 2025 12:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvJTKd3DiVBBzo+4SbGXnYKiX2ladKshQc3eDdkMGjPooaMV3Z1zx7t2y26EO4W+/XWvm6pXkXvWdIvKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLnvbXNa5yA2LwL6sXFUwNyrgyWp781dtBbXLKJjk1Ex3++hI
	UQqk2+Krzq+OU7ZNd8+ToDsICqFDnA5UuvHJn9ouyL1oBnCaUY+R+ymE0NsPGz9Dm6hKHtQpEGH
	3HYGVyCPciB08DiQFSNhICMyiTM2eFKo=
X-Google-Smtp-Source: AGHT+IHtEAO4mbgV8Nltne51iCQNtuDfxBQX1KXGg7Kw94/aSiDf0gBpycFU9kuHw12NXFbeFsYjUMiHLR1JKuPgUvQ=
X-Received: by 2002:a05:6871:3a14:b0:314:b6a6:688e with SMTP id
 586e51a60fabf-314dced3582mr144426fac.46.1755803364650; Thu, 21 Aug 2025
 12:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Aug 2025 21:09:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5RTsyryCuqwT0G=0F-eY_ky0HXsXp2kEcCGggFe=ycg@mail.gmail.com>
X-Gm-Features: Ac12FXzzvzJufNxfR-WhOEHI5hBSTDbJeapSOam0qXVAu2ndUWhMQluMtS-mhag
Message-ID: <CAJZ5v0j5RTsyryCuqwT0G=0F-eY_ky0HXsXp2kEcCGggFe=ycg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc3

with top-most commit 094a7c318b29ca792fcee28e448da1ab6627ccea

 Merge branch 'pm-cpuidle'

on top of commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9

 Linux 6.17-rc2

to receive power management fixes for 6.17-rc3.

These fix a cpuidle menu governor issue and two issues in the cpupower
utility:

 - Prevent the menu cpuidle governor from selecting idle states with
   exit latency exceeding the current PM QoS limit after stopping the
   scheduler tick (Rafael Wysocki)

 - Make the set subcommand's -t option in the cpupower utility work as
   documented and allow it to control the CPU boost feature of cpufreq
   beyond x86 (Shinji Nomoto)

Thanks!


---------------

Rafael J. Wysocki (1):
      cpuidle: governors: menu: Avoid selecting states with too much latency

Shinji Nomoto (2):
      cpupower: Fix a bug where the -t option of the set subcommand
was not working.
      cpupower: Allow control of boost feature on non-x86 based
systems with boost support.

---------------

 drivers/cpuidle/governors/menu.c             | 29 +++++------
 tools/power/cpupower/man/cpupower-set.1      |  7 +--
 tools/power/cpupower/utils/cpufreq-info.c    | 16 +++++-
 tools/power/cpupower/utils/cpupower-set.c    |  5 +-
 tools/power/cpupower/utils/helpers/helpers.h | 14 ++---
 tools/power/cpupower/utils/helpers/misc.c    | 76 ++++++++++++++++++++--------
 6 files changed, 95 insertions(+), 52 deletions(-)


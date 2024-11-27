Return-Path: <linux-pm+bounces-18177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FC59DAD34
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FDD165D7E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709F2010E7;
	Wed, 27 Nov 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELEBKve5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA121FCD1B;
	Wed, 27 Nov 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732582; cv=none; b=UScvHQQH+TwfJz1g3wV3h/5njMRbnpZasNlQS83dB4jy++1gruh7C0Rl/aRAxZv7cOtsGYsrMPWsnfWa/Hdb+SaxJ82ixc+SkBF2OtI3VoX4qWSk/5aXq62w6lfntxYLkPmGNDS1duuqzBcTvn830gLV/gitXPgrKvJHaX5ryyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732582; c=relaxed/simple;
	bh=OrXScUUFMGRJ74uZrtJlNcOeD/uZHBYXeScs8TXe1Cg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IkeNFZ5pQ3ooni1IswXEHf5I7065pkH//PJPjeUvrcMa4vNxPkMF4wxG0vq6j+SbpsCEQEVFSlavH35umD8BJ5VZCtK/4mKy66SXZ4TbmYVOwllhiM8MB8l3d6JXsgjTlTI6C9A6DrrK1ZH98Op9UcvOet1ZNi4I1ZsCAaLZ/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELEBKve5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A48C4CECC;
	Wed, 27 Nov 2024 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732732582;
	bh=OrXScUUFMGRJ74uZrtJlNcOeD/uZHBYXeScs8TXe1Cg=;
	h=From:Date:Subject:To:Cc:From;
	b=ELEBKve5mmN6zG9FN6+PwrIDUdpfcV/ayLoUEzMxmgpUo1sxM3v0UiZgw3gfcQj9O
	 abSfg4+fFaiRSlST11QQyzEWQ0SBHtOxD9RGAxZ4tKUK6b+aUE4RoYZZsUpm4P88wP
	 w2X7/8OG5H0SfSrpAFa799OGVNRxgy44PvsdTboXJWCXRN7dgr9HrwlCOBjIQ8rlP9
	 eGMjnNpzBGCs29IMafmaImQHjvWedBQMKnhVQ7PnK2w3SaMc+nKFYNSXURLfG8C7aU
	 PRibxlugViaVFXZg3aVlkSdgXpm23KFu1BGEH6Hg51KDoh6q/K4JLWlOEXIttml4ND
	 7Mm0TtAiSB8xg==
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f74d6457so114296b3a.0;
        Wed, 27 Nov 2024 10:36:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUolzVel4B6E+jD0eKiL4ZRkvCQBTEPKOLE0uFt3gy9ZBHKQRCSM37ixNFg3GJ5SHlP2orUSzjp/79k2vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOU/WjLGJQ3uPy/wqyp3LJiv+Rkdnl04Nkn3nYHKKOKVPUm3o
	b+o1hxrTrFtd7U029377Vg7t/v/7GUzBNzvWyLix5IItx8KwvCsXuKLtNXsCpQjmrn6Oy4ttVu5
	r5Sf2PB+vTudh2k1aAS0p0+bf2IM=
X-Google-Smtp-Source: AGHT+IG5fzWzgwlA8b6epKIQt3uRACS9APRYa5aQu+s2m4GSvimvhw/k50kF2w5w2hBxO55VFG7ZV2mBLbYl8VUBhrg=
X-Received: by 2002:a17:90b:4ac1:b0:2ea:5e0c:2845 with SMTP id
 98e67ed59e1d1-2ee08ea021fmr5087973a91.14.1732732581795; Wed, 27 Nov 2024
 10:36:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Nov 2024 19:36:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCibaDF1vZPDTs2YfJM-XK3O-S_si_xJSsZApEomPpvQ@mail.gmail.com>
Message-ID: <CAJZ5v0jCibaDF1vZPDTs2YfJM-XK3O-S_si_xJSsZApEomPpvQ@mail.gmail.com>
Subject: [GIT PULL] Additional power management updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc1-3

with top-most commit 07d66acad26bad33defbf26516d0a84261ae6adc

 Merge branch 'pm-opp'

on top of commit f3e66e78f2ecb18a55374f7d58030556b751dd79

 Merge branch 'pm-cpuidle'

to receive additional power management updates for 6.13-rc1.

These update the OPP (Operating Performance Points) DT bindings for
ti-cpu (Dhruva Gole) and remove unused declarations from the OPP
header file (Zhang Zekun).

Thanks!


---------------

Dhruva Gole (1):
      dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw

Zhang Zekun (1):
      OPP: Remove unused declarations in header file

---------------

 .../bindings/opp/operating-points-v2-ti-cpu.yaml     | 20 +++++++++++++++++++-
 drivers/opp/opp.h                                    |  2 --
 2 files changed, 19 insertions(+), 3 deletions(-)


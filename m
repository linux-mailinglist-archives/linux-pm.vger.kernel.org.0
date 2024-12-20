Return-Path: <linux-pm+bounces-19592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE859F9B39
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 21:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039D166F49
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC342206B5;
	Fri, 20 Dec 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrU9cwHg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5071157A48;
	Fri, 20 Dec 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727763; cv=none; b=CiqtSmidqsiNQwkUagEPewFQRZ1tqqbF9Fmov6Sq2XDLmhvlkiFbmWjNROC8vjxIdBzGTisfFAjiefBmM0PgwGLBJ1jGi6DSWfHhJ7J002dMFfAT5WVIoa1iXQ1D+DTDeTP3XpR2yNQ4JiIskHvi32EmUiHMZRUYRVfKJl7FBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727763; c=relaxed/simple;
	bh=BK3KTDqH3ilHl4Q2ldR93FXLDEgrqvV6xq3m3R/WK/M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MOXKAHeB01zxerDdNH0DSdahdXxN5fD1Tec5IiH3JdqI35hMumobBC1g25aOYHoKL5nAUNdMqy2JWQydI1/G5dZTsmIxjlHdiugSyUDCD6RHmb6wAjGQlMRl3MMrXjWMv0l6FKy9Y4objGEAajLJZhlD9KcvWmtOYUwHoSkQEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrU9cwHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC33C4CECD;
	Fri, 20 Dec 2024 20:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734727763;
	bh=BK3KTDqH3ilHl4Q2ldR93FXLDEgrqvV6xq3m3R/WK/M=;
	h=From:Date:Subject:To:Cc:From;
	b=KrU9cwHgcThWowrbFE7otTNF/JExfIs1DkK1ViZDiT/Zk992KWLKTYjcrgL4kptHZ
	 jjA1fRAY/u89CMHmVVSWEBwNuXN6Z3NL4GaViut045b4rcpAvVSiKc36NV2qDf6Pzn
	 6pvm/cLsow9fkkpE6yGF4zVjS/AbOwaNguAcwB8i+W+7Aja3X4HsY9lADSOtn2T5vy
	 0s4watrlaOffUidtN1mh8a30a6PiiT/NWdwSNWfL9bxi4UYCrsYFgihOKeyEoM5yyI
	 sRFXhPNADKbStgn/TAbgPPwJoL9mpqTZH5MGncD6WbvPPnMGbJFLVcAiXY8+gn5Qg8
	 RGq7jqXPi5etA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ebb2d8dac4so1289051b6e.0;
        Fri, 20 Dec 2024 12:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp1UFsgZgpJQVUazt4EHdClsTnvdqV0Qah8oKlQKSHf+WVFKvoDUeQv3X4/vq8Isd4H/fo7y6FmH3V2Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytiZIAbeBFlupulS7wdFeiBusd3p7VSutsB3xXADNzb9XtH01p
	oQP8NHEaSSZeQZJjfEUdv+HImv0GOu9MzNjxANwakgTJYVYLTNu3ZpJXOEDY3uwHVaY76I6EH57
	PjHICdUG3yS8+yiUm/QfB/BD4j8A=
X-Google-Smtp-Source: AGHT+IFiPVclxjtoFpRrLQAwQ+FN+DInDpof/AG3vzBOmmF61Im81fCYO6KKauiDnDHqr17v4CKW6MtHqrON/4U/jKQ=
X-Received: by 2002:a05:6808:3a06:b0:3ea:5483:1eb2 with SMTP id
 5614622812f47-3ed8fdcdf23mr2620737b6e.43.1734727762786; Fri, 20 Dec 2024
 12:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Dec 2024 21:49:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jK7mjw1tO3NWcAOesheWJtKjpk3vsdDc_iYwR4u0wXWA@mail.gmail.com>
Message-ID: <CAJZ5v0jK7mjw1tO3NWcAOesheWJtKjpk3vsdDc_iYwR4u0wXWA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.13-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc4

with top-most commit 05648c2f58b3da82d304e7a449101a4545472836

 Merge tag 'amd-pstate-v6.13-2024-12-11' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux

on top of commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8

 Linux 6.13-rc3

to receive power management fixes for 6.13-rc4.

These fix some amd-pstate driver issues:

 - Detect preferred core support in amd-pstate before driver
   registration to avoid initialization ordering issues (K Prateek
   Nayak).

 - Fix issues with boost numerator handling in amd-pstate leading
   to inconsistently programmed CPPC max performance values (Mario
   Limonciello).

Thanks!


---------------

K Prateek Nayak (1):
      cpufreq/amd-pstate: Detect preferred core support before driver
registration

Mario Limonciello (2):
      cpufreq/amd-pstate: Store the boost numerator as highest perf again
      cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies

---------------

 Documentation/admin-guide/pm/amd-pstate.rst |  4 +--
 drivers/cpufreq/amd-pstate.c                | 50 +++++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)


Return-Path: <linux-pm+bounces-13815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A596FBD5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C031C21B71
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22B1C86FB;
	Fri,  6 Sep 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEbgfR/l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12D1B85D5;
	Fri,  6 Sep 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649838; cv=none; b=sHykGkebBjpW0tUrH+PqmwFA2QoP+2aJ9r4HQqpxIEqt1ai2PruYAMZlIXSFzRDRbNGVwE+rY/HtMwfECmwRg4OBqBwtMs5OGa3xpcf1XsclJUJGzagaDCxh31SZOmVb8JihL1Wl0kTsiMnVSrZMOJrXnG4gVLdxJeRZ85R2rEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649838; c=relaxed/simple;
	bh=hiquEXMCz6aSLiASFZGingdVCueyHBdPjRz4YPk8UBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Yc3CQJxhSRixLmEHjG6ehX1PKksZ4m6KN6VOhcH8o/LG7TmggGQVwx9XRjajSjxnDvJTIHFDsfmvj4Dn44oQ7fSalkrD+0LRrMiSqQmA8ce5qVFZVGf0Eps/WsSfJlb9qnlDEa09O6UuqAPA28FKB+/+Lqu7adMMQ0M3oj1NCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEbgfR/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B4C4CEC7;
	Fri,  6 Sep 2024 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649838;
	bh=hiquEXMCz6aSLiASFZGingdVCueyHBdPjRz4YPk8UBU=;
	h=From:Date:Subject:To:Cc:From;
	b=iEbgfR/lB/R6HvmyrNRN7j3B7dddYb7rMH9KSVSDNcWYTdg3OSAGrJe0wg0f/EF0k
	 n1eGHiGuVqTfV9UyuBkhzhBcJcQOMYXdLXfneIUCPXhvR+/zfpYEP2gB6ghbcUun40
	 e/apQkdzaT9rd+MuuBqCl3iwuaW5Iu3JbBEIIpMcVOPp9fTNicVMun2/YVRp3+wcJ6
	 bdrfvy8WMBVy4Kdoa5ByHJq0+badF45Ijixb4mk9q/ySyoMPUgy7yZCvS5NuG/FEnc
	 rBOD0XwoT2iuQhp5DQxldT4N7oqsdd0QFOxlsKfuwOlqPUW7/+Qn3ZevAfyMoJLFkk
	 QSjgrJGWADSTQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-27045e54272so1255365fac.0;
        Fri, 06 Sep 2024 12:10:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWWWpuGyR37+vK9BL9Ty3qas5/J5Jg7tAlW/uzFgeYJLvVqs96ImDa4yQ9pQgVb2eiD4RtYamQCUcNQn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+9TEGdzS9LNDBn17uc9/2CSWZeDBmi/Jwqy+baFjZs1a7V3n
	28VS5tDMO8NPN824XIwbZj+GR6wYcgrpvI4/fZuDHTocdpjuoxwMj+QkRKNPMZgCcMR+MVtsAb1
	fs00L8iISaMiiUlVJE+p9HvFX4QM=
X-Google-Smtp-Source: AGHT+IFNkWP1nFqqzRS1dqzCwykMUo75UWsFphQyKTWdHkEBLxTQdcJmUOBx1yhRBNFhiLEZ+0F5ygCffSsKQR27kmo=
X-Received: by 2002:a05:6870:d887:b0:278:973:e510 with SMTP id
 586e51a60fabf-27b82ea5534mr4571419fac.26.1725649837646; Fri, 06 Sep 2024
 12:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Sep 2024 21:10:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iD3rPCHDrA7ebRr64GPYFaSJ1fF-GcUCf_avXm0_k9aw@mail.gmail.com>
Message-ID: <CAJZ5v0iD3rPCHDrA7ebRr64GPYFaSJ1fF-GcUCf_avXm0_k9aw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.11-rc7

with top-most commit b02d2cf5b220872cd10afe610348b9ec41b9ac05

 Merge tag 'amd-pstate-v6.11-2024-09-04' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux

on top of commit 431c1646e1f86b949fa3685efc50b660a364c2b6

 Linux 6.11-rc6

to receive a power management fix for 6.11-rc7.

This fixes an incorrect warning emitted by the amd-pstate driver on
processors that don't support X86_FEATURE_CPPC (Gautham Shenoy).

Thanks!


---------------

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on
certain Zen models

---------------

 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)


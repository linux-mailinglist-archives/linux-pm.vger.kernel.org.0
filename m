Return-Path: <linux-pm+bounces-42792-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH70Et69lGnHHQIAu9opvQ
	(envelope-from <linux-pm+bounces-42792-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:13:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB914F8C7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7727D3008CAB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E9376471;
	Tue, 17 Feb 2026 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t02wlwAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BF14A62B
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355607; cv=none; b=Uw4XFyZ+Sde/33SyYzHbybAJumqHO4o9FafM8aIC1y4+2uF7IybviZWwPcLHplZhpxJ4d+PWu08LpR2JOvcBaronh6HGIpTDrIKJiAnkvhIqD0de/khEFgHm6xBzJtWeTmrqitck4FJvzAB6k3xzZHmrVUhkl5IhS7RDSXPlTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355607; c=relaxed/simple;
	bh=kpmtc1+t2EIomUM5NOng2NkTHO8yNMvLFRdhc/LFOR0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jarfjomz6Tr3wu3nhZOPSXQdMNmfAvXG72KjHFdqerijmb7Qgr9IiLdsAqilbxsIkFFPnRkSilHMLLk6HTmb2bvGwPPg1EzWelHeP4LUHesTBK/ApIkg7tUd43JMFLaHIRq1cFMgc17KboLCS3ddbJrqTaeHBkqDNN+4yQB83g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t02wlwAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C25C4CEF7
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355606;
	bh=kpmtc1+t2EIomUM5NOng2NkTHO8yNMvLFRdhc/LFOR0=;
	h=From:Date:Subject:To:Cc:From;
	b=t02wlwAq9hQ/vit0uZHbXgmqCssane02jG+eUXNZ0JQqBBsezMZs4W6UkZoBkWUTP
	 2CXUm53zb+fKCmsM8eGcvRs0iH1KRFu1noWnfbDqLxorRK82Qr5VhYCHtSfLmz0Q5V
	 A1yhDdBXNy9cTukny6/tetPRFI1+FrmdiRGlK5jmKICTatmjcAINoEUGHo1zUtC121
	 kTgxCyPKZTZwpjrv6Ulv9kwOWhbDDySiZ6A8PlOWGBv1U5AvL6bhD26xU+Q41cHNmB
	 AqruBeh5yLZFbNETrE9kYORe7T0r9PEoSDK/HARCGUByiWQyluYkbAR3aapMjzYYZV
	 iBJCCKp1d1TIQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a3fdeb7d9so6589754a12.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 11:13:26 -0800 (PST)
X-Gm-Message-State: AOJu0Yyav1lJYQtQmyPf+TRITG936aTgtMpJrqjtH4W3bKothFhD9h6d
	8GD8ULbCVJHRIZ8qLF/ehkiOJRnVkVJWajX4dU8zPcoN2t7/mjXfZPl/eUfpVBbuXme1JKhO4f6
	nMOxiTMjJwBfiD09Tq+x8zVnWrtHtzmE=
X-Received: by 2002:a17:907:9627:b0:b73:572d:3b07 with SMTP id
 a640c23a62f3a-b8fb4390643mr816675566b.28.1771355605677; Tue, 17 Feb 2026
 11:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Tue, 17 Feb 2026 13:13:12 -0600
X-Gmail-Original-Message-ID: <CAJvTdKkX_A4++yaM54so4+Y0Pz87c362ggAbPo8C27r7gw+NHg@mail.gmail.com>
X-Gm-Features: AaiRm51DM62HXgkfZWfZ0Ttm1BSGjpkw5Tf4pbAMAcyKoIs8VbwilYe01dNyLLI
Message-ID: <CAJvTdKkX_A4++yaM54so4+Y0Pz87c362ggAbPo8C27r7gw+NHg@mail.gmail.com>
Subject: [GIT PULL] turbostat v2026.02.14
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42792-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74CB914F8C7
X-Rspamd-Action: no action

Hi Linus,

Please pull these turbostat-2026.02.14 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 7f98ab9da046865d57c102fd3ca9669a29845f67:

  Merge tag 'for-6.19-rc4-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2026-01-05
14:10:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2026.02.14

for you to fetch changes up to 51496091dd37b405e6e399a9638da3f1da3f4c64:

  tools/power turbostat: version 2026.02.14 (2026-02-13 14:08:33 -0600)

----------------------------------------------------------------
turbostat-2026.02.14

Since release 2025.12.02:

    Add L2 statistics columns for recent Intel processors:
        L2MRPS = L2 Cache M-References Per Second
        L2%hit = L2 Cache Hit %

    Sort work and output by cpu# rather than core#

    Minor features and fixes.
----------------------------------------------------------------
Kaushlendra Kumar (1):
      tools/power turbostat: Use strtoul() for iteration parsing

Len Brown (22):
      tools/power turbostat: AMD: msr offset 0x611 read failed:
Input/output error
      tools/power turbostat: Dump CPUID(1) consistently with CPUID(6)
      tools/power turbostat: Dump CPUID.1.ECX[31] (Hypervisor)
      tools/power turbostat: Dump hypervisor name
      tools/power turbostat: Harden against unexpected values
      tools/power turbostat.8: Document the "--force" option
      tools/power turbostat: Rename "LLCkRPS" column to "LLCMRPS"
      tools/power turbostat: Allow more use of is_hybrid flag
      tools/power turbostat: Remove redundant newlines from err(3) strings
      tools/power turbostat: Add L2 cache statistics
      tools/power turbostat: Cleanup internal use of "base_cpu"
      tools/power turbostat: Cleanup package_id
      tools/power turbostat: Rename physical_core_id to core_id
      tools/power turbostat: Delete core_data.core_id
      tools/power turbostat: Allocate average counters dynamically
      tools/power turbostat: Unify even/odd/average counter referencing
      tools/power turbostat: Simplify global core_id calculation
      tools/power turbostat: Enhance HT enumeration
      tools/power turbostat: Expunge logical_cpu_id
      tools/power turbostat: Favor cpu# over core#
      tools/power turbostat: Fix and document --header_iterations
      tools/power turbostat: version 2026.02.14

 tools/power/x86/turbostat/turbostat.8 |   20 +-
 tools/power/x86/turbostat/turbostat.c | 1455 +++++++++++++++++++++------------
 2 files changed, 936 insertions(+), 539 deletions(-)


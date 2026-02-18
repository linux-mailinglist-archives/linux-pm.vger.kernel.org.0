Return-Path: <linux-pm+bounces-42837-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBe/A6EYlmkSaAIAu9opvQ
	(envelope-from <linux-pm+bounces-42837-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:53:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08F1593AA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69603009CEE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F2346E5F;
	Wed, 18 Feb 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGvrVHHF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA329E114
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444349; cv=none; b=Ips8hCeT1THsCDnTMSvjUZ6JYivaortqri4HPGWNuDLfBkS0lv4kKEwKyTwrHRAwOlGs9PdKTBrQHpvLCjbjgItCQPLnsxYgXKMKC80nz5mFiklUtTrkOaV/+ew9tS48besQ2UVpHOSKD2Ismeyf+Re4HL/TdqYeTOYjQ6AJQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444349; c=relaxed/simple;
	bh=loKDKRL+VNrQeK04SGdYaiKjA6UPYd9CVSJ1CklYnQ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lWSLVY372fEFLDtrmZrXsdinHc9K9lWbh5WHbNg4uDHY89bpbpkoGE6k3785bnEwUDndwCwjyo1e7gRE4vc5pwSf/YWIsDg3gU/DlwupcFT4CVfXPDoHzpXMb5vQJb9nO8nxZaPLItJpi5h5cXYvk7322vuB7JOPJnkEahy7GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGvrVHHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD5DC2BCB3
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 19:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771444348;
	bh=loKDKRL+VNrQeK04SGdYaiKjA6UPYd9CVSJ1CklYnQ0=;
	h=From:Date:Subject:To:Cc:From;
	b=LGvrVHHFWC3pd/cuxZuD82C0rq72AXEh7DQ4OoRW7LqZY9xlF/vXBtPrDzEN0C8Hg
	 tpEVibghctDeT9A6vIAeVhp8sDO7ge8joFkNGOO7RMSZjKvXhuwFcRaDrM+TssQln2
	 0dNvJEMgaHfkMTjKyUs89EYpGTIjIQ83rdIZ0J3zlwDMhRVutURnVY7T85p5Cozp0W
	 ipsmwaz46KXXsOKa5tEkW2o86Bxc97cW/kdNgByMsW2x0XwDnJjN5/lDA81BmmSNXq
	 ML5m6CSwQJHW+KKoOHXXNiUJCht8BIMMS1L34Q+WL/okh2uMITGUAh0PDLJ8Xay+N1
	 uSQWaEq2w0wsA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so137471fac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 11:52:28 -0800 (PST)
X-Gm-Message-State: AOJu0YywKwEuxU8Qolzsah3jSBdNDBYxaxgJCJlljHwdnRKEmw/iryo+
	65xmiL0ptVeezKZMypPBbeFcBZ0t9ekMCPUfhoPm3dR/KE8QoSP2a951sIYOifO0lEKk1yBb8od
	dqLXldkWodLRpODGn6AYXbk9SOb94p64=
X-Received: by 2002:a05:6870:63a5:b0:409:7ed8:850c with SMTP id
 586e51a60fabf-415291f50f1mr1907583fac.57.1771444347535; Wed, 18 Feb 2026
 11:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Feb 2026 20:52:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gh1N0codB+aY67U-e_mAkYQghKj6QE1jMB5jA_bJjLSw@mail.gmail.com>
X-Gm-Features: AaiRm53VvhVtDv9O7PkiH8EeX1k08UyeTfPMshTSUne3G_ofsCHJujbND4F7at4
Message-ID: <CAJZ5v0gh1N0codB+aY67U-e_mAkYQghKj6QE1jMB5jA_bJjLSw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-42837-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B08F1593AA
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc1-2

with top-most commit becbdde56a5c0e40c9bbbb6b8d5ffbb8de635d63

 Merge branches 'pm-powercap' and 'pm-cpuidle'

on top of commit 9b1b3dcd28c271fc8c4a87e81860f3a34b6d29b7

 Merge tag 'pm-6.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 7.0-rc1.

These are mostly fixes on top of the power management updates merged
recently in cpuidle governors, in the Intel RAPL power capping driver
and in the wake IRQ management code:

 - Fix the handling of package-scope MSRs in the intel_rapl power
   capping driver when called from the PMU subsystem and make it add all
   package CPUs to the PMU cpumask to allow tools to read RAPL events
   from any CPU in the package (Kuppuswamy Satharayananyan)

 - Rework the invalid version check in the intel_rapl_tpmi power capping
   driver to account for the fact that on partitioned systems, multiple
   TPMI instances may exist per package, but RAPL registers are only
   valid on one instance (Kuppuswamy Satharayananyan)

 - Describe the new intel_idle.table command line option in the
   admin-guide intel_idle documentation (Artem Bityutskiy)

 - Fix a crash in the ladder cpuidle governor on systems with only one
   (polling) idle state available by making the cpuidle core bypass the
   governor in those cases and adjust the other existing governors to
   that change (Aboorva Devarajan, Christian Loehle)

 - Update kerneldoc comments for wake IRQ management functions that
   have not been matching the code (Wang Jiayue)

Thanks!


---------------

Aboorva Devarajan (2):
      cpuidle: Skip governor when only one idle state is available
      cpuidle: haltpoll: Remove single state handling

Artem Bityutskiy (1):
      Documentation: PM: Document intel_idle.table command line option

Christian Loehle (2):
      cpuidle: teo: Remove single state handling
      cpuidle: menu: Remove single state handling

Kuppuswamy Sathyanarayanan (3):
      powercap: intel_rapl: Remove incorrect CPU check in PMU context
      powercap: intel_rapl: Expose all package CPUs in PMU cpumask
      powercap: intel_rapl_tpmi: Remove FW_BUG from invalid version check

Wang Jiayue (1):
      PM: sleep: wakeirq: Update outdated documentation comments

---------------

 Documentation/admin-guide/pm/intel_idle.rst | 11 +++++++++++
 drivers/base/power/wakeirq.c                | 11 +++++++----
 drivers/cpuidle/cpuidle.c                   | 10 ++++++++++
 drivers/cpuidle/governors/haltpoll.c        |  4 +---
 drivers/cpuidle/governors/menu.c            |  2 +-
 drivers/cpuidle/governors/teo.c             |  6 ------
 drivers/powercap/intel_rapl_common.c        | 21 ++++++++-------------
 drivers/powercap/intel_rapl_msr.c           | 12 +++++-------
 drivers/powercap/intel_rapl_tpmi.c          |  2 +-
 include/linux/intel_rapl.h                  |  2 +-
 10 files changed, 45 insertions(+), 36 deletions(-)


Return-Path: <linux-pm+bounces-43273-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEZDIbi2oGnClwQAu9opvQ
	(envelope-from <linux-pm+bounces-43273-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 22:10:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59D71AF7D5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 22:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C2CC300C6F1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C339446F;
	Thu, 26 Feb 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUXn2nE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E7393DE3
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140193; cv=none; b=alUrFv9YAMRjFp1aC1SR1/wF9Z9tEVC4Kyw5GhSZNxvGjHuJ/GWH5KZ92F3WB1szyjNtZfbMgr25vqM7mQvrkvN/d+stf4ie/4FRFKY4AtJY9oGM2pSqZ3gVSAPS+tS0TNtEwIKX6Tt1RjQ5etBQUmlFVLXfCFPTCI07np36kvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140193; c=relaxed/simple;
	bh=RGvNNOtR2S1WHt3kT8TPaMPVN6bCqxnzOyx/V3S/eE0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UeofFp1nDPmIZahvVGtxOaGLMJZTz9a/kGZYp0NBmA20epleCIPsXU9HTO+6PVdm7C5Lk3wpA7MUKxXotNf4CrhSVqM9IWWTK3ZU7a/uZmLLFxsiDLvKJRWBRpCHW5qKInttxz2x+6Q0V1/X2Or/k67KcROVyjaiYcmwZRWrOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUXn2nE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65ECC116C6
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772140192;
	bh=RGvNNOtR2S1WHt3kT8TPaMPVN6bCqxnzOyx/V3S/eE0=;
	h=From:Date:Subject:To:Cc:From;
	b=hUXn2nE/aTDueLxd/2XMwD2JDKAUsPTOjnqR05a8mCwzXo5FqQBgdl5dRMl8Gp0ZU
	 LaLTytPIs86mKtqVP990cu9X0PB2eifNEyKJSrdmdJWVLBxa7zzYT85yoGyFEp4DUQ
	 NZTN6C/SKRAL/aewJUrkljMpXVcY/D9w3fzvDCwx1bmP1SkJWzIkp94yv4ZuyNz8eK
	 diM2eJQEjf4dq8vRjE0TtYtRafZTnQNv+0Vj2uj8jTFRHHJG0LFTDndqif44IBkZmp
	 MxPMZ4W2HIKlF+oSsc0ZED4+Wp8EKdSzqAdajC/r6tBobMtjq1ygx7/x2mpzSY/0Mu
	 CQ7TEvqHlYYpQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c85307b2so880967a34.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:09:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxRr/Lcd2so55eLbSlHaNxwqCDqp8giYG4126xj6kl7e+QacO0B
	03RyeVqLEgp+ljJcniyjLEq0ih/gZt83JjUYb7TwECqWtiPIwX9phQhPmQiIkjokGhxByp9fc6l
	vLLkFxkoXK+osw2+O2i/XdkVYin+hszk=
X-Received: by 2002:a05:6820:450f:b0:679:e889:dde1 with SMTP id
 006d021491bc7-679fadbb77dmr406802eaf.6.1772140191933; Thu, 26 Feb 2026
 13:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Feb 2026 22:09:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDdCnCYAfQVut_uFnzc46EifhRVBns2cT04M_xw-eo9w@mail.gmail.com>
X-Gm-Features: AaiRm52Dh8exBQ4gcmVPAOatynjqvgfQb1kRkdYo-VZ7Li6JzrcdrY8qYVY43Sc
Message-ID: <CAJZ5v0iDdCnCYAfQVut_uFnzc46EifhRVBns2cT04M_xw-eo9w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v7.0-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-43273-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A59D71AF7D5
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc2

with top-most commit b78030d0f10570845568153637c5831e27d9871f

 Merge branches 'pm-cpufreq' and 'pm-runtime'

on top of commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

 Linux 7.0-rc1

to receive power management updates for 7.0-rc2.

These fix two intel_pstate driver issues causing it to crash on
sysfs attribute accesses when some CPUs in the system are offline,
finalize changes related to turning pm_runtime_put() into a void
function, and update Daniel Lezcano's contact information:

 - Fix two issues in the intel_pstate driver causing it to crash when
   its sysfs interface is used on a system with some offline CPUs (David
   Arcari, Srinivas Pandruvada)

 - Update the last user of the pm_runtime_put() return value to discard
   it and turn pm_runtime_put() into a void function (Rafael Wysocki)

 - Update Daniel Lezcano's contact information in MAINTAINERS and
   .mailmap (Daniel Lezcano)

Thanks!


---------------

Daniel Lezcano (1):
      MAINTAINERS: Update contact with the kernel.org address

David Arcari (1):
      cpufreq: intel_pstate: Fix NULL pointer dereference in
update_cpu_qos_request()

Rafael J. Wysocki (2):
      pmdomain: imx: gpcv2: Discard pm_runtime_put() return value
      PM: runtime: Change pm_runtime_put() return type to void

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix crash during turbo disable

---------------

 .mailmap                       |  4 ++++
 MAINTAINERS                    | 12 ++++++------
 drivers/cpufreq/intel_pstate.c | 14 ++++++++------
 drivers/pmdomain/imx/gpcv2.c   |  4 +++-
 include/linux/pm_runtime.h     | 16 ++--------------
 5 files changed, 23 insertions(+), 27 deletions(-)


Return-Path: <linux-pm+bounces-43966-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBBIGMcHr2loMAIAu9opvQ
	(envelope-from <linux-pm+bounces-43966-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:47:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9A23DDBE
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF6243023040
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25F27FB3C;
	Mon,  9 Mar 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpzL4PwU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CEB2741DF
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078443; cv=none; b=AOQtClJ/8w4G8M1lAY+HQNkUW1IGodViUFSIiCS8rRCqgqLU+YCNj1bYCgW3VcycZflYGP0lyxnvHInen1NXciQs7ycrAzcD6+NyPE4VOUOrHDc2Q4wPw4Zkpv/u6gNyXgLrGAdyCIH+TNMAgXmAHoL4+y44d9xiCvl0zUdFAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078443; c=relaxed/simple;
	bh=vtVtEe5cUCSst5nprBNdeLl8/wMgnTd+j1ddIr86FfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et4WgkEXeCC7ZgCnVcBXPEqmWPY6R1wZOgFg4CZcx2yJVX1KwJ+0GxaOZ0mV4ffJRegdAE8eup/4xgBFX6+zrEfIVxQcXXFv9hRt03c/OWLCH8CoDwlPl6I0QKo2QtbEv9uL8axwESBp4U8i+KTYq8NFVj6MeQyWdKp91mV77F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpzL4PwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC46AC2BCB2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078442;
	bh=vtVtEe5cUCSst5nprBNdeLl8/wMgnTd+j1ddIr86FfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DpzL4PwUq7jjM6T19jTFgJp6vzG4Ma5cwmbEI/SuWVoqA1mVoY1Wba2iR2gonRFoZ
	 7D0RGx83hIe4nR/cROw03Drj00vAAaCMJUAsTqEY7Z0W1DvTE1tPmG8hlzqtsCIHht
	 UgvKywroMqfUlH6UXFExBBMp70gNRW2drD4GZ5qvv81uocWmu7US4i5G1tmXJslJuZ
	 zRE+o1Hx3Wc035UZMmduDrfl8l9JQSBS/OnEamiZ6KSYiwhNHoBOVWrWoBPjiLvrU3
	 dSC0yVqB2ej3N4r5jphH15SIayfjV/wb/dFch3KbTCi3BjEt9AFETpxQ/rjsyBJbYZ
	 6xt2t/LVNK45w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-464bc03efd8so6985671b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 10:47:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHkpn1tjxulmWNcf95v09RRWsXRT5U/QFZAQIi7JIMDBoIaW35QD+KaGFjTJ7CqaL6w6Y6VP9pzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqB5YpoSukq4z33hrJLBBxapghZQfvEjTIXeEJ/X8rIb75nXKN
	AuIwtXqLaS/kjqNg5TEowJXf00LkBEtyP9Rpl+OxS8GJ/ByFWXYnBEPxtyNooBFo37xzwtY4dAe
	uxz2M2/U74q1nDpIDRk+hv1cNsN0TXXM=
X-Received: by 2002:a05:6808:f8b:b0:467:baa:ed5c with SMTP id
 5614622812f47-4670bab0435mr2038191b6e.12.1773078441948; Mon, 09 Mar 2026
 10:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ac44758-822b-4a7d-94ce-23826e6cb30c@linuxfoundation.org>
In-Reply-To: <3ac44758-822b-4a7d-94ce-23826e6cb30c@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 18:47:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hjDR5+DoNCncWPrFNhLD15HvMaWOFMu+RVB_Sx5gvHAg@mail.gmail.com>
X-Gm-Features: AaiRm51Yii_QoKwmvBlUKDzfQVYXwcNM1KWQ-mWUwki1KiQ_yQXt2MOT-Hcw8XM
Message-ID: <CAJZ5v0hjDR5+DoNCncWPrFNhLD15HvMaWOFMu+RVB_Sx5gvHAg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower fixes update for Linux 7.0-rc4
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F1E9A23DDBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43966-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Shuah,

On Fri, Mar 6, 2026 at 9:44=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower fixes update for Linux 7.0-rc4.
>
> - Adds support for setting EPP via systemd service
> - Fixes swapped power/energy unit labels
> - Adds intel_pstate turbo boost support for Intel platforms
>
> diff is attached. These aren't very critical. Please send them
> when you send your next PR.

Pulled and added to my linux-next branch, thanks!


> ----------------------------------------------------------------
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f2=
7f:
>
>    Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-7.0-rc4
>
> for you to fetch changes up to 3817b1d34432d3d83a61576719570d04c341b7cd:
>
>    cpupower: Add intel_pstate turbo boost support for Intel platforms (20=
26-03-03 11:18:53 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-7.0-rc4
>
> - Adds support for setting EPP via systemd service
> - Fixes swapped power/energy unit labels
> - Adds intel_pstate turbo boost support for Intel platforms
>
> ----------------------------------------------------------------
> Jan Kiszka (1):
>        cpupower: Add support for setting EPP via systemd service
>
> Kaushlendra Kumar (1):
>        cpupower: fix swapped power/energy unit labels
>
> Zhang Rui (1):
>        cpupower: Add intel_pstate turbo boost support for Intel platforms
>
>   tools/power/cpupower/cpupower-service.conf   |  5 ++++
>   tools/power/cpupower/cpupower.sh             |  6 ++++
>   tools/power/cpupower/utils/cpupower-set.c    |  6 +++-
>   tools/power/cpupower/utils/helpers/helpers.h |  5 +++-
>   tools/power/cpupower/utils/helpers/misc.c    | 41 +++++++++++++++++++++=
+++++--
>   tools/power/cpupower/utils/powercap-info.c   |  4 +--
>   6 files changed, 61 insertions(+), 6 deletions(-)
>
> ----------------------------------------------------------------


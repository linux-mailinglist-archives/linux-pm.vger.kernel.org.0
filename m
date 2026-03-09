Return-Path: <linux-pm+bounces-43955-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEcROr3krmmsJwIAu9opvQ
	(envelope-from <linux-pm+bounces-43955-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:18:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42923B823
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B158E308A8A3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9438BF8B;
	Mon,  9 Mar 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgaylCIf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7653A961A
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069207; cv=none; b=H0m8+qWDHUZ6Hfn62d0iR3jhrMOc1m2c24B/kZ+2PFepcQGIHx+yalvt0iA0HUyG/YzgONANMdK0y+8n4Lw5rJKzNfo1+QdPoVhRe8Y75+5pBAI5IviLhbAh2QTO/JXe7ZxBcC2l89aaKOyA2O7+loEFvAAb5/nSyjJA57qKaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069207; c=relaxed/simple;
	bh=49TKuQN03cuR/ixziMwo/sxdG8QTob0zJtdfZ1Zxyhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBsj5mGCLfvN3z9U2l+nJhLHnTGaO803ZhYABGeUh7Vs4XUH9sN2aXr+fIexQi17RiSGQ+t6+dEkBUrmIwJMswB/b41uVcqaN8WMX7aW+UTkjeMU+L3+1rc1aR0IziTVNtPAYICM8ER9L4kaWoMvRHUn7NmRo5mywgRYGwrt5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgaylCIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96F2C2BCB2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069207;
	bh=49TKuQN03cuR/ixziMwo/sxdG8QTob0zJtdfZ1Zxyhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BgaylCIftD+1hDKX/l70pfD2cw0W5O4oaRHTY3vbVJb0UF0T3LP0J2VWHRym3sVJG
	 5fLwu9RMavfaS63HI4f4J3jHia6ZStE5S2WXxFBmm6m/Hzvp8LeFrFxT2n9XWPaiE8
	 1hynobNLbmSyK9zI2lHFkVooXMpShtWhXN5VZGhqYq6CRzFqpzmUH7ZxS2ZHYmvBqX
	 IP1tlCd/+kALR55SsOVwAjAjHyhlH4XOwk4QdLw1p8ZPvYD0TFjMXNm00kth5Sa9wb
	 oN0Rz6joXqhGloG5DcyqFWdIQ5zltxvhqdyoip2x5dNzyal3TbJp1jXZXezVIAwdio
	 lJrp3DSLTGgpg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67baf20e8c2so243896eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 08:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjWPbf+OuhlrDcDm5FKuG4SDfgPK4T3MCmVXKQ5vzDPeSA8R/mYaVN6KVjFv9eXN9WVQTEGRkHwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FOmUo+dRd7l3KB4py5iKdiamZCBkBRTHA0+zVQKANuA3uup4
	HBi/fe7qRzZwnU8D2JMbz6xEMhzK4I22gw9o6T6RMFFXsz3/xjiAUAygTpcZ1GgsakoLES0hFsj
	PtC65OJ7snQyFsugCfOeb8iEICvE97rs=
X-Received: by 2002:a4a:e846:0:b0:679:97ac:2cc3 with SMTP id
 006d021491bc7-67b9bc976eemr6571668eaf.22.1773069206748; Mon, 09 Mar 2026
 08:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2780abfc-39d1-4441-833c-65e66f747054@gmx.com>
In-Reply-To: <2780abfc-39d1-4441-833c-65e66f747054@gmx.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 16:13:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hokpC_2E77nrm2KHeOdhhH6qvYsg3wCQpTEG=PCim=ww@mail.gmail.com>
X-Gm-Features: AaiRm53DlYhLR-k2-DVzEs7axQUuHxUb-bjFYTFjCi_T-97qxkViYvYsZ70y4I4
Message-ID: <CAJZ5v0hokpC_2E77nrm2KHeOdhhH6qvYsg3wCQpTEG=PCim=ww@mail.gmail.com>
Subject: Re: Subject: x86/msr + lockdown: allow access to **documented**
 RAPL/TCC controls under Secure Boot
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D42923B823
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43955-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,gmx.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:24=E2=80=AFPM Artem S. Tashkinov <aros@gmx.com> wr=
ote:
>
> Hello,
>
> When Secure Boot is enabled and kernel lockdown is active, the x86 MSR
> driver blocks all raw MSR access from user space via `/dev/cpu/*/msr`.
> This effectively prevents legitimate use of documented CPU power and
> thermal management interfaces such as RAPL power limits (PL1/PL2) and
> the TCC/TjOffset control. These registers are part of Intel=E2=80=99s
> **publicly** documented architectural interface and have been stable
> across many generations of processors.

There is a power capping RAPL driver.  What's the problem with it with
Secure Boot enabled?

> As a result, under Secure Boot Linux users lose the ability to read or
> adjust **standard** power-management controls that remain available
> through equivalent tooling on other operating systems.

The power capping RAPL driver is there, please use it.  It is documented ev=
en.

There is also a driver for TCC/TjOffset control, it is called intel_tcc_coo=
ling.

And there are utilities in user space (for example, Intel thermald)
that use those interfaces.

> The current all-or-nothing restriction appears broader than necessary
> for the stated goal of protecting kernel integrity. MSRs associated with
> power limits and TCC offset are not privileged debugging or microcode
> interfaces but standard hardware configuration knobs intended for
> platform power and thermal management.
>
> It would be useful if the kernel either allowed access to a small
> whitelist of such documented registers under lockdown or exposed a
> mediated kernel interface for adjusting them. Without such a mechanism,
> Secure Boot effectively disables legitimate and widely used
> power/thermal tuning functionality on modern Intel laptops.
>
> Most (if not all) Intel laptops don't expose or allow to configure
> PL1/PL2 limits in BIOS/EFI either.

Because it is not necessary to do so.


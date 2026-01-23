Return-Path: <linux-pm+bounces-41379-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAaHDn+sc2nOxwAAu9opvQ
	(envelope-from <linux-pm+bounces-41379-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:14:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9160D78DBD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34D4300E72D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347172EA72A;
	Fri, 23 Jan 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3N41HTk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2E22F75E
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188305; cv=none; b=hpTtkdBX03PJaCqPETkfBmqSWVwHp42cLOqx8wREBog6itSDlrWx7k8n1QCJT14FVzUpgvJxnOlqhKtCYvR9N/LTuC4Hm5ZdrBBS43OaI3ZzpcoHh4R/zLkTLPfNtNNyTIAn/zD0aNY4bFa1bhXf1hkX+DZh3kYFuWFK5wqX9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188305; c=relaxed/simple;
	bh=9FooZVcsufvu9ghg0VlFYYX/jGCgk5LDYqMFp5jZTzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL7djL9SwfL1pQgUeNypOoCkccyPhBL0QITmhqH7IubjPbeJgQOHeF/wmcuZ2oSvp7tkPQADFjeB5+E7C2rpjtazeXvFJUn1SIfvQrhUNN60OXpkEnNhckygryscNJmuXTl0wKQYIe9mG25jMPJ+wE5CjPMZT5rrDDFzzBR445g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3N41HTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF645C19422
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188304;
	bh=9FooZVcsufvu9ghg0VlFYYX/jGCgk5LDYqMFp5jZTzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r3N41HTkyopvu0PGLMQZprqgL44fQui9J6pGJbz8cDT1krrwd1NY8mS7iyEsa5spy
	 reGgV81m1UWlqB8KkDjlx8b0E87oaM29G/vE0bwzJjMw2bfmqIzhQx/aHpKypeaERd
	 RF7Qi3MAt1x+dLez5c1ig1fEzoC0zNFk2SFt3uRN2y0qn69TJ9hthHWa+C0IErZlzQ
	 K7mgiECmTCWtF2+8wi59O+EZn6elxtA5ISrXED9xzW5XIBWHOmqcoXg6G50Y7i9PqZ
	 eB7eAb6XphID0i5yRF2Fiq7YuWZgCwEj5+RSmb7psrOh0XiYtAAvRGZqQi5Xq7pyKe
	 POVstdAe7Uesg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so1113214fac.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:11:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI7eQSKA0nNAHRRS1xUdCb0YPzz2t/0Y5Ll+0VGKah23mFS/fGBgIP9TdvBKeagZ9Qh2JdwD/dkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYgHoc1TpQwD1l/gQWmWMv8IWkSgAwoVV9okYgU7LRbh1nDAr
	yjrhigev6eb0DCkTM6ZnsPhGBZe1uw6PLeA0ZTUtuH3sJmSTxGS5MpR+DygLONyT1XsWevHdB5n
	6VaYvZK29RBGxpGqkENORJUDeismb6QU=
X-Received: by 2002:a05:6820:8107:b0:662:8b01:c7d8 with SMTP id
 006d021491bc7-662caaebb79mr1483981eaf.9.1769188303801; Fri, 23 Jan 2026
 09:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8cd367ed-3b80-4233-ac71-77a88782ed2f@linuxfoundation.org>
In-Reply-To: <8cd367ed-3b80-4233-ac71-77a88782ed2f@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 18:11:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ieQncbXBNiz34BNM58LPqsg6NqF45e1=xkXE4OpMZnyA@mail.gmail.com>
X-Gm-Features: AZwV_Qhm9Ix573WaBoWe9sfQNUJWb3NKXkukqn2Jb0886qxUr9u7L72-wY67isA
Message-ID: <CAJZ5v0ieQncbXBNiz34BNM58LPqsg6NqF45e1=xkXE4OpMZnyA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower second update for Linux 6.20-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.com>, 
	Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41379-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9160D78DBD
X-Rspamd-Action: no action

Hi Shuah,

On Tue, Jan 20, 2026 at 9:41=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower second update for Linux 6.20-rc1.
>
> Improve the installation procedure by making this systemd step optional
> enabling users to disable installation of systemd's unit file.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit ff72619e11348ab189e232c59515dd5c33780d=
7c:
>
>    tools/power cpupower: Show C0 in idle-info dump (2025-12-15 12:33:29 -=
0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.20-update-2
>
> for you to fetch changes up to 7799ba2160e4919913ecabca8a7fc1aa4c576fb4:
>
>    cpupower: make systemd unit installation optional (2026-01-16 13:41:26=
 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.20-update-2
>
> Improve the installation procedure by making this systemd step optional
> enabling users to disable installation of systemd's unit file.
>
> ----------------------------------------------------------------
> Jo=C3=A3o Marcos Costa (1):
>        cpupower: make systemd unit installation optional
>
>   tools/power/cpupower/Makefile | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!


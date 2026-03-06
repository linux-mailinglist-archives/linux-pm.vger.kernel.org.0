Return-Path: <linux-pm+bounces-43863-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJY8OVkeq2mPaAEAu9opvQ
	(envelope-from <linux-pm+bounces-43863-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:35:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F454226B7B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB2053023681
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0036EAAF;
	Fri,  6 Mar 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dji6xzzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301A36E474
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822103; cv=none; b=dqYMw6I7AHtFtCQ4+OeEVZxZGlcWypHKVVZOwPWUqLAvDhe/bkW9FjozXvHLPdac7jvBg97eGAb1YEPED3/H4TH045UIHCjBExNAxwxreXhVsaZQ8yO1PgEtm5/v0397IWkK8pTyqmV7YGJB78aOdPSWYlzQJ1nHDA6E8RMmfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822103; c=relaxed/simple;
	bh=fwLRI5Jx/QR+J2uzWzMXZaPPi/j8OrodSn/Mz70/uuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oimn9FtgwIr9UDupK1Tr1DovrVv1mEpud75hYuhKJs8Hd0JMvAxzfzmRsf08fLz8+cZzgTTDOoyoQA7wldTk+zSbZcLIvEQ7yktE8SmzYpHoSmsu3/8cH9FPadLUKJyYNqNDzFfU/Prb0tkP0PXS+Ej9YkBf1Y/N+4+mWc1BBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dji6xzzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A98C4CEF7
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822103;
	bh=fwLRI5Jx/QR+J2uzWzMXZaPPi/j8OrodSn/Mz70/uuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dji6xzzSkOVWrFQzqMJBTg2+HoFdJMKOU0Tw6U7LK+BF3uqR03taBkNJFSg3oo1OY
	 n4hsHxF3dZvT5BReIwG6bHAKCl6WVeCE5XQjgQuw0nH1XJVEu6pDE9DSK4Q3+KOhsL
	 2m0MtA2e7/ZbsYgl1TjkwPsUOGeceqoJSgyVe3DhCn/egA0xQgcvqfwuAGhxK+Jsn1
	 /6igNbmYI1Kw7K6suBlT6qWYuGeDzRq0zUDeatA9MvitGXHElUfyc/6gbJLiXxS+Si
	 MeCY4ZAMcx0Uj6jRFEzgYwOwfbcG8vN2CtjqOHuQ80jhiUJv3HRG+ILg37DJBFQDoC
	 Ye6jCHuQj5Vsg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40974bf7781so3176360fac.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 10:35:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwMJQFphbvyn7KCWowF+MKwZWtkNn6cKf75od4qRJEH/rdZfuH6
	Z5eZ5/RHls4TriDE5Yl/L1012d+/gQ2Zk8ewxY8fECvNp6kTv9z9yqlIJXzSFPGa5C5RY1I0K5h
	vNz7pg9fHHns73daDTthMqYY/rKV4Nko=
X-Received: by 2002:a05:6871:5b1e:b0:409:6148:e23e with SMTP id
 586e51a60fabf-416c3ba2c6fmr4263173fac.10.1772822102337; Fri, 06 Mar 2026
 10:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223210351.344388-2-thorsten.blum@linux.dev> <zmsi4hmhqk6kirjbhs4mrcrxqpl7ajer6u5poob5s5jcw7gwas@bxbddyoqehlh>
In-Reply-To: <zmsi4hmhqk6kirjbhs4mrcrxqpl7ajer6u5poob5s5jcw7gwas@bxbddyoqehlh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 19:34:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXK6xmZuve9X8fo5oE2p9tevhxPa+yDSW9okk0npUccg@mail.gmail.com>
X-Gm-Features: AaiRm52BfZeKU78EqqoT2pQGNXiy-1ua9dlP_woPiweDqnk5ubcMzERMa6A8MGI
Message-ID: <CAJZ5v0hXK6xmZuve9X8fo5oE2p9tevhxPa+yDSW9okk0npUccg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: governor: Use sysfs_emit in sysfs show functions
To: Viresh Kumar <viresh.kumar@linaro.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F454226B7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-43863-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.961];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 5:12=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 23-02-26, 22:03, Thorsten Blum wrote:
> > Replace sprintf() with sysfs_emit() in sysfs show functions.
> > sysfs_emit() is preferred for formatting sysfs output because it
> > provides safer bounds checking.  No functional changes.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/cpufreq/cpufreq_governor.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.1 material, thanks!


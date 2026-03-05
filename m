Return-Path: <linux-pm+bounces-43695-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHEQC0m4qWlEDAEAu9opvQ
	(envelope-from <linux-pm+bounces-43695-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 18:07:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D91215DAA
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF09304A6C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E63DEAFD;
	Thu,  5 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mckz3k4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8D3DEAD2
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730427; cv=none; b=brDB6fDeuKYA9A3qwo3KUWkhuBam+4+Kal7dq+rs6W85D+AmPHEmV0fCbcnwnAxj1HypmfHe1CTtB7pr+v/a9PAUb+wyAX16hBfQq/M75pJ6ZRy7MH1bWfJCcq/c+hfAy2u42ngJIxrD3fMXqnD9KWmJe/cEeX/ermRCpqxL47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730427; c=relaxed/simple;
	bh=cHXbdYTccSGkPhP6wpFZMciZSsoHmfSiWvXXcyOpSeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAiSQ9PvzEP79zehiHGebft99dDOwnIm1e6jqobfd9y8tPodbeZ7VsEjmBYGZBDRKWPS+7X91LLydZh+veZGWiPTPeDDp6AOZgcj+zorCkgLOM4FQRx3rQOWP10JkHWP/5X3mjeaqMrE0Z7g3GyNkrWh9e2XgDntx3dghsPPw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mckz3k4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F33C2BCAF
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772730427;
	bh=cHXbdYTccSGkPhP6wpFZMciZSsoHmfSiWvXXcyOpSeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mckz3k4F/pEBCgYvaKXxmo+eEOsZmIpVvmcNbbrZFad1yMbbCLwTY49+g6X9vafnO
	 ZgTu+vLeHu0UXrCnIUnV2sGrpL4weSitOFec/i+wi9ol7CVY38GTJ3gZr7FJ9ktt+b
	 Z/2spFPyelrLQGdZVyxlJN2Jv5DH7jK3m1dCT2O8Pqr7jyfmVwxh9F6H/WHKtAGaK7
	 jcRE/tWVthcyDu699+LMUX9O3NF3LJil77LbEwj8XoE4b7VYIuOoPbYRuyDpvc/0H8
	 R89YUjqCGuUD/VwCyM1frmhSj0h98bfMligGSZJOc6Fkn44lOmaGaIrRQgcEM9rRe6
	 z2JkNSpnWchvQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1319965fac.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 09:07:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/JAa9E6YNjs653MJGaJ3skk3My/MqShQKw0iUhfAY52k+qWW3l1abQ078A9Wn2Y3ltM0s4QZutA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxDHPZJi83/3qRztmj1DG9caJDKnftCeZxqUpZsuS9l8mUHCo
	ogW01VSlUHbJWWI+mUHkRZh99JJiYgkE4RR+5NA5X9MhLGlDn5NQRUkaPK7g3UrkMJm+363AiEf
	jhj7ebGJSsar4q9Oi80h1YNVUEiwP1gI=
X-Received: by 2002:a05:6871:72c:b0:409:6ea8:5f7f with SMTP id
 586e51a60fabf-416ab595928mr3507225fac.20.1772730426159; Thu, 05 Mar 2026
 09:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-2-aboorvad@linux.ibm.com> <37ab17cd-0488-44bd-9e03-1ba3c0757e8f@roeck-us.net>
In-Reply-To: <37ab17cd-0488-44bd-9e03-1ba3c0757e8f@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 18:06:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKAcAqWuR41bwjjpQuhs6poHrNFwQABeGz1w3j3b6Pww@mail.gmail.com>
X-Gm-Features: AaiRm50w-DhhtUCA12_myPVvf3_l_3tVDRtwhMRuhY3VHHAfMxkv46010ONk_58
Message-ID: <CAJZ5v0hKAcAqWuR41bwjjpQuhs6poHrNFwQABeGz1w3j3b6Pww@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state is available
To: Guenter Roeck <linux@roeck-us.net>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org, christian.loehle@arm.com, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82D91215DAA
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
	TAGGED_FROM(0.00)[bounces-43695-lists,linux-pm=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,roeck-us.net:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 5:53=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Hi,
>
> On Tue, Feb 17, 2026 at 12:20:02AM +0530, Aboorva Devarajan wrote:
> > On certain platforms (PowerNV systems without a power-mgt DT node),
> > cpuidle may register only a single idle state. In cases where that
> > single state is a polling state (state 0), the ladder governor may
> > incorrectly treat state 1 as the first usable state and pass an
> > out-of-bounds index. This can lead to a NULL enter callback being
> > invoked, ultimately resulting in a system crash.
> >
> > [   13.342636] cpuidle-powernv : Only Snooze is available
> > [   13.351854] Faulting instruction address: 0x00000000
> > [   13.376489] NIP [0000000000000000] 0x0
> > [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
> >
> > Fix this by adding a bail-out in cpuidle_select() that returns state 0
> > directly when state_count <=3D 1, bypassing the governor and keeping th=
e
> > tick running.
> >
> > Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START=
 symbol")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index c7876e9e024f..65fbb8e807b9 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_dev=
ice *dev,
> >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *=
dev,
> >                  bool *stop_tick)
> >  {
> > +     /*
> > +      * If there is only a single idle state (or none), there is nothi=
ng
> > +      * meaningful for the governor to choose. Skip the governor and
> > +      * always use state 0 with the tick running.
> > +      */
> > +     if (drv->state_count <=3D 1) {
> > +             *stop_tick =3D false;
> > +             return 0;
> > +     }
> > +
>
> An experimental AI review agent provided the following feedback:
>
>  Does this unconditionally keep the tick running on systems that only hav=
e a
>  single non-polling idle state (like basic ARM systems that only support =
WFI)?
>
>  Before this patch, governors like menu would check CPUIDLE_FLAG_POLLING =
before
>  deciding to keep the tick running. Could this change effectively disable
>  NO_HZ_IDLE on these systems, causing higher power consumption?
>
> I don't know scheduling well enough to understand if this is a real probl=
em,
> but I thought it is worth mentioning it.
>
> Please let me know if the problem is real or not so I can feed it back in=
to
> the agent.

On bare metal, this isn't a problem at least in practice because the
only available idle state cannot be too deep anyway, so stopping the
tick doesn't improve energy efficiency too much and it adds overhead.

On virt, it may be a problem if the tick that runs in the VM
effectively prevents the host from using deep idle states, but that
would only matter for VMs running on systems that have deep enough
idle state in configurations where the VM has only one idle state.

This is kind of under discussion in a separate thread here:
https://lore.kernel.org/lkml/20260301192915.171574741@kernel.org/#r


Return-Path: <linux-pm+bounces-41647-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ky5GFl/emmF7AEAu9opvQ
	(envelope-from <linux-pm+bounces-41647-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:27:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15BA91BC
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EE3302F737
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C433B6ED;
	Wed, 28 Jan 2026 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQFz8JB6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64D2EC0A3
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635669; cv=none; b=K7Q0f60KnuhHYWqQoZAFDgKXipx8LWGAq098hTVBUYE9G4Wb/mFEaEVuP/Fn9olxKezUfkVAS16bB6iR/0r9G1wiwLwcZiVJiRvBvme5QBuYtpXBqQByC7kOhN+MVymgLEWD0JPoGWDuHqI2TPbcd1OiuYq6TzTydzDWJYMpj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635669; c=relaxed/simple;
	bh=RxgjmEp30ULU/g5Fq3w6FBxL1x6mLpqjkaZoLJPASmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfNgVI0egV80xS6IMH4ZccNOrIlFsjakCAzjAbGnOERKSFWEAIsl8MANz31hcsiNVs/1cgib0GclqnzsQwpXrb9p+Z6RU8DM3JteOLvpn/9wXL19hsfwgGGhps24WniYzjNKijvsP8Kogr2ZbYmHy7elgxgrWHzrdVBPGY+gExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQFz8JB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B5FC2BC86
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769635669;
	bh=RxgjmEp30ULU/g5Fq3w6FBxL1x6mLpqjkaZoLJPASmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQFz8JB6SWZGlbMOv+p8Oh1zGdlAF0lYXR9ffJ7v890NeCJFoLlQUrRRxq6AEt8b9
	 h/c9yjbzAtthSpyPgbgTGeU6g0eTbFwOu/5A14JYf01TU54v69HfCrdu0PWm0ivb6X
	 BaPTtYvoyt7lhzO9scsAYQaPB9TRBzvfWOuqlAElP4CtfhYAp8UhORrG6Xy6t2h8lc
	 294Bxrz9akudvQq90cJa9yi5bzDd1Q6Rmax4aOFZOkYAJe01U7xrVMHyIMN+BP+yn4
	 ngVEnOBHI/TRGGH9awj5IIt5cVe5uZZeJh25kDkVPwCR7Um7qK0Q5OiMeEM9bRuedx
	 9WBMLX7GzQNsw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4096aab5521so200538fac.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 13:27:48 -0800 (PST)
X-Gm-Message-State: AOJu0YwiBSRUNMjcI54wPWCY9+m42SQDOB8/xZ619DgL1apotNPMv8Wf
	aj/EdnhOrsAPFHoeTqaIJ9f7rxmYFdDGJWr6PhsDgSB4mUTupkrIlayZ0nrRu1AhA0497k9kZdL
	JOKXUatyYQi5su8mXTviDu3rMtOkj5qo=
X-Received: by 2002:a05:6820:134f:b0:662:ecc7:7193 with SMTP id
 006d021491bc7-662f20d5753mr3512943eaf.54.1769635668024; Wed, 28 Jan 2026
 13:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116094623.2980031-1-zhangpengjie2@huawei.com> <ny7npyivbpk3zaf3dm6h3ves4azp75hzmrqmpiex3nauuzrzmt@zf3rto3vrjbq>
In-Reply-To: <ny7npyivbpk3zaf3dm6h3ves4azp75hzmrqmpiex3nauuzrzmt@zf3rto3vrjbq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 22:27:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g+TzQN6AxejRHkrmpWiuKqOLZJ4WJSjxvPpGQELZAdsA@mail.gmail.com>
X-Gm-Features: AZwV_Qg5uDzF72FpYYiP86NuPEYAAOyFRW9un7T4xqi1CdYHTx3tUBvmVNfFuz4
Message-ID: <CAJZ5v0g+TzQN6AxejRHkrmpWiuKqOLZJ4WJSjxvPpGQELZAdsA@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq: userspace: make scaling_setspeed return the
 actual requested frequency
To: Viresh Kumar <viresh.kumar@linaro.org>, Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41647-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linaro.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF15BA91BC
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 9:28=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 16-01-26, 17:46, Pengjie Zhang wrote:
> > According to the Linux kernel ABI documentation for 'scaling_setspeed':
> >   "It returns the last frequency requested by the governor (in kHz) or
> >    can be written to in order to set a new frequency for the policy."
> >
> > However, the current implementation of show_speed() returns 'policy->cu=
r'.
> > 'policy->cur' represents the frequency after the driver has
> > resolved the request against the hardware frequency table and applied
> > policy limits (min/max).
> >
> > This creates a discrepancy between the documentation/user expectation a=
nd
> > the actual code behavior. For instance:
> >
> > 1. User writes a value to 'scaling_setspeed' that is not in the OPP tab=
le
> >    (e.g., user asks for A, driver rounds it to B).
> > 2. User reads 'scaling_setspeed'.
> > 3. Code returns B ('policy->cur').
> > 4. User expects A (the "frequency requested"), but gets B.
> >
> > This patch changes show_speed() to return 'userspace->setspeed', which
> > stores the actual value last requested by the user. This restores the
> > read/write symmetry of the attribute and aligns the code with the ABI
> > description.
> >
> > The effective frequency can still be observed via 'scaling_cur_freq' or
> > 'cpuinfo_cur_freq', preserving the distinction between "what was
> > requested" (setspeed) and "what is effective" (cur_freq).
> >
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq_userspace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpuf=
req_userspace.c
> > index 77d62152cd38..4bd62e6c5c51 100644
> > --- a/drivers/cpufreq/cpufreq_userspace.c
> > +++ b/drivers/cpufreq/cpufreq_userspace.c
> > @@ -49,7 +49,9 @@ static int cpufreq_set(struct cpufreq_policy *policy,=
 unsigned int freq)
> >
> >  static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
> >  {
> > -     return sprintf(buf, "%u\n", policy->cur);
> > +     struct userspace_policy *userspace =3D policy->governor_data;
> > +
> > +     return sprintf(buf, "%u\n", userspace->setspeed);
> >  }
> >
> >  static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy=
)
>
> Looks okay to me.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.20 material, thanks!


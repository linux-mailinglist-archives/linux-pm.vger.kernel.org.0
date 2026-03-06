Return-Path: <linux-pm+bounces-43860-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP23ABsaq2lNaAEAu9opvQ
	(envelope-from <linux-pm+bounces-43860-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:16:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67D2269C5
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0933F302D118
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFD36CE0C;
	Fri,  6 Mar 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxDPksDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C2344DA4
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821016; cv=none; b=O/TVb1TNjPhAcTahOyucbnBVLDBdmRp19pNSRrFsX33pEkeQ9pxGsDJecWU1hNJP1Ixjbjft7d5tMbrOxtfJj/pVuAHHAV+wDGFuAyzitRLR9z2evmx2iPNzhN1rBa/7VKhcpIGQ8881tre0ylx2G2Hi8OpAXwgwQygo/4oHyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821016; c=relaxed/simple;
	bh=LfZ74cz3WH7daqyCfziyu4zAq4NwOyPGCoUPlt8yedY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlKumKjs7c9LWbY41rL36TiRDOgeXJtDXLKDn1gBmateYDa0WjBuxzQwljBrttGypwAo82qXCe47Es4vkTYMNqaEEtFze7F1g3hVBb4W5hWvPzIZmZwVD8aaAYp1sXkKr9nbNGCKphoX6S1pO7Qz8mV/NXNM9D9H0BEUxCmPmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxDPksDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD44C2BC86
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772821015;
	bh=LfZ74cz3WH7daqyCfziyu4zAq4NwOyPGCoUPlt8yedY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mxDPksDiRqOw6XhCciwkr8sG4LZMJnpyVLeIicpT+nHcUF9uYhlx8Qr2qaD8aAQf9
	 LLHyMxFWBxqjQ+aAklgLpLF8d12PdYyUW0LpSwmdDroko5k9DuCj9pgCCYYhCi18Pg
	 XkCWUcwOH3LTLRKggf0oF098d0bZByUCS2tst1o8E4JTPjLj/Hm7McsZW7MVbCtqlG
	 0/181TzWOEe1Xp6HUII2OLhfvSJL3//L2CItWO/eckZoVIx3W39tsqrgBrDkeXWUR1
	 PmFVXyyk6/nPHHlfNaj4N5Y8Gq4jijCDmb7aD2nT/E81ULiK12XkVoezWGu38/klJ6
	 MbC99PIsxoD8A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-413c2977db8so3016129fac.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 10:16:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV457XCXToMp7XpbdMOzqBmO6VOATHJ4HUaysKp/vyM2C8OehWfOm0/5ZXIEgWwKbeK1iZYJhF2/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jxrt8FW6+6Nc/+GmhKUnt5uGl+ajy+NNaHoDSJWF5EdrAZuk
	uTIgri+Q5xoXYq4uw+i2B665tm9TqLSW/WvhB7bEv5ZGnXViWURJ6qvFVPMVZD2Bt5MR//FInGa
	vLRlT2CHj0dY0ItVt6b3DIN1eVjQ6mLU=
X-Received: by 2002:a05:6870:a789:b0:409:4842:5d0d with SMTP id
 586e51a60fabf-416e3e6f722mr1848319fac.5.1772821015008; Fri, 06 Mar 2026
 10:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com> <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
 <a5827299-28e8-480f-a250-5f3eed8dd128@arm.com>
In-Reply-To: <a5827299-28e8-480f-a250-5f3eed8dd128@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 19:16:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hSb0fp65MWcLmeoGqmXu9znpnip8QfZJ9wcp8-YY010Q@mail.gmail.com>
X-Gm-Features: AaiRm53z_AEo84Q3kaimBbZBIo8FE4ai8rqx7HDoeiiTz8Dh5mmiP1WtnxClc6A
Message-ID: <CAJZ5v0hSb0fp65MWcLmeoGqmXu9znpnip8QfZJ9wcp8-YY010Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to lowest_nonlinear_perf
To: Pierre Gondois <pierre.gondois@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "zhangpengjie (A)" <zhangpengjie2@huawei.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Prashant Malani <pmalani@google.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	linhongye@h-partners.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A67D2269C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43860-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 4:09=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.c=
om> wrote:
>
> Hello Viresh,
>
> There are already quite some people, but please add me aswell.

OK, so is there a consensus about this particular change?

I guess I'll need to take this one if everyone is fine with it because
I have picked up some ACPI CPPC library change that was combined with
cpufre_cppc code.

> On 3/5/26 07:32, Viresh Kumar wrote:
> > Added few more people
> >
> > I think we should updated MAINTAINERS with a list of reviewers or maint=
ainers
> > for the CPPC driver. Who all want to be part of the reviewers list ?
> >
> > On 03-03-26, 20:03, zhangpengjie (A) wrote:
> >> Just a gentle ping on this patch.
> >> Thanks, Pengjie
> >>
> >> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
> >>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
> >>> linear performance scaling. Performance levels below this threshold
> >>> are typically inefficient and should not be used by default.
> >>>
> >>> Currently, the QoS minimum request is initialized to 0. This defaults
> >>> the performance floor to the absolute "Lowest Performance" state
> >>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
> >>> an inefficient range unnecessarily.
> >>>
> >>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> >>> ---
> >>> Changes in v2:
> >>>     - Renamed the patch subject to better reflect the logic change.
> >>>     - Updated the commit log to clarify ACPI spec details.
> >>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhang=
pengjie2@huawei.com/
> >>> ---
> >>>    drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
> >>>    1 file changed, 16 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cp=
ufreq.c
> >>> index 7e8042efedd1..4a3031d9fcf4 100644
> >>> --- a/drivers/cpufreq/cppc_cpufreq.c
> >>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(str=
uct cpufreq_policy *policy,
> >>>     return target_freq;
> >>>    }
> >>> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
> >>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_dat=
a)
> >>>    {
> >>> -   cpufreq_verify_within_cpu_limits(policy);
> >>> +   if (policy_data->min =3D=3D FREQ_QOS_MIN_DEFAULT_VALUE) {
> >>> +           struct cpufreq_policy *policy __free(put_cpufreq_policy) =
=3D
> >>> +                                         cpufreq_cpu_get(policy_data=
->cpu);
> >>> +           struct cppc_cpudata *cpu_data;
> >>> +
> >>> +           if (!policy)
> >>> +                   return -EINVAL;
> >>> +
> >>> +           cpu_data =3D policy->driver_data;
> >>> +           policy_data->min =3D cppc_perf_to_khz(&cpu_data->perf_cap=
s,
> >>> +                   cpu_data->perf_caps.lowest_nonlinear_perf);
> >>> +   }
> >>> +
> >>> +   cpufreq_verify_within_cpu_limits(policy_data);
> >>> +
> >>>     return 0;
> >>>    }


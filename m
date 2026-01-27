Return-Path: <linux-pm+bounces-41562-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH/5IFjjeGlJtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41562-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:10:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567697781
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8C1300B3CB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55535EDBE;
	Tue, 27 Jan 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlwuDaH6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A735D611
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530096; cv=none; b=IANHhQjGau5wTBylqlH3D9UQ3Hc2+1LIHKfCWVliJH6mzNcNgUlUhIj2GP6FZdFCWgS2ulGqIA+VRuHpvUjeV8Mmbw5okY/JUS0ypafDYuCLSPf2B/C+0MOiQIWVPeE52T4Z9N0LgVuA2z6WelV5BrnJz+cWR51ip2EmkTWoY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530096; c=relaxed/simple;
	bh=JjEGJSn4+byJ8bIrTCUWp7vAx/191L7akBfHgovlkG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/0eNI6o7LPDJPTz20w44q7ZLR8w8AOOtkkYSplTnxSf334e/HEEVCR7Lw3hwvLiyEqamO9OEmaY/uvh4mRufoZTUuvPiWizyPpJOrAj0IzgRtLi1BGhRiA1ELR6mq1yUfF0E+iXUycV9625SE3P+UaANY3nEtw8HLjQ2YYeriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlwuDaH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7A8C2BC9E
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530096;
	bh=JjEGJSn4+byJ8bIrTCUWp7vAx/191L7akBfHgovlkG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jlwuDaH6vETxCa4L4Mv6D2u4Pc8DjoDg0JeJBXPdT6Y/Nt2mm7IERGGOLXIxNf21I
	 UsnZcYgNitHmPLkBHmsYkJUAYYIAmdBDitgFYui/9s95RU2mO7VmL9flvHd6bIy7jB
	 FhPuc9p5dyoKfHn/V7eJKlds/RW0QjklZUjdYyaJCP7gWyMc4+LPW5FzKBtXqhlE5/
	 /AGrOIflh0w+uMNI31GUWeYS0xcIpZk2Q1Zhc2VYgDH011n0zFvJ3IkjlDZh/g07zy
	 0WsHCmcH724441ysSaMlOvsWlo+W1kHo7+OfkaTMtAkhYpRW5NO5hOZr47dAXu747m
	 YFgTSUdX6dhnw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6611cab8ca3so1940238eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:08:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQOQCGCwE5yqWItn3N20MRQlTrd053e0VCYrUDQVl9uvloCe3XWggMWPF/E9TFW9LDy3xdSz08vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaogRRk3EzgRARO14OwjRRgXUajqPxoZ9G+Ahgwh5f8iKamRX
	t4znSyHLmIJqth/vfGbXscoSGylAs+qIsbIWJYkOKci1oE5CH61jbEfhofK8ZfhHs0vOkMrJEBg
	pm25TU7sNzlXegMaeC7Dxbvc0/911ECc=
X-Received: by 2002:a05:6820:4dee:b0:657:48ac:99f4 with SMTP id
 006d021491bc7-662f208c42bmr1336638eaf.1.1769530095140; Tue, 27 Jan 2026
 08:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
 <20260122155549.GA18021@ranerica-svr.sc.intel.com> <7cc76b59-964d-4ce2-b3c4-e1337dbe0c67@kylinos.cn>
 <CAJZ5v0ipPwmBe0bxKBJc203ug6ENzT6OEaOruyL=vUw6NWMZfQ@mail.gmail.com> <b9c9eb84-04a9-4a16-9a31-df8216f3460b@kylinos.cn>
In-Reply-To: <b9c9eb84-04a9-4a16-9a31-df8216f3460b@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:08:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-Kw8WLJZO5s5NsHTdGC5gomxeXDcbRLFhFoVmm43s9A@mail.gmail.com>
X-Gm-Features: AZwV_Qi6OSU8y3of3CjsemTOC7eu9iVOUpFjnAWbqh13TFDK3Yl0m5qIZjDzPog
Message-ID: <CAJZ5v0h-Kw8WLJZO5s5NsHTdGC5gomxeXDcbRLFhFoVmm43s9A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems
 are enabled
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	srinivas.pandruvada@linux.intel.com, lenb@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-41562-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0567697781
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 3:15=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
>
> =E5=9C=A8 2026/1/24 04:12, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Fri, Jan 23, 2026 at 2:20=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylin=
os.cn> wrote:
> >>
> >> =E5=9C=A8 2026/1/22 23:55, Ricardo Neri =E5=86=99=E9=81=93:
> >>> On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
> >>>> When hwp_is_hybrid && !sched_smt_active(), the driver enables
> >>>> hybrid_capacity_scale and disables ITMT. According to the original c=
ode
> >>>> logic, these related actions are one-time operations; therefore, I
> >>>> believe the original design intent did not support dynamic runtime
> >>>> switching.
> >>>>
> >>>> However, SMT can be toggled via related interfaces in /sys. When SMT=
 is
> >>>> enabled, the system is no longer hybrid, and the original settings b=
ecome
> >>>> incorrect.
> >>> Indeed I was able to enable SMT siblings:
> >>>
> >>>        $ echo on > /sys/devices/system/cpu/smt
> >>>        $ echo 1 > /sys/devices/system/cpu/cpu1/online
> >>>
> >>>> To resolve this confusion, permanently disable SMT by calling
> >>>> cpuhp_smt_disable().
> >>> IMHO, the user should be able to enable SMT back if she or he chooses=
 to. Instead,
> >>> the sched domains should be rebuilt with asym packing and without asy=
mmetric
> >>> capacity.
> >> Yes, I also agree with this viewpoint.
> > I don't agree though.
> >
> >> I think a better solution is to
> >> place it within cpufreq online for heterogeneous judgment and to clear=
ly
> >> address sched domain rebuilt and asymmetry issues.
> > Maybe in theory, but in practice the EAS-related code in intel_pstate
> > really only targets systems with no SMT.
> >
> > While it is possible to use it on SMT systems with SMT disabled, I
> > really wouldn't recommend doing that beyond debug/diagnostics and no,
> > it is not sufficient to disable stuff when SMT is re-enabled, you'd
> > basically need to unregister the driver and register it from scratch
> > in that case.
> Thank you for your explanation. It seems I didn=E2=80=99t read the docume=
nt
> carefully enough before.
>
> >
> >> I ran some tests the
> >> day before yesterday and encountered a few locking problems. I will
> >> publish the patch a bit later.
> > Given the complexity involved, I don't think it is worth the effort.
> >
> > I can apply this patch though.
>
> Um, although I've already done it, I agree with your point.
>
> Besides, I don't think this patch is very suitable either, because I
> supposethat on a n system without SMT, the SMT-related|/sys|interface
> should indicate unsupported (though I don't have such a machine).
>
> Moreover, based on the previous discussion, would it be more appropriate
> to use !cpu_smt_possible() instead of !sched_smt_active()? After all,
> the original design was intended for systems without SMT. If you also
> agree with this perspective, I can test it on a machine with SMT.

Yes, please!

Using cpu_smt_possible() instead of sched_smt_active() would be the
most straightforward way to address this, provided that it works.


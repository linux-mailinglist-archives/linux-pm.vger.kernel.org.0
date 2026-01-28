Return-Path: <linux-pm+bounces-41637-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA84DnVRemnk5AEAu9opvQ
	(envelope-from <linux-pm+bounces-41637-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:12:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB93A78FC
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BAA030D3055
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F1374161;
	Wed, 28 Jan 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0lk8F/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD1371044
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623556; cv=none; b=MpnA/pMWVOZ9pClHh0GuXHu+JsRjHrCd9SPoJBwmd42EOP6V8+HrM0dOCOPnjbSTYKGXP6FjP0Rql35g8lIFi4mBgaHsGDYSYZLOiLkjf0MdScpoUr5h8DhfFQDZelON6ofbBag3e7sqrAQbgsJG89/W+oJBQdXXsOLOKCmWYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623556; c=relaxed/simple;
	bh=zW/SEQETQkWqKGvjJtFU4mZeXcsTJT41jjunCxVykGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKDaiqo2NoEbIz6SFEe/nY0sN94HS1YMcNc+0LZpx6aHOoWNEpfpKta3y4QnDkHeYAk+IAw/4Wo6qLat+hvtKrZCgTetdeGNAPTxAppEX9vzYoLKgqAuQx5V1ozbmg9CGRB6Q8MQ2xm94yZLHfpgEHFqhUp7LG/6v6EduU+Jj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0lk8F/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A425C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623556;
	bh=zW/SEQETQkWqKGvjJtFU4mZeXcsTJT41jjunCxVykGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c0lk8F/bFRm5BhV6LWbFkomzlYCgJwkyJi2GHe8crXgRQCY+e0mwg5nRrQW0a2+Un
	 b8DZObL5da6lC5H10dgnLDGSYKr7ky9Sg2HI+2qaWMgFksB5Gsyr9fQK+jeVSRVHuJ
	 dP1gBG6gaiVH8oZIteGuQr0fyzS0F8YVqsSuIixIMRaSgAwZlYw68ltPnOnLDG/+cZ
	 npMtBskTg53PfEs4eVjBiLMTqc4GZcCuMw337jLZzXwSeITwVaH9imgDOMe0sLAjZd
	 ZKogAlG7bwPx0y6h8x+gWXeTPyYIwqKAprCXqYS/Qktbw5v5lSexEPkbxWttR4u1lI
	 K+n5413PfcoDQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404263bd58fso734470fac.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 10:05:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwEd65dT38TrJID6DvAYG4BiU+tezmIYhG4eK1hrQ75cnzZW4yXEg29jdbFrxHSsDZL3b16NXLgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMb5uiUtGw3k/wiASCu59vSez3CjxM6mh/8Jk/At0opH0l8Ip
	sLnfJl1KBVG3QtyAfKWyN6Zvl5KIZWJ9rLwdnePnsmZ1gkVwVnzzzO5sMwqtD2ghwmS8Z1XRPPP
	A4kPJq5d87yHheZUORoFpx1MYLLxNE+E=
X-Received: by 2002:a05:6820:1f03:b0:662:89e0:2308 with SMTP id
 006d021491bc7-6630612825bmr129940eaf.8.1769623555386; Wed, 28 Jan 2026
 10:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5959091.DvuYhMxLoT@rafael.j.wysocki> <004801dc9015$b9715ec0$2c541c40$@telus.net>
In-Reply-To: <004801dc9015$b9715ec0$2c541c40$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 19:05:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hqkdzbVkSBrMRw9BEQRowxtVTMHCAsffXT=P_otg++pQ@mail.gmail.com>
X-Gm-Features: AZwV_Qj47YXF3Hfff8qNcnUtAs3Y9aIqm3x339WFRjeh-7Psq69z91mkfuvaDWU
Message-ID: <CAJZ5v0hqkdzbVkSBrMRw9BEQRowxtVTMHCAsffXT=P_otg++pQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Always check timers with
 tick stopped
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-41637-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: BAB93A78FC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 6:19=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2026.01.20 07:26 Rafael J. Wysocki wrote:
> >From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After commit 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_len=
gth()
> > call in some cases"), if the return value of get_typical_interval()
> > multiplied by NSEC_PER_USEC is not greater than RESIDENCY_THRESHOLD_NS,
> > the menu governor will skip computing the time till the closest timer.
> > If that happens when the tick has been stopped already, the selected
> > idle state may be too deep due to the subsequent check comparing
> > predicted_ns with TICK_NSEC and causing its value to be replaced with
> > the expected time till the closest timer, which is KTIME_MAX in that
> > case.  That will cause the deepest enabled idle state to be selected,
> > but the time till the closest timer very well may be shorter than the
> > target residency of that state, in which case a shallower state should
> > be used.
> >
> > Address this by making menu_select() always compute the time till the
> > closest timer when the tick has been stopped.
> >
> > Also move the predicted_ns check mentioned above into the branch in
> > which the time till the closest timer is determined because it only
> > needs to be done in that case.
> >
> > Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() =
call in some cases")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> ... snip ...
>
> I have been testing with this patch, and have not observed any difference
> in test results and energy use with and without this patch.
> A couple of graphs are attached.
> I did this work on top of the teo work, so those results are on the graph=
s also.
>
> Legend:
> rc5 =3D kernel 6.19-rc5
> rjw =3D kernel 6.19-rc5 + original teo 5 patch set
> rjw-1-1 =3D kernel 6.19-rc5 + current teo 5 patch set
> (note: Not including the most recent V2 of patch 5 of 5,
> now a newer 2 patch set.)
> menu =3D kernel 6.19-rc5
> menu-rjw =3D kernel 6.19-rc5 + this patch.
> disable =3D all idle states except state 0 disabled, as a reference plot,=
 at the cost of energy.

Thanks for the data!

I think it is most likely to make a difference for the setups
involving CPU isolation.


Return-Path: <linux-pm+bounces-42511-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABIfJGWpjGkusAAAu9opvQ
	(envelope-from <linux-pm+bounces-42511-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:08:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F6125F49
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592CC3015456
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87133A005;
	Wed, 11 Feb 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ZhKQAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B429339719
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826072; cv=none; b=UyQNAioKmHnEhgwrpamtwKt2C94I70UUUSQX0iL/ZXbOgK/SmSLIFcDlAuTFz6PWZLRA1ZrGe1woTw/7rYqEulEtCX/S1he5x8CmEyVlELhGCR6w9bb3xhThJf2h9ZkPOvZEfxLZXpGX8LErBSknC5rYlBe5opC2So9GHsOnLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826072; c=relaxed/simple;
	bh=s3JmlDX6uVJ8R0nvQCkr1ExhWZ0FpyZMY91TVWc1vvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsb99twM7TybaWLSa9OghhV++FFGWKtI4le1MR7q2Q2XUtk7n0fWsL0n3nvPY4Uh4OfUVdtf+nicSbRovuIkiNJkJVdqXRrjUyyeEqS6ZYw/OS8n2EhYhR9/JHBUQOiJixaab2EG2e0O5RoP8UO7iQjwNmqohjb0R4HZ936xyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ZhKQAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA47C19424
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770826072;
	bh=s3JmlDX6uVJ8R0nvQCkr1ExhWZ0FpyZMY91TVWc1vvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O+ZhKQAGiI5PNvwL4jeS8eRcNVVBBKdnl6mwcMONzDKcdqu5AFVXoR50JdOyDNZct
	 kJPRUnEfWgHIaq6oorhHm0r6kxHueYeMQKfVG3LDEd2eMWPWqohC8Lst0DbL/d7GUX
	 YqRdkT28g1Dr9GFVvv4+2imNVv4DcYLy5a1xDBov6eXA4jFFwtUS8ISY8ZlXcaUii4
	 h8P7O2UC0zaboQU+ROM2bI7zyYj/BsStZlLqoxbeViVDA9kC7boY5xmTle1zDxlyAB
	 1zKZIZdRcq20H5H3JCzYbbSKO48nX8ggDnD3NNdV0+nkR7cX1vkiq7w++ba1gzF2kK
	 cINv9xWdid1tg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042905015cso3310347fac.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 08:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzeq+/hHDwQ+gWhgmznAC043+G9gE3mN7odLzgxjlfsROYCrJ3niAv6QFXv/nJDMKKDIsJMbpbqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJ5SrPJWvLbR1kJd5iCVLfsc1CPpDZDh3asPAXe/IGIKBfbyY
	vmiJzEBmShHVa50YqFTBFN8ec/hdsJANTvEeZNT/swkoMeDnA9ysip1b6LM/eyn0/+NK9LHCNjU
	QaHUaI6T1ZasHT53wIfWpCzoHRhgLMtg=
X-Received: by 2002:a05:6820:178c:b0:664:7c2b:c79e with SMTP id
 006d021491bc7-6743aa0c95dmr1556170eaf.62.1770826071003; Wed, 11 Feb 2026
 08:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
 <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
 <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <861b65f7-6d84-41f1-a284-95e99f37fc68@linuxfoundation.org> <LV3PR11MB8768B808DDC32B24D8F3D10DF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB8768B808DDC32B24D8F3D10DF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 17:07:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+iQZ35nvSc352bVv0x9FRCPPAfWX2-UdwnBPaNmGugA@mail.gmail.com>
X-Gm-Features: AZwV_QgORbJdbo6zlZGHVCaM6CWuEZkhbWDSM4wMYReysVhkwSUHw3PzPtsAjis
Message-ID: <CAJZ5v0j+iQZ35nvSc352bVv0x9FRCPPAfWX2-UdwnBPaNmGugA@mail.gmail.com>
Subject: Re: [PATCH] cpupower: Remove incorrect EPP dependency in get_latency()
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "trenn@suse.com" <trenn@suse.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com" <jwyatt@redhat.com>, 
	"jkacur@redhat.com" <jkacur@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42511-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E35F6125F49
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 5:05=E2=80=AFPM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> On 2/8/26 09:15, Shuah Khan wrote:
> > On 2/7/26 21:34, Kumar, Kaushlendra wrote:
> >> On 2/7/26 14:23, Shuah Khan wrote:
> >>> On 2/4/26 04:11, Kaushlendra Kumar wrote:
> >>>> The get_latency() function incorrectly called get_epp() and returned
> >>>> error if EPP (Energy Performance Preference) was not available, even
> >>>> though transition latency and EPP are completely independent CPU
> >>>> frequency features.
> >>>
> >>> How did you find this problem? Are EPP and CPU frequency features
> >>> independent on non-intel platforms?
> >>
> >> Hi Shuah,
> >>
> >> Why do we need to call get_epp() after capturing the latency?
> >>
> >> The erroneous get_epp() check can cause get_latency() to fail, even th=
ough valid latency information is available.
> >
> > You didn't answer my second question about non-intel platforms?
>
> Hi Shuah,
>
> EPP (Energy Performance Preference) is Intel-specific and part of Intel's=
 Hardware P-States.

That's not actually correct, EPP is part of ACPI CPPC now and
amd-pstate uses it.  cppc_cpufreq uses it too IIRC.

> So, on non intel platforms these are not related.

Please double check.


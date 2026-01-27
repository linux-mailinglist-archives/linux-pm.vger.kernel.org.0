Return-Path: <linux-pm+bounces-41535-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF5yLSrGeGmltAEAu9opvQ
	(envelope-from <linux-pm+bounces-41535-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:05:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7339550D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0C3C3081844
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65D35B127;
	Tue, 27 Jan 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGs5FGUX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F335A954
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521976; cv=none; b=AAZNysIEWloi4C1o+rlHpOeqhRIOHE9e5iOkQitTIGEzSY/6UUy5tfba+s4CjV8j8fWEySu8UcgkXp8QKt2WC3m0kciKFO+m89ANS1RbQVof32kr98swX1rmNuIV6N+pxm2T4hcG21Fw0gdCOYgsRotWct3ZluXKMGxH7RzSRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521976; c=relaxed/simple;
	bh=Swvs728l6GQF/8r+UWmLWYcHQjIO+XT13zy8oa+4lCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcJFQ5UH14bUAyoBHN5TLWnrBOrobCpOSuHeq6e8nZVQt1P4SUJkU9zPfm9A1cDuNmTSw7Bv5jQ8wNKRDlWWNEZhsRBb8bKOuG0mv2D9Cik+M7Xvb50k4aghblpa55tYd+lrzIO6zXdm4BAjsKw3sp/sqnVcXh198ro2PfFBvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGs5FGUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4474DC16AAE
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521976;
	bh=Swvs728l6GQF/8r+UWmLWYcHQjIO+XT13zy8oa+4lCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WGs5FGUXMEqpc799ysZBfg0UsvLcUg4i8AyJLzWBo2//K/ddAESby9xLAg+19GIXI
	 wvLO68y2/soMcaiLgvoT8MB9miBwHgFe9PSh2FQJ5WHhLSulJmorg/eAF3bPINUXD0
	 iwq/68oM7WaOrqwW+yn0x4i53bB1c7+IYA0z2pT+I0+PKPN4rq59EKLAV/RTdpSpUT
	 sc/QBSCvLC1JDNV/GuLkkW2GXUh+6e8i4s2F9EMQDvkFi/sgcFYBrEMogsa4ubShlg
	 hASmyI/OKslXHcf9lQcQvN0fabe3H7DW+Otf/ZYtAwYVTSAuoZlUHsCNitEcri9Fsz
	 GSF3Dy3gteJ3A==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40438a46d7cso3596249fac.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:52:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm1BQHq+mIuS6oa6l4LJ7eRncYnbRik4Bdl5YGFxVfTjghajOMxV2r4LBGkVxaHEi4FDuYVMtLnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeuvcxvbLvJsrow1635IdpNJLZwWr9VBcr5SCEPFC3UDmkhkT
	knNT1Mr88fS6uGlqWk5f5jQlC+snCobdf61+PJz5qpeiIzDWOAic1xeQM1DerGKVECZD+2WGRvB
	0057gWPllccxBTCXI3eKE9udyykPuE9I=
X-Received: by 2002:a4a:c893:0:b0:662:f452:648f with SMTP id
 006d021491bc7-662f45267bbmr521120eaf.17.1769521975285; Tue, 27 Jan 2026
 05:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wf7r3yfa3gywn7r7cl5yl43c2r5627nyrkqjc2y4nl3ng2savf@koymn3rhll7b>
In-Reply-To: <wf7r3yfa3gywn7r7cl5yl43c2r5627nyrkqjc2y4nl3ng2savf@koymn3rhll7b>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 14:52:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=O0D1u3yZ1k8x8zYauKNRBj4ZKxk+EMtrEe-J8jO55Q@mail.gmail.com>
X-Gm-Features: AZwV_QgyxHMYaNvl52u71b-Fmq1TtQHRFlbrf-k9qNNL5gp5pmfjD59TNIs2j-w
Message-ID: <CAJZ5v0g=O0D1u3yZ1k8x8zYauKNRBj4ZKxk+EMtrEe-J8jO55Q@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates 7.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-41535-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 1E7339550D
X-Rspamd-Action: no action

Hi Viresh,

On Tue, Jan 27, 2026 at 7:57=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1=
e8:
>
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-7.0-rc1
>
> for you to fetch changes up to 0b7277e02dabba2a9921a7f4761ae6e627e7297a:
>
>   OPP: Return correct value in dev_pm_opp_get_level (2026-01-27 10:58:50 =
+0530)
>
> ----------------------------------------------------------------
> OPP updates for 7.0
>
> - Return correct value in dev_pm_opp_get_level (Aleks Todorov).
>
> - Use scoped for each OF child loop (Krzysztof Kozlowski).
>
> ----------------------------------------------------------------
> Aleks Todorov (1):
>       OPP: Return correct value in dev_pm_opp_get_level
>
> Krzysztof Kozlowski (1):
>       OPP: of: Simplify with scoped for each OF child loop
>
>  drivers/opp/core.c | 2 +-
>  drivers/opp/of.c   | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!


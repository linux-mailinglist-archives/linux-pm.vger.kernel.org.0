Return-Path: <linux-pm+bounces-42619-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBjzMV1pj2lHQwEAu9opvQ
	(envelope-from <linux-pm+bounces-42619-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 19:11:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B5138D59
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1D73011F21
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1A30E0FB;
	Fri, 13 Feb 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBItYnPg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FA26738B
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006298; cv=none; b=GR5QYyUWmKEANV/vQIb36w5ulEc/eyxTQVdHzL/DlKqduRtFkQ8WwuwJAO/xM6lmeuDXQyvCwkFE5LTcosoT+ViuvuT4LKBsqI+3r4dHszA+GHv2eiT2XOsSPrpQh83KFNggl03U8K8IeyoRfkVgtxu7LBd5VhJ2zj9dEP0F8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006298; c=relaxed/simple;
	bh=xtjukwYcDPaMf1tilncRW/lVbLNzxia64I7G5rbz/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQmnMKkXvAWEN47TECzFtpnAtjY8H8OX8svQtm34O+xygWbdKmwNLVfcod0PIraKNoJksieP8M19wqbwITY+AqVRZoJ12yI7RwdEeFvwVlqlV37T7S0RYLQV654u4uQLosYxAT7hqCrOcrKSpvceeljjGaMWwJWeRbRYVEq8L8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBItYnPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DB0C19425
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006297;
	bh=xtjukwYcDPaMf1tilncRW/lVbLNzxia64I7G5rbz/iE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SBItYnPguESZiit9DH6upQ94v2HNaH3KzZCWPVm+xbUmv0yXLEWk/MSdfefXW76E7
	 aMmMukxLhUtYKaVRTxH6tGfpeRwA+r4YkKCH5OAjb278+tQhsFEBkwBW4HiMZjjU/X
	 reufBh8LbeYA0so4OKpKwY0DSmDKwtaZNN+NzXar0T7OSo4qoFff2KNiDrE3mzyQpY
	 cK/eT8vRF+WdMsNi1J6lhZB4Kr+LhqCw9EHQdDH2/MPSbYbop36eqVjepkotGYpxlp
	 PgmwbKupCiVfUw1/vExnx816TmbLe0DuYTK72bDo57TtqWXYfcTQFcpEIy5R7fPA+1
	 WilvGYXmqKsAg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a196a735eso2201210a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 10:11:37 -0800 (PST)
X-Gm-Message-State: AOJu0YwRktWcjP1a9XdUBM0iXtum4hCWERp54+Dbqj8K6FK5HyKwsU8F
	/SpC5dcFobCTQNm0xnbi4qyeIDw0WWxhm7GjwTsPQJu3o9nYBWFC3i7PWavpCeyxdAs4+PTjr7V
	nYkZpGYzfv79mavLSZyFwN0qL6WrOaB4=
X-Received: by 2002:a05:6402:1468:b0:64d:2889:cf42 with SMTP id
 4fb4d7f45d1cf-65bc784b143mr70428a12.2.1771006296680; Fri, 13 Feb 2026
 10:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130025358.4136660-1-qinyuntan@linux.alibaba.com>
In-Reply-To: <20260130025358.4136660-1-qinyuntan@linux.alibaba.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 13 Feb 2026 12:11:25 -0600
X-Gmail-Original-Message-ID: <CAJvTdK=RmwGqLkuZNYPck4f+tJStE0tZVeWX6qTASYa5b1FOFA@mail.gmail.com>
X-Gm-Features: AZwV_QgeDQZKmkE5AYvZWxBfX84gsu2eK1wx3uNj2Sd1ctV5APYEqGOy7CYbPNg
Message-ID: <CAJvTdK=RmwGqLkuZNYPck4f+tJStE0tZVeWX6qTASYa5b1FOFA@mail.gmail.com>
Subject: Re: [PATCH V1] tools/power turbostat: Fix RAPL MSR address selection
 on AMD platforms
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42619-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 2D1B5138D59
X-Rspamd-Action: no action

Thanks for noticing, reporting, and suggesting a fix!

Please let me know if this fix already in my tree does not address the
issue for you.

https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git/commit/?h=3D=
turbostat&id=3D16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c

-Len

On Thu, Jan 29, 2026 at 8:54=E2=80=AFPM Qinyun Tan <qinyuntan@linux.alibaba=
.com> wrote:
>
> idx_to_offset() uses valid_rapl_msrs to determine which MSR address to
> return for RAPL counters (Intel's MSR_PKG_ENERGY_STATUS at 0x611 vs AMD's
> MSR_PKG_ENERGY_STAT at 0xc001029b).
>
> However, probe_rapl_msrs() calls idx_to_offset() before valid_rapl_msrs
> has been set - it's only assigned at the end of probe_rapl_msrs() after
> successful MSR validation. This causes idx_to_offset() to always return
> the Intel MSR address (0x611) during the probe phase, even on AMD systems=
.
>
> On Intel platforms this works by coincidence since the default (else
> branch) returns the correct Intel address. On AMD platforms, this causes
> turbostat to fail with:
>
>   turbostat: cpu0: msr offset 0x611 read failed: Input/output error
>
> Fix this by:
> 1. Falling back to platform->plat_rapl_msrs when valid_rapl_msrs is zero
>    (not yet validated). This ensures the correct platform-specific MSR
>    address is used during the initial probe.
> 2. Changing valid_rapl_msrs type from 'unsigned int' to 'int' to match
>    plat_rapl_msrs type and avoid sign comparison warnings.
>
> Fixes: 19476a592bf2 ("tools/power turbostat: Validate RAPL MSRs for AWS N=
itro Hypervisor")
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 5ad45c2ac5bd..449492d5e043 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -492,7 +492,7 @@ unsigned int quiet;
>  unsigned int shown;
>  unsigned int sums_need_wide_columns;
>  unsigned int rapl_joules;
> -unsigned int valid_rapl_msrs;
> +int valid_rapl_msrs;
>  unsigned int summary_only;
>  unsigned int list_header_only;
>  unsigned int dump_only;
> @@ -2132,10 +2132,18 @@ struct msr_sum_array *per_cpu_msr_sum;
>  off_t idx_to_offset(int idx)
>  {
>         off_t offset;
> +       int rapl_msrs;
> +
> +       /*
> +        * Use valid_rapl_msrs if available (non-zero), otherwise fall ba=
ck
> +        * to platform->plat_rapl_msrs. This allows probe_rapl_msrs() to =
call
> +        * this function before valid_rapl_msrs has been set.
> +        */
> +       rapl_msrs =3D valid_rapl_msrs ? valid_rapl_msrs : platform->plat_=
rapl_msrs;
>
>         switch (idx) {
>         case IDX_PKG_ENERGY:
> -               if (valid_rapl_msrs & RAPL_AMD_F17H)
> +               if (rapl_msrs & RAPL_AMD_F17H)
>                         offset =3D MSR_PKG_ENERGY_STAT;
>                 else
>                         offset =3D MSR_PKG_ENERGY_STATUS;
> --
> 2.43.5
>
>


--=20
Len Brown, Intel Open Source Technology Center


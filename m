Return-Path: <linux-pm+bounces-42678-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PzUYI+RUkmlhtAEAu9opvQ
	(envelope-from <linux-pm+bounces-42678-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 00:21:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD9140110
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 00:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2231301176A
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE72C3254;
	Sun, 15 Feb 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1DRZ36Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C123F417
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771197664; cv=pass; b=OO/wG6Np18FDhvTscKSYs16a/FrrdK8DNosR/jrCNTFWgNLOtW2/ScN1+iOa3EXsXIvPXvnZ763/omAAgELJqUJM2qZXbO1/VfGqB0gYfcDLSTKz2sM2ph/VltpHsAtaPUDlg1zGQu4cgOORZAbCqFFR5Eex/nUnaMkyNf5m+X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771197664; c=relaxed/simple;
	bh=7KASuP1+sNMsyCnwba2Fjk5F0eYOayk6mhtp3LX7os8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7fCl8L3ALmPaX9B5ic6FDH6TA7oZOhDHNSVNaV0Uex/Ohr4XjmebxDdceBNo4yk5/EVNdm2c5DkrEMAEF5UTgCVUs1VkbsgZwjaiqDRQ2RfmwakZK85hm/RUXyE0maGCsrDNxgpIWi7tQC0s6V7c4PHB/bAcNPqIAHpHAlRrT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1DRZ36Z; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-896f632d206so57306636d6.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 15:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771197662; cv=none;
        d=google.com; s=arc-20240605;
        b=LoYm2JWtmQbDqpjUJrWLc1TBo00dFEM50SlibYGKy/m79uvfwYMzxUe4xxcqKVplmT
         fwZg42kFGzSXvT7c8T3QpjCgmpOpOIu+VNvRk49ebtDKEWdS5pO/PU3bh9fpPx337rc5
         zywIRWTz/vtyETz98RP3kiXYUtlIsNflyT9gQg77OA5JE50nu5L2juCLnLjZ1diygd1c
         8DNragFzlyjOdROd/RtWJp3wXydR1qlebG/6v/3tgW1nyWiGqpAEgwKOZe1jTJ0LgNhg
         vAiOij1mNnYp+KLvz7D6eRZVudY1T+G3LMq8OzlsZP5o7GtkTRSg01cq3+KBBRnCpdBX
         R4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9dSti6qUG4k+SbmTKg26mkaMIh7kMD2KX/t/B9iBo5Y=;
        fh=Qky+z1KGLTRifRqDu2iyEsUGUdB3kLPfuOSn2RtPX5M=;
        b=kXd/I6uv6n1GFqZF2sXTeuDpmQwu3Tzes/UnEUYyNP0NykOQwPHuh+60xw584JMjph
         2cJuYrISCjcCSZxbgFJjCTvmHkU/TCrFTHcQf3RGw9orrx09sB/Ovt2e5G4FXlcbC/UB
         csbco1M5/UXj187GTBpzYBOmJ1CVHE3lu8c9zGmPwn+piOSyjmt8yyeHP4yUOoAPnkKz
         iRYvBhYF7aeplq84eavTCJ2R1hoF5/lnUPFG5nfKsgGIGB2sS/0irjEQpSyqueVxNNf+
         pRjEtDpo4omcGHnvVPD0O0xzbynooImDCfk3zyJUzU0SKfUQ0rKNPkJ6C70fs3vrIY6d
         HLdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771197662; x=1771802462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dSti6qUG4k+SbmTKg26mkaMIh7kMD2KX/t/B9iBo5Y=;
        b=M1DRZ36Zg7HekwoJKuQt0ra/suKWva1nNP31OFUkok1tbG/o8L98wRawaLS9O0NyKi
         GeqIVzCjaZiH6S+MYHRKx5vBbIcECj9TqMhMthqRxTaqdA6bDiuUFO/bf0TVsa1u9zNj
         8L8vEQLoTl5GHsxc2Ndi37rUEh1ifgkx+AyRB3vCxjUuHJK1jta2koNj6OOKt/u349B5
         PFUxrpp1ouF2yC8vCK4E5s0RkuapSoWJq3WprpJVWIr9zBih7UhBJdbiR+vbLEsMira3
         k53uQz7yRpeUeFNIMPmuOW4tdb5NyWmp0E5BHYPoFL/qXqgMLoYJCZt2MxlPgOhWanWp
         ztww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771197662; x=1771802462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dSti6qUG4k+SbmTKg26mkaMIh7kMD2KX/t/B9iBo5Y=;
        b=ucuVWOgRUtYoTK6SZUjbTdqLFTVqK5Lc25fnOjq9NVsSfmi+g1xkLfHkT3dmPl/TDc
         x8yknj7DZftS/M/XQqiZm0Xb0zV12rmmSQEvADsMHkK176jmxo+QgIpWBS/KcG9ItQ0R
         xmgHfRpuEJWdHIuEQyPK7Er3CqFFqNqkXmW9i9y3ww+G5EAJ0NwKX/VWBUXgKF7sDZdF
         GfrYFYWFrJsrBOFjysE40TZJAQ95t6WRsYnv/KHstHRX9bBfwyJOJUmX2lR6xTzCClbX
         L2Dp0Fxich0kQsmGftH09/x2ZSOya6H369Kn/ZaPovKcZKcP8VSKW9qlnIuAq3DdShYR
         SVYA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEA8/bA7DlXNUdYnaPU8Det/Nl+zArGHUSlNAIBMX0jf11cyLOP1ta3kYmGktT7l7CIPNoAyt9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEp/KTzdAnavZkYDMNnxiLCW2Sx/sy0DMpkgMP2nOAYgQkmF9p
	1tVR3XmbIQ05N20rETKRvM1ovjEJXxrEdo/7XruTbm5zSymQhW5jeL08sX+dxc7mkFWgyHIJmqf
	XL1jFY8BKyggESunRIkCi7225x39SVKU=
X-Gm-Gg: AZuq6aI27Fc4AMPg5IvkS5SsGwFCqzxa9iHu5fa8oi/q4knDr0iEmDKMnNCaSevK6il
	bm9GIDgYStfuTM5pCGNK5WwjFz52vwdW7K0qs4HW3Spc/uDaKuhyMbiyj54zbmFIweZMnBAG+m9
	WV6uALbye7dt27T1oGusNI06K+J/qi02tfv0AEZVivhQDHNpxR1Mk+bW/pqfWe7uS7L9+3DJA10
	pQuVrZ4fsNl4JeOdKQBWzBmPoV/FgdQJFI7r5AjWoAynfdSI5iOzRAdp4c+vdLsdtlWmvtXokih
	W6K8r98rPz4GlTzK
X-Received: by 2002:ad4:5be4:0:b0:895:4d3f:b6c with SMTP id
 6a1803df08f44-8973f2fbedemr106347506d6.17.1771197661590; Sun, 15 Feb 2026
 15:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com> <20260216-hibernate-perf-v3-2-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-2-74e025091145@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 07:20:49 +0800
X-Gm-Features: AaiRm51jPFCewXyj-msKubNXn_1t8hUGFcByOC4NgVnj27CFj7IIHpXYi_25B1Q
Message-ID: <CAGsJ_4ynCA_w4Xcwu1k=2Hw3bMnURBxC2FeZEzN+uzBp+9YJcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, swap: reduce indention for hibernate
 allocation helper
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42678-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: D7AD9140110
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:00=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> It doesn't have to check the device flag, as the allocator will also
> check the device flag and refuse to allocate if the device is not
> writable. This might cause a trivial waste of CPU cycles of hibernate
> allocation raced with swapoff, but that is very unlikely to happen.
> Removing the check on the common path should be more helpful.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 32e0e7545ab8..0d1b17c99221 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1936,27 +1936,25 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>
>         /* This is called for allocating swap entry, not cache */
>         if (get_swap_device_info(si)) {


I guess we could further reduce indentation by doing:
if (!get_swap_device_info(si))
    goto fail;


> -               if (si->flags & SWP_WRITEOK) {
> -                       /*
> -                        * Try the local cluster first if it matches the =
device. If
> -                        * not, try grab a new cluster and override local=
 cluster.
> -                        */
> -                       local_lock(&percpu_swap_cluster.lock);
> -                       pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0=
]);
> -                       pcp_offset =3D this_cpu_read(percpu_swap_cluster.=
offset[0]);
> -                       if (pcp_si =3D=3D si && pcp_offset) {
> -                               ci =3D swap_cluster_lock(si, pcp_offset);
> -                               if (cluster_is_usable(ci, 0))
> -                                       offset =3D alloc_swap_scan_cluste=
r(si, ci, NULL, pcp_offset);
> -                               else
> -                                       swap_cluster_unlock(ci);
> -                       }
> -                       if (!offset)
> -                               offset =3D cluster_alloc_swap_entry(si, N=
ULL);
> -                       local_unlock(&percpu_swap_cluster.lock);
> -                       if (offset)
> -                               entry =3D swp_entry(si->type, offset);
> +               /*
> +                * Try the local cluster first if it matches the device. =
If
> +                * not, try grab a new cluster and override local cluster=
.
> +                */
> +               local_lock(&percpu_swap_cluster.lock);
> +               pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0]);
> +               pcp_offset =3D this_cpu_read(percpu_swap_cluster.offset[0=
]);
> +               if (pcp_si =3D=3D si && pcp_offset) {
> +                       ci =3D swap_cluster_lock(si, pcp_offset);
> +                       if (cluster_is_usable(ci, 0))
> +                               offset =3D alloc_swap_scan_cluster(si, ci=
, NULL, pcp_offset);
> +                       else
> +                               swap_cluster_unlock(ci);
>                 }
> +               if (!offset)
> +                       offset =3D cluster_alloc_swap_entry(si, NULL);
> +               local_unlock(&percpu_swap_cluster.lock);
> +               if (offset)
> +                       entry =3D swp_entry(si->type, offset);
>                 put_swap_device(si);
>         }
>  fail:
>
> --
> 2.52.0
>
>

Thanks
Barry


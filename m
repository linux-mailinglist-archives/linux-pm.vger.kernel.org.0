Return-Path: <linux-pm+bounces-42677-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DJJzJg8wkmk8rwEAu9opvQ
	(envelope-from <linux-pm+bounces-42677-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 21:43:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7313FAA4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E45A30075F4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417C303A32;
	Sun, 15 Feb 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P01W/YS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1E2741A0
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188234; cv=pass; b=EJtpTriR2EmQx4v+BLPfb4p9H8lK4ovJ2AL05m5ZIm6lwILdYDf3LnO6yiD4/gertDHtCelDzIrb3SobTJryD8FoCFMsmPpqpNLemHS0phzbI18rzio0l1K07eijCd6ACVrfADWqaiZlmBV/Oz+4Om5Xa3/wV7FkXgUAcnns0Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188234; c=relaxed/simple;
	bh=zD5CZP34AdfNzMLyyeRSFpmesixbFhvK4lsi6vLs53Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxxFr8LNeY2fx0Cn5fWFavAWST2hT/vKo8709Wud3ksQsdGjzx0DlwkI0vEERAKVhPZC2rMVvYeS8bBw9mIn8GTekmVnuHBJh/TDkQvfi+L7nPZxpyP0CXSqZocYNb2F4lISpTy7MTM31lcmbg6CZpykQtPMetZTiDypOoh1D/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P01W/YS3; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb420f7500so251237285a.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 12:43:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771188232; cv=none;
        d=google.com; s=arc-20240605;
        b=k2kJfcUX2lSLbdWi7igxR02EcSt9cKPNLA/feXU3s8h5k0P/AzaeI+C/xVdh7YiS5T
         r1kulx5PLurWN9ZKnnOGNIVNGNLhrbi9boMFLnB8kaTlYUkyF1ND05HCvDOCfuhh4f3P
         g4sE6twLZTONIzsH9aV1laOlWh3b1ZUMiGJeq7LtRJof9apz9AXXS35RTZ5ZWlOCOV/1
         jZHxDl3ppAEwcZIqH9gsxwVqOXoC0q+1J7nzDEEIe3BjSkGSc+HDeJ1ucn5Tycy5jCVb
         JaoPrWXwGP+Bg7oTTUDevshfng0tDaQjtQf1FKBKvHQ+yAncAUxUKHrSXvEtaHARcAdw
         AwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        fh=RHYktdA7zZ5K5i+4d/aOQbBa+4+OrGIY270NI2hp2B8=;
        b=H8CWNrVhEgqJvxNr5tAx6BhBd7ITWoq6ZnxIqmzGBGzECCPdOkeGioaWTmVrTRCcSJ
         WfSJzlwUuXg2iQXyuEgo+3Mj822Jqa0Fz0exkRiS+00GnlhKBscOhdBl3NUJw5JRXIbz
         aZBSQCiAZNrNuFE9Bw61savgDVj+EEn6x9usPmLuyPjTRi6694ZeJW+9B4HXWbFQDAjb
         Rryrkzef6XMhPls9zmafNaEWgWNZBUTMjKu8d0b84iW5vY4A6rtr69XYxTOj8pzTti6v
         4UDmhhqiR11E7U1L6TojMfCudG4ah4oVvI3SSzb/1L2+FkIT7bDVgYMoq2S662cNpNQd
         wMFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771188232; x=1771793032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        b=P01W/YS3AfVe08mAkH9z8nsJGx0/Xe85vHYoQX52xDEMBB6Hi5jfkaGwvfWpr+gSVn
         P2FSv+LCICN3h2beM9mP4p5wEttmT0LkQKhBua2nqhIhqq3+OcAJiHpdsRpGlXQQX7gM
         Hafq/AtZymrPZtlwX21Vcs68/YB9YBRc2cZtpksa+iVu4kATPWVuz4V3T2B4O9oQBRtV
         3kuXALGHHl0lHnMn2b2cz4IVOPKm35xKDfOzJbgpt7mEJ65w8k/McAg5Qc4FSBKk08YO
         Kc3jf/FA/879scNf4Z359q61Di+xNajDL4cGN9i6irzvAHY+bW3lixUcVAiW3+RwIhZZ
         v0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188232; x=1771793032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        b=u1PwXEktiSJ8tkIQtUumN7Up7BbC3jxv6nhA4K+KJcxnhM3OVNgvPw2l5hNJypdxtu
         hB1LMj28c5Uog5KGxfqqUfFzRzj3db8StaUPyg1mDVqmrbiuvwqsX6AMVTY0nVhQ3v5R
         eELZHfQlo26AeabKfOn9yLHljc1erHqskB7EBYHGoCKlvrMqlhE5uJ/IYWXmG0qZGVRF
         nHLMFouu/ar6HVDxAM/g9kXKGTiMnORvettfhC/BzcKuxnuKDho33mlk/CKdZ2I1BAq4
         bg4YOY83bXOU0byf+NwFCGikDpUZv02AlPFPwKfCL+lxYeBdCmCBLQST0HC9c+U2kf49
         EaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVtiY2QboMiOWrtafKWN61d//KXXuZ5Q/f8fXTvrTvp6F8vNvYGDvPnbJLwJEWWzxPHEod3e8cTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtC69n6KjuaNlQjTXeJnJrK3rgujeGfJFuFxkT6StacL6uP2p
	G0U/OwqBRHWV34DtCe5Jv6zvnMn9uSZk/80DnwzrF2W/HiolrxbEewHyhv1MvPE7vL/X9ist9NF
	yJu5BUVsZoG80zNQArFQZaq6ZY1ba5xM=
X-Gm-Gg: AZuq6aLskOsjyMG5073TgwDXqPi4XMr9vKexRdF4MJ8lji4yQ7EeWygfy8SsxIRdqKO
	6KOK+UkbTi1J1QjVQ13JcsgpIu6Q6GhB/FfIUKJZ4UkaQvWo1hUKQqKYJMw0eN3jVqjI8S6xocb
	HxdZl58cPuWqNWmNdGdHmLSPGoYedXBEB/tSRbOfp7e9lTa3QCczsy0T5YXOFxTTvNvGABC/ENK
	UZzfTzEs6yzxKpH+aeNIbhFO5ZE1E48coNbFhIIqo05xi5RGEROOsbCD3zuuoihJzaSWSnBJg3G
	YCL1ag==
X-Received: by 2002:a05:622a:58c:b0:501:4ff5:ae3 with SMTP id
 d75a77b69052e-506b3ffff08mr84696281cf.42.1771188231378; Sun, 15 Feb 2026
 12:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com> <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 04:43:40 +0800
X-Gm-Features: AaiRm52fgDtfNvU3kxKbZLjl0RB593izYUrm1DGrHb9hftHazRJhLykKi9hoAlw
Message-ID: <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, swap: speed up hibernation allocation and writeout
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42677-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: C6F7313FAA4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:00=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> hibernation has been using the swap slot slow allocation path for
> simplification, which turns out might cause regression for some
> devices because the allocator now rotates clusters too often, leading to
> slower allocation and more random distribution of data.
>
> Fast allocation is not complex, so implement hibernation support as
> well.
>
> Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> performance is several times better [1]:
> 6.19:               324 seconds
> After this series:  35 seconds
>
> Fixes: 0ff67f990bd4 ("mm, swap: remove swap slot cache")
> Reported-by: Carsten Grohmann <mail@carstengrohmann.de>
> Closes: https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bb=
f49c22e@linux-foundation.org/
> Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c1=
8f@gmx.de/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c6863ff7152c..32e0e7545ab8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int=
 nr)
>  /* Allocate a slot for hibernation */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> -       struct swap_info_struct *si =3D swap_type_to_info(type);
> -       unsigned long offset;
> +       struct swap_info_struct *pcp_si, *si =3D swap_type_to_info(type);
> +       unsigned long pcp_offset, offset =3D SWAP_ENTRY_INVALID;
> +       struct swap_cluster_info *ci;
>         swp_entry_t entry =3D {0};
>
>         if (!si)
> @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>         if (get_swap_device_info(si)) {
>                 if (si->flags & SWP_WRITEOK) {
>                         /*
> -                        * Grab the local lock to be compliant
> -                        * with swap table allocation.
> +                        * Try the local cluster first if it matches the =
device. If
> +                        * not, try grab a new cluster and override local=
 cluster.
>                          */
>                         local_lock(&percpu_swap_cluster.lock);
> -                       offset =3D cluster_alloc_swap_entry(si, NULL);
> +                       pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0=
]);
> +                       pcp_offset =3D this_cpu_read(percpu_swap_cluster.=
offset[0]);
> +                       if (pcp_si =3D=3D si && pcp_offset) {
> +                               ci =3D swap_cluster_lock(si, pcp_offset);
> +                               if (cluster_is_usable(ci, 0))
> +                                       offset =3D alloc_swap_scan_cluste=
r(si, ci, NULL, pcp_offset);
> +                               else
> +                                       swap_cluster_unlock(ci);
> +                       }
> +                       if (!offset)

I assume you mean SWAP_ENTRY_INVALID? Would that be more readable?

> +                               offset =3D cluster_alloc_swap_entry(si, N=
ULL);
>                         local_unlock(&percpu_swap_cluster.lock);
>                         if (offset)
>                                 entry =3D swp_entry(si->type, offset);
>
> --
> 2.52.0

Thanks
Barry


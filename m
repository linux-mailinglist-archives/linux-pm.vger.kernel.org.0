Return-Path: <linux-pm+bounces-42669-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tKI3E7arkWlTlQEAu9opvQ
	(envelope-from <linux-pm+bounces-42669-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:19:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354B13E941
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAE23011F39
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCA2D46B4;
	Sun, 15 Feb 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aioe0ynP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633628DB46
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154351; cv=pass; b=dDoI9uhuWiZp7pc+1oOsGYT4a/GvCqWSJ66l5EIhsw99VsP5lOyT4E01XaAa6RM06aIDnwdnLDQorO1G4CRxSFq8oUQWp5A0pv3e3z/bihUWPGyRFYlzbHaOnul5uOrkx1kB452IcX/WVZiIO1kOSTUWurv8xCUWbiGxb+8rN40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154351; c=relaxed/simple;
	bh=NAyAZ+BZrsX7V4lztoBlyfB4bz2pU7jvfvgYU4Rbwrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvhL/t4KbtcZv8aYbHGKoEieBShAhW4sXsajM7iyh58IJLG/idOqzveXcCS/sssu/EjfFo6VLIa8DgX3DybZkFIm3AFTJdrNDsHN97Neb46cZ+qEeKaF7NrAIjrEQC0zo2fKG9GC9F+Bu2J8Ngt3P+QOsSZc6LBaipEH9ME1PTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aioe0ynP; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65b94e0a875so3382130a12.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 03:19:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771154348; cv=none;
        d=google.com; s=arc-20240605;
        b=bCmGzJ1g+nVA4t8Hnl0L8Xg7SdbhOTIDNCvlG7mMRI3D6rTAJbNQJAEzOBr7NR+wAm
         LjIG3DEZMVYKxGwZEVM6p0B18Y2nOUucb33BT/Bmnqz+P+lfv5nb/G8ZegdFKrWEzW82
         UfqPlureHV+US0bgDZHLBT8wx6q/Cvs6l0KFxlL834dN94H3vXRST/4gVm2pEAPpF8BL
         Mblp+DL1oZap/P+NvURdrErSf9H7geg9hNbEGGCgq38mwL54zC8RgH8vEKkcslpuHLxo
         vg/pAAyfhslFe2SvQxQUsaW/EJoMa84C+vld2Ue6+4op1P7v+v45p2LYF0h3T/WAfc3T
         wlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ox2CDuqzI57uLB8CBlCfkrupp4w7Jrt88SB/Nkc1CBc=;
        fh=1XdarYGrEI6YIAvvsdzP56C/r9pa+ZCQyVhkTrsfw0I=;
        b=h5it7kJq8Yg6tueHFKUXvF70Lw68wxn4gOZiUDceMN7ZMy0uKt5KjbKzCJWtc5ceyJ
         wJ0/ZBDG2gFEJN5i7ftrkJn5KSfi5Al1Km4wy/3ZqQiwRsEmHq21u0Z6F295YZryt9Nt
         vaRWqnFllQ7d+kKwdS0KP+A20zdgMwLiR8SClwHJCA8tAOJPrMkLmhcaJIOvtMhs5d6/
         2XB68uQYpkLrujyQEGfGAL7IRY1oPMmSu1imsnf7cxx+MuJXv6ZQY+3kl1lFVzwOHHQM
         x9q78fCIsq7bT+wpvJMoUxPgk2ANyIm+Ysi0tYZ+3I7OHZrpDpQlfUL9Nmnf5P+DGL5A
         yJSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771154348; x=1771759148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox2CDuqzI57uLB8CBlCfkrupp4w7Jrt88SB/Nkc1CBc=;
        b=aioe0ynPii1Qh8btzFenkYQmrAm8kcXSJcysLlnplTog8fam0G7mBbOx6/YiTEY0/O
         ssOyBXFOECp0QFqCY84tdHGh+QcTr6zDEefxg3mHst8AXOYWSJ+tCa1grjaKrXG0YEcp
         FoxQbc2MQ6YTNrS/T36NSIoWkF1SbPX0nh9Wwqj1qLGmchWwYuHWALhsJ9MuefdJvgYd
         j4bDMFy/Exq21j0IKkq7A1SNfRfnA+CJAoFNob1/mKz4eOP95gFhdB0SgHZ1jZjUX0Vz
         AoSWJTJIiFGYmTatseZHWnfYCE454XHBfuno6k20launXczxn0PslUqCrcnhOXZ1CcUI
         lvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771154348; x=1771759148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ox2CDuqzI57uLB8CBlCfkrupp4w7Jrt88SB/Nkc1CBc=;
        b=UL+/q3AqxoBqnOvTapx393F6KiM7ex27+87SyDQB6Bx874SRsmDCGLP4oIstmV694N
         B6AY2iij+xycXIhR4QfYnBbCdou4dBCFXpN5B07KgtY2rAhjW6rliT0qT6+f6jJbmPdx
         PIcmloYpyWbqbpV879P5RRt3vZc+BFqoOSt4fabF/gMO4efCI506MspRxoV8UHjAOrdg
         nwmU2rcD/3++BhQ1xfq/dYf0gqmSQOf+ghyckfvvN5RIHbZm15pThLJI5KPUzfKkVOMQ
         Kf49FjyzWXrtTPLAQYOwSWb2+klMA3U/8aqtoCvaF0m/YFt1UJ53gbOjAfaKTOELV5bF
         5nxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlC/zl/ibcxU8H9+JqM/0Ms+OKE+qSY+3ENeuBE1W0ZbxGJVfat7XIdcZNK/O1M8G7zfdBHIJ7iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1zY5Jfgxb6z3mbeG3uQjk9Lz3/Ef1EV6WvtJzzsmD95ULf+D
	2mbzhaK4aNWv0Lw7X83dMtd/oUHk0CjwiAWUUOqnYxcZZj9EQTyx0exUZ3evMAStLD7ibC8kbAl
	jo9993zoW8budT9Ji+cOfRdzZqcgTqmk=
X-Gm-Gg: AZuq6aLG2yCScNVvGM3G7bSRx0VuDhRjcOb93I2XGZaMQNpdgs4874kN1pzNbc8Ksx0
	WgAIacAGNEG6PsSjJr22pKWrT430cimqtkf6WE9QbkFeejrzxgxTIOl5hJorhrT0FEBNByMiyWV
	vYLvWeqqeK0T/nq+88SXYlddb9A3pEx4QmC4k4cE1GfzNlwdqY03Ii23k7dwmvRZgFReHLZFVxd
	e6Xo7v7WAP9b8KjYg62GO7m/L9JppLad5n8y67oP0Q0RpRFczJEG6o69W68E7YtJUREcMO9WVOP
	i/teYFvkOsoG8hOZ5tBEj5GvExDPTI1Y+m+aEscl
X-Received: by 2002:a17:907:3e0c:b0:b8d:e10d:6f96 with SMTP id
 a640c23a62f3a-b8fb44a6f8amr411119466b.32.1771154347545; Sun, 15 Feb 2026
 03:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
In-Reply-To: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Feb 2026 19:18:31 +0800
X-Gm-Features: AaiRm5163H6nvK_79QuEJvHPMlc_6xIM2aw4ipOgiTJHSPUBFTFzHzHk1kEMfrc
Message-ID: <CAMgjq7Dqh4xPFQe1AywHytn6zCRjTS0GBy9FTb4F-AuN66OFiw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/swap: hibernate: improve hibernate performance
 with new allocator
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42669-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,tencent.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9354B13E941
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> The new swap allocator didn't provide a high-performance allocation
> method for hibernate, and just left it using the easy slow path. As a
> result, hibernate performance is quite bad on some devices
>
> Fix it by implementing hibernate support for the fast allocation path.
>
> This regression seems only happen with SSD devices with poor 4k
> performance. I've tested on several different NVME and SSD setups, the
> performance diff is tiny on them, but testing on a Samsung SSD 830
> Series (SATA II, 3.0 Gbps) showed a big difference [1]:
>
> Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) thanks
> to Carsten Grohman [1]:
> 6.19:               324 seconds
> After this series:  35 seconds
>
> Test result with SAMSUNG MZ7LH480HAHQ-00005 (SATA 3.2, 6.0 Gb/s):
> Before 0ff67f990bd4: Wrote 2230700 kbytes in 4.47 seconds (499.03 MB/s)
> After 0ff67f990bd4: Wrote 2215472 kbytes in 4.44 seconds (498.98 MB/s)
> After this series: Wrote 2038748 kbytes in 4.04 seconds (504.64 MB/s)
>
> Test result with Memblaze P5910DT0384M00:
> Before 0ff67f990bd4: Wrote 2222772 kbytes in 0.84 seconds (2646.15 MB/s)
> After 0ff67f990bd4: Wrote 2224184 kbytes in 0.90 seconds (2471.31 MB/s)
> After this series: Wrote 1559088 kbytes in 0.55 seconds (2834.70 MB/s)
>
> The performance is almost the same for blazing fast SSDs, but for some
> SSDs, the performance is several times better.
>
> Patch 1 improves the hibernate performance by using the fast path, and
> patch 2 cleans up the code a bit since there are now multiple fast path
> users using similar conventions.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Tested-by: Carsten Grohmann <carstengrohmann@gmx.de>
> Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c1=
8f@gmx.de/ [1]
> ---
> Kairui Song (2):
>       mm, swap: speed up hibernation allocation and writeout
>       mm, swap: merge common convention and simplify allocation helper
>
>  mm/swapfile.c | 56 ++++++++++++++++++++++++++---------------------------=
---
>  1 file changed, 26 insertions(+), 30 deletions(-)
> ---
> base-commit: 53f061047924205138ad9bc315885255f7cc4944
> change-id: 20260212-hibernate-perf-fb7783b2b252
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>

Patch 1/2 is a wrong patch, sorry about this.

Just resent the series using B4 relay and marking it as V2 to
distinguish from this misformed one, please check that series instead,
thanks!
https://lore.kernel.org/linux-mm/20260215-hibernate-perf-v2-0-cf28c75b04b7@=
tencent.com/


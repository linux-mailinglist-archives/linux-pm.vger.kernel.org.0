Return-Path: <linux-pm+bounces-34451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A731AB52D75
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE458412F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AF2EA72E;
	Thu, 11 Sep 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxKiLP4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61D22126D
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583758; cv=none; b=SXypasKdGG8AdD1znArYdjtWfSK6IpM1RMtK0QZIGXA6RRfu3GURtxDsppKzr4HAZ1v8fAW+m7Hqdzvt6CupKNjazzO9BS9j32O7KHEWDCaKSPd5Ip2wQ3dC/FSChAnMwzN0Ycqa7UVYZ8sPL4IrLswzPCeoOAFBubz+maGw/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583758; c=relaxed/simple;
	bh=EScqyVuWwnuUYZ7dA9WB/8RNsN8dYaXzUoZsHdGe1vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2vP+U8M2YM/neDdQV8/Qz2xGQq8ScRoh1cKrq31MbS4TLaiPfZLznsVZUi+jzKl6AMkKiJKB3Mri9A77O6SomRmG5ou9VrVqmXIlFza0VlPIV/QvTUHCEdMjC7edv2C7fHTP1hwmQQ7pVjK9e6vBsSGJeZOdJ7LWMajkXV7q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxKiLP4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AE2C4CEF0
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757583757;
	bh=EScqyVuWwnuUYZ7dA9WB/8RNsN8dYaXzUoZsHdGe1vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IxKiLP4acfUIEcPpePNBW9wuSSLWfkolJ1bTvQLDZRETuRVvb5OK96av8y5gQkwcQ
	 unNtO8E4yX1V/UUc6hw3eTyBuDiM+jOlB3RPozYsZgbUorbZrX+HZQRNFd2GBwqGKm
	 18IGVS4PaSo65cRjaQmd90iXvbvb373rAap1KSSOkB+bt5Op8LqowgX5kqTxS6TDR3
	 B4yjj7Cpu6brII6vDLTQtCe7CBmLSucEZ0hMSpLPRXdh5ZLKpCVArfUZTseR+60ofL
	 iZj6cszoHIuaBaBnDnOWqBsPhWybTGHGfse+x2exsCNfAUPHZGG31el+qdx1q5kM3A
	 NTbqnTSl1aYHg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-621b50dca6eso174809eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 02:42:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YyWLPFDvqccZh98tm43xwOCtx7KxZSrjmbXu/5fwiTd0X5emEhM
	v8yWLNpv3Yn59CnofNKx1KGdoJVUlLMK+W/NfT86fa+cpjTSAynoQunkYxYoAD4vH14FeR27Igz
	azsZ26jNDtBIssMICMJGmC7VDaFZD5yY=
X-Google-Smtp-Source: AGHT+IGfXfDpVkv4JDVyDVpxshNNbneBxYZJ6fn133a4p4WsTMHPv2mdUXwQuFo2rHeAuQ7Gh68C9HKFej/echvP46k=
X-Received: by 2002:a05:6820:1ca6:b0:621:b76e:66b9 with SMTP id
 006d021491bc7-621b76e6989mr384850eaf.3.1757583757188; Thu, 11 Sep 2025
 02:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
In-Reply-To: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 11:42:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
X-Gm-Features: Ac12FXzBQnQR7ZXKcdLECD_wCYjF3Jots-eHazm5Qwgn9UCX1szpkvNbrck_riw
Message-ID: <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
Subject: Re: Sometimes I only see 3 RAPL (out of 4) Counters
To: Kenneth Crudup <kenny@panix.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Srinivas & Rui

On Thu, Sep 11, 2025 at 2:20=E2=80=AFAM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
> I have a Dell XPS-9320, with a i7-1280P (family: 0x6, model: 0x9a,
> stepping: 0x3) CPU. Sometimes I'll only see 3 RAPL counters instead of
> the normal 4. (It used to happen a lot more often, BTW):
>
> ----
> gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | fgrep fixed
> 2025-09-08T12:09:05.915989-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> 2025-09-09T08:52:19.098522-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-09T17:25:24.377784-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-09T17:50:09.334140-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-10T16:42:13.259270-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> 2025-09-10T16:46:36.322016-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-02T13:05:02.632218-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-02T14:07:19.683466-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-02T14:20:43.602483-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-04T13:13:38.636326-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-09-05T09:21:50.147180-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-29T10:57:14.419740-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-17T11:52:55.733943-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-19T07:52:30.696326-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-19T07:55:49.083600-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-20T10:53:54.601680-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-20T11:00:09.560496-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> 2025-08-20T11:12:30.580414-07:00 xps-9320 kernel: [    T1] RAPL PMU: API
> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> ----
>
> ... and it's always(?) the GPU RAPL:
>
> ----
> gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | cut -d\] -f2-
> | sort -f | uniq -c
> grep: (standard input): binary file matches
>       18  intel_rapl_common: Found RAPL domain core
>       36  intel_rapl_common: Found RAPL domain package
>       18  intel_rapl_common: Found RAPL domain psys
>       16  intel_rapl_common: Found RAPL domain uncore
>       18  intel_rapl_msr: PL4 support detected.
>        2  RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360
> ms ovfl timer
>       16  RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360
> ms ovfl timer
>       18  RAPL PMU: hw unit of domain package 2^-14 Joules
>       18  RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
>       16  RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
>       18  RAPL PMU: hw unit of domain psys 2^-14 Joules
> ----
>
> A reboot fixes it up again (and that's if I even notice), but what would
> cause this to happen? What's the effect of it missing the RAPL counter, B=
TW?
>
> LMK if you need more info,
>
> -Kenny
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
> County CA
>
>


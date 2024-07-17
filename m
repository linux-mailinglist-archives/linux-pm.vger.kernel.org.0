Return-Path: <linux-pm+bounces-11191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D8933537
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81454282CFC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931A1C36;
	Wed, 17 Jul 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BRh1dVet"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A06184F
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181604; cv=none; b=s41F3wiXHseKJtarUv98kHfFFqNh4Gp8z5WgG4gjkif4pl5MB9TdI2inGzZP6yGFMTlggZ8B/oYekorBmwBW0WDn5UwOjOCnq3+osuTU5FSwszwHoFlzEmVkr3w9c0dK6E6xFMrzg0yS6FzJ3Ovt0hhS4AgynYOmw58W6G1fxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181604; c=relaxed/simple;
	bh=otbpXk5wsPPz6XJGPF2ZHjiSnqLtz1IifI3EWyeNr8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB9wYSE89OpkC65EKud+K42mztBgXH1/vAgKKgNEadokPz7oRKgUcdDNAZHWyJVUc+YQT+YQeSkbatZpi6uMHW17HxV5AIpwF6jf6IplAa+Kj/w1MDE0IeM3SPWVE7euzOiyVLGOfXrG7gcFLtNHAGDsyuWdhnE4wXXB+cW6TNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BRh1dVet; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C321E400B1
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721181591;
	bh=b9vdzAo4C5+FVtkHDz7bknOD30qXvHpnXLygC/XElrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BRh1dVetskQBfIzLNfHwKkaX26NsnGtlFhfH5DuSJzTc3QmWNjyNfHjDpMR9NbaI/
	 pB0kk2Zb6wz1p2eWdrIATpCi/Q8Avdy4zGJpXTClJrSwVcCBx5v8CLSMKrYihC2wIC
	 8mKbJPBxq6UrxbsuKozVkvSy/IHQYArvvNvzHGdxrqzEGP5uLa2mGuFpgZtl+s909V
	 ithDBJ74fXYvCbGysA3FG4bDrtNrnqJ67j/CpfpcoWciL2D/0eD+GaRKH0E9rxt121
	 +M8ifQnFKk78FtKBZnpl/v2DjM7TbaHQJLqxLRcEja8aRt37ArSPuWnWXaRt1x6w1R
	 6CE8qcJR8QrdQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb4e6725ccso223398a91.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 18:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181590; x=1721786390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9vdzAo4C5+FVtkHDz7bknOD30qXvHpnXLygC/XElrc=;
        b=SBma2yy4CEqOy9VHQWyk1Ud3YhEKflp8j4V5SsK2Kg47jz4UIQl9X9PjuXjGk7HEVE
         CT6V3LpAVvE/EHMhKVLm5fZDTbAF2T8/plgPTf2uJhPfFPaGLlKPvRQKxrdZ4myZah2K
         zuhXK7k6/2zmLdpxU03cahTgAmTQr+ij7SVFLZJsNcm62hq5hfgzX7pHTZGGXMgGxoMU
         tIZ0k2Ns7BPNrd9klyn8f9o0DhyEoxAyjAjcWTFwOOl7qgqA37o+q1nikORk9rlXYkDd
         OZiIrEauP5J2Q9/UUqaxHEje6pzvL4jSpWi3Gz7gcNDJqSERwls6sRLN2MmSBQfQ6VS3
         pXJw==
X-Forwarded-Encrypted: i=1; AJvYcCXDCe1sCYJa1Y26DXq7tXLf+rsB6qS04/YMDBISx7Bly7r3kJC/pCptDompQkLBoixnjqltm+2YFSovHiGkO1BijYCeSOHyZ9w=
X-Gm-Message-State: AOJu0YyOU8hy44esIdGbV8e89GImc4W2FqcCYs+wYPdXIIXAral2nZrF
	qgFTOezM55xbGVCISaEQs6/75SEHVT+IVF++fph/e/u0JqTXcWv63zpguh17YXsu4/MMJvDqVDo
	EtUbkQh0NhXUrLeGug3eoxkFIWIP0vOs8wL16dymVHSN3NZpGaFZu2o5gmjb5U9OuEHX9GA2AGV
	CEbxEItYFRPCymbey/zqvzKpredUVl4e0LVRu5gpecO33gJp4=
X-Received: by 2002:a17:90a:9f92:b0:2c9:5c63:29f4 with SMTP id 98e67ed59e1d1-2cb527a5998mr167033a91.25.1721181589974;
        Tue, 16 Jul 2024 18:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw9euHC99eVzbyiJNv44RLx/qaomLKH24On+RBnzpEkQH0GvoKfIVCYOeeTMIQui+3p0ZNWtRMijMTKmhAun0=
X-Received: by 2002:a17:90a:9f92:b0:2c9:5c63:29f4 with SMTP id
 98e67ed59e1d1-2cb527a5998mr167017a91.25.1721181589616; Tue, 16 Jul 2024
 18:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
 <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com> <CAAd53p70Hkv6vaim0HOncSQGBPO83f4QOGLE869T+4WKWdLjBw@mail.gmail.com>
 <0481ec61-3a57-4b4b-a0d8-b8b523af3f17@panix.com>
In-Reply-To: <0481ec61-3a57-4b4b-a0d8-b8b523af3f17@panix.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 17 Jul 2024 09:59:38 +0800
Message-ID: <CAAd53p7NpwK11AyMtAOiFxAEJ8Ho=V=93gwje_2j=h3a=L5G9Q@mail.gmail.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Kenneth Crudup <kenny@panix.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com, 
	vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenneth,

On Tue, Jul 16, 2024 at 2:27=E2=80=AFAM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
> No joy yet for 6.10, so here's my patches, maybe it'll save someone some
> time (they're pretty much the same as 6.9) .
>
> Fingers crossed for 6.11!

I forgot to Cc you when I sent the patch [0].

It will be great if you can test it out.

[0] https://lore.kernel.org/linux-pci/20240530085227.91168-1-kai.heng.feng@=
canonical.com/

Kai-Heng

>
> -Kenny
>
> On 3/21/24 03:12, Kai-Heng Feng wrote:
> > Hi Kenneth,
> >
> > On Tue, Mar 12, 2024 at 10:37=E2=80=AFAM Kenneth R. Crudup <kenny@panix=
.com> wrote:
> >>
> >>
> >> On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:
> >>
> >>> The only release kernel that was able to get this laptop to fully get=
 into
> >>> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series =
from Ubuntu
> >>
> >>> I'd bisected it to the following commits:
> >>> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/re=
sume
> >>> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register prog=
ramming
> >>> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD=
 domain
> >>> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind=
 VMD
> >>> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name ins=
tead
> >>
> >> Since (for what I'm sure is a good reason ... I hope :) ) this has yet=
 to make
> >> it into mainline, here's the set of commits refactored for v6.8; maybe=
 someone
> >> scanning the archives for a solution to their Dell draining too much p=
ower can
> >> use them.
> >>
> >> But is there anything I can do to help these go in? I saw that "Refact=
or L1
> >> PM Substates Control Register programming" is still reverted, is that =
still
> >> an issue on the machine it affected?
> >
> > Let me work on this.
> >
> > I think both VMD and Thunderbolt devices need ASPM enabled by default
> > regardless of BIOS setting, but I am not sure if PCI folks will like
> > the idea.
> >
> > Kai-Heng
> >
> >>
> >>          -Kenny
> >>
> >> --
> >> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange C=
ounty CA
> >
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
> County CA


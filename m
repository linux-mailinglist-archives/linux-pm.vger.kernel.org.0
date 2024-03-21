Return-Path: <linux-pm+bounces-5183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5B885729
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4FB1F21DC6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823155C1A;
	Thu, 21 Mar 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rjnBEwJ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EC273FE
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015988; cv=none; b=oVMHpHFrhCTdLlV+ImjTFLDVVjnDDMc9zht0MqMyEslKkSkt922jGDVyWZ9t0HoM6NANX2eTKrurrDPiJn0MJTxx64ChH68GmWr8oAwQC+08d8s5XO37SgIEkIB1OzCIniujHqwyPtIfIhMBwzOi3VgSVq6JT6NRYdk2n2BjPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015988; c=relaxed/simple;
	bh=ZU6nQPtH6V0VToUEmgqVDFpbpay55+Mer2abh4QCSvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3fCmXW5mJDbtKieW3C8GshHV0eW5IrG2whifIZ0EriI4gkmaZ2KBDB69+SjYyK6beQaJWTNP/f4P9on18PP08jT6e8ZfTspmj4sOqrF1qwgHksCDDTcfLMkfaWwo7wZ5M7+XKgYavNc3YJWobjyxxFhiz3RJh78a9FotV7WxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rjnBEwJ0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B52EC3FB72
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711015976;
	bh=S2NrBWqw+PmJIgF0pVfyDLjv1mOTUgLX6TdLBObutIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rjnBEwJ0JZ1MiCJsp7+DgdrPqIEcWRRlgi80S9ZJnxmP+j8/HrxMSU0X3cJmrpQzN
	 t536IYEjWFkFpqCdHfScmZEcPHGLu0rXvS3H+f6znmtQl0rGGwIGJWmtNAgQsmzKd6
	 WpGFvLY1w+LdWjgvBNApaRMicVLMw+kEWiflK+QHgI8rwlUS1JexNdwV8mSah5HikW
	 Jpxpf32V/zpgWX/5ShAICpF3ZuIYDw7rUgoNqML7IhuIwTwYCOJqOUoJlGNEuTkXHc
	 QJtEpU11/xeZxc56z9axynClZjq2i5v1qBDcRuKYfA1Zm1pNsbA7oUX+EuaeQWGfWz
	 rPzyIohxbPTdg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29fbe1089b8so566086a91.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015975; x=1711620775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2NrBWqw+PmJIgF0pVfyDLjv1mOTUgLX6TdLBObutIw=;
        b=rJVVfv4hdtMxHjvGYbZSAyNx/nkpcNIiUaiEvRAxw9UF1/vv50WBcGCuG65R849PgS
         w1TDBmb7gewqx/Zz/HHHvFLv0X7DRpWnZ6LT5O5p2/QqYC3rzMcwNQfk7L3aq3EIRSbv
         RLnEVH7mav4yoef3o1msd7bhpf1cHTv1tmOX0bYtp3m4KuruCneHjq5yO9HmcyNp8cnJ
         QExkWF+nAzv2H56nd4EjsNUStdkOecWN5t1sDCQehtHqZpwoEiOUanHHHVPWrFdedQVW
         S4keqNCc3FsSF1MdhgJBS9YhqERznMVuzull1fZqvQs3vpwR32IHV9zbPYSZzv3JPxT9
         ywFA==
X-Forwarded-Encrypted: i=1; AJvYcCV29VLiu+dV5iXdqmLvJ6HHWZLtyQOSgdNZ4VjaA06LetB82or6VCDqXI3w3CCEKBnRy/StOVDH0TFGgYkdycr3nG0WAB1F8Us=
X-Gm-Message-State: AOJu0Ywb7NCDSQ2PVSQYQvbpULSlTuu+wu7c8PqG7LHAkrQf3HdsFrIj
	yRmMbWG2TZzLBb2VHDtKyQ9jgmkx2QR+ATWdSRZw0InMeoK4Eg7CEo5+G7S6YJQUmnJT8hEokqj
	47qIZ/akdwIcIJQCzqzYEh7xDDMwMC+Bn5yemImuZQ3Dd43Tv5bwa/5ZLNCZcIZDjYd3wQZoNVH
	IEu6vdbSvEyMFSS9qmOerPib7cbazdgsQeEKmiN6Tku6qGKXc=
X-Received: by 2002:a17:90a:5b0f:b0:29b:4d0b:66ab with SMTP id o15-20020a17090a5b0f00b0029b4d0b66abmr1358660pji.33.1711015974762;
        Thu, 21 Mar 2024 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeyifwWlbEgFsg4kvzBPcHlsqYbG6wFng/b3ks2luEMSz8Swse/LMJWcd2s1hI2+Zui0xuZBAvOYNT3wFDHOE=
X-Received: by 2002:a17:90a:5b0f:b0:29b:4d0b:66ab with SMTP id
 o15-20020a17090a5b0f00b0029b4d0b66abmr1358650pji.33.1711015974445; Thu, 21
 Mar 2024 03:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com> <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com>
In-Reply-To: <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Mar 2024 18:12:43 +0800
Message-ID: <CAAd53p70Hkv6vaim0HOncSQGBPO83f4QOGLE869T+4WKWdLjBw@mail.gmail.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com, 
	vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenneth,

On Tue, Mar 12, 2024 at 10:37=E2=80=AFAM Kenneth R. Crudup <kenny@panix.com=
> wrote:
>
>
> On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:
>
> > The only release kernel that was able to get this laptop to fully get i=
nto
> > low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series fr=
om Ubuntu
>
> > I'd bisected it to the following commits:
> > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resu=
me
> > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register progra=
mming
> > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD d=
omain
> > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind V=
MD
> > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name inste=
ad
>
> Since (for what I'm sure is a good reason ... I hope :) ) this has yet to=
 make
> it into mainline, here's the set of commits refactored for v6.8; maybe so=
meone
> scanning the archives for a solution to their Dell draining too much powe=
r can
> use them.
>
> But is there anything I can do to help these go in? I saw that "Refactor =
L1
> PM Substates Control Register programming" is still reverted, is that sti=
ll
> an issue on the machine it affected?

Let me work on this.

I think both VMD and Thunderbolt devices need ASPM enabled by default
regardless of BIOS setting, but I am not sure if PCI folks will like
the idea.

Kai-Heng

>
>         -Kenny
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange Coun=
ty CA


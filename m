Return-Path: <linux-pm+bounces-11737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E767942663
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5509B2814FD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0C16C85D;
	Wed, 31 Jul 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="C3dvMG2p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2B8289C
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406689; cv=none; b=KlvC8amTp6WphhZ21dmEj2vhPExbp+aAm4Br7Zw4Ys8dmwLEBkw6Fd3YtewFfzKPN1tN0TjnNeFDYnL7anBbOoyyytHaBRsM5B4IlqaAlFKOwFSR47WtngUxIgiYXMeg/eV4PIT3w+OpfJpEEfF0yLpUiiQGVG9m92rcjx5DYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406689; c=relaxed/simple;
	bh=3TD+IGRLb5fmL9uN/xIlWcShtt4fFIxTIOP6c4SxY6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6mgW2YeAt+/5let7XSobUccAj1yTVahhvnQNevk6gejSTmmx2C5IQw38DG5zII+MAxM8XeJVotEQyHBx3c2iF+gKGJW8QNoCyx7U4pLvWZIy+RooM8VkGixnrd7KvBqHLEOX/HpLsZCrI3Uaeb8ZJuKYp39gKC0IKnPIj8kLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=C3dvMG2p; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C2DA3F0B1
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 06:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722406679;
	bh=ssw5x/CYADqMGy84FcI3TzdNl42qVwl89rpsqSqpOiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=C3dvMG2pxpFrd9nQHbo0k5o03Ll6Xp6hSuC+1Bgx2kQOlXMsZ7roaVe5aAboqP9Qv
	 S4WUxBoSpTu7BflY6/YbfDjJU/SdJEljv42ffk92yhj9eUgxXmN7ctmjwwRFrSJ65f
	 0nydd+1xKKhC+UP4xV2pzomTUJzf54Q9CBI/LaxrCk3aK3T7nH22RvJqIBJW2BpCq2
	 LUMBrluKiNJ49p//SSVsFtXmQ6VBT7qUJXBi8+W0D67y8INOSs0RzwCUiqM/M4uffQ
	 zIjYZ1FaUTqyLPqZ6kODTSXx3O2AhTj3mh+DlcuC2mROUag/yBBigkPlwf722W32VR
	 /TKqCr0+rMa/w==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb7364bac9so685185a91.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 23:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722406676; x=1723011476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssw5x/CYADqMGy84FcI3TzdNl42qVwl89rpsqSqpOiY=;
        b=b9Sw2eh4rAZZwJEojIfYEUT/S4Uxwvt6fGvycQAgFgtIweX+a13aNtuDwTXP9/usx3
         ZmG7hbz4xxPclg9pDpvpoQ5vj6kqRejQbROXvbd7ggHg//naueo7YfZPRN+1ZpJBihaO
         GOll/Ppg2T4h5qvnUPXs2LOa4Y+8PgxpQU8JRUPRw6A956QinmBEcw/aUf7bxWXuxxyr
         Pp7wU6G21QNfWQL6KBYF0hlupPrP/0/rWjhKQJ7fmb7Ypprzm1kEgLbyYksF1RA9dEKh
         9zVN8UpQsT885zsnHbK3SidXQY5w1PQ8NbY+0RVG8AAqys7/gZkQGm4/nCPIMIsomF+2
         BJRw==
X-Forwarded-Encrypted: i=1; AJvYcCVEhBz1fe7l/WN8ykEqdWq50UpxfTAPHrDEiPz/g3vjDskWUegsHUoOrjJYXbExs7jQoJhzPVZoRBMSuLMgFjUVFCRaPdnHPw4=
X-Gm-Message-State: AOJu0YwQ29k2OdLWM2a9ZakpeEJdaWrES2LhyIRfIJilIkip87JKH5V/
	WBFqEis7IfCog8jeA6XTnP4S3uJscxYPzGmpEVPg5bW5M2xbhjwYRainp8UIlZOZTdV83Kt0KiB
	TWCYuFbBvGCouG5dEDIkGJlopG7/oY4RKjcziy9BF/wxZzPXooNGbhRPTyGVOBYS3UhIevU1h4Z
	CBT1H2yC3UadGQJShFLPyF7X1Coy3vrO15C+bb7dA+BlppuM4=
X-Received: by 2002:a17:90b:3907:b0:2cb:50b8:e59d with SMTP id 98e67ed59e1d1-2cfcab119b5mr7125414a91.12.1722406676589;
        Tue, 30 Jul 2024 23:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHiNHt0e8r+J16WpmTX658h3SHjZ4qclCo5nuyNo1MeoazeMAVzJCq/CVbDiXLbAfOteubHgc26cPv1m8AaaM=
X-Received: by 2002:a17:90b:3907:b0:2cb:50b8:e59d with SMTP id
 98e67ed59e1d1-2cfcab119b5mr7125392a91.12.1722406676190; Tue, 30 Jul 2024
 23:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
 <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com> <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 31 Jul 2024 14:17:44 +0800
Message-ID: <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jul 29, 2024 at 6:08=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > [+Cc Rafael, Srinivas]
> >
> > On Fri, Jul 26, 2024 at 2:52=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com=
> wrote:
> > >
> > > On Fri, 2024-07-26 at 14:26 +0800, Kai-Heng Feng wrote:
> > > > Without proper C-state support, the CPU can take long time to exit =
to
> > > > C0
> > > > to handle IRQ and perform DMA.
> > >
> > > Can you provide more details?
> > >
> > > Say, what cstate is entered w/ and w/o this patch?
> >
> > Without the patch it's ACPI C1, C2 and C3.
>
> They are called like this because they come from ACPI _CST.  You need
> to use turbostat (or equivalent) to check what C-states really are
> entered.

Both C1, C2 and C3 have some residencies.

>
> >
> > >
> > > can you show the output of "grep .
> > > /sys/devices/system/cpu/cpu0/cpuidle/state*/*" without this patch?
> >
> > /sys/devices/system/cpu/cpu0/cpuidle$ grep . */*
> > state0/above:0
> > state0/below:631
> > state0/default_status:enabled
> > state0/desc:CPUIDLE CORE POLL IDLE
> > state0/disable:0
> > state0/latency:0
> > state0/name:POLL
> > state0/power:4294967295
> > state0/rejected:0
> > state0/residency:0
> > state0/time:19513
> > state0/usage:635
> > state1/above:26
> > state1/below:12437
> > state1/default_status:enabled
> > state1/desc:ACPI FFH MWAIT 0x0
>
> This is C1 AFAICS.
>
> > state1/disable:0
> > state1/latency:1
> > state1/name:C1_ACPI
> > state1/power:0
> > state1/rejected:0
> > state1/residency:1
> > grep: state1/s2idle: Is a directory
> > state1/time:18621370
> > state1/usage:74523
> > state2/above:1690
> > state2/below:17
> > state2/default_status:enabled
> > state2/desc:ACPI FFH MWAIT 0x31
>
> This looks like something that used to be called "C7s".
>
> > state2/disable:0
> > state2/latency:253
> > state2/name:C2_ACPI
> > state2/power:0
> > state2/rejected:0
> > state2/residency:759
> > grep: state2/s2idle: Is a directory
> > state2/time:7063052
> > state2/usage:7909
> > state3/above:13111
> > state3/below:0
> > state3/default_status:enabled
> > state3/desc:ACPI FFH MWAIT 0x60
>
> And this looks like C10.
>
> > state3/disable:0
> > state3/latency:1048
> > state3/name:C3_ACPI
> > state3/power:0
> > state3/rejected:0
> > state3/residency:3144
> > grep: state3/s2idle: Is a directory
> > state3/time:4451519230
> > state3/usage:55467
> >
> >
> > >
> > > >
> > > > The data collect via wult shows the latency is similar to Broxton, =
so
> > > > use the existing table to support C-state on JSL and EHL.
> > >
> > > so you have done cstate measurement on the EHL using wult?
> > > can you share more details about the measurement results?
> >
> > I look at the "spikes" of the aggregated graph. Not sure if it's the
> > right way to interpret the graph though.
> >
> > It will be much better if Intel can add the proper C-states table for
> > JSL and EHL.
>
> So what's missing in the above, from the technical standpoint?

The crucial part to make the issue (i.e. slow ethernet) is
".disable_promotion_to_c1e =3D true".

Can we use that for EHL and JSL?

Kai-Heng


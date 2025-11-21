Return-Path: <linux-pm+bounces-38339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F0C77ADA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 08:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A2A4E75F9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D833555F;
	Fri, 21 Nov 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLlR6q/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB3318155
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709744; cv=none; b=tLOKY2Fqgw0uXpZ8kDo5hHFEb+PhaWKeN9jDGlu5Vc5TLzdtrSGfbPOauWUkrfzooa08moR6HMabkasazcHnybQvHtNSCkYpjT+rFVGZQGM+cg/ZTT9vLeSMvVqYpysGL6g03OQyMPERvxyy77c3FUSdv0usRir9od9eWBnK8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709744; c=relaxed/simple;
	bh=ySLfQXo1dbGgAcRXcfcligNniGhIdzsrysHnlKsOdXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5YYa46t8hSZUej4L1WwRT0NNDwErvcDmN0jko5o25+uHkA8NvQ9ijY8ybUaZixacMVAg/Xr2lwpw60EdrRoCssuc2+bm8bQ05intsk/itm2WbH7KShhNdCPdaN+C0M5qCwhF/vGHnC8iK3d1mp5BnmbkaJ7syWk0/AOsSsbhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLlR6q/G; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so2386393a12.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 23:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763709740; x=1764314540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXe3NiNtXd09TBAnyXOy9PFKvfckYekcVcmJPAsWbKA=;
        b=kLlR6q/GYph6YNc3pW2fcaCIS9BR7FtlaLrQb5XstSZbNEIfIxN8eYXZmIFg/5sDY7
         cyEeal4KRSCt5joTi0rHl0GoKfmmqrD9lkhNhGQoFXzINsYBDuigPCjpomcyFME7ERkr
         6BZ3O/y3fJJyjzqNM2wVD3YLCuHGoymrH9VrvZYs70+frqljW5zGW5Vds7DkVC2Z9g2U
         6kUHojxzvC2Aw+lDZhr6aIUUY3KZdRbdqfnh41nRgMT7hHHLWOY51ztCuVu/ZpORJ/oB
         xGlV270RG19FNoIjmp2UobWvTEQHFzSqTw87VEN5CQE+QqJW6txcKOX57Y27SGOLYXEw
         lrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763709740; x=1764314540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXe3NiNtXd09TBAnyXOy9PFKvfckYekcVcmJPAsWbKA=;
        b=KGIr8EYNRMpWThUQ3a1Tu92JSfhQZevcp+3UDLvq5XKCr6MH0fPDZsNc6nm2781lJ+
         UpHCNF/Sw6y+O7Ql1LY2we+62R/6IOHV74zfMU0C5G9XUhb/zR029OajAa9kU+4nAzlx
         Od+doyxK4R1ihItURN10/M5WSNnZfvd9bED97RZscAvKBXA0tYA3BtgGER3tnuj8vThR
         Ioi52ymWIpkpwR0LfT0F6duVLN4T9Wjeet0W3vhe6zx+1sqNIKy9fLcAy81G4PhGoQft
         8b/YVwZ3lUyh5nIsOGYIDCKqsbD4Ltkpwr21bIhnU9FoMrLDOlBAigGNEKN7K7vpAV5j
         sbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqTheHqZMpqsTCvJ9y38sbtYplCE4Z1vStJRloOjBk05rvW0lnNVF5oEYwxUKDMD+UPdjMwuU1Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIuRchkeBCdYLOmi2WOac5XkeTEgRLOUSYQCWZtFvWvoyDimP
	/dRLVgEOHtMeCaBj4164PDIN3CMigvAz7LQVQkLtLSTNxy8NHYLJfNl2DeMfINHKH4KpMROqXKN
	AZBL9i0P0pNmzdWfPvgxQ0bUikJHvfE7ICJpuJUHHSg==
X-Gm-Gg: ASbGncvcrF66dTDDTdau7NnG7Rp2/HhHkQBk/GzJNXPkB18UBaYmQmEXsEUzWV3Fi2w
	K7Pt6yDxhR0vAPppUcRbK63MHdZ0DSQnII34fAyR9Om72PUEsLcP/Oj8ANUbEHfEjrpyErHTOgK
	/N59rL3Wa2SEZduHkNcBOsSjyx/0RfKaxZX/E0aVszzoyLkl5WkrffKHAOF0Cdx5rB4c/cqLrHq
	KMbZvhJpFlWokB1bncHGHbT6d+9zfnbqwgIHL7Dp/zasUmHXblYlSdvd9nQAl5h1wfaLGDRQwes
	DxFReluEVZcdZogE6sHwJ9pR
X-Google-Smtp-Source: AGHT+IG4pcNLrDM5DFik+IbRdmayjl84fVKRTwjmeW0u8QWj9awEZHXjGuAgK6EmlJyE+Yn21YGkJAlurTcHgk94Xf0=
X-Received: by 2002:a05:6402:2714:b0:643:e2d:1d6c with SMTP id
 4fb4d7f45d1cf-6455431d30emr1179091a12.4.1763709740284; Thu, 20 Nov 2025
 23:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
In-Reply-To: <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Nov 2025 08:22:07 +0100
X-Gm-Features: AWmQ_bkMstmn2slDmBsoamS92mlNB1KLBAs-OU9TYoY6UxE1YIMQSR6PAIKupGo
Message-ID: <CAKfTPtAq_90WkSbL-vg8Uh46WNjzqVApjDHF+htgdNBApRFM-w@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 08:03, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/11/21 12:55), Sergey Senozhatsky wrote:
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> > > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > > Hi,
> > > >
> > > > We are observing a performance regression on one of our arm64 boards.
> > > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > > > Rework schedutil governor performance estimation").
> > > >
> > > > UI speedometer benchmark:
> > > > w/commit: 395  +/-38
> > > > w/o commit:       439  +/-14
> > > >
> > >
> > > Hi Sergey,
> > > Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> > > What do the OPPs look like?
> >
> > How do I find that out?
> >
> > > Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
> >
> > > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > > stats of a few runs?
> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> > > Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.
>
> Am getting failed delivery notifications.  I guess attaching those as
> text files wasn't a good idea after all.  Vincent, Christian, did you
> receive that email?

Yes I received it


Return-Path: <linux-pm+bounces-35287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80299B9ADCA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E461C7AA514
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C930E823;
	Wed, 24 Sep 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lDGu75/C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C631327A
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730888; cv=none; b=lnX7OvooVwF/QV37YXCecUZozE8Jgemdkl65DfXvrySYQCZgxLgCln4ms55wmdgnT3s4UHtsRySPkfBUyocqJo5CTPbVtizFR38Qp0YBdLz5F8i1WP4+ZaR570XvGbUd2frWJfNokyjnP8xI4qz5FnFpgmbn/R7X0dbTM8CePBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730888; c=relaxed/simple;
	bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkcOMS3PA7DdZr1Zisrp2yec8RTtzMvDattNZhNP71adHBW71M5th5y92j1Sb44g9rIhfik9EF7Lg/7y7AWT7uwuW0W82Cq7GKW3Y1rH4bCr1j87WiZruLBJc3zPF3oYyiZO24b+0dcog7dVd584IkodtVUOTo+cvW/iy7jUpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lDGu75/C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso2574688a12.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758730885; x=1759335685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
        b=lDGu75/CmUU+chrQl3SRXh04l8tU1MPx3VDaJjKh4FMAxZdaWUQiM6JOTs1wB5UFoB
         qTzqGmc/oU9KcFcfb6NmV72oofiD5kokl1cG5U9izgTL2aWBtO8K/S+B9csLMN90Fs9U
         tDxtsaqrsgr+gRYzxucJtFeY+4/9wxTB17tRoNCwcfeJd/80g7eS/ee6cY2DRvjs2FTr
         gGSQjMcfvNrdt6wKkebwyJIWSGh4cgcEvFmyosjCk2/wyXOna6bTzTAf4in+rWHOP77z
         WE7zjPM2JZ3nkVRH0kif80XGdqmBnLM0khtwbIZdTWhpXR6BoDe7qz/rl/iuxUcrz9PY
         JSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730885; x=1759335685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
        b=hdlV5XLsZzHX271x3hUQ7TMgkjtBYIvTeUZtWztSD/3qCWzRAva/Ir6/ICvfsRzvl3
         f4Am6Npa1G+h3jO7z8DvgSmDSk1aVsg0z1dS6oKXGQPs88FBPv68+KMtYYLCTVBoQ/Vv
         BADBiJBXa1z4vX6+peVlz1UgysKwpSJZTc4fmMZSi/IgLcf7aRO1Y2sLpMnuxLkBLZ2b
         Xs+P0K/CCXXzPZbALq440FKIPdH87sibjFio5l62qQEZCPHXzCK2USC05TKWaCZ6kKtK
         VxdxR9Gb0XXHcOrj2N9tR2ONFenP4tPLQy7lghE463nIg35UwXslqp4VJfDaNyyF3O6L
         2Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5hT5jNou3l16rguRqQU5tXAPH8MrKYj9Kw3OEK65S1EhBNAI4MozIOPaVCRzBLScCwPkx/U14Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTj2jTdc8QZfgK+8qxSgFWsHgvD6vttaCJiqZVpv4wRux9OBA
	L7ZlEVRHev+8cXOTex8KYWOb0iHuS+RifXg6IeEO/LUvgyok2tVOhmhKWOKXzH63i2D6n1OTFaq
	CZTN1sawGnwr1WbIBI10NYsI34gJWzRv07lzF4uW2+Q==
X-Gm-Gg: ASbGncuqzSZeOLp3foMUx9FFAPEMJJYLSAx0L71l8iuzJGLDtXgKv+FQX1VlHQnCKpB
	S5aQPQq0y1ppPrz9dg+2LgohiYWBonaxNdVDyTD28WZEqkJtkJHkSfOfCKjv48UbHr2z7blHkkg
	T58uWqiXBEa8Ln0Z9U+0RaH7BIT7wfELQPL6en/DRZ9G2W3kd2bAy7VEiL5omIz9llFFjRa3dzp
	Dick3rbEh1P777EoKzE8LzQRw==
X-Google-Smtp-Source: AGHT+IGRWpoRX5kieAx8ODfA2c3P5709GPwYpJaUY9gD32LbMuLf1qLMI747P1qalIOpXzd9sueLH/Q8vbfBhoPeM3k=
X-Received: by 2002:a05:6402:90c:b0:62f:4bf5:2b1 with SMTP id
 4fb4d7f45d1cf-6349f604f2fmr146057a12.14.1758730884308; Wed, 24 Sep 2025
 09:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com> <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
In-Reply-To: <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
From: Fam Zheng <fam.zheng@bytedance.com>
Date: Wed, 24 Sep 2025 17:21:13 +0100
X-Gm-Features: AS18NWBFLLBlUj7TG1Zl8-MnAWo-Z0AA8d0KVmB7UquRCmlLYJ7gqHCqbgn4mu8
Message-ID: <CAG+v+KZ4bRgVNiMDhNTeiOqqbEXCBD72K5SQZCo=m0xaQ2vauQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, liangma@bytedance.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org, 
	Thom Hughes <thom.hughes@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:23=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 9/23/25 08:31, Fam Zheng wrote:
> > In terms of fault isolation or security, all kernel instances share
> > the same domain, as there is no supervising mechanism. A kernel bug
> > in any partition can cause problems for the whole physical machine.
> > This is a tradeoff for low-overhead / low-complexity, but hope in
> > the future we can take advantage of some hardware mechanism to
> > introduce some isolation.
> I just don't think this is approach is viable. The buck needs to stop
> _somewhere_. You can't just have a bunch of different kernels, with
> nothing in charge of the system as a whole.
>
> Just think of bus locks. They affect the whole system. What if one
> kernel turns off split lock detection? Or has a different rate limit
> than the others? What if one kernel is a big fan of WBINVD? How about
> when they use resctrl to partition an L3 cache? How about microcode updat=
es?

The model and motivation here is not to split the domain and give
different shares to different sysadmins, it's intended for one kernel
to partition itself. I agree we shouldn't have different kernels here:
one old, one new, one Linux, one Windows... All partitions should run
a verified parker-aware kernel. Actually, it may be a good idea to
force the same buildid in kexec between the boot kernel and secondary
ones.

Fam


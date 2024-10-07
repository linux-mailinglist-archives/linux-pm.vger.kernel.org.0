Return-Path: <linux-pm+bounces-15278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B249931F5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877272841F3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5DE1D969F;
	Mon,  7 Oct 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq8JGo6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7F1D47AC;
	Mon,  7 Oct 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316101; cv=none; b=jl8lnyXL6JIT73t7QU30tTrMSJfcGsimsAGIt/pDrtkXlRZG12/YZx8nPEOYg6i6+VORcDODu3+I7RpCKqlxwdDVZqTxlYE8XYX73b7cqp9mQFqGyLy5FrbJKji7I5taV56SMqh3jzFFdrjoQpt9Yq+7UNSRlkLzR/KrwaqaYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316101; c=relaxed/simple;
	bh=BvIRqePvItPKQGZhVGBArWVNWRnqTWrk0hpOKpr1jUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJW2jhyHsDaaZxaYdX506UvRijvZiCaxCk8duAiHtUWmNphi8wdCk7xhLB20OcmfQ801zVwALA5UQrBtRc3Z1kBMamfIXTrO5f/B5ghS9AR5yQFwzMjGR5myV0pcxbNA2KOgZi3ef2194CuJOy096Kq/dVQCn+h/NnFQis9GBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq8JGo6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B521C4CEC6;
	Mon,  7 Oct 2024 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316100;
	bh=BvIRqePvItPKQGZhVGBArWVNWRnqTWrk0hpOKpr1jUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lq8JGo6I34izVAMuIGTCyZaBxer8WOFKJ5RkU1140IXVvojo14xjkuhEkBnhJEvir
	 LCBLS6EXoE//yC9Fo8Oy5Diuk2xnfOekGOuoAMC7m9h0k/m6lFhSQBz24Dd4Q4nW/g
	 Hz0s2Z8bfDvJAn6akt18hy8aGwihE0R8X3BxvS1TcQO1YQjfe4iJ9jr0I4QG3hm8ET
	 57u8L2xDED5kieUk6L5w2ckJH8biMswir6MKtjLxWmGuiUv/VejutfyNsTXNo1wM71
	 i5uUT5xhuQvugS+EdNdJoSjT3qvBSLxwa6lNlJKhFusjRqsamqxgjUqnNzIsHoBR1A
	 SVykrhrphCQLg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e0402a98caso2434407b6e.3;
        Mon, 07 Oct 2024 08:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3yJf2F4PyLVHu9D/wRSSryYsUYR5MoEcE7cSO4QTqaraLzub/WqEGtcDwsh/1Sits6jgNTL4Yh6EHjjM=@vger.kernel.org, AJvYcCVTZ+KXS2YUXLqmuMyLTOkg1r1iV+miv4IAmx89Hvi/Kn0iYo3ZrKfpUpF1GlnyKqCGEsWiSJF9PXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx917Ilj2pQhKgQr3yw3YRFsQIRfPkqmgOdPIsfiVCpY55Hjns1
	UF9c7aQVqZM0EV5T4HdzTACm16krFMv1XVmu4WAe/WscRQxi5rgeAgpfd3ujUIMOrlH4sEA7bD5
	6IpCfLQPibnEjyREXjzi+ikGdcoc=
X-Google-Smtp-Source: AGHT+IG+Bjoy4hnIn6zCDrUD56RsM9Z4KXhwAYcNCR00YhzmEW+RLrYEitFcYuXJCvryOOd2OU3Fe40KVtmwvxZILmI=
X-Received: by 2002:a05:6808:128a:b0:3df:54d:7b4a with SMTP id
 5614622812f47-3e3c188d5afmr9184413b6e.46.1728316099978; Mon, 07 Oct 2024
 08:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com> <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
 <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com> <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 17:48:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j46anSdQBnsqojcyn2RGKG259ahd92n380wUSAtRFDxg@mail.gmail.com>
Message-ID: <CAJZ5v0j46anSdQBnsqojcyn2RGKG259ahd92n380wUSAtRFDxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	ray.huang@amd.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:46=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> On Mon, Oct 7, 2024 at 6:40=E2=80=AFAM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
> >
> > Hello Rafael,
> >
> > On 10/4/2024 11:47 PM, Rafael J. Wysocki wrote:
> > > On Thu, Oct 3, 2024 at 10:44=E2=80=AFAM Dhananjay Ugwekar
> > > <Dhananjay.Ugwekar@amd.com> wrote:
> > >>
> > >> Currently, there is no proper way to update the initial lower freque=
ncy
> > >> limit from cpufreq drivers.
> > >
> > > Why do you want to do it?
> >
> > We want to set the initial lower frequency limit at a more efficient le=
vel
> > (lowest_nonlinear_freq) than the lowest frequency, which helps save pow=
er in
> > some idle scenarios, and also improves benchmark results in some scenar=
ios.
> > At the same time, we want to allow the user to set the lower limit back=
 to
> > the inefficient lowest frequency.
>
> So you want the default value of scaling_min_freq to be greater than
> the total floor.
>
> I have to say that I'm not particularly fond of this approach because
> it is adding a new meaning to scaling_min_freq: Setting it below the
> default would not cause the driver to use inefficient frequencies

s/not/now/ (sorry)

I should have double checked this before sending.

> which user space may not be aware of.  Moreover, it would tell the
> driver how far it could go with that.
>
> IMV it would be bettwr to have a separate interface for this kind of tuni=
ng.


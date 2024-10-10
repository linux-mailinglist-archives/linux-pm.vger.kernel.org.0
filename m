Return-Path: <linux-pm+bounces-15468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23344998F07
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528C41C213DD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BAE19D064;
	Thu, 10 Oct 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbXir0cH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB919C57D;
	Thu, 10 Oct 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583054; cv=none; b=lfshqp4bPlPYS4YX6DaVGMh+OtncvAHRwUDibe1h1WBjPEY628mWlJPpz2PELr51e1I+WphGXWKyIsIYjxnIV4v9oIcyaDw5qB6LvCW1iNbhJaFgpbMAFRsvM7h1bD8Q9kpxNWl+Pj495WBXB/0igysSqdEiI/CQ5SF9/0t+38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583054; c=relaxed/simple;
	bh=PFsH6ItHrM4WJs3X0uhKTVAGz1bIRu+P1arqBYDfk2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtKHZZD0AGUJN1CAwfNTHUASrFGREyoRssZwUnqa6AZ8SJBcvPicrpLJCDDtue/HB+nhB3uTI49TgFXeavKKFvhtw3o6M+PjGH2vyjTWl213uV4s383DVYDk+d6IVkDlEbPtlSQZHGx+ZWaXcVYbdA+X20/FOF/GFDGeWpIJvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbXir0cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E780C4CEC6;
	Thu, 10 Oct 2024 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583054;
	bh=PFsH6ItHrM4WJs3X0uhKTVAGz1bIRu+P1arqBYDfk2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BbXir0cH3uyT1gpTZnaLVIYlVE9/xzWqPbd1p8SQCEidrrVyViaUYXgj6/W9fWwaK
	 A/Z5wKSiBSBNchzKk5gpms7l5/CdX7ZJN1P1x2tOefp7AYF9gdKLmfqk9Dv8v/UxCW
	 NoFYPW/rPljT30mNpsphVe2Qpeiao9FieOulHksZVMV2Tgc301LE5Y1cvpnS1WWeog
	 +VMs1PTmXPI0W3lKpjLtMumODX4zn7gNnphYX2DW7fX68poe9g7QYn3oCnxcA5x6FB
	 71TUhaPYzqQF5QE2GhhFe0xoOBtQwNC51VmgoyG5r8UlvsWozLM9MqLy8SjEE80AHg
	 zD2OkKfMxF3mg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e5d0a80db4so625935eaf.3;
        Thu, 10 Oct 2024 10:57:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5NTIwfmjvgkDGJmcNUOxPdO3Kli46F5nnrWkE4T+kyVDzBPkNUXulh1Z60lPJ4xF2rrdVEBR6eo8=@vger.kernel.org, AJvYcCXy/6EFvcBCbDwrd5nPWnDhvCJmeavNNF4ypxVR2Ym0s2TAAMZp4EbUSE1uwlCt8lhaKCHW6yonPYeL5Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrezFQ52XralKkodS9mil69bK3Eq03sKgjGohvnPSK4MRl+hx
	p0f7mEf4HWvoMH3G59ZxfuiQrWq+tzvVx+sqBXiu5JJJ9IM2WIMsBLKbasVBBfySYMF27UannO6
	YXArF80JbZlkxmWh5ALbetMnQZw4=
X-Google-Smtp-Source: AGHT+IHsGFdp1H2B0bRRMFETpGIZM6TFOs4+STFq23+cQOaCSlRAvLYs2o5IIAiNjyfZh29gcfzP5sR3gjPZzlbL2II=
X-Received: by 2002:a05:6820:1621:b0:5c4:144b:1ff9 with SMTP id
 006d021491bc7-5e9900a5a42mr4003997eaf.5.1728583053486; Thu, 10 Oct 2024
 10:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com> <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
 <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com> <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
 <CAJZ5v0j46anSdQBnsqojcyn2RGKG259ahd92n380wUSAtRFDxg@mail.gmail.com> <b4758500-9169-41fd-8dc4-9b61d00f2fb6@amd.com>
In-Reply-To: <b4758500-9169-41fd-8dc4-9b61d00f2fb6@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Oct 2024 19:57:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrbNFGR3gevtRS+KDB-iVx-aK4F30TCrZOLH7x0QXuqg@mail.gmail.com>
Message-ID: <CAJZ5v0jrbNFGR3gevtRS+KDB-iVx-aK4F30TCrZOLH7x0QXuqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, ray.huang@amd.com, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 8:32=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Rafael,
>
> On 10/7/2024 9:18 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 7, 2024 at 5:46=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, Oct 7, 2024 at 6:40=E2=80=AFAM Dhananjay Ugwekar
> >> <Dhananjay.Ugwekar@amd.com> wrote:
> >>>
> >>> Hello Rafael,
> >>>
> >>> On 10/4/2024 11:47 PM, Rafael J. Wysocki wrote:
> >>>> On Thu, Oct 3, 2024 at 10:44=E2=80=AFAM Dhananjay Ugwekar
> >>>> <Dhananjay.Ugwekar@amd.com> wrote:
> >>>>>
> >>>>> Currently, there is no proper way to update the initial lower frequ=
ency
> >>>>> limit from cpufreq drivers.
> >>>>
> >>>> Why do you want to do it?
> >>>
> >>> We want to set the initial lower frequency limit at a more efficient =
level
> >>> (lowest_nonlinear_freq) than the lowest frequency, which helps save p=
ower in
> >>> some idle scenarios, and also improves benchmark results in some scen=
arios.
> >>> At the same time, we want to allow the user to set the lower limit ba=
ck to
> >>> the inefficient lowest frequency.
> >>
> >> So you want the default value of scaling_min_freq to be greater than
> >> the total floor.
>
> Yes, we want to set the default min value to what we think is best for th=
e platform.
>
> >>
> >> I have to say that I'm not particularly fond of this approach because
> >> it is adding a new meaning to scaling_min_freq: Setting it below the
> >> default would not cause the driver to use inefficient frequencies
> >
> > s/not/now/ (sorry)
>
> I believe we are not changing the meaning of the scaling_min_freq just se=
tting it
> to the best value at boot and then allowing the user to have access to th=
e entire
> frequency range for the platform. Also, we have cpuinfo_min_freq/max_freq=
 to
> indicate to the user as to what the entire frequency range is for the pla=
tform
> (depending on boost enabled/disabled).

But the default you want to set is the lowest efficient frequency
which user space needs to be aware of.  Otherwise it may make
suboptimal decisions.

> >
> > I should have double checked this before sending.
> >
> >> which user space may not be aware of.
>
> I guess, this part we can fix by documenting correctly ?
>
> >> Moreover, it would tell the
> >> driver how far it could go with that.
>
> Sorry, I didnt understand this part.

Sorry, never mind.  I was just repeating myself.

> >>
> >> IMV it would be bettwr to have a separate interface for this kind of t=
uning.
>
> I feel like we can incorporate this change cleanly enough into scaling_mi=
n_freq,
> without adding a new interface which might further confuse the user. But =
please
> let me know your concerns and thoughts.

I'm not sure if you realize that the .show() operation for
scaling_min_freq prints policy->max and you can easily make your
driver's .verify() callback change it to whatever value is desired.
You may as well set it to the lowest efficient frequency if the one
passed to you is equal to FREQ_QOS_MIN_DEFAULT_VALUE.


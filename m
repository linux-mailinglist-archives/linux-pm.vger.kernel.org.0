Return-Path: <linux-pm+bounces-16869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451A9B90CB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06B91F22B81
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75AA19CC29;
	Fri,  1 Nov 2024 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIaRloLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCE19B3E3
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462215; cv=none; b=DNy+GlwqPm5iXR/cs1SB/D1GCMUfWgQmSWLjT8bgIaQ0Q3HP29Z5P0YfzyuLbYHoKGSAgk8CUMFkS8R0cLhbckA5VGUMyrXWJNUF1tvOkdIQEeN7x9fQHrjQUtwWTYtV0M++/mLcv8GGdWq72EiZhFDK/nAhF6+ZMtxr0XH1boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462215; c=relaxed/simple;
	bh=bEjXnXMl7Ay4KShECfnw+okEgY3Haneebjk5FbB0/Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1S49qQ0RqEuWe950eAqA9shzMen/cMPqDJOd389mSK2GaDPr5wS6QLDF5fTUUDL4yVdCH7B6lY6svtSzJIec1FBWsI8Vw/D0m3IJpPRhVtVFymw7hCC0Ct8XEq1ORYJyCqZggdvI7qKxI/FercJAQQ29E/SDSh6XhrTn/246F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kIaRloLB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e33c65d104so15606767b3.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730462213; x=1731067013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bEjXnXMl7Ay4KShECfnw+okEgY3Haneebjk5FbB0/Hs=;
        b=kIaRloLBKIzN1mFarxzEwoV6g9qkmQTid2cJCNcfVvJxYKj34d1kez5rgjO934Su8E
         BfoAQblT+mDSveJZGEemCgonnuROJQtYVbCy4Xj5tXwwIUTrK74sCLt5US0w4yQZtG3P
         ir63ovRXSLVzXsDFLMIDH9285fLWIcvF0dUPF2aS25H7i01V4kihkctdbxx5KjEchqMl
         rOVjIw3Ju4wR4vrOSyc5AKVYyOYjHdhqHqpbNBA1WviwiETZ4RfT+GywYEBHiQ29hFnO
         j85T80fbbQi0Ek7CwQ8TwAGqNTXwdv8LMGvU0DCRRhjTKQoLfJKYPTgsctL3EWvOm/R7
         2ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462213; x=1731067013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEjXnXMl7Ay4KShECfnw+okEgY3Haneebjk5FbB0/Hs=;
        b=rk1jlZjlfbpvHPMuRvD4NLNqoIAwYsK4XJSJEmGEyGzp6SzO09Tj0KuGf2h5N78Fah
         mouavKsnnsIZMI+oKcuLepGBn/RHsxF3LseTeW3eewmTzvXOkwmMOB3vEvpVIgsotnPQ
         IMrIR360jwFQlNJNvjWaoZJ2b++Kt8dg+cZ7fW74FHrzfiNEYVeP452D4d4G5rYWUfFw
         D3JmsWFWLXajq/0jjzPGEkyJSxLMormNxiUEFnSxNi3ciFAqXU8DY+tumvewgHi//W+i
         htJuwDmrlTMzswPMJHFxAKmjc3qcZTnBzIwCNScg8RT7o0k5j3uVznUqrnUxQcQqMrjU
         M3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ORedbx4aYpHlszaM6IUWIntLtFUrwpTMOH/sDAqJFhoCat49a80YA0KJJuJvbLVD5yEjopyB2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYrGaHEFbyz1jdYzQMrvqKX02o4vJOQiXu1AdtXXbDME8KHE6
	ZmVk1lpKuDWMbOPrhHUzRLSnooXkYl1pZqmMgaNsBoN7PGYA6FGrKzdlYFYAy4qxOA0T3/2VKsF
	sPZQY/T35CYjdl5rul0UiuYwWwqdRd7K129Bnbg==
X-Google-Smtp-Source: AGHT+IGEoqkUdkWxi7vuinWA4jtAEJie/21Db5kfRuMM/lRk+uKXHoSQVZnW3JPpiWrncmcO/tvCnkg7EHY1ZRQ4gvM=
X-Received: by 2002:a05:690c:f15:b0:6e2:aceb:fb34 with SMTP id
 00721157ae682-6e9d88ea2b9mr230633227b3.1.1730462212665; Fri, 01 Nov 2024
 04:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022154508.63563-1-sebastian.reichel@collabora.com> <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
In-Reply-To: <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 12:56:16 +0100
Message-ID: <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:05, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Oct 2024 at 17:45, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> > driver is loaded late after booting. The crash starts with the following
> > shortened error print:
> >
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> > SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> >
> > This series first does some cleanups in the Rockchip power domain
> > driver and changes the driver, so that it no longer tries to continue
> > when it fails to enable a domain. This gets rid of the SError interrupt
> > and long backtraces. But the kernel still hangs when it fails to enable
> > a power domain. I have not done further analysis to check if that can
> > be avoided.
> >
> > Last but not least this provides a fix for the GPU power domain failing
> > to get enabled - after some testing from my side it seems to require the
> > GPU voltage supply to be enabled.
> >
> > This series is now based on the pull request from Mark Brown:
> > https://lore.kernel.org/linux-pm/ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk/
> >
> > I added one more patch, which adds devm_of_regulator_get without the
> > _optional suffix, since that is more sensible for the Rockchip usecase.
> > Longer explanation can be seen in patch 6, which adds the handling to
> > the Rockchip driver. My merge suggestion would be that Mark adds the
> > regulator patch on top of the immutable branch and creates a new pull
> > request.
>
> The merge strategy seems reasonable to me. But I am fine with that
> whatever works for Mark.

Mark, any update on this?

If easier, you could also just ack the regulator patch (patch1), and
can just take it all via my tree.

Kind regards
Uffe


Return-Path: <linux-pm+bounces-137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254F7F63B7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9376C1C20DC8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0F3C088;
	Thu, 23 Nov 2023 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TB1au32u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CF10C0
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:14:37 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cc55b82ee5so10022447b3.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700756077; x=1701360877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipzMNGrGtolaTuN+LIIgKEncct0aftDF2s8V+J8A68E=;
        b=TB1au32u8m8eCO3UzV/gibdFPsdh5WsVOoeM3EqADr21c22opVoMNQkCvOooM127Wl
         G2PJ0otm4EnQfy67H383gMAr32cNWvbLl/3MRk4APIVR1FMIIHaW1kFVbtM/ZcUXv/ly
         h9SYLETXEGUx6WsYR0JhLnky5U+FlS1h6cyS6bEHtoQGxrqPxukBk44oWX59lQw1Bt7I
         nrnZ++FSyM8TCdYoM3u0bBFrekieYqQ7RlbejqgHKprziT3+EBV5YAecmZndOhXeZu1m
         xxMRujogWdPBWjC9Zjjale10DjBU9NtADu1hE39BWJkrOc/ioNJsXoEQ4wWbXu0lp/C6
         Y4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756077; x=1701360877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipzMNGrGtolaTuN+LIIgKEncct0aftDF2s8V+J8A68E=;
        b=NveJt0BYdWLavzrfVX0JHpawItUeNeRosUNS5yA+Ny+StS46hFBaJ5tv+iNz8msNYf
         jq8xy3RoheJwjtf/fyqyrwoLXPf5CI6Rml0x0tg7KTv7Rn7xr9yDQsITTElHYp5hW7fM
         HjybgQK2menjk499Uo5qn4DQzt7aNrJhZjeKUxLfrAyuByC2AfvETdPzRyMuKxAMWMqV
         vcHcchbS8NSsAP+EBbpz5S5dyk00DK8sTzH+MvkMSpjXJg02TGTHGiqbFPPNooD6VRR4
         fLe9EAy2Qvlf93Av/FgdoAp0wG8vs5CVqqvRQt/rjHtEkMLquBqu149C2ydUYoCx3A8C
         yr+Q==
X-Gm-Message-State: AOJu0YxqCg4cgRd/iSv6sOi01ceYm/QH7ZSZZwsBbBTZ2mvqejYK+Th4
	hMakDL9hAepxRRxNrbGXge20XHNjCTHgGwbCRP3XVg==
X-Google-Smtp-Source: AGHT+IGVXCCNObF5Fssf2rOst5kdMHeHaWlMqNi98aNmC9WRf3QJ62k48s/V/HjbQ+uLlCBO8r4oX3qbTumAUwJj8zw=
X-Received: by 2002:a05:690c:2891:b0:5cd:6004:3549 with SMTP id
 ee17-20020a05690c289100b005cd60043549mr1455172ywb.27.1700756076780; Thu, 23
 Nov 2023 08:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
In-Reply-To: <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 17:14:00 +0100
Message-ID: <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] cpufreq: qcom-nvmem: Fix power domain scaling
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Stephan Gerhold <stephan@gerhold.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 08:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-11-23, 11:07, Stephan Gerhold wrote:
> > The power domain scaling setup for QCS404 and MSM8909 in
> > cpufreq-com-nvmem does not work correctly at the moment because the
> > genpd core ignores all the performance state votes that are specified in
> > the CPU OPP table. This happens because nothing in the driver makes the
> > genpd core aware that the power domains are actively being consumed by
> > the CPU.
> >
> > Fix this by marking the devices as runtime active. Also mark the devices
> > to be in the "awake path" during system suspend so that performance
> > state votes necessary for the CPU are preserved during system suspend.
> >
> > While all the patches in this series are needed for full functionality,
> > the cpufreq and pmdomain patches can be merged independently. There is
> > no compile-time dependency between those two.
> >
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> > Changes in v3:
> > - Drop patches with MSM8909 definitions that were applied already
> > - Add extra patch to fix system suspend properly by using
> >   device_set_awake_path() instead of dev_pm_syscore_device()
> > - Set GENPD_FLAG_ACTIVE_WAKEUP for rpmpd so that performance state votes
> >   needed by the CPU are preserved during suspend
> > - Link to v2: https://lore.kernel.org/r/20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com
>
> Applied. Thanks.
>
> I picked the pmdomain patch too, lemme know if that needs to go via
> some other tree.

Usually I should pick the pmdomain patches. Although, I thought it may
be better to keep this series together.

Assuming you are going to send these as fixes for 6.7-rc[n]? In that
case, I can just rebase my tree on a later rc if I find any problems.

Kind regards
Uffe


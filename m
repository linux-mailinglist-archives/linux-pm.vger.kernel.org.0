Return-Path: <linux-pm+bounces-31596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56809B15E2B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BEA3BB751
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C4280327;
	Wed, 30 Jul 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBzaE8mt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25B26B95A
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871394; cv=none; b=eq+YjDC/OQbticAfR//pk6z0en7rWsPjez6IDTqDu+CT1N4FFgihzR6pG1yNiJ41M44nJFbIBA13qQIi0TYx09sekAm5L6A1snV++mU37g9AbLrJk3OaJ9YjA0YuYxwVmEBtET9Hf9jVb+2L4SUVTPsrua9dOF6SuK1igPSe59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871394; c=relaxed/simple;
	bh=g32rR9qU4kIiq4ZDdhalVntuHNQUFPPPoLfAdLm96tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKoAV7l+plAlAgvh70eLLZtSBasscoWJtx6BTdfLi7xcj8R//2TH23AHwhMnaHBkJRBdXS0P6Unc1GawZIXEC5B8VevmjW5f0othSqNJkLU2hZNUCGWSxRCErB5yBsWf03v2cti4E/s2TSgfM8rdi6aS1BYRXsS4LnALLLcAu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBzaE8mt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71a39f93879so8447537b3.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753871392; x=1754476192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DfRGBX3mcpytWgeuQOoQcWlLUxxXP7ehgwEP8S8+jQ=;
        b=JBzaE8mtJ3Ny2bHKAB30lPQDy6AaMbEqiAEki77two5pZm+C3NT/o1khfRr8Hr5hpB
         iTecnffx+lLkLzO7BadFmMgBJcxYzmKYq/UsTJ4jBS6C08L4ynvd9xH/FjZiBN6kPen9
         4NThFlbcG5c/EV5Eqtkc3I+wyV7R64ghPBPMKYRZaeYDj5kf155ocwhLrbhKXGeCxK/p
         ukV3m2kivRp754NLy7GFzIbh1VQ8F/vIJpNUNsdQ3eLJSJCXj3mYMtjB8V8bZyjlskLb
         RPQpbHGraTLpy5zN/r3LlpyAzgfsA+xpjcvJsbi2WSpWrF9MQjBdO2dgcukFbf1SXFDW
         8buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753871392; x=1754476192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DfRGBX3mcpytWgeuQOoQcWlLUxxXP7ehgwEP8S8+jQ=;
        b=Oubq1uPQnvaruqyP7jqkdADekD5IdnN9Fb7RdZeV+HE+1A47kO+Scx3bN64BvUm46C
         Uk3kqtYYxuy8W29lOziARTxtJGuNmwOJFGtJ46voe2ihKYC5+zBOV7IVaa6SaKqkAReb
         5e3eqFhZgQvZcBYbiQ6sjIfc39KV6XJTWU1bpNs6BgxNTdDol29vfFjjIcEYI14nx+fX
         PKWlMun7pmdxQ4i/5rMJ4aYLDSNLE0SgSOb3Rqf2nPqz5KvOG85Wq8PkZHeElQvMhBLI
         S5q2DCJF/RxX1gEpcklTBDKNYhXpoelLtK8L6AFjYW8FgQynhXT09JLYr4YyDDGOLdVx
         natQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb/kvBRvtBhtEUrQaVVlysqYv7uMrauV5+Ye/P+zeOJpqK+WqvcoV0o6WS9t5fULCFN6fROLx4bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxGTlNby3PI34AOToY+oRKePyVNYmTWnHQcRKP5zpb6KZe/fF
	uxhXBJlp3BbtQct6TzmbsVFouwh2Gbi20DMCg0zbtrCUez7lTvsdITP81axLpSBLJipt1kwYA4i
	2VaVNNWmr0Zpng09KzRM4iOny9OuEOQmSXu9i+RY9hA==
X-Gm-Gg: ASbGncs/ARqGVK3z7LOBJY57FGmoY624l5JvLhxyh8rti7CJfHOqMoIqkEP0eOzbOiO
	4M/LJvok6nEfR74KzlFmwUgznmlw60khosHMm0ZMH6dqW0h0Vg2X8G64/hfcwHlP6lCdcqRp0Cm
	66C50Ccqan433g/8jKEtqmQ5Yg9WA79y58McazoM8T2ubjZSUlya3jJVtW8rdMMyiH3QxY5Qv6t
	LTx9P93cDmBRI+9V04=
X-Google-Smtp-Source: AGHT+IGFQjbmfwQ2KygX5zLfPtAfVRDoKZEoCDWpl15Tj6cbjvtyN/moXAbjn/fUqackhgtTl9hi4qXu0QdfTHnMzRw=
X-Received: by 2002:a05:690c:3686:b0:71a:2178:3e70 with SMTP id
 00721157ae682-71a4745d2abmr37909517b3.8.1753871391946; Wed, 30 Jul 2025
 03:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com> <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
In-Reply-To: <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jul 2025 12:29:13 +0200
X-Gm-Features: Ac12FXyYhnc-5Yj1CQN0T9Q5i6IKPQAs_4KsBvKN_tu1xC2bA9MW4FBogdA1snU
Message-ID: <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > Changes in v3:
> > >         - Added a couple of patches to adress problems on some Renesas
> > >         platforms. Thanks Geert and Tomi for helping out!
> > >         - Adressed a few comments from Saravanna and Konrad.
> > >         - Added some tested-by tags.
> >
> > I decided it was time to give this a try, so I have queued this up for
> > v6.17 via the next branch at my pmdomain tree.
> >
> > If you encounter any issues, please let me know so I can help to fix them.
>
> Thanks for your series!  Due to holidays, I only managed to test
> this very recently.
>
> Unfortunately I have an issue with unused PM Domains no longer being
> disabled on R-Car:
>   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
>     disabled.
>   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
>     sometimes not disabled.
>     At first, I noticed the IOMMU driver was not enabled in my config,
>     and enabling it did fix the issue.  However, after that I still
>     encountered the issue in a different config that does have the
>     IOMMU driver enabled...
>
> FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> of_genpd_add_provider_simple(), while all R-Car drivers use
> of_genpd_add_provider_onecell().  Perhaps there is an issue with
> the latter?  If you don't have a clue, I plan to do some more
> investigation later...

Geert, thanks for reporting!

>
> BTW, the "pending due to"-messages look weird to me.
> On R-Car M2-W (r8a7791.dtsi) I see e.g.:
>
>     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
>     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> due to e6020000.watchdog
>
> ca15-cpu0 is the PM Domain holding the first CPU core, while
> the watchdog resides in the always-on Clock Domain, and uses the
> clock-controller for PM_CLK handling.

I will have a closer look as soon as I can  to see if I can find some
potential problems.

Kind regards
Uffe


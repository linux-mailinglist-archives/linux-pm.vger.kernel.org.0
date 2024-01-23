Return-Path: <linux-pm+bounces-2556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2572838EA8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CBB2462C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EB5EE7F;
	Tue, 23 Jan 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1xJnaPu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8D5D8F5
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013503; cv=none; b=n7loFVQvWCI0CUSvWjgdeRldLiL9DgYhCEGo4ka6Zick4WEbztnjeItQ6URF2KFD/8JHUpow6b+QMU/dE5zhY7QIYHZA2eJhmbdNdwCwiKl1A456jnutiR2eu+dvwxzjI9LUnrXunHyeNcUVq1kRpsb/BXBBvoWQPT4iDujmUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013503; c=relaxed/simple;
	bh=WBQDTNBTK9sdRRuBTkFzcjNllsxW2QS/rV8OG3A6y6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcMCuAb7najw4WZKTgxtKH81ndYfTaIdCcmBDZ3k/gVOZO+OIxVIfHainyMkj1AIv83Mw1JZ9PL/ogyRICNyIbkUH1xz+fkxpDllEL9qSj84noMhZegF+rIyPxAhuD0dWnEIKafoyqIzw1ztJAr/oxouIUjHeFCQvCNIJxqiez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y1xJnaPu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6002a655d77so12184037b3.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706013500; x=1706618300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Aht4Z16P8L5ltKdjULPwhLp0+Y9JoWi3OkWohTfrU=;
        b=y1xJnaPuWp2atV6P14a9WHO0DEDzDqqaFQjOJhABoM9HEZgIAA7h/FQw2EYKEo2j8Y
         QcGlzyugWSOtZDWjdB3/+cb5bAbvjT4jUXWYuXnBDa0+0mJWpGkCktP7/u5l5/QxrrF+
         LJtANgl+8BjmeCHxXl0UjwkgqGxLhMdBZWFj4zvieKZZNy2IYFnImWfEnvZDf1PeP0ov
         +7tYWBdA+v9zxeTUkCLZWcXGm7lxQabns0EutJtxdlWuNfwemytn3o6yG7L64DvYMcuW
         mPbxGOfmevdoQ2knoKISALT1jScuIf444motd8lM9KDEz5r3SwHdNsOjz2HKcIBkptMN
         1sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706013500; x=1706618300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0Aht4Z16P8L5ltKdjULPwhLp0+Y9JoWi3OkWohTfrU=;
        b=lD1CFyu9TzWrRHPquF0vxlKNQOdl7CaCGvJ9JD/7tF/moeWUneHMmG+L+0YzTIzM/W
         qPjkBUN2n2QjWYP4ZfFUUnFSuboO2qEY/VLEQDpVzX7m7PDY4SPA3Lam9uEL3VVuSv+B
         aKiJqrSdL5MTSZPV4huEMIa1k5/2ePnd40nZJxsFaVRxxBG9XaXJgdv3PqTwJ2EIbp8B
         yUq5e/oAYE21xmG+Si2G0knARKZntlPPrOyW64aqEqcVXF3wXl3LpI/6DxGuX98BaPaa
         vCouutqOjGeVpzUg1YOezRfvqIZGjSKTmYOEYYl8hu+HS2VJQved5NtCqD/lGVffHzm2
         S31w==
X-Gm-Message-State: AOJu0Yz8Qy0qAx2sUt5PT+NjW85mHfGibBjcbZRxcE3Po1T9htJwPaQv
	79WXRR61HpmcRSy3kc+J8pcMizbych590UEmkjsNUN8crp5THvoyDe6ZImWYbgrRq7ocBZV5jxx
	YzQzu8kcW7aPUibYfBWSQLxYPML5M5o+L7WA7nA==
X-Google-Smtp-Source: AGHT+IFjlLKWbIaooUFn6twpk291b0gxpXJoWwlTCxkhUpnf30Mbu7r2hCw+P/4GYu6YGZMa4RxyQnwR/iUlnPiM5mg=
X-Received: by 2002:a0d:de07:0:b0:5f7:a3bf:6071 with SMTP id
 h7-20020a0dde07000000b005f7a3bf6071mr3324304ywe.105.1706013499919; Tue, 23
 Jan 2024 04:38:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
 <20240105160103.183092-4-ulf.hansson@linaro.org> <87801f3e-b7ce-46ba-9856-1321635a11b5@nxp.com>
 <CANLsYkwtNa_-t0f5rhTh5mtF72urKNyqWk0_qfbBwSCQK_6eOg@mail.gmail.com> <Za8WFHxVQZ44fJJn@p14s>
In-Reply-To: <Za8WFHxVQZ44fJJn@p14s>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 13:37:43 +0100
Message-ID: <CAPDyKFqTEYygDTQz6a4TRWr0Ozs8eMBFYWrFRohTzp7svC9gsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
To: Mathieu Poirier <mathieu.poirier@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 02:27, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Jan 22, 2024 at 01:02:08PM -0700, Mathieu Poirier wrote:
> > On Mon, 22 Jan 2024 at 10:51, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
> > >
> > > On 1/5/2024 6:01 PM, Ulf Hansson wrote:
> > > > Let's avoid the boilerplate code to manage the multiple PM domain case, by
> > > > converting into using dev_pm_domain_attach|detach_list().
> > > >
> > > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > > Cc: <linux-remoteproc@vger.kernel.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >       - None.
> > > >
> > > > Iuliana/Daniel I am ccing you to request help with test/review of this change.
> > > > Note that, you will need patch 1/5 in the series too, to be able to test this.
> > > >
> > > > Kind regards
> > > > Ulf Hansson
> > >
> > > Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > >
> >
> > Thanks for the leg-work on this.  I'll pick this up in rc1 later this week.
>
> Looking at the other files in this set, Ulf of perhaps Bjorn should take this
> set.

Yes, all patches in the series depend on the new helper function that
is introduced in patch 1.

I can certainly take the whole series via my pmdomain tree, if that's
fine by everyone.

Note that, there is also another series for genpd and qcom drivers
that might make it for v6.9. It may be best to keep all these things
together to avoid conflicts.

Let's see what Greg/Rafael thinks about patch 1 first though.

>
> for:
>
> drivers/remoteproc/imx_rproc.c
> drivers/remoteproc/imx_dsp_rproc.c
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks Mathieu and Iuliana!

[...]

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org/


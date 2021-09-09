Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67FC4059A9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbhIIOtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbhIIOto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:49:44 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D4C0610D0
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:46:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q39so2754464oiw.12
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ChRY5qZ6aR0j17B+EVqR+PtUGBXRuYLRwVbbRc3ayQ=;
        b=Bdy8Oa1Hb11ijPET2Ah28GdKVGzh4zPCDc7TwDvHdHJbI+DZL7w641tMGcw+SoYsld
         q+2qk3yJpM6uhgcWZbXmmvnZAdJS22qe7xyfIEc914mqTlLCY8ZIGRVqCjdLnsEgeFbS
         e9qPNJCQK++Qvl1bfTODmIsh6vwK9Dn/NTQL8e7WvR27VZyAn/xPk/dwkSg6rusXpv9E
         Mgaf6IuMo1cs1F7FGLfk/aZ2FZNvigdGQjht7zxBBXjriDJWc6rgoqmpECSzXYuFbdrR
         U9iWm4dEGaYxTbBbU3v7k9h/yCGnBrfwlJXN+WDv6rdEf3kAnivwpSorZ3XxsIJyxTh5
         Q8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ChRY5qZ6aR0j17B+EVqR+PtUGBXRuYLRwVbbRc3ayQ=;
        b=3DnCf0ejLc6A1agHtXEoQjsiXkuH0z5gzZ1XApaK1EHG4BXfnlnITZNuKk7g794Fa9
         YkYMK/IAV2/36w0mEaqMYat4z6Zz186XboVVhCEKZsu8P4D/iQqPqSrDuD0oUEyraiqU
         68ncAl+OyY/gWKWLlJCsSz0Fbk3PZ5Yw86zJbuhZHRAeDJm3z2jpOdlPnvHfK/qFVH1z
         b7PZmVrH7vyeCByAvNBCzWBHbEVKUPz6iOG/m8rnhiTuAI0V6ukIUXRE3p9XzuXfl559
         S80DVd20rciz8N+WhD5UTK2VmDFolGbjZZiWzyAt12fAldRORkDjKRVdmqK/5g/3S9EU
         bYPw==
X-Gm-Message-State: AOAM533vGBa4lO0aOf9VmGimCC5iNGo92cNMwsYEFRT/mSdoZFwNw2L5
        K67W8p7vwyEVsduNP40MOFdYcIsKSrGyGSqrSTT7Hw==
X-Google-Smtp-Source: ABdhPJwHQGIIX3mQpLaPVGGhUXiOunthEmnUWyGqehpl9+g7ZtzzosgPE0btauYypXuazb5o8pgdTtVGFGGodUWjkBo=
X-Received: by 2002:a54:4f03:: with SMTP id e3mr115395oiy.32.1631198774476;
 Thu, 09 Sep 2021 07:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com> <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com> <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
 <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com> <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
 <7ee1a2eb-67d7-dcad-6039-05129d3822ec@gmail.com> <CAPDyKFoFPpPPd0cUDRhqzXzXaQyNAv7UZToTaHnGXY30QXNB9g@mail.gmail.com>
 <71618f83-de5b-1180-60f4-8561c4f655a9@gmail.com>
In-Reply-To: <71618f83-de5b-1180-60f4-8561c4f655a9@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Sep 2021 16:45:38 +0200
Message-ID: <CAPDyKFoV9MOUvu0GLyW-WmNzXbGyFomcug9aTEB-pH32gRHYnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 9 Sept 2021 at 15:48, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >>> Also note that a very similar problem exists, *before* the device get=
s
> >>> attached in the first place. More precisely, nothing prevents the
> >>> performance state from being set to a non-compatible value for an
> >>> always-on HW/device that hasn't been attached yet. So maybe you need
> >>> to set the maximum performance state at genpd initializations, then
> >>> use the ->sync_state() callback to very that all consumers have been
> >>> attached to the genpd provider, before allowing the state to be
> >>> changed/lowered?
> >>
> >> That is already done by the PD driver.
> >>
> >> https://elixir.bootlin.com/linux/latest/source/drivers/soc/tegra/pmc.c=
#L3790
> >
> > Yes, I already knew that, but forgot it. :-) Thanks for the pointer.
> > Let me rethink the approach.
> >
> > In a way, it kind of sounds like this is a generic problem - so
> > perhaps we should think of adding a ->withdraw_sync_state() callback
> > that can be assigned by provider drivers, to get informed when a
> > consumer driver is getting unbinded.
>
> Not sure, doesn't feel to me that this is necessary for today. A bit too
> cumbersome for a simple sanity-check, IMO.

Maybe, but I can bring it up with the fw_devlinks people to see what they t=
hink.

In any case, we should not move forward with $subject patch as is.

Let me think about it.

Kind regards
Uffe

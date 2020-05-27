Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07EF1E46D5
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbgE0PEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 11:04:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44167 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgE0PEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 11:04:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id f18so19381794otq.11;
        Wed, 27 May 2020 08:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Vx58Hq7sHLXBsQGSYl+3QZFOqiNWHmAX7GPof+o7eQ=;
        b=RPNRGy3RVD/8p8fIS/e71D1IzKwwT4JtFTrm+9lC/39N5oDVv48rysacQmI6AmEc0m
         3w5UTJ+iK/gdHOuIgFP/gtFpyWpP0wbVZCIbsEpT6UHN2M2vLki4/LyIBAVsP/0LsdsK
         bAWezmc21ocmBiJRM12Zwxa8XKiFSovo1HnPZAmARVo/PJIB2GPTe4hCuFGiB1It6jKu
         IeZN7xuwvAw5rSuUZVeDEEYZQKPgPxhkbpIemItMRjxrE/PUtos40b4sWDmJXNO9Knqt
         Tzsk464l6sECog1uDQqAsyK5/tTyOzvSOpGG3jmKABi2ZeyfOIWFfOdl+Xffd1EIq57T
         A27Q==
X-Gm-Message-State: AOAM533q0gyFdGO7ekckdz3fm/enUSJCCyHIxy1XGwZFLpIag6VHdc3p
        o2C66z/zAwxAkAGZ41kL5kH/uO0AQ2j97OcfaVM=
X-Google-Smtp-Source: ABdhPJzwMPGSTgdrUYctj0XU40med+NR1Bq/ddfSHu6e0BLAm4f5O93pxTTndqvUHsxmhkX1InI0IHrV5NKDuiWzbv8=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr4711281otf.167.1590591844210;
 Wed, 27 May 2020 08:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
 <jhjk10xu1tq.mognet@arm.com> <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com>
 <CAKfTPtBt6Ju-CnETnn6_FkgR0CAJ+jYnySz9OHP9X2hmxWHM7w@mail.gmail.com>
 <51917583-f8ff-3933-7783-2eedc91484a4@st.com> <fe69390f-ea8c-b6e3-7610-d6bd73e8500d@st.com>
In-Reply-To: <fe69390f-ea8c-b6e3-7610-d6bd73e8500d@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 17:03:52 +0200
Message-ID: <CAJZ5v0h17aPe69KbZ6xVV4RiUKwSHWOQLycUFFNCprg5XPpN4g@mail.gmail.com>
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 27, 2020 at 4:54 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
>
> On 5/27/20 2:48 PM, Benjamin GAIGNARD wrote:
> >
> >
> > On 5/27/20 2:22 PM, Vincent Guittot wrote:
> >> On Wed, 27 May 2020 at 13:17, Benjamin GAIGNARD
> >> <benjamin.gaignard@st.com> wrote:
> >>>
> >>>
> >>> On 5/27/20 12:09 PM, Valentin Schneider wrote:
> >>>> Hi Benjamin,
> >>>>
> >>>> On 26/05/20 16:16, Benjamin Gaignard wrote:
> >>>>> A first round [1] of discussions and suggestions have already be
> >>>>> done on
> >>>>> this series but without found a solution to the problem. I resend
> >>>>> it to
> >>>>> progress on this topic.
> >>>>>
> >>>> Apologies for sleeping on that previous thread.
> >>>>
> >>>> So what had been suggested over there was to use uclamp to boost the
> >>>> frequency of the handling thread; however if you use threaded IRQs you
> >>>> get RT threads, which already get the max frequency by default (at
> >>>> least
> >>>> with schedutil).
> >>>>
> >>>> Does that not work for you, and if so, why?
> >>> That doesn't work because almost everything is done by the hardware
> >>> blocks
> >>> without charge the CPU so the thread isn't running. I have done the
> >>> tests with schedutil
> >>> and ondemand scheduler (which is the one I'm targeting). I have no
> >>> issues when using
> >>> performance scheduler because it always keep the highest frequencies.
> >> IMHO, the only way to ensure a min frequency for anything else than a
> >> thread is to use freq_qos_add_request() just like cpufreq cooling
> >> device but for the opposite QoS. This can be applied only on the
> >> frequency domain of the CPU which handles the interrupt.
> > I will give a try with this idea.
> > Thanks.
>
> Adding freq_qos_add_request(FREQ_QOS_MIN) when starting streaming frames
> solve my problem. I remove the request at the end of the streaming to
> restore
> the default value.

You may as well add the request once at the init time with the request
value set to PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE initially and update
it as needed going forward.

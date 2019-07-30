Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E427A0C1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfG3Fxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 01:53:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34365 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfG3Fxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 01:53:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so65137121otk.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9yhVZrCo2Ym96O9jSbeb4ViFfqeymdVjMGrDKz2FPM=;
        b=N17K/Md9kf9zsF+8d2jNQ4qeEMqeDzuH2Fn+lKJIzHgbcXXOjdXqxhe19pt/7H+kfK
         XIK9MUmRSzEkvOdZxeQ6792Oxc44al7rEb96Qa4TRYkiZNU+2QBvoxA5HSBjy2Qbr6W8
         karZdmF31kOYyjULxZJDgpCSFY/y12xphn+Ku0jhWDm02Ic0UcY97gI3Q798ydEBPQYd
         +ddBmLBRhnl5/3zOGgNhGxyitb7DltzQm7fjlDExtim+zNKXNt1MRCHizz3F+SBjicNQ
         nOI9ItTaH6hxoO9MeQTvvhUsb+gY3mSY/yxaPeWHKRA3MkxO3883J0ao/X5SwFU2hK48
         Cu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9yhVZrCo2Ym96O9jSbeb4ViFfqeymdVjMGrDKz2FPM=;
        b=WEqx9+b5pRUiW8x/T4CBvrmgt1UjlelIqOYT078EiqnFZi5fMXqnPW7B1tvkXtB7eA
         hrCRo9rgSs+DDsmzZ5h8fbAYrHqhExV7nKdVp5oQ7PqLdeFGzOlnZYgXztGmuzv12/nt
         9QSLgfVl11x8am/n2u3vPEoewaGzyApNflQJAe50qZYO8Rcjk6tN3AaplIydjMUMTGYY
         i0YwY0VS+T4Od3iY6DXDUCLfjmjdLOtOeXdc1SON13G4cMXolu3Au/Q1qqKoPcrwl9MJ
         eipRzqDUHAHY9PLEx3CIRFCdlqC8JkWV4rmwvYyCOliWfGFB1z6NmJdhI2KbU9Gt9Xb/
         i5nA==
X-Gm-Message-State: APjAAAWA2Xqhfrozl4ZMUuJPiSrwtaTLG4kLosGAMSZauOoEWwdgvtoJ
        /3vvXYw0/egKUNnusg/Hr1yhh0laWuXpibWGxFdWFw==
X-Google-Smtp-Source: APXvYqw7aEwNPWqA3eNN9XZ6LCef/h3vqbjo/cS8W1eUnYiAmCC4A8v/J5cB8Qphwz409QxSDP0CwBJE6rzqfg/0x8I=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr86267586otj.195.1564466028394;
 Mon, 29 Jul 2019 22:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com> <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
 <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7> <361effba-4433-24d9-243c-201af39214cc@codeaurora.org>
In-Reply-To: <361effba-4433-24d9-243c-201af39214cc@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Jul 2019 22:53:12 -0700
Message-ID: <CAGETcx_BpJswxA4AGARogZ1xRJPqm=_zTOZq1xJ2vgx+DUYsqQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 10:28 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Viresh,
>
> On 7/30/19 8:16 AM, Viresh Kumar wrote:
> > On 29-07-19, 13:16, Saravana Kannan wrote:
> >> Sibi might be working on doing that for the SDM845 CPUfreq driver.
> >> Georgi could also change his GPU driver use case to use this BW OPP
> >> table and required-opps.
> >>
> >> The problem is that people don't want to start using this until we
> >> decide on the DT representation. So it's like a chicken and egg
> >> situation.
> >
> > Yeah, I agree to that.
> >
> > @Georgi and @Sibi: This is your chance to speak up about the proposal
> > from Saravana and if you find anything wrong with them. And specially
> > that it is mostly about interconnects here, I would like to have an
> > explicit Ack from Georgi on this.
> >
> > And if you guys are all okay about this then please at least commit
> > that you will convert your stuff based on this in coming days.
>
> I've been using both Saravana's and Georgi's series for a while
> now to scale DDR and L3 on SDM845. There is currently no consensus
> as to where the votes are to be actuated from, hence couldn't post
> anything out.
>
> DCVS based on Saravana's series + passive governor:
> https://github.com/QuinAsura/linux/tree/lnext-072619-SK-series

Thanks Sibi! You might want to convert your patches so that until the
passive governor is ready, you just look up the required opps and vote
for BW directly from the cpufreq driver. Once devfreq governor is
ready, you can switch to it.

-Saravana

>
> DCVS based on Georgi's series: (I had already posted this out)
> https://github.com/QuinAsura/linux/tree/lnext-072619-GJ-series
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

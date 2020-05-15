Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CC1D4C99
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEOLaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLaF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 07:30:05 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF70C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 04:30:05 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v26so1014052vsa.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ktIgdpUDXYhr4tMpXpfk9fbt7teNm/a/V8MPQX7Saw=;
        b=xIJ+hGvMWZuCj0lEQr7vds9EGl/GHMtEkdLIVHntzKQB8496/Bha7rPIecLIhwPb5t
         m2mSTGasqwnlpazDhvN9sXnlah6pTH59aYEsHJK1GW9/fTd/5YjxJcj4LW3K120wd8v9
         h1Jq6eTt4OgYYiGzWzEBxhkD8GkbomSpd560cc44QKUQnufiCtIml1iSoMnc7jtYfh8j
         /U2vHQvnTIB5/vSG9aYLwsQiGywN6pvQiqKVPk/Lk75As7jsgqhEaQIOKrQNMchhIdrW
         seEMvXV2QmYcReh7TgBdaR6PDUic47/Cl/a4e8flA6hT6XLOA7qjGOtbhRhpp/rYUgVp
         ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ktIgdpUDXYhr4tMpXpfk9fbt7teNm/a/V8MPQX7Saw=;
        b=gTJRjdkG92xXNmfclf8YjvqaC7Kum1z6gmidI7F265gsgt4/cNse9pmto1VLbL+NFN
         iYar7u9azCZX8haLUypvVPDjzfOBYyeP2gC1YXkfTuCjWZCb+94VFpdzD254QebYp2MS
         XTxKqmpvhR0gL+xpZdSza8Lclyk8Xd6z9jWfnJWvOoMhOS8rEsqhiUNJr2vWstygdOa9
         4AF3eMDGN2VM3Nvp4gx1atXG8hnKfmPcqmZaqKKOW6pY5/GEiNeAi9elXHq8a9wb3BVW
         1IbAktrSBdGnZBVo23sAnWHkTvHfBPj2KCKNV8lgZQVkFw7S5CYQ9WW7Ia/9x251A0M9
         ZCOQ==
X-Gm-Message-State: AOAM533bOhLJLxjDMNRSpn+OsEkDnoEPG6TPWegJBcpq2iS0R1CKMedP
        JMfwdzJ3un0+CaeHl7N5WOXl1fMrnyDiv2sVdphslA==
X-Google-Smtp-Source: ABdhPJy4kGs+w/U4e8EWAdRJDCldcb3ykamHfM9EW2/KxvxKbn2MgVc1eDswBiEaeH6vj6BYrIipGHHI3IorCHhMZTk=
X-Received: by 2002:a05:6102:242:: with SMTP id a2mr2041840vsq.200.1589542204535;
 Fri, 15 May 2020 04:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
 <20200514142015.GA23401@bogus> <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
 <20200514172816.GA42669@bogus> <CAPDyKFrdrOnxFHaAR=cmMi2VfSudyHdjZ7vRZKhTQtepdkiXug@mail.gmail.com>
 <20200515102255.GA25927@bogus>
In-Reply-To: <20200515102255.GA25927@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 13:29:27 +0200
Message-ID: <CAPDyKFrsfLExZHvNrJgqsJj8TTzj9jg5v=jEowBTdi26uyjZXg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 May 2020 at 12:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, May 14, 2020 at 09:11:50PM +0200, Ulf Hansson wrote:
> >
> > No worries, thanks for reviewing.
> >
>
> You are welcome.
>
> > That said, are you fine with Rafel queuing this then?
> >
>
> I am fine with that. However I told if you need fixes tags as there are
> no users of the notification yet in the kernel. Though this is trivial,
> but do we need this backported to stable kernel. I don't have strong
> opinion and leave it to you and Rafael.

I wanted to add the fixes tag, to make it obvious that there is an
error being fixed.

On the other hand, no need to tag this for stable, nor to need to send
it as fix for 5.7,

>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe

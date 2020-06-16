Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7691FA97E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgFPHGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 03:06:17 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA9C05BD43
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:17 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id k7so3882936ooo.12
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dWf3nAO7RIVSziG2R8EQ/byF3ECDsm88+AYas5NW7c=;
        b=hUotNTYXbchN5+ZCIKb2puKz+0Wpr1cYv6v7VWZRr+/1TX1hvM+/cLeVgxvJaWTVRT
         BK06DsQ5hih6fbisut+zRwvLe0SVJEEQLJpdarfBtBsTnPWYBVGVfTQG0jGX4/uQKvOh
         iX0R/Nkxv4JPAI9mylZXUMyp8+xdlUCLaplYa424ZmAt9E5Gn2ASlVA1sghIj+RGHePm
         CedQrJTsqUWf3htF1exEDiTcPB7ZeiNXoRV2m3CoLk5vE0zuog32+8YApbzFY5USxBXV
         jExuLIvfS1/Wv4mQvm4MU9hP1A++pcpeld8k8jy6D6dxDZDFBeImgNt15ZZPNDtN7F2D
         iBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dWf3nAO7RIVSziG2R8EQ/byF3ECDsm88+AYas5NW7c=;
        b=QKprk0pL852JbEpBAB6jKVIclLDkwFFWASIbZ7G/055pupIRZQJxrepjFDedDsAyuK
         YA0YOIkRmFNQFRv+g/QCVo+7lPwFDKGUic4OpCD2jZqrVoXqrcYeCFTUsIuurWusx2dR
         IbmXOk2BhQTj6Aj9G3Mxqt+4OwGm/YTFyLsUQvnokkwqLoKbJXcpp28p7arWU0nunuZo
         9kg4f1CAzes3AHramfdWeiSq2aT6ZaPnIOPiKnxaZGNWgxQcnVkFchYAczmkXiq/uMaf
         3o6sAJYcxYKNkAotK0bU+M9q0Oi1zljWoB80Rti8fCthVh6CRN51txvCiioBpzL7ALcM
         Y3Cw==
X-Gm-Message-State: AOAM530c2iAKIHYqE4rlavcMyqVdf8I3SSBOfyeCik44CbFM2W1BBItw
        lQOkn5lTMFu4gr+u9T5B8I7vb/BJFx3t+iw7Vo+J8A==
X-Google-Smtp-Source: ABdhPJyVCYktZ6V7XSNJTtQEsGKzeWMLHV4XTyT4toPtCAIDWAQGrjSr2pm4XD2vjPGlVkDlDoLj7plcz2bqcFbDg7Q=
X-Received: by 2002:a4a:374b:: with SMTP id r72mr1233953oor.15.1592291176234;
 Tue, 16 Jun 2020 00:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <20200615152054.6819-6-ulf.hansson@linaro.org>
 <CAGETcx9bbhW6NoHmjcx3h2y-b8eS_NLwGSyh_scX=CnTpujDNA@mail.gmail.com> <CAPDyKFo+p3MyesDDXJBBgQEYFfw0wQ=4ujyD_ORcS=gVKw8DSQ@mail.gmail.com>
In-Reply-To: <CAPDyKFo+p3MyesDDXJBBgQEYFfw0wQ=4ujyD_ORcS=gVKw8DSQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jun 2020 00:05:40 -0700
Message-ID: <CAGETcx-eCae4iTmZDVnve5Cht+NF_DL6YLde_fhdoNHcSNfwuA@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpuidle: psci: Prevent domain idlestates until
 consumers are ready
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 11:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 15 Jun 2020 at 20:06, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 8:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Depending on the SoC/platform, additional devices may be part of the PSCI
> > > PM domain topology. This is the case with 'qcom,rpmh-rsc' device, for
> > > example, even if this is not yet visible in the corresponding DTS-files.
> > >
> > > Without going into too much details, a device like the 'qcom,rpmh-rsc' may
> > > have HW constraints that needs to be obeyed to, before a domain idlestate
> > > can be picked.
> > >
> > > Therefore, let's implement the ->sync_state() callback to receive a
> > > notification when all consumers of the PSCI PM domain providers have been
> > > attached/probed to it. In this way, we can make sure all constraints from
> > > all relevant devices, are taken into account before allowing a domain
> > > idlestate to be picked.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index bf527d2bb4b6..b6e9649ab0da 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -27,6 +27,7 @@ struct psci_pd_provider {
> > >  };
> > >
> > >  static LIST_HEAD(psci_pd_providers);
> > > +static bool psci_pd_allow_domain_state;
> >
> > Is there ever only 1 device that's probed by this driver? If yes, this
> > is okay. Otherwise, you'll need to handle this on a per device basis.
>
> There is only one device. Subnodes, may exist to describe a
> hierarchical description of the topology of the power-domains [1].

Thanks. In that case:

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

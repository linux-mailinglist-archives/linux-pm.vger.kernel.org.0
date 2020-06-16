Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D01FA915
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgFPGuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 02:50:19 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4AC05BD43
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 23:50:18 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id t132so10845769vst.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xsn4sYJ9N3GdQ4UwPuiI0oU7Rkc9ofrrOyqI9+Zu+vs=;
        b=lPLhLQjLDtPxB2h7HpZbj5XDp+iQwwn0lgr3MKY1Z9ydSw1gEUqt6EXie/Da9Fy+fZ
         /xrrUYwBQRsw4xD3YYMhg/4cphu+PjsHo5MylX8OfXhTVJcDSl4kD438Hx6gXe86T7eK
         TRb4/gsT+fgFAc3qfQbuWKBL7smIAxo3KR04lCG/W16BK6T7WpSMDBloukBDLHIKTPuk
         QhxuaGLVNqmSs4ly6hR9JYGqAslb654YIhpm+KBrSVidbEzx0eIBWWGg0Xsfm2JZ/wEg
         JxG8L03KPeo43STHvjyzallQfgpXs9+mM4oPEULLd41HaAB0XeLfTDgTsYXsTsssWbDX
         Qc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xsn4sYJ9N3GdQ4UwPuiI0oU7Rkc9ofrrOyqI9+Zu+vs=;
        b=Cvymp0K5l0eLVCLA7fhPWSj0nG4SF2jc3COAME66nH9McDIYut5a9Kq4VsKYXVJ+Cg
         /rsPMUcrnK5CphJnAwtBb0/+EEoxC5oBfGxKPBWRm5kNGLycrUP5NjsjyHGASYt8Fau3
         rWIC+ubVWbonXvqlfbzdG26Gh+vrdE7DBDKa5hC+7AATk8geGj/1XIt5d8pXKM1Zf1Ud
         9lgDTscPx0Qbksob56VBVtU4vlogZbNpRR/DQDlwKsXnabNl0nqsLHLVou6x4R9IhXUT
         4H/KXkupcoeRC5+gw2POsSyyRmteAzTnI+CDcRofE2mOBYa2gY5EK3SUdYBsaLTVru2j
         X7IA==
X-Gm-Message-State: AOAM532XL5ieso4+A6HgxLFYfupDINsI/7p4fOzUbUKuHDEwOYWZTa/b
        PsEJ1LLwgZxVssLLWNZJamAMc9S3Be+p9TZ55O5ukA==
X-Google-Smtp-Source: ABdhPJwVprXIzriB+Mukv1+Y2AfHXFYc9TMGG9na1M4igDSqdnDhrHJ5SlkiQmSkoFjGXqzzQsH5L3vNpBwsO6oZXmM=
X-Received: by 2002:a67:db88:: with SMTP id f8mr469381vsk.165.1592290217683;
 Mon, 15 Jun 2020 23:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <20200615152054.6819-6-ulf.hansson@linaro.org>
 <CAGETcx9bbhW6NoHmjcx3h2y-b8eS_NLwGSyh_scX=CnTpujDNA@mail.gmail.com>
In-Reply-To: <CAGETcx9bbhW6NoHmjcx3h2y-b8eS_NLwGSyh_scX=CnTpujDNA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 08:49:41 +0200
Message-ID: <CAPDyKFo+p3MyesDDXJBBgQEYFfw0wQ=4ujyD_ORcS=gVKw8DSQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpuidle: psci: Prevent domain idlestates until
 consumers are ready
To:     Saravana Kannan <saravanak@google.com>
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

On Mon, 15 Jun 2020 at 20:06, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jun 15, 2020 at 8:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Depending on the SoC/platform, additional devices may be part of the PSCI
> > PM domain topology. This is the case with 'qcom,rpmh-rsc' device, for
> > example, even if this is not yet visible in the corresponding DTS-files.
> >
> > Without going into too much details, a device like the 'qcom,rpmh-rsc' may
> > have HW constraints that needs to be obeyed to, before a domain idlestate
> > can be picked.
> >
> > Therefore, let's implement the ->sync_state() callback to receive a
> > notification when all consumers of the PSCI PM domain providers have been
> > attached/probed to it. In this way, we can make sure all constraints from
> > all relevant devices, are taken into account before allowing a domain
> > idlestate to be picked.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index bf527d2bb4b6..b6e9649ab0da 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -27,6 +27,7 @@ struct psci_pd_provider {
> >  };
> >
> >  static LIST_HEAD(psci_pd_providers);
> > +static bool psci_pd_allow_domain_state;
>
> Is there ever only 1 device that's probed by this driver? If yes, this
> is okay. Otherwise, you'll need to handle this on a per device basis.

There is only one device. Subnodes, may exist to describe a
hierarchical description of the topology of the power-domains [1].

Kind regards
Uffe

[1] Documentation/devicetree/bindings/arm/psci.yaml

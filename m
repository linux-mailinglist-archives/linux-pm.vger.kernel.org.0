Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472E87C0054
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJJPYV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjJJPYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 11:24:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426FB0
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 08:24:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8164e661abso6165990276.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696951457; x=1697556257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn15KWgGGRcrueS021viDnJreSa8yQoFFn5f4Rtn5SA=;
        b=OiUReANFSB5TMKxMeOg23YFfHooraf+o3/sJuK1bUa3TjAWBqCejL+A1CjYCujZvRn
         dGuDJmkK/MQpmH2ZJnQsvAaDxz2txBZBA7vVRcmk6ehcYW/g82H1cRKs8dxoAD4qOOiS
         PklwbajPcZHaG+wc0H9tgXokAfL6lQecraiOUyNmB4lB7g+iZcdHVmn05a03D78pVK6v
         JDYDCjKamUYaXrufklRFxvGY0SOS7LPozRDTitGKWMlH6CvEjnUhs/5qxHs/VX2BtPJW
         3pjrDmFttSomWKIyV84rNRJAf/5DtKGwrFgHb1a3/8KghLw+ximrZsjdGVz3GXESXsih
         G0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951457; x=1697556257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn15KWgGGRcrueS021viDnJreSa8yQoFFn5f4Rtn5SA=;
        b=fMSCxW8/Ql4A4usCDoTsh3GxmU6bMxBnXfjE7wBRegtSSodz0rBsggWhuG0PwqU3aE
         jR78lAr0ybT5PKceM8BT9OUkp4qIGKG2JdgvwDypQ3lVJGYskfg4lrZGgxyB+HtSODKf
         0JEjCtt0r5XR5VxDFpvpnJ0KACoLYaZWmRwRhKXv9/YJSL85sRpzJEQN5Gme5nx2fWAE
         jxZVDEEnqhhLvz03yyIOhUnxU02Ty3EyG1BwFBTDkhe784+takhdTAIHO48gsS1ILsDX
         /aSQMGHVXqTLeLRWnqPsH4jaLy9FQ3YNXKKxr+Bvyyvjv8Z8BkgNT5vp+nFp5DgYVKbw
         HEUg==
X-Gm-Message-State: AOJu0YyS1hcZsIzFwl4MZF6PO2XKgKFRgiGsxPUEEt4VkyPtlejn4f+1
        I6wu0TFPJ3Rh60i99dRIWeP3B/6+V22ItfZVLfjaDQ==
X-Google-Smtp-Source: AGHT+IH9OttSPww8dv6/ttXikHszOSaUihiCwdH8JamgkAVSX/n9IeOUKkJ0ba7766OwnH/ijiLjeoLBdkqvGk4yNW0=
X-Received: by 2002:a05:6902:4cf:b0:d81:70b6:c24b with SMTP id
 v15-20020a05690204cf00b00d8170b6c24bmr17663939ybs.19.1696951457640; Tue, 10
 Oct 2023 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus> <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
In-Reply-To: <20231010145137.fyxjlsj5qq3elq7l@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 17:23:41 +0200
Message-ID: <CAPDyKFrBXz1MrqqcRaSf3dkO5YByxehi96TO9F=5b43_LAqRSg@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        Nikunj Kela <nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Nikunj

On Tue, 10 Oct 2023 at 16:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 10, 2023 at 01:43:32PM +0000, Peng Fan wrote:
> > > Subject: Re: Question regarding scmi_perf_domain.c
> > >
> > > On Tue, Oct 10, 2023 at 01:15:26PM +0000, Peng Fan wrote:
> > > >
> > > > Thanks for the detailed explanation, so power-domains property could
> > > > be used both for power domain or performance domain. But if one device
> > > > has both power domain and performance domain. Only power-domain
> > > > property is not enough. I may understand wrong, let me look into the code.
> > > >
> > >
> > > I haven't tried this but something I could come up quick wit Juno DTS as
> > > reference:
> > >
> > > We can change something like this:
> > >
> > >       scmi_dvfs: protocol@13 {
> > >               reg = <0x13>;
> > > -             #clock-cells = <1>;
> > > +             #power-domain-cells = <1>;
> > >               mbox-names = "tx", "rx";
> > >               mboxes = <&mailbox 1 0 &mailbox 1 1>;
> > >               shmem = <&cpu_scp_hpri0 &cpu_scp_hpri1>;
> > >       };
> > >
> > > And then in the consumer node(taking GPU as it has both perf and power
> > > domains). The CPUs are simpler as don't have explicit power domains, some
> > > Qcom platforms do use that. Anyways I would change GPU node like this.
> > > Hope this clarifies things for you.
> > >
> > >  &gpu {
> > > -       clocks = <&scmi_dvfs 2>;
> > > -       power-domains = <&scmi_devpd 9>;
> > > +       power-domains = <&scmi_dvfs 2 &scmi_devpd 9>;
> > > +       power-domain-names = "perf", "power";
> >
> > With one single power domain, the platform common code
> > will automatically power on the domain before probe, with
> > help from genpd_dev_pm_attach.
> >
> > But with multiple entries, device driver should handle power
> > domains by themselves.
> >
> > Maybe Ulf could comment whether the genpd could update
> > to support perf/power case just as one power domain
> > entry before.
> >
>
> Hmm, I would rather check if the genpd can still handle automatic
> power on of the domain before probe with one power and one perf domain.
> IWO, one power domains and other domains in the mix. The reason why we
> can't have single domain to support both power and perf using SCMI is
> we don't know if the domains are 1:1 as presented by the SCMI platform
> firmware.

Well explained above, thanks!

So in the case where a platform will support both, it means that a
driver for a consumer device, actually needs to attach to two
different PM domains (one for perf and one for power).

It's easy to imagine that we are moving towards getting a lot of
boilerplate code to manage these things in drivers. Therefore I think
we need to consider adding some helper functions to manage attaching
of multiple PM domains. This has been discussed earlier too, but I
will try to pick it up and move it forward as soon as I can.

Another option could be to discuss how we can extend the SCMI spec
and/or the DT bindings, to optionally allow us to use a 1:1 mapping of
an SCMI perf/power domain.

Kind regards
Uffe

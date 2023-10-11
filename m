Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A197C4E97
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjJKJ1f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 05:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjJKJ1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 05:27:34 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2059E
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 02:27:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7c95b8d14so16815247b3.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697016451; x=1697621251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYGgGp6JgsGJShIv/xbM+rn7HAZJrq9pOdpSfsAagnc=;
        b=SDFw/JXhQjcRVsllHd3Y0DM7YHXyVfDEx1RUzANPuj+hy5F8JxlXLryxtdOvWrxxUe
         uMf3QMgNgYx6L2zpLRiC3MCNXgvvuCW8JZ3Y/cNGi5tgzMI4JX2I0PnaoxRJ3D0jM+KF
         Xwlf30jr+tefOYCqCSMN5QGfMj/SZ0IZXIVorl7kG7g/w2fDUgm8+hqgQdlwRid4abfA
         OXllvjpCUeiiQkkK/4hpTLBn9X12QO0gVt50msPADlMKxc+L+pPudQeS57UKapfQZKoy
         uuiPjKOQTTYkfasyWbi5Op5AElmDV2dwYVBlas11Cf4q6AOZ7OeQFNUCphZ6W1B68Yas
         WKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016451; x=1697621251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYGgGp6JgsGJShIv/xbM+rn7HAZJrq9pOdpSfsAagnc=;
        b=ITMidZRWfrBAL2rpK9QBJ1zr+GMPX4VfJcXPRo6iNq7uOup1oxJfx0vkTl/ZhGTNS6
         N4eJWvdmQKls2DhoAfXJh1A0sHebCBWvjmcfELcffGG/PUhFxAzyIeVPJCwfxjL3KSyc
         HuP3RMbDw01VhGZuz55Ln22HjXsEQe3cf5xuEeZP5rzRK8NJnhApaiLtY/DDaklSq8Qh
         BMCXSLzGc1Asl9z6amveyqd2fMnkRicj/zQtC5dspTFcwlbeMIH95OanPTjlXcM/xgS5
         gh7AYiy02E2jhijwbtqrNvgEPPtsLj/nFXoEqZzVVnAIxdMk5dKd1Ge71NiTQ3bcbxCm
         MLJA==
X-Gm-Message-State: AOJu0YxpmATnXn9x+T6YIE3iMznMiBn7/wzrUT4xz7w4HZU2S5kVs/6b
        eRcN3vGoTgl6/vTBzZMqIxnzhtLPlcu3RiAXAWo5dg==
X-Google-Smtp-Source: AGHT+IHObW4gWE+NavYXKj4hANzmzzP3WjwkLkaIeMx2v8L1/yk6nMpu3Rz1sn+Ei7DJJ4KZmI2by1zZoM1KsPG8H/c=
X-Received: by 2002:a5b:70d:0:b0:d78:341d:e475 with SMTP id
 g13-20020a5b070d000000b00d78341de475mr18663050ybq.44.1697016450845; Wed, 11
 Oct 2023 02:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus> <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus> <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Oct 2023 11:26:54 +0200
Message-ID: <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Oct 2023 at 02:30, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: Question regarding scmi_perf_domain.c
> >
> > On Tue, Oct 10, 2023 at 01:43:32PM +0000, Peng Fan wrote:
> > > > Subject: Re: Question regarding scmi_perf_domain.c
> > > >
> > > > On Tue, Oct 10, 2023 at 01:15:26PM +0000, Peng Fan wrote:
> > > > >
> > > > > Thanks for the detailed explanation, so power-domains property
> > > > > could be used both for power domain or performance domain. But if
> > > > > one device has both power domain and performance domain. Only
> > > > > power-domain property is not enough. I may understand wrong, let me
> > look into the code.
> > > > >
> > > >
> > > > I haven't tried this but something I could come up quick wit Juno
> > > > DTS as
> > > > reference:
> > > >
> > > > We can change something like this:
> > > >
> > > >       scmi_dvfs: protocol@13 {
> > > >               reg = <0x13>;
> > > > -             #clock-cells = <1>;
> > > > +             #power-domain-cells = <1>;
> > > >               mbox-names = "tx", "rx";
> > > >               mboxes = <&mailbox 1 0 &mailbox 1 1>;
> > > >               shmem = <&cpu_scp_hpri0 &cpu_scp_hpri1>;
> > > >       };
> > > >
> > > > And then in the consumer node(taking GPU as it has both perf and
> > > > power domains). The CPUs are simpler as don't have explicit power
> > > > domains, some Qcom platforms do use that. Anyways I would change
> > GPU node like this.
> > > > Hope this clarifies things for you.
> > > >
> > > >  &gpu {
> > > > -       clocks = <&scmi_dvfs 2>;
> > > > -       power-domains = <&scmi_devpd 9>;
> > > > +       power-domains = <&scmi_dvfs 2 &scmi_devpd 9>;
> > > > +       power-domain-names = "perf", "power";
> > >
> > > With one single power domain, the platform common code will
> > > automatically power on the domain before probe, with help from
> > > genpd_dev_pm_attach.
> > >
> > > But with multiple entries, device driver should handle power domains
> > > by themselves.
> > >
> > > Maybe Ulf could comment whether the genpd could update to support
> > > perf/power case just as one power domain entry before.
> > >
> >
> > Hmm, I would rather check if the genpd can still handle automatic
> > power on of the domain before probe with one power and one perf domain.
> > IWO, one power domains and other domains in the mix. The reason why we
> > can't have single domain to support both power and perf using SCMI is
> > we don't know if the domains are 1:1 as presented by the SCMI platform
> > firmware.
> >
> > AFAIU it was the main issue/confusion you raised initially. I am
> > surprised as how we had all these discussions and now you are circling
> > back and requesting to combine the support in single domain which
> > contradicts your initial confusion. I am seriously lost as what you are
> > looking for now ?
>
> No, I am not requesting to combine in single domain. I still wanna perf
> domain and power domain has their own IDs. But I was not aware
> perf domain is using power-domains property, so one device has
> power domains and perf domains both, the automatic power domain
> on is broken. I was thinking we introduce a new property saying
> perf-domains property.

Not sure exactly what you are referring to when saying that "automatic
power domain on is broken". Genpd power-on the PM domain for a device
that gets attached to it, if the device has only a single PM domain.
This is the legacy behaviour.

When we added support for multiple PM domains per device, we decided
to *not* power-on the PM domain, if the device that gets attached has
multiple PM domains. This behaviour was chosen deliberately, to allow
consumer drivers to decide themselves instead. Is there a problem with
this you think?

Kind regards
Uffe

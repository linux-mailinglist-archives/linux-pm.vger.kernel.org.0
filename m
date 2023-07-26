Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83468763496
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jul 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGZLNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jul 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjGZLM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2023 07:12:56 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC497
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:12:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58451ecf223so2398277b3.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690369974; x=1690974774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC3AR3+9slbh/4XbZH2z2i5m6IqJXybcbNCnztjWWm4=;
        b=GIKp7cxeKp4zmEz2mQN94gHbvPxItEqza6KBeYXLugORmRYcLv1CWod7hbvJstboIE
         vdlhucLz9Nc/5F+paWv3OhNx6UH3ba0RZBXJLlDquQ0UZbxvouGn7q6YWYtTc2yYblFN
         alhR9KB47Get+0nnNmVUMvWDWk22w4ehhNi4PC4AIDmz3WDbiWYhmlLco4oOVQwtcJ0t
         fHQCjRTYj3MdDUuTtRaAPoo6lZYv/L9WLJ9B0FofS2x563l1EZD+8svWHfeBhIqnXUOP
         npO0BMqSN8Zi4KvSMwa4Yo1UhZEffezUycW8ODgBHD8Nz0n/RP3vDiy+0R+3WZhbvwAE
         4Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369974; x=1690974774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZC3AR3+9slbh/4XbZH2z2i5m6IqJXybcbNCnztjWWm4=;
        b=S/TyVPSZDjHX7tUxEK8hmRdxOdZBSkeTJCfaCD8Oo3LZ1CnNML778AojarYE/+OyPO
         uuXbj2gUUsCvWKCYkzi59VtDXAZpYj9eyUIT3lJX3lJiLzVZi7EhvxCYJordH7uXaN3V
         IYCQLC2MiJRh+ubhejFgGJa8x3hwS9HKidmOB7x5rZegnjwxfZ1JuDN7kvQupqz8bleT
         EaycJaHv+A++toZU/KEULQPnZVl8MtH/nJX2zjKsvlhCBQcEcw1Bzb+R8nLoYMXVJwxx
         x9OfPbQlua46vV/Zu/GaoGESB1djB/tD2SKKUOBBWXWKX5ETc6LHFXazt3e06Llg5k5S
         Uxhg==
X-Gm-Message-State: ABy/qLaGTndjLsjMTcn21UWU7NLH8gbZR7l8d5RcIfMGQp2pItkDw1eD
        PBQ9cbo9Btd4pLm5czdx+Ck9oRiBW/GTVf0Lb6ieRw==
X-Google-Smtp-Source: APBJJlGLdZHOcJAENAqLfGiqi/72oSkGaPDVZwRn15fbhmiMArFKWA4P9ndHJR4qlDNh2XztdXFdHxu4C2CClhB66Sk=
X-Received: by 2002:a81:69c2:0:b0:584:1a4d:bbfa with SMTP id
 e185-20020a8169c2000000b005841a4dbbfamr1741114ywc.29.1690369974370; Wed, 26
 Jul 2023 04:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-9-ulf.hansson@linaro.org> <20230719151716.qhobfnclrjf4yqkg@bogus>
 <CAPDyKFpjMWOAbV+b2DcxDWqvRDQCbSC6Ti+KGGPWJoC4Ghp7=w@mail.gmail.com>
 <20230721115535.mx46dg56pxjnzbuv@bogus> <20230721143304.GA1092306-robh@kernel.org>
 <20230721183817.34lgb42nlnsvqx4s@bogus>
In-Reply-To: <20230721183817.34lgb42nlnsvqx4s@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 13:12:18 +0200
Message-ID: <CAPDyKFqsaz=hruktv+sPQz-ttOtWa9O_Jvp2iLnpxQqX2r7yBQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Jul 2023 at 20:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jul 21, 2023 at 08:33:04AM -0600, Rob Herring wrote:
> > On Fri, Jul 21, 2023 at 12:55:35PM +0100, Sudeep Holla wrote:
> > > On Fri, Jul 21, 2023 at 01:42:43PM +0200, Ulf Hansson wrote:
> > > > On Wed, 19 Jul 2023 at 17:17, Sudeep Holla <sudeep.holla@arm.com> w=
rote:
> > > > >
> > > > > On Thu, Jul 13, 2023 at 04:17:35PM +0200, Ulf Hansson wrote:
> > > > > > The protocol@13 node is describing the performance scaling opti=
on for the
> > > > > > ARM SCMI interface, as a clock provider. This is unnecessary li=
miting, as
> > > > > > performance scaling is in many cases not limited to switching a=
 clock's
> > > > > > frequency.
> > > > > >
> > > > > > Therefore, let's extend the binding so the interface can be mod=
elled as a
> > > > > > generic performance domaintoo. The common way to describe this,=
 is to use
> > > > > > the "power-domain" DT bindings, so let's use that.
> > > > > >
> > > > >
> > > > > One thing I forgot to ask earlier is how we can manage different =
domain IDs
> > > > > for perf and power domains which is the case with current SCMI pl=
atforms as
> > > > > the spec never mandated or can ever mandate the perf and power do=
mains IDs
> > > > > to match. They need not be same anyways.
> > > >
> > > > Based upon what you describe above, I have modelled the perf-domain
> > > > and the power-domain as two separate power-domain providers.
> > > >
> > > > A consumer device being hooked up to both domains, would specify th=
e
> > > > domain IDs in the second power-domain-cell, along the lines of the
> > > > below. Then we would use power-domain-names to specify what each
> > > > power-domain represents.
> > > >
> > > > power-domains =3D <&scmi_pd 2>, <&scmi_dvfs 4>;
> > > > power-domain-names =3D "power", "perf";
> > > >
> > > > I hope this makes it clearer!?
> > >
> > > Yes it make is clear definitely, but it does change the definition of=
 the
> > > generic binding of the "power-domains" property now. I am interesting=
 in
> > > the feedback from the binding maintainers with respect to that. Or is=
 it
> > > already present ? IIUC, the ones supported already are generally both
> > > power and performance providers. May be it doesn't matter much, just
> > > wanted to explicit ask and confirm those details.
> >
> > I commented on v1.
> >
> > Looks like abuse of "power-domains" to me, but nothing new really.
> > Please define when to use a power domain vs. a perf domain and don't
> > leave it up to the whims of the platform. Maybe perf domains was a
> > mistake and they should be deprecated?
> >
>
> Just a thought here, instead of deprecating it I was thinking if possible
> to keep the power-domains and performance-domains separate and just exten=
d
> the genpd to handle the latter. There by we are not mixing up and creatin=
g
> confusions that need more specific definitions in the binding(which is no=
t
> a big deal) but platforms getting it wrong inspite of that is a big probl=
em.
> Keep it separate makes it more aligned to the hardware and doesn't dilute
> the definitions and probably avoids any possible mistakes due to that.
>
> Sorry Ulf I am just not yet convinced to mix them up yet =F0=9F=98=89 and=
 wish you
> don't convince me to. Let me know why the above suggestion won't work.

The main point I think we need to consider too, is that on some
platforms, the power-domain and the performance-domain are managed
together by the FW. It is not really two separate things and hence it
would not quite be correct to describe it as two different types of
providers in DT.

If we should follow your suggestion above, to use the
performance-domain bindings, then I think we need an additional new
binding to cover the above mentioned case too. This would lead us into
having one binding for the power-domain, another for the
performance-domain and a third for the power+performance-domain.

In my opinion this sounds quite like a mess. I would rather keep using
the power-domain bindings for all these cases. Of course, it's a bit
of a stretch too, but I think it should be less confusing in the end,
assuming we extend/clarify the description of the power-domain
bindings, of course.

Did that convince you? :-)

Kind regards
Uffe

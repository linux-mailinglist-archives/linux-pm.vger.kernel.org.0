Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA416727AAD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjFHJAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFHJAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 05:00:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA39E
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 02:00:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-566586b180fso3183217b3.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686214827; x=1688806827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbS7bAo8RzhYC9F95C74bwc0WgK8qcH9Nsq7/PhrBD4=;
        b=RLLQpNe0Um2T3leRxsS6jhQMutCxtncL1kCOpfVD91JdQvhCv43heXnzcOB4nfk0uV
         m5x8VP6xXzWYazK5d4spsYoVt/wgUO01Nhq6Y/PSCGXVFTznd7EcRiaYFakAGCqppUiB
         H8KOQrESEQddCUtcvTbNXjMbvZnGmLMwloPT3nIEKpiLgwS0cE/5r0kcySZQaJqMJgA6
         6yVrGpilLZd5TWN2qG7KCcu+lQVaCw3sV44TaqkonroNJ+tkVwSYV3/NpVN8Yodna92e
         076dmtMB8YmJZTIvosEYfDXjg/MV3bOJKGEILYqTDZajX27MjtmBy15Z/NppcRvtihwr
         NreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214827; x=1688806827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbS7bAo8RzhYC9F95C74bwc0WgK8qcH9Nsq7/PhrBD4=;
        b=k7/aIpk3RyPtcZUKtYxpFNgSA6gsLyRDmUhu2K4XVs4yvk1tlUQ+5jYSG8YmsuYjTU
         sK02tm9xbLQtkwIdB+qJP37eIp/+y2Z1Pricekh7PobLqT7utgvVL4Ac1BvJL9lwXR4O
         vGtCmrvA4Gv6sNVifWazzf/qpAgJNTOoqOCMjwUVuG/j71eherEpvtP9WhlsMkB0k5nq
         NC+MuN/f8Hd7nwNGpPBb/0AK9292skJwwYGrJniR51k7SdELxqbfA3zRTpVgdDRZLiCM
         hxMZ0BFVutpaNcp9fFZQx2ICukShhunNgXSXp0iY2PNMP6O7kvpg1HL4vNVpu1OD88Ll
         HTOA==
X-Gm-Message-State: AC+VfDxukljA4En75o2kITZO+K470bj8/I9Q7wACLP3SDosFosz8Iknr
        p2V8ZrjaZHatUhbsju770PgLYLcUSER720/P5MHU6XMvFEMWaSTu
X-Google-Smtp-Source: ACHHUZ501BMS8jGFf40yhOCCWQ7oQe9q9IAK69pq3af0USYacTgEH7+htpKND7lXGWncLPF2uc5MIREhy7QU/PtZwqQ=
X-Received: by 2002:a81:5d05:0:b0:55a:18e2:cdf9 with SMTP id
 r5-20020a815d05000000b0055a18e2cdf9mr9070544ywb.49.1686214827585; Thu, 08 Jun
 2023 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-12-ulf.hansson@linaro.org> <20230608052953.l44dwb6n62kx4umk@vireshk-i7>
In-Reply-To: <20230608052953.l44dwb6n62kx4umk@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 10:59:51 +0200
Message-ID: <CAPDyKFodvtRE5DHeMSSG5o4iJw07TjFHSeAoTuugH9OAmE8bMQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Jun 2023 at 07:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-06-23, 14:46, Ulf Hansson wrote:
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 954c94865cf5..0e6ee2980f88 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1921,8 +1921,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >   * _opp_add_v1() - Allocate a OPP based on v1 bindings.
> >   * @opp_table:       OPP table
> >   * @dev:     device for which we do this operation
> > - * @freq:    Frequency in Hz for this OPP
> > - * @u_volt:  Voltage in uVolts for this OPP
> > + * @opp:     The OPP to add
> >   * @dynamic: Dynamically added OPPs.
> >   *
> >   * This function adds an opp definition to the opp table and returns status.
> > @@ -1940,10 +1939,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >   * -ENOMEM   Memory allocation failure
> >   */
> >  int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> > -             unsigned long freq, long u_volt, bool dynamic)
> > +             struct dev_pm_opp_data *opp, bool dynamic)
>
> The name `opp` is mostly used for instances of `struct dev_pm_opp`. Can we use a
> different name here please for the data ?

Certainly, what do you suggest?

>
> > +/**
> > + * dev_pm_opp_add()  - Add an OPP table from a table definitions
> > + * @dev:     device for which we do this operation
> > + * @freq:    Frequency in Hz for this OPP
> > + * @u_volt:  Voltage in uVolts for this OPP
> > + *
> > + * This function adds an opp definition to the opp table and returns status.
> > + * The opp is made available by default and it can be controlled using
> > + * dev_pm_opp_enable/disable functions.
> > + *
> > + * Return:
> > + * 0         On success OR
> > + *           Duplicate OPPs (both freq and volt are same) and opp->available
> > + * -EEXIST   Freq are same and volt are different OR
> > + *           Duplicate OPPs (both freq and volt are same) and !opp->available
> > + * -ENOMEM   Memory allocation failure
> > + */
> > +int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>
> Maybe move this to include/linux/pm_opp.h and mark it static inline and get rid
> of documentation too.

Good idea!

>
> > +{
> > +     struct dev_pm_opp_data opp;
> > +
> > +     memset(&opp, 0, sizeof(opp));
>
> What about
>         struct dev_pm_opp_data data = {0};
>
> I think it is guaranteed that all the fields will be 0 now, not the padding of
> course, but we don't care about that here.
>
> > +     opp.freq = freq;
> > +     opp.u_volt = u_volt;
>
> Or maybe just
>
>         struct dev_pm_opp_data data = {
>                 .freq = freq,
>                 .u_volt = u_volt,
>         };
>
> Rest must be 0.

Good suggestions both, I will change to whatever is best suitable!

Thanks for reviewing!

Kind regards
Uffe

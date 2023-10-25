Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8D7D706D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjJYPJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJYPJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 11:09:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA071128
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 08:09:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9de3f66e5so38997035ad.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698246587; x=1698851387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3i4q/8dh08pTSJ6aN+GctK8CWDUW91sqoqWG/NbmAao=;
        b=NNicel3AXdCU+YO/0saf/OlSPvhOe9cpmOFr2wbjF5fRxZuy3mimDgLhPHWTzPJZay
         yFLo4lu3ljLIlp6PhAEiY2pHhLVISwQVaeE71m1ciqnRdiOtYo3DlGdfK2MjUGgok427
         HGMSd2sx+tri2xWiJo01VeUQDMPBd0opabiwvo1+nNYn6eJtsAPkH1YHsBzGFVsan3Rm
         2KsxehgdmftOHCmJPWZY8DD0fuBkNq6IGhOh94Kbg6GOMBU1bVOeJKUTT2oMsRifwNHH
         8lG+z75P4P6AWVRCZji8TK6krVHg9cKfsw0LJBZE7jWoQnZRHyrfoWMyq2fceuxn0VP9
         1FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246587; x=1698851387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i4q/8dh08pTSJ6aN+GctK8CWDUW91sqoqWG/NbmAao=;
        b=N9qiIL+zWgJIyK5mN3NE9yIFJbVxY2j3NovMgZ9hpih8fs/jIHTAdZAkeaaVurZexz
         Z3eK1LwWNar2FoL71r79v/+g7/ihy17Rw3Z6moqFLH34hOChCbNtODnPsa0uXbaETjbq
         bYM0hC+mMae+xM/NEsuqufCOicaJJnC0xyvBp/+HQ/HCdvVwJ83VGK8t4ilb/cRftTMq
         x0PtBv2kEdhvWx1QLE794ApjENjzY0G9i6yoWRykE8/rhlL3WTfO7Ps4A+qeSE0ooleB
         nWeWgSSpYehWYO2KSq34d4NfTLQirosoE1Mg380gn2d0VZOyCqtf8hdz/fHhCGCw1tPt
         Y3gg==
X-Gm-Message-State: AOJu0YwDBh/LlJdi+8dAXoPreij0emY8H3JI+7Fx9HkxkztbpaVzA1vn
        am7lDXJq8Y8Vk1JNLyugDVR/qw==
X-Google-Smtp-Source: AGHT+IGDIDHND1VBh40mj7rUqQqhP5djLQnYuMgZRi2QnJU20aWCuiq60+tz5HZKoIduEJZdUB6vGQ==
X-Received: by 2002:a17:903:1246:b0:1c8:7d21:fc63 with SMTP id u6-20020a170903124600b001c87d21fc63mr13200813plh.56.1698246587035;
        Wed, 25 Oct 2023 08:09:47 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c9cc885022sm9310654plb.259.2023.10.25.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:09:46 -0700 (PDT)
Date:   Wed, 25 Oct 2023 20:39:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Message-ID: <20231025150944.b2noxaznyqltehhf@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFrxFmNZpNdwQs3CS0NzmDjtCaNSQWkT=zW1Tm+MommWkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxFmNZpNdwQs3CS0NzmDjtCaNSQWkT=zW1Tm+MommWkA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-23, 15:51, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > -static int _opp_set_required_opps_genpd(struct device *dev,
> > -       struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
> > +/* This is only called for PM domain for now */
> > +static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> > +                             struct dev_pm_opp *opp, bool up)
> >  {
> > -       struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> > +       struct device **devs = opp_table->required_devs;
> >         int index, target, delta, ret;
> >
> > -       if (!genpd_virt_devs)
> > -               return 0;
> 
> Rather than continue the path below, wouldn't it be better to return 0
> "if (!devs)" here?

I can add that optimization, moreover it would make the code simpler
to read.

> > @@ -2429,15 +2374,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >         int index = 0, ret = -EINVAL;
> >         const char * const *name = names;
> >
> > -       if (opp_table->genpd_virt_devs)
> > +       /* Checking only the first one is enough ? */
> > +       if (opp_table->required_devs[0])
> 
> The allocation of opp_table->required_devs is being done from
> _opp_table_alloc_required_tables(), which doesn't necessarily
> allocate/assign the data for it.
> 
> Maybe check "opp_table->required_devs" instead, to make that clear?

Hmm, the expectation here is that if someone has called the config
routine with genpd option, then required OPPs must be present and so
required_devs won't be NULL.

What instead we are looking to check here, and later in
_opp_set_required_devs(), is if this operation is already done for a
group of devices.

The OPP table is shared, for example, between CPUs of the same cluster
and the OPP core supports the config routine getting called for all of
them, in a loop. In that case, we just increase the ref count and
return without redoing stuff. That's why we were checking for
genpd_virt_devs earlier.

Though interfaces and things have changed several times, I may need to
check it again to make sure it all works as expected.

> > +static void _opp_set_required_devs(struct opp_table *opp_table,
> > +                                  struct device **required_devs)
> > +{
> > +       int i;
> > +
> > +       /* Another CPU that shares the OPP table has set the required devs ? */
> 
> Not sure I fully understand the above comment. Is this the only
> relevant use-case or could there be others too?

Answered above, but I shouldn't write CPU here anymore. We support all
device types now.

> > +       if (opp_table->required_devs[0])
> 
> Maybe check opp_table->required_devs instead?
> 
> > +               return;
> > +
> > +       for (i = 0; i < opp_table->required_opp_count; i++)
> > +               opp_table->required_devs[i] = required_devs[i];
> 
> To be safe, don't we need to check the in-parameter required_devs?

I left it like that intentionally, in case someone wants to skip the
required dev for some required OPP, while make all others change. But
maybe I will keep it simpler and check it all the time.

> Or we should simply rely on the callers of dev_pm_opp_set_config() to
> do the right thing?
> 
> [...]
> 
> Besides the minor things above, this looks really great to me! Feel free to add:

Thanks.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945AA4BA0D8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiBQNSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 08:18:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNSJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 08:18:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6C2AE2BE
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:17:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bx31so8336333ljb.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAdbmEH0mn4WGWopSU8BAttfUYajicOMG3/as3ZGlQU=;
        b=KfGxNkjcBo+fiSnn7LEh10U18s9kJA31PoOfLXylizg3JiSY+lFKHfvbrm81+a2VPw
         dnEsOoQ375qiNdKocKXSGBRsVfKHx2Z/3kQB4d7U6hateE6QJ+iarDW/qn4sYOEYbax8
         Sdy3oaT32eXalaMSy/TjEgKKLyE6yrcBv9iO9cQrvesAomi7kdD6Pj9EmaP3WP4inqr9
         yZrUkK2BpGM1CwiFC8cGX57Fhu5kKVmf4bLk9eZy8QDg2tMXPTvNbyxs0CwCvH2pb6qu
         UQBi29wLjVkxYUAhzmlH/QOcSk9GPb4J5on8Qo4JjD/LBLYhUIydVXk8cUe80Aurn4Ka
         vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAdbmEH0mn4WGWopSU8BAttfUYajicOMG3/as3ZGlQU=;
        b=QyweX1NK3vS2FC6ScwM1NgVlBj6N5cJh7M8xciBY/7m/Mm1UFRWvegynOgMHlLAXXI
         VQ89QCBJUMEqzwCBXyGlLd208xGdEyIySh6IGYaDEu+y7c18e/CjD5mOOLfX0mh/H2hZ
         81uG2uZI5lwtZgWAP85qcdsUHWY811zaEgbDcSEIs5KgUkgLaMpIZ/PeaAiks5BHqvRV
         wz0oRHtStfgc7Wwo4vue2KxvxMJxZge8vLrfjtuRauzx0E8AVhIC4+m79epX7KXCasC1
         i7nCvgmw+cWTogy2alSvvYC1EnuNk8SmPQA6iKHfl5Agc5RfR59KDN3j/PfPkC5hRjqX
         qZvg==
X-Gm-Message-State: AOAM530DdKfcrCyqK14oJsK3VSW6ugptHB7dEERgNFtB0q9rj+H5a+7U
        nz0D5B/SvSguaXT4CYAG3USHsidLDgFPrZ9kfz1nBA==
X-Google-Smtp-Source: ABdhPJyzr8lHFKbkYO2QBge2HdgGajKl7q78dW6j8wdAuUHiEE+yg4TJlxSQPhjLaWnpybmN9ZYAOd6hA3bYEzWK1dE=
X-Received: by 2002:a05:651c:1594:b0:239:9df5:f447 with SMTP id
 h20-20020a05651c159400b002399df5f447mr2107899ljq.463.1645103870304; Thu, 17
 Feb 2022 05:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org> <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
In-Reply-To: <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:17:13 +0100
Message-ID: <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Feb 2022 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 16/02/2022 17:22, Ulf Hansson wrote:
> > On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> When the node is virtual there is no release function associated which
> >> can free the memory.
> >>
> >> Free the memory when no 'ops' exists.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/powercap/dtpm.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> >> index 0b0121c37a1b..7bddd25a6767 100644
> >> --- a/drivers/powercap/dtpm.c
> >> +++ b/drivers/powercap/dtpm.c
> >> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
> >>
> >>          if (dtpm->ops)
> >>                  dtpm->ops->release(dtpm);
> >> +       else
> >> +               kfree(dtpm);
> >>
> >
> > This doesn't look correct. Below you check dtpm against "root", which
> > may be after its memory has been freed.
> >
> > If the ->release() function should be responsible for freeing the
> > dtpm, it needs to be called after the check below.
>
> It is harmless, 'root' is not dereferenced but used as an ID
>
> Moreover, in the patch 5/7 it is moved out this function.

Right. It just looks a bit odd here.

>
>
> >>          if (root == dtpm)
> >>                  root = NULL;
> >>
> >> -       kfree(dtpm);

So then why doesn't this kfree do the job already?

kfree(NULL) works fine, if dtpm->ops->release(dtpm) already freed the data.

> >> -
> >>          return 0;
> >>   }
> >>

Kind regards
Uffe

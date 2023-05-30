Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B6715A76
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjE3JlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjE3JlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 05:41:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44A184
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:40:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad87129480so1937645276.2
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685439642; x=1688031642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np76NH4DXG5VPctuj6JKiBCHCXXXSYiZoU6sFG87XRo=;
        b=Z6O/YRq798f/jWzC/w9ubTwCF4GKZjvsXGJrDqFux7uEH73IqpbLodsyL+/9ZDm2a1
         pi6p15vIDnMLqePre2XyNk5eX7rCmb8AHbUx8Q7cimy6TABGiK2cuyRw2foOOHvjGdgA
         rBlE5CdGi81IGzy21KmMOkcKfbBZg/Rbim1tiWGCWSfsVZuyT/bL0DEzSNbi2mZRIdFn
         Fojya9hZlPdSZRmJmw/E6sLz/2y5mFYCnXrFD0b+Y6izlartjn6TGZW2TycxjbxexZDs
         dIcR3aOuq5Ir4x7w2+u/Ba/N7VyHZJzwCO1wAaRfprpj3zndIjMuF7YTU7N1dZlcw+hT
         kkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685439642; x=1688031642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np76NH4DXG5VPctuj6JKiBCHCXXXSYiZoU6sFG87XRo=;
        b=AF4Q0tzNkuCj5C7xEfFNpg3iZk+PtC14K1WB4EEeaN0KNoaBRcORHNk4yMl/Zy1mfl
         G1AEy0dwzg7jMo5wI39GQz66w19hri5RKVylfkC3rqLhkxTKZDmwVo+ocGlaWdwWKHMs
         6CW8aS8uAQBzuCDnKlmw8pXQ0CEsF9MQ2xgkPC/KQRWx2rCPDeLty3laTQrp21ohoSRS
         mhi1jDwgrOoZ6QxHqomturhabyGBVhQgCFBzzi8JjkzKVAyc8ORk8JP8tHmkv5DsPYwB
         RPDIOdG4jC1BJGTiKD8ZYJWLcyVm+6i/BIqXpR12Q7Be//Q8TuvV2p84KACC+NH5zwzQ
         dI1w==
X-Gm-Message-State: AC+VfDz5mKncQERgIc5UkyldB/lKtdepoGa+KE5DW0u0eEj2rJEmFaFf
        QjJP/aONceWk2VLT4vQagHQpYfvt77Du8bXZEL0wqg==
X-Google-Smtp-Source: ACHHUZ7hWGOjZ6t9I+QJjuE3Ygrmb7SGRAWd1kZ6LyiMFZlDj0Tf/BRJmUuMKxkm3mbmAhMtYkrwF9PGE7YzEDcuIzE=
X-Received: by 2002:a25:764b:0:b0:ba8:26da:3147 with SMTP id
 r72-20020a25764b000000b00ba826da3147mr1971460ybc.59.1685439641947; Tue, 30
 May 2023 02:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFiuC=8bwgac2kafh6om3jHw6QtcDqtomA-Fpt+uekcqMv63aA@mail.gmail.com>
 <CAPDyKFqdSFhHobJD-22MsE1jTpaLzKDBWw-vH1NGza=27soBHg@mail.gmail.com> <CAFiuC=_OvOE6naD-ReAceJOVnUkaGOEqJkWP11AkV59MVUdaLA@mail.gmail.com>
In-Reply-To: <CAFiuC=_OvOE6naD-ReAceJOVnUkaGOEqJkWP11AkV59MVUdaLA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 May 2023 11:40:06 +0200
Message-ID: <CAPDyKFq3uFouiOnbP_jW79qNy-d_zECQHvTHqkTdW6Zi=rit7w@mail.gmail.com>
Subject: Re: On dev_pm_domain_attach function behavior
To:     Quang Hoang <quangh@google.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 30 May 2023 at 02:21, Quang Hoang <quangh@google.com> wrote:
>
> Hi Ulf,
> Thanks for your response.
>
> What is the recommended way to disable auto attach and powering on a doma=
in on driver probe? I am thinking of using an additional dummy power domain=
, but it seems to be hacky.

Auto attach is done for the single PM domain case for some of the most
common and generic cases, like the platform bus for example. In some
cases, there are consumer nodes in DT that need "manual" attaching, as
those don't always get a platform device created for it. Like the CPUs
for example.

Adding a dummy power domain seems certainly hacky. Although I am
trying to understand the problem, why doesn't "auto attach" work fine
for you?

Kind regards
Uffe

>
> Regards,
> Quang
>
> On Mon, May 29, 2023 at 8:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>>
>> On Mon, 22 May 2023 at 06:08, Quang Hoang <quangh@google.com> wrote:
>> >
>> > Hi Ulf Hansson,
>> >
>> > Hope you are doing well!
>> >
>> > I am Quang from Google Silicon team. I am working on drivers that use =
generic power domains.
>> > I have a few questions related to the behavior of dev_pm_domain_attach=
 function and genpd:
>> >
>> > 1. in dev_pm_domain_attach function, why don't we pass power_on variab=
le to genpd_dev_pm_attach function?
>>
>> At the introduction of the dev_pm_domain_attach() function, the
>> power_on variable was only relevant for the ACPI PM domain. For genpd,
>> we needed to always power on, as that was the assumption that was used
>> by the consumer drivers to allow them to probe their devices.
>>
>> > 2. Currently, if a device has only one power domain, its power domain =
is automatically attached and powered on probe. What is the reason behind t=
his behavior? Why don't we let the driver decide when to power on its power=
 domain via calling pm_runtime_get_sync() for example (as in cases where a =
device has multiple power domains, see this patch).
>>
>> The behaviour comes from legacy. It's not a trivial task to change the
>> behaviour in genpd around this, as a lot of consumer drivers rely on
>> it. Especially those that use pm_runtime_set_active() in ->probe().
>>
>> In the case of multiple PM domains per device, we did not have legacy
>> behaviour from consumer drivers to consider - thus leaving the PM
>> domain powered off while attaching is perfectly fine.
>>
>> >
>> > Looking forward to hearing from you,
>> > Regard,
>> > Quang.
>>
>> Kind regards
>> Uffe

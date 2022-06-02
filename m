Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB653BE50
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiFBTDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiFBTDI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 15:03:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85F26D4
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 12:03:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y32so9222729lfa.6
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+AakZjiwOsK+dWHtOxyzbKdyGeB21Ob6yUQXKjAAh0=;
        b=iAJBGZkAh89DFa1buvEfiQvUWb9pY230zOiqiSUUyJzmFzNNOpPS4v8i20jBNH1mPi
         uLSmExzlsMsxe5LPTDqczIEhY0xSHqWYrQzxdrxKNrYvMPEcXlzX98em5wddiURGg1P3
         cgFbQwAPssK2msRzLFmJqlKFPAYRAc1zivlHITcWUPZ38UHYPRRnzI2o4zjh1qwOJ0ea
         aZJqsMPHhDB9pKpTIYLxbHRmx8J6vARPTt46TJzKUoz/4LKNtL3rlbALb/9ChC/87ufZ
         P8PZeyghuBRhzTNxBtxEJHjP8JarLnGZirh8XMGmsBmCuY5343LiQVu2xlaECspsDs2g
         D+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+AakZjiwOsK+dWHtOxyzbKdyGeB21Ob6yUQXKjAAh0=;
        b=cb6B6vyRs7HK1hHEqY2zTj/0WPjwd14CqsnG1rmX0PLVcFw8/m5T2oD46VrtUAXI7N
         CrKzad6YzDtrA4opSUunN3+XM/B1g+rRPDKIo5e1YHeW9i5ijaYmpmnCZVYTGMrbKvgR
         Lnd2wDdqni7fbj4CnIGfTjQGBXEzkYyDs5CLtKdx51WF8swHj1axJMM721vs77Zez80E
         taxbyOtTFQ9ORPlUnJsv9YyKk9haVj/d1iLSyrUZZY9No5vQsUNH7m59lcqCrdpESac1
         IA+CAZf+W2IU+Q8v5KPOTOtXxxrA91P2FOXve0uk6Fyda4FFFf8eyfOefzQ5VO/aP4QM
         h/+g==
X-Gm-Message-State: AOAM533HT/9vvzPHi/wDpzKGBXyov5n3vJVTTNsZi1sBADW03kcIQ9u7
        8NNjlZcwMCFafGCAWtECbVi6oY8o+bmIGNyP5cqbqA==
X-Google-Smtp-Source: ABdhPJxVj1otSUGxA/O9PIblDPMV+r3FR82bbiykSEFQQb6RxbFGzBxlJd2rsesQG6CbBY7aht2SwSPSMczUFIfNe3I=
X-Received: by 2002:a05:6512:e90:b0:477:cc44:9813 with SMTP id
 bi16-20020a0565120e9000b00477cc449813mr4651605lfb.226.1654196584961; Thu, 02
 Jun 2022 12:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org> <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org> <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
In-Reply-To: <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 2 Jun 2022 12:02:53 -0700
Message-ID: <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 2, 2022 at 2:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/2/22 09:37, Daniel Lezcano wrote:
> >
> > Hi Lukasz,
> >
> > [Adding Todd]
> >
> > On 01/06/2022 17:33, Lukasz Luba wrote:
> >> Hi Daniel,
> >>
> >>
> >> On 6/1/22 16:14, Daniel Lezcano wrote:
> >>> The statistics are for debugging purpose and belong to debugfs rather
> >>> than sysfs. As the previous changes introduced the same statistics in
> >>> debugfs, those in sysfs are no longer needed and can be removed.
> >>
> >> I just want to let you know that in current Android kernels we cannot
> >> even compile the kernel with CONFIG_DEBUG_FS.
> >
> > Right, it makes sense. Precisely, with the sysfs stats they are always
> > compiled in for the Android kernel and is a problem for low memory
> > systems. While debugfs can fulfill its purpose in the developement and
> > will be removed in production systems.
>
> True.
>
> >
> >> I have this pain with
> >> Energy Model there... Some vendors might see useful info via this
> >> sysfs interface in bring-up of the SoC.
> >
> > Well alternatively, information can be extracted from procfs in the
> > device-tree description.
> >
> > What prevents to add energy information in sysfs now that the energy
> > model is per device ?
>
> Probably nothing, but we need strong need. I have proposed this
> a few times internally, but this must have a requirement.
> If a user-space tool would ask for it, then I could send a patch
> exposing the sysfs. So far we have only one user-space tool, which
> suffers the missing debugfs EM dir: LISA (but we are working on a
> workaround for it).
> If you have a tool or plan to have such, which uses EM, please let
> me know. I'm gathering the requirements.
>
> >
> >> I don't know if there are user-space tools tracking this
> >> information via sysfs. We probably should check that.
> >>
> >> I agree that these statistics look more like debug info, rather than
> >> something useful for control.
> >>
> >> Furthermore, we have trace events for the cooling state changes, which
> >> should be good enough for bring-up and experiments.
> >>
> >> I don't have strong preferences here. I tend to agree to remove this
> >> interface if there are no user-space tools using it.
> >
> > I agree userspace can also get information about the transition but the
> > goal of the debugfs is also add information about thermal internals like
> > average temperature at mitigation time, min and max, timings, etc ...
> >
> >
>
> I see, it makes sense. Let's see if Todd and Android folks don't
> use this thermal sysfs stats, so we could remove them.

Android HALs do use the thermal sysfs stats. debugfs isn't a viable
replacement since debugfs must not be mounted during normal operation.

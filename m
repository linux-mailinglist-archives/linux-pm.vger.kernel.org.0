Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E63583B09
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiG1JQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 05:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiG1JQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 05:16:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE612D1D
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:16:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l14so701731qtv.4
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hX4PTZfbTDTzhGaheJdjVlXek0iUFl4cndal0FNDY3I=;
        b=yj5ZkPzeLcVY7uKoP67SxzUA+eeDKUsOhdM/5w94M6AVULJIiJz1H7wlrP8kNI3pOf
         /pK346n51OIzXPBZWHSWHQ1GXVcFypsm3yGDIjKUw41S30C8ZnYgge0suUepF0AIy5Re
         1yD4pCP4mhbsI6/JL35cxcbPHUAmDLcKizUPobdh4q5riOBdF2QxDKLEvlb5fP9mPT5i
         IJ0wwzm3lM+HrkTjqvREP5LJAsbGyhm1vMCYDNVMnaaILAVAioJZM8ZeUhElbC58kNKq
         e4NuZBTCvIg/tI+U7I9Ln/HkvZujAHPvFEQepUbsRo8kdwOMHzcc6Zjkzs5F48QnUXrA
         p1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hX4PTZfbTDTzhGaheJdjVlXek0iUFl4cndal0FNDY3I=;
        b=xjEoVMciyFDbj2lcyubTJ5ZDlAPSLX8/owNmEKp0L8vDBkcgExdv/N5VlFNlbSYGQB
         zQiTA0JsQkll7PwsZPyQy7BhoRQVbCfzZA9z4amKn8PCHXj8Gq75Vi65BTY7d6UM+lrm
         Qecwp9FWFp0FtMc46L/JvgbzcS6JUR5UotYTQNtzVjeopT6w0vHa0b3+RdjdjNLsdlC2
         CXkr6tzQ7BN3nIU6J6R4knwP448pBuD0hYO8S9Egelwo/+CrXoSt76AWhXJ6Yk9gPoE4
         hVSm9etbUE+MhNiyk86NuyIB1D4qepMWOE4chHC9LskY74+uyEUD1BQvepthcKerXLAp
         uJbA==
X-Gm-Message-State: AJIora81WaFd4RtRAzZCZ+qsOSL0UGGlNgLQSM1c9FaFnsT8Sz0G+LzK
        9xAKNe0M4NmjIyUfBnKiRxx365Y+C06uRN3GCHYfXw==
X-Google-Smtp-Source: AGRyM1vm0kUV6dysNE7OEyfOc25hck4p5+rpV736Zm51d+2L/vefKpLt1y5ssWVQm9zQd4YSnEUzNsjNhvoHpDX7M4Y=
X-Received: by 2002:a05:622a:178a:b0:31e:f9ff:c685 with SMTP id
 s10-20020a05622a178a00b0031ef9ffc685mr22423284qtk.62.1658999765547; Thu, 28
 Jul 2022 02:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus> <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <20220728084012.jjbmycplye3zuaok@bogus>
In-Reply-To: <20220728084012.jjbmycplye3zuaok@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Jul 2022 12:15:54 +0300
Message-ID: <CAA8EJprxFxwoQPCSCNY13GDhmw+SCy-pCK0aQv=QqkgZE_FE1g@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Jul 2022 at 11:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
>
> > > > - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> > >
> > > Meaning DTS flag for this ? If OSI enable fails, why would you want to
> > > still proceed. It is non-compliant and must be fixed if the firmware
> > > supports OSI and expects OSPM to use the same.
> >
> > I'm not sure at this moment. PSCI firmware reports that OSI mode is
> > supported, but then when psci_pd_try_set_osi_mode() tries to switch
> > into OSI mode, it gets NOT_SUPPORTED.
>
> Yikes, fix the damn broken firmware. That is utter non-sense. I don't
> understand why would the firmware authors enable some feature before it
> is ready.
>
> > Just for the sake of completeness, I added a print to the psci.c to
> > dump the result of the psci_set_osi_mode(false). It also returns
> > NOT_SUPPORTED!
> >
>
> Well it is simply broken then. Not tested firmware, so please don't
> attempt to use OSI if it is so fundamentally broken. I find it hard to
> accept the argument that well it works just that the query API is failing.
> But what is the guarantee that it is tested well enough. We will end up
> adding more quirks after adding one to enable it.
>
> > My logical assumption would be that the firmware reports support for
> > OS_INITIATED, but then just fails to properly support
> > SET_SUSPEND_MODE.
>
> I knew this argument was coming as I wrote above, sorry I don't buy that.
> It is probably one of the early platforms supporting PSCI and not well tested
> for conformance. So I am inclined to just say we can't support it.

I have quoted the commit message from the vendor kernel (and the
debugfs entries) in other messages in this thread. It definitely seems
like the platform breaks strict standard conformance by supporting
CPU_SUSPEND, but not the SET_SUSPEND_MODE. Vendor kernel still used
the CPU_SUSPEND with a domain-like approach, expecting to find the
PSCI already being running in the OSI mode. So I'd ask for the ability
to add a flag to DT telling the PSCI_DOMAINS code that the platform is
already running in the OSI mode despite set_osi_mode() returning
NOT_SUPPORTED.

I would not say that this firmware was not tested to work with the
domains approach. The whole bunch of phones/tables were shipped with
this issue being present and the vendor kernel using a tree-wide
approach to cpu/cluster/system states.


--
With best wishes
Dmitry

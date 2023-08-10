Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359B777CF1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjHJP5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjHJP5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 11:57:07 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392C270B
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 08:57:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d43930354bcso919998276.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691683023; x=1692287823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9sGoVbxdv4YPhOUnQcFpS/Jp5lNjVGlLCDMDJuXP2k=;
        b=s2Wu8NC4UigDmdioL3VQS97aKvIVP4LvDfAot42IRMa8KV6a6ZyzJBrSTckqi66DCI
         a/JQIZ8L9oNV9LLAif2OzLn1zQFOwQTeFZSkNCTfixm9rvdx64siVUKsofW3w0tPXuYr
         y+GeS88ERGUl94kCuc5x7goIk7/XF02W6BoOdvgxkZzefVhedIgmYy2TDB87MZWxGN18
         MVmY3FgBd8BUZbLwEelj2qfzwft3VHHMsM08ZhfhiKu4HPgmoudxy0VQ9bC0oXd1iK0o
         doS+GU4wwRVokYhITn2K99LNX0I6P0Rj+FYzLQjuyI0nheOQ8+fUU4qyV+A2Ek7vDRlb
         aC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683023; x=1692287823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9sGoVbxdv4YPhOUnQcFpS/Jp5lNjVGlLCDMDJuXP2k=;
        b=Q5DA3AfLXyrRp3IrTZSyjVVWCAppbz9orYXb9scqJGJBVt3b3bN4pxd7sRfWPrFjWt
         ZurYFH21LIfl816LmknJP2NcoePEWsKtAFt+6f3R0mkvYqe5TNwn6bGXFC01J6E1PfMz
         PtVMx7SR0wry1QPl8tzsp+BgZjjg9++Qln2EJUMLjMD2i+I0BufY4pHY4zvQdnmmCJg9
         SOp1Pf/IP2B6UefkRMLynV06YVA9U+l86cIMiqaUR4EGwfUnqiqg+N1oXnw76mZgOPJi
         9hhuoOheYw2XR3PPryy8NDGJp8lU0RImIOg5pS9x6Pm5Pi8giGE/VqsadFzm3Kimt+7s
         3C6A==
X-Gm-Message-State: AOJu0Yyi0DjdoeEKphKpMJbUDrAdGwJBN4KRx6BQLhDrqoQZfse8CXPo
        QEcl6S2WFHtDLlY1nc0jCUxpvZLY4BvDpWiOHPHO2ecQ2zaDEg9d
X-Google-Smtp-Source: AGHT+IFL7HWh83Oo/6VC+Bv7LyX2Znjjqya7l9TXPmARB6mFCogrZIY3a4woejSQ942tnpGejtKC3PpeGO0GPKjoCMc=
X-Received: by 2002:a0d:fd86:0:b0:583:973:cc74 with SMTP id
 n128-20020a0dfd86000000b005830973cc74mr3074375ywf.8.1691683022846; Thu, 10
 Aug 2023 08:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com> <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad> <ZKxHHvBKvJeWiioc@google.com>
 <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com> <CAKHBV254i3fdQ7UX0Pc+CDaKO_OROA276vmgDPx4aPtZTiS2Bw@mail.gmail.com>
In-Reply-To: <CAKHBV254i3fdQ7UX0Pc+CDaKO_OROA276vmgDPx4aPtZTiS2Bw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Aug 2023 17:56:26 +0200
Message-ID: <CAPDyKFq6gVbQ7cGggmqgPGwNd9=5jdm=zN6zfT5VPeSrqkYR4w@mail.gmail.com>
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
To:     Michael Shavit <mshavit@google.com>
Cc:     Ajay Agarwal <ajayagarwal@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, quangh@google.com,
        Koudai Iwahori <koudai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Jul 2023 at 14:28, Michael Shavit <mshavit@google.com> wrote:
>
> On Thu, Jul 6, 2023 at 11:06=E2=80=AFAM Ajay Agarwal <ajayagarwal@google.=
com> wrote:
> >
> > Hello Linux PM experts
> > I have a question on PM domain. As per the current PM domain driver des=
ign, the genpd_finish_suspend turns OFF a power domain if it is not already=
 turned OFF by runtime suspend.
>
> I don't really understand why genPD does this in the first place. Not
> only does it power off domains that might have RPM_ACTIVE devices
> during suspend, it also powers on domains that might not have any
> active devices in them during resume (except for wakeup devices,
> similar to power-off. See genpd_finish_resume).
>
> Why isn't genPD powering-off/on domains based on device's RPM status
> sufficient? Assuming those are correctly set by device drivers during
> system suspend/resume.

I think you kind of already answered this by yourself. We can't rely
on all drivers to update the runtime PM status of their devices during
system wide suspend - simply because there are no requirements (legacy
wise) that they need to.

Moreover, as runtime PM gets disabled/enabled for all devices by the
PM core in the suspend_late/resume_early phase (for good reasons) - we
have a window when runtime PM can't be used to power-on/off devices.
In other words, if a driver needs to power on its device (and the
corresponding PM domain) during this window, how will that be done?

>
> Such that this:
> > But this flag is really intended to be used for devices which are capab=
le of waking up the system from PM suspend. But my usecase does not involve=
 a scenario of the device potentially waking up the system, it just needs t=
o stay powered for the co-processor to be able to use it.
>
> becomes just a matter of the device keeping its RPM status as active
> during system suspend.

Theoretically this could work, but unfortunately not in practice with
all the legacy code also taken into account.

Kind regards
Uffe

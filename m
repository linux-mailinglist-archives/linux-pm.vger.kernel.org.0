Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8B45DDEC
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhKYPwH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 10:52:07 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43725 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbhKYPuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 10:50:07 -0500
Received: by mail-ot1-f46.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so9978633otm.10;
        Thu, 25 Nov 2021 07:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCerFhrT655vbv4nCL7oKRYJTOa2nuC2HJ+XBleEaic=;
        b=xFWMEz+znu4RnRR//O9/ZrVk+h+I8T4WMgoWQEXwb0354ROoANzBtZk2GYln112QYE
         1BXUNcob+8FH3cNsr8nm4YaaZxFQstW3QRWldqdnPm1QaLJ57iHzcc7Yh49Rp+H5ADa2
         AsOZZJSFqq505kZB+ONIUyLywWLxDvDLxnHb0gajTlbGbiBbU8qk/JNmYBfXShVe3gko
         QtrOgYkYClQnk2SjsD5AipDtp+kgj8xzGgL2LJ2xHgncB1+N9jmx3CRSNyI/jL9xIFBN
         veDPOOl0J426JpI2+sy2DGrT4rorS8NBZxBz207slyjWKkTRMf1ByLSqc7ZN1Ne504kG
         87FQ==
X-Gm-Message-State: AOAM5338ylkRMWaVHNZFv3Flhqv/OU597PB2wQNBjSihZYFKs8HH9nZE
        jT0r7vkH/aaO6b7blKpfwAvv5pLUqeHaHGd3fPY=
X-Google-Smtp-Source: ABdhPJw6kC4CgpTqN/QGPY8kv41HRrZ+mJbwBj5XI3Q6nKglnh017y0ljFHKh1XAnfdLKKP3bdiXwNtXNNpqqSeAxco=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr22458073otu.254.1637855215279;
 Thu, 25 Nov 2021 07:46:55 -0800 (PST)
MIME-Version: 1.0
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <CAJZ5v0hhUSjNdHwF4dRUQ1Fgos-jqg1agHBShhhwFUGK6wiedQ@mail.gmail.com> <ac35bafa-a57f-e9ea-4dee-9af547de34e2@quicinc.com>
In-Reply-To: <ac35bafa-a57f-e9ea-4dee-9af547de34e2@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Nov 2021 16:46:44 +0100
Message-ID: <CAJZ5v0jqfvgEGjhiq6Cbd5S2Aj7+Jvi2Pj_GE8==Q2vjATRXCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Allow cpuidle governors to be compiled as modules
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, quic_lsrao@quicinc.com,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 2:18 PM Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Hi Rafael,
>
> On 11/25/2021 5:57 PM, Rafael J. Wysocki wrote:
> > On Thu, Nov 25, 2021 at 9:55 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
> >> This series makes changes to allow cpuidle governors menu, ladder and teo
> >> to compiled as modules when building with allmodconfig.
> > What's the purpose of this?
>
> There are two purposes of this series.
>
> 1. The series enables cpuidle governors to be allowed to compiled as
> modules.
>      This is something similar to what cpufreq/devfreq governors do
> today as they can be be compiled as modules or built-in depending on the
> build config.

Which is not the case for all of them, though, and I don't see why
this would imply that making cpuidle governors modular would be
useful.

> 2. The series will also enable custom cpuidle governor to be able to
> register with cpuidle framework by using cpuidle_register_governor() API.
>      This will be already achieved by (1) since it will export the
> required APIs for menu/ladder/teo governors to be compiled as module.

No custom cpuidle governors in the mainline, please.  If you have one
you want to be included, please submit it.

So from the mainline perspective this series doesn't serve any useful
purpose at all.

Sorry about that.

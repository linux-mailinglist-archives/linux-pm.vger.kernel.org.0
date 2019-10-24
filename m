Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61218E37CA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439830AbfJXQYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:24:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43221 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733261AbfJXQYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 12:24:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id c25so2056873uap.10
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1anzqH1b5gzyZ3/d3q3kK38QkzN8HcncYb5zfSj0BQ=;
        b=E/q0K3696VpElrs2lpW8Q2s+GBHRhjRLGtFdCkxyHnAGVL1bRWQFwNrRb4kgVH/cyx
         afI3Ee1718yQo/k85rEzWO95aChy00LdxwV9EC3rtTs/dzkI11Jo8ovoossW+rZYfiSP
         Obe+KnX2k2n2nTwkOP///OvJCHTHFMKGzu/wK4e9jgHMyEO5bO0SFZZSAiO6QdsxqIDL
         yp5LglQMiOqOw0Yg0r+4GCeNbCWwZDsL0k9+c1IicVRBSHu1hkfECSu6q53VV0pK3p9a
         IbO8nQv7m8JnK+m3MvoR4OAOFrowCWKARS9/Oyz8P07H/p+uJrm4ScwzG3X8hzL3gHPZ
         qRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1anzqH1b5gzyZ3/d3q3kK38QkzN8HcncYb5zfSj0BQ=;
        b=h+xrdzCKgESq7wReEcRaJibGF/3R7QaVRWW9rX2PSvrGdNoTjVWAi5fIogoTuOeU9G
         0XNsf871ZI7X3grzHB7m7lgfrS3huPlEJpPiLhiXRfIUKmkM9YDpEpohevSNlph35bOd
         NmJfZ+4ANU/CJPkcQNfADw8/ChZiiCPTTqQ3u+WPo+soNzoJErwnZXk8d8qamPbT29Oz
         t6Cxi+RgHIhYGwSrBtlSd16vFsXdSPRTlitDQmZmBfhZJlPBG5uAAdUA6gdGNAS++jYN
         NllU0dpQCLX4W0Fumki+y+7Y8b0xhl+6rE31oH3H6RGlk38n/MSgZjD0JFV6yg09Z8EC
         voEA==
X-Gm-Message-State: APjAAAV4MEzb/0eixkdC81QT0l89ZqYNiI3zl6htz53RhSGmrzO62cOP
        Jci0MXXgBDifmaoUa7jQcPsAA3BpN6fu18iJrS5tJMVr
X-Google-Smtp-Source: APXvYqyySL3xB/zgWf4uqU7Y5C8r4SvbrDVRO0QvG+k7GvkFZfc7dHw3X1con5tjqeOm2Zd1Ri21l6bd+BN2rpEbFmk=
X-Received: by 2002:ab0:348c:: with SMTP id c12mr9355249uar.100.1571934241763;
 Thu, 24 Oct 2019 09:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-3-ulf.hansson@linaro.org> <20191024152504.GA11467@bogus>
In-Reply-To: <20191024152504.GA11467@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Oct 2019 18:23:25 +0200
Message-ID: <CAPDyKFroHhRGN6k+eDCMooZ+Wv0AC6R4JzLKcVWHzs6M64o4+w@mail.gmail.com>
Subject: Re: [PATCH 02/13] dt: psci: Update DT bindings to support
 hierarchical PSCI states
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Oct 2019 at 17:26, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 10, 2019 at 01:39:26PM +0200, Ulf Hansson wrote:
> > Update PSCI DT bindings to allow to represent idle states for CPUs and the
> > CPU topology, by using a hierarchical layout. Primarily this is done by
> > re-using the existing power domain description [1] and the domain idle
> > state description [2].
> >
> > Let's also take the opportunity to update the examples to clarify the
> > difference between the currently supported flattened layout vs the new
> > hierarchical layout.
> >
>
> This looks fine to me. FWIW:
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> But before this gets merged, I would like to add another but "the golden"
> example Qcom *always* referred during ACPI LPI discussions. Ofcourse, it
> can be addition patch and if I get time, I can write this but no promise
> ATM.

I like the description below, thanks for clarifying that.

Although, as you say, we can for sure add it on top. As a matter of
fact, I think that is even the best way forward, as currently we can't
support it (because of limitations in genpd, that I have started
working on a bit).

>
> Hierarchical Representation:
> System
> 1. SYSTEM_RET
> 2. SYSTEM_PG
>
>         Cluster#0
>         1. CLUSTER_RET
>         2. CLUSTER_PG
>
>                 Core#0
>                 1. CORE_CG
>                 2. CORE_RET
>                 3. CORE_PG
>
>                 Core#1
>                 1. CORE_CG
>                 2. CORE_RET
>                 3. CORE_PG
>         Cluster#1 (ditto)
>
> Flattened Representation:
>
> Core#0
>         1 CORE_CG
>         2 CORE_RET
>         3 CORE_RET + CLUSTER_RET
>         4 CORE_RET + CLUSTER_RET + SYSTEM_RET
>         5 CORE_PG
>         6 CORE_PG  + CLUSTER_RET
>         7 CORE_PG  + CLUSTER_RET + SYSTEM_RET
>         8 CORE_PG  + CLUSTER_PG
>         9 CORE_PG  + CLUSTER_PG  + SYSTEM_RET
>        10 CORE_PG  + CLUSTER_PG  + SYSTEM_PG
>
> Though we may not implement everything needed to support this, but
> we must ensure we don't have to end up in a situation breaking backward
> compatibility trying to support the same.

Yep, right. I don't see any issue in regards to backward compatibility
to support this above.

Thanks for reviewing!

Kind regards
Uffe

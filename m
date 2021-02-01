Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBA30A981
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBAOT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:19:56 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45632 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhBAOTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 09:19:54 -0500
Received: by mail-oi1-f181.google.com with SMTP id g69so18883433oib.12;
        Mon, 01 Feb 2021 06:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl0r7E4pmPDbzLNU5N8bDECPX3AdG/sX/U/vlhC1xFk=;
        b=hf4+ue6GgKRubzn8XHs5QlRnkkMCnu+kJ8KpOJ2+bmOoElvND+Wq5/IDzCWm1d42fl
         /jFXMHlLDVyrgMgivYH5ni9JsWuu+GkbaLhi4p6qjrjlqIOs42SQu3k2n8lnPJOi+dpU
         e0FAmP1XsUVRA2PsrDeREKRdb6jHL17Jtjr9l0jUv0ZQD9hzCnmSwz7puZYA7wHYq1nf
         IlK6+VJl7nmzcrlOxxXKD9/fE3jF78E6BpwHhawj4zkPADSD/Jhhy7nF268SbX/kGo/T
         wfzMPC/x8XJEJJHfVdk6pt/ugEjHFMvx/1e9y/A+ymjxANf3BS13ulXisIanrkli4Xmg
         hPew==
X-Gm-Message-State: AOAM532IROtiOam3dv6BMp7n9fH7ru/PtT5HBd1VdQYjD9edQLzJsyNp
        OHUgcvKy6uULpvxMV4pmFgkJkwSTSlMU/PHRsaY=
X-Google-Smtp-Source: ABdhPJz00OGkDdFmt7vYjfTz/1PnWPAq//PkpSMGscieC47E85iAXencF6eG0+UOGIujvJ5b8D/NWkPfFRm89XBiu/M=
X-Received: by 2002:aca:308a:: with SMTP id w132mr10398744oiw.69.1612189153445;
 Mon, 01 Feb 2021 06:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20210126104001.20361-1-lukasz.luba@arm.com>
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 15:19:02 +0100
Message-ID: <CAJZ5v0gm7TU59Cr1SUZ8Xk_PwBbwv+J5kA75fNqK7OsGM8F6RA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max power
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 26, 2021 at 11:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi all,
>
> This patch set tries to add the missing feature in the Intelligent Power
> Allocation (IPA) governor which is: frequency limit set by user space.
> User can set max allowed frequency for a given device which has impact on
> max allowed power.

If there is more than one frequency that can be limited for the given
device, are you going to add a limit knob for each of them?

> In current design there is no mechanism to figure this
> out. IPA must know the maximum allowed power for every device. It is then
> used for proper power split and divvy-up. When the user limit for max
> frequency is not know, IPA assumes it is the highest possible frequency.
> It causes wrong power split across the devices.

Do I think correctly that this depends on the Energy Model?

> This new mechanism provides the max allowed frequency to the thermal
> framework and then max allowed power to the IPA.
> The implementation is done in this way because currently there is no way
> to retrieve the limits from the PM QoS, without uncapping the local
> thermal limit and reading the next value.

The above is unclear.  What PM QoS limit are you referring to in the
first place?

> It would be a heavy way of
> doing these things, since it should be done every polling time (e.g. 50ms).
> Also, the value stored in PM QoS can be different than the real OPP 'rate'
> so still would need conversion into proper OPP for comparison with EM.
> Furthermore, uncapping the device in thermal just to check the user freq
> limit is not the safest way.
> Thus, this simple implementation moves the calculation of the proper
> frequency to the sysfs write code, since it's called less often. The value
> is then used as-is in the thermal framework without any hassle.
>
> As it's a RFC, it still misses the cpufreq sysfs implementation,

What exactly do you mean by this?

> but would be addressed if all agree.

Depending on the answers above.

But my general comment would be that it might turn out to be
unrealistic to expect user space to know what frequency limit to use
to get the desired result in terms of constraining power.

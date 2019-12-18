Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82136124982
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLRO0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 09:26:24 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33147 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRO0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 09:26:23 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so1867585iln.0;
        Wed, 18 Dec 2019 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wlPxPww6z6FnBuvqZdCSnOZoPUkGvAxji1Q0RJ5rgw=;
        b=L0cuGq4QdVQcuoKxwq/ZrEBaI8Thl/hcoH7fDKC3QcY0Juvw2tJN2qHL5oKs0QHHcL
         2li37AzFZsgrZEUfXRii2ybgHnL8Ulq4t0RYml6blxSFluTt3R9W5HIQXmrj2IA2iNGR
         k9yMdQSCyoGkwwPRnNTAEpgfUAOBYZqQITBpE8LBGhRXKCawZVA8n/psJzgryfZw0FET
         VwWV0ZCutOK2r10WBfLanx87B9iCzzgzYxegj2+a1ocFZO3VKbYw6B5HMXXJiO55g0E+
         W3mLZgm1h3bllOmAkL+UQ+A+gedihUVqRLXmDLAlh94gZQbdnkGT8IgHhyBC6TotqY6P
         TG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wlPxPww6z6FnBuvqZdCSnOZoPUkGvAxji1Q0RJ5rgw=;
        b=GcrgC6cQhI6GtPlv624PhgvlRFwXW7LcXc1qSQq1XWEOgEFfyRheNk2Bj6xypaVyi6
         7qFC0nXblE1J2m/0U9i09wvkXsTQzjmMA2Q/69Rgxj5hahNB7VqeTZ8TykbFtaFRlmmF
         Fscc54wVexaqHtgW8WBdNoc+b1oWDHLivnmCgeNl1/WLCmUncET3LSgSjcvvQfbh5Nui
         RpCK071vQnL3o5becwT2PKpPVADZAuCsWxPpleiwg+U2nCk+YpO63n9Gv8syEwOVqTEW
         3Q4jNC3AlDQZb+v8wi7DCVJfps6QPBB/zxfWQ79PU75ejcqPNFr30KA7NALhpvjYUZmc
         iXgw==
X-Gm-Message-State: APjAAAU5DxMA3x8ZAFCm93UgddfMfLCI+v87rmV576/prJbWmhen/Ips
        VfhJHgN0QI4OCkzJhK1HjN6hf3cVoP6ENfEbQk4=
X-Google-Smtp-Source: APXvYqx2Zh9m2SuSjEBkL7Y//MOgmcWkxInemOTWZeFNxJHgDtxwj7VI23wyzRqlUIJwndOxhAYoWLlg+PDjCfNjA1c=
X-Received: by 2002:a92:910b:: with SMTP id t11mr2101801ild.195.1576679182953;
 Wed, 18 Dec 2019 06:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com> <CAJZ5v0jmMwRGDY70EV3sqpw7uJ4R+VomoWtJ9rWzNTVuV3AUxQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmMwRGDY70EV3sqpw7uJ4R+VomoWtJ9rWzNTVuV3AUxQ@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 19 Dec 2019 01:26:11 +1100
Message-ID: <CAOSf1CF9F1iViKCCoJXOPmkbj+kLXnJJz5b5B7xLgrLpCZoB3w@mail.gmail.com>
Subject: Re: [RFC] cpuidle : Add debugfs support for cpuidle core
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 3:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 17, 2019 at 3:42 PM Abhishek Goel
> <huntbag@linux.vnet.ibm.com> wrote:
> >
> > Up until now, we did not have a way to tune cpuidle attribute like
> > residency in kernel. This patch adds support for debugfs in cpuidle core.
> > Thereby providing support for tuning cpuidle attributes like residency in
> > kernel at runtime.
>
> This is not a good idea in my view, for a couple of reasons.
>
> First off, if the target residency of an idle state is changed, it
> effectively becomes a different one and all of the statistics
> regarding it become outdated at that point.  Synchronizing that would
> be a pain.
>
> Next, governors may get confused if idle state parameters are changed
> on the fly.  In particular, the statistics collected by the teo
> governor depend on the target residencies of idle states, so if one of
> them changes, the governor needs to be reloaded.
>
> Next, idle states are expected to be ordered by the target residency
> (and by the exit latency), so their parameters cannot be allowed to
> change freely anyway.
>
> Finally, the idle state parameters are expected to reflect the
> properties of the hardware, which wouldn't hold any more if they were
> allowed to change at any time.

Certainly does sound like a headache.

> > For example: Tuning residency at runtime can be used to quantify governors
> > decision making as governor uses residency as one of the parameter to
> > take decision about the state that needs to be entered while idling.
>
> IMO it would be better to introduce a testing cpuidle driver with an
> artificial set of idle states (or even such that the set of idle
> states to be used by it can be defined by the user e.g. via module
> parameters) for this purpose.

The motivation for this patch isn't really a desire to test / tune the
governor. It's intended to allow working around a performance problem
caused by using high-latency idle states on some interrupt heavy GPU
workload. The interrupts occur around ~30ms apart which is long enough
for the governor to put the CPU into the deeper states and over the
course of long job the additional wakeup latency adds up. The initial
fix someone came up with was cooking the residency values so the
high-latency states had a residency of +50ms to prevent the govenor
from using them. However, that fix is supposed to go into a bit of
firmware I maintain and I'm not terribly happy with the idea. I'm
fairly sure that ~30ms value is workload dependent and personally I
don't think firmware should be making up numbers to trick specific
kernel versions into doing specific things.

My impression is the right solution is to have the GPU driver set a PM
QoS constraint on the CPUs receiving interrupts while a job is
on-going. However, interrupt latency sensitivity isn't something
that's unique to GPUs so I'm wondering it it makes sense to have the
governor factor in interrupt traffic when deciding what state to use.
Is that something that's been tried before?

Oliver

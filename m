Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDE1B4717
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDVOV1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 22 Apr 2020 10:21:27 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:43250 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVOV0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 10:21:26 -0400
Received: by mail-oo1-f65.google.com with SMTP id d21so542414ook.10;
        Wed, 22 Apr 2020 07:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNjUnY94w0UWiXsubeBPALgzfBzt9q3zu5ENZfCjrts=;
        b=kzMfRMWsG3VKy4zOrZ6AWWh9+VxDQgk3o7R3I3vJGxDuR2m3Ff55DR+qVGM/41INfc
         SRqtTmc/SPtU898lTlfO6FVqElolwC0KBBORYM7S4V1cbGfEetXQV0rYvx6HEz8IcKAx
         fnkceX6RjxM0RspmXFvC3Egn2exCU724l4mg5jW+dlVkaVBPkYSC0VQYUhQz9WjTQqgl
         XCAFoVVwM7KGJ0MPdWtjWxisiIIxDM/j1HOh6pVxbdTWoUvcif6IyLX16jW9MUuK6N7a
         51QK97T76ALtCwTqpex/TY4Xqy27+JlGFt/r1/muguVL9i5zzJAaqeqneCrgcPUCDniV
         NiNw==
X-Gm-Message-State: AGi0Pubq9OqcnWDWAWXiKuf0eaZhRasusOLnyNrvOdH+d8HrByKr4f3z
        7YsAtydc9QV1gfSMCYBR050QY83CWVH4e4hsggN/cg==
X-Google-Smtp-Source: APiQypLzDbS17kDo7l7U/QyP+cqX3xyR5zgbb/QPEQAJ3Y5SfI4zsMPbwN/toLIfmHzKulF8hMgy2GynWRg/ze+Lcak=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr15515496ool.38.1587565284215;
 Wed, 22 Apr 2020 07:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200422051529.30757-1-zhang.lyra@gmail.com> <CAJZ5v0ikL3avFomZVqtBhfEjeauN-5ZUm9kZwzG=Vo+Ks0AiyA@mail.gmail.com>
 <CAAfSe-sVEEPOrq_ZzB1z59uXTfhmNh=+U_QvgaTcd4U1=9Tfvg@mail.gmail.com>
In-Reply-To: <CAAfSe-sVEEPOrq_ZzB1z59uXTfhmNh=+U_QvgaTcd4U1=9Tfvg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Apr 2020 16:21:12 +0200
Message-ID: <CAJZ5v0jxnSUDqVpaHo6ECQdr6bpe2WHEhV+uDL_=BAJQC9fA9w@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: call devfreq_suspend/resume and
 cpufreq_suspend/resume in pairs.
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Samer Xie <samer.xie@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 1:19 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Rafael,
>
> (Behalf Of Vincent Wang)
>
> Thanks for your comments, please see my answers below.
>
> On Wed, 22 Apr 2020 at 17:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Apr 22, 2020 at 7:15 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > From: Vincent Wang <vincent.wang@unisoc.com>
> > >
> > > If dpm_prepare() fails in dpm_suspend_start(), dpm_suspend() can't be
> > > called.
> >
> > That's correct.
> >
> > > And then, devfreq_suspend() and cpufreq_suspend() will not be
> > > called in the suspend flow.
> >
> > Right.
> >
> > > But in the resiume flow, devfreq_resume() and cpufreq_resume() will
> > > be called.
> >
> > Right, and they are expected to cope with the situation.
> >
> > > This patch will ensure that devfreq_suspend/devfreq_resume and
> > > cpufreq_suspend/cpufreq_resume are called in pairs.
> >
> > So why is it better to do this than to make devfreq_resume() meet the
> > expectations?
>
> Yes，we found an issue with cpufreq schedutil governor on kernel4.14,
> and I think the issue should haven't been changed on the latest
> version of kernel.
>
> In the function dpm_suspend_start(), dpm_suspend() would not be
> exceuted if return error from device_prepare() [1]. So
> cpufreq_cpufreq() will not be called,

I guess you mean cpufreq_suspend().

That should be OK .

> then cpufreq_remove_update_util_hook() will not be called either, and so
> cpufreq_update_util_data will not be NULL.
>
> In the dpm resume flow, sugov_start() will be called, in which
> sg_cpu.update_util will be set to 0.

Which code patch does this?

Surely not cpufreq_resume(), because that checks cpufreq_suspended which
cannot be set if cpufreq_suspend() has not been called (because it is the only
place setting cpufreq_suspended).

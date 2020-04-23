Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293851B52A5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 04:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDWClq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgDWClp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 22:41:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3572AC03C1AB;
        Wed, 22 Apr 2020 19:41:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so4871127wmg.1;
        Wed, 22 Apr 2020 19:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+E1Vpl6owsWhbt4oEdMFH6LpaqhM5KtB6JWE9dlZYRY=;
        b=DbYLdPIsz5Ec24KSUtplycQbYhICIHFOjMX+ccSHDmiHKcEKTQ25ZcSr142eSm2zI/
         B5hzTgrN1a5XdBUvc/zfkFX7APm3YAw6T48wbriQvyiNa34E6BIYJgAU2WmqQQCMYKLV
         K6FBLeLekyMO/nUnHANBCHhZsIYumwS+jpV+TkO+Kk5g0QDNbPUOgXq37ULQ1LS2XAcw
         pUxUBlrkpHJI7Dra8vLb9qdvqfwrHEVYqLpZdbUoEiG7hl+cQbY0ReYYzIpWK6aLtpba
         sZKaOgzKHf1mSpuxB9UukvpnjLZT4Ub7ypyISs8UcZdJckZfgOb+7WJsBNwvzWRuVPws
         RzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+E1Vpl6owsWhbt4oEdMFH6LpaqhM5KtB6JWE9dlZYRY=;
        b=TlRIcy53wvcwTY36rLF1lET5BBs3cfhNNIgOYUVPSFii9aperzKlF8OWI9bCToFd4d
         uTZzkGaqDewFFam/iF0bKmXhRbYb6igMIAQ2ArWEPbeC4f9DPFhVscgJBKPrvaMuByxa
         vWlukiHErTfkWGG1+QjiHZmy2TTwNfdFYzNaNSuKyTO077qSEwyO8j6bTJWG25rP1shC
         JsJEKVcGCgLDltRyKh/z16272eUKdDMkOC0nK8ZhP60iCYEnCXdcN9pLs2XsX6xCv4Oq
         szmlXGHz+NiBEHa1bfOjgqlLsY3CZ0S3BgeuKqLQ6hUoAfT8E4YICql2suhfr6JpkBHf
         5vUA==
X-Gm-Message-State: AGi0PuZatZBk2qqAV6sZVvrxIV9SC1+6wdW8Qcgtzzg4sSfTqGl4DtTv
        CrzOeMxn5fUlkkOHSxCUaHLiLkQvbfu8nJ3ONQQ=
X-Google-Smtp-Source: APiQypK9iUilhdAbGX59xP93IoiPJ6rBlFwjxn/QZMGOU3aqLLfvq8hkALLx+OCpN9j0RV9HCUU1SJVZFgdHY9iDVYk=
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr1516959wma.26.1587609703900;
 Wed, 22 Apr 2020 19:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422051529.30757-1-zhang.lyra@gmail.com> <CAJZ5v0ikL3avFomZVqtBhfEjeauN-5ZUm9kZwzG=Vo+Ks0AiyA@mail.gmail.com>
 <CAAfSe-sVEEPOrq_ZzB1z59uXTfhmNh=+U_QvgaTcd4U1=9Tfvg@mail.gmail.com> <CAJZ5v0jxnSUDqVpaHo6ECQdr6bpe2WHEhV+uDL_=BAJQC9fA9w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxnSUDqVpaHo6ECQdr6bpe2WHEhV+uDL_=BAJQC9fA9w@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 23 Apr 2020 10:41:07 +0800
Message-ID: <CAAfSe-uv7fh5Wf7zXLOu0_5wZ2fNQHd3QJ7LWWZvciexvUgivw@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: call devfreq_suspend/resume and
 cpufreq_suspend/resume in pairs.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Samer Xie <samer.xie@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 22 Apr 2020 at 22:21, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 22, 2020 at 1:19 PM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> >
> > Hi Rafael,
> >
> > (Behalf Of Vincent Wang)
> >
> > Thanks for your comments, please see my answers below.
> >
> > On Wed, 22 Apr 2020 at 17:05, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Apr 22, 2020 at 7:15 AM Chunyan Zhang <zhang.lyra@gmail.com> =
wrote:
> > > >
> > > > From: Vincent Wang <vincent.wang@unisoc.com>
> > > >
> > > > If dpm_prepare() fails in dpm_suspend_start(), dpm_suspend() can't =
be
> > > > called.
> > >
> > > That's correct.
> > >
> > > > And then, devfreq_suspend() and cpufreq_suspend() will not be
> > > > called in the suspend flow.
> > >
> > > Right.
> > >
> > > > But in the resiume flow, devfreq_resume() and cpufreq_resume() will
> > > > be called.
> > >
> > > Right, and they are expected to cope with the situation.
> > >
> > > > This patch will ensure that devfreq_suspend/devfreq_resume and
> > > > cpufreq_suspend/cpufreq_resume are called in pairs.
> > >
> > > So why is it better to do this than to make devfreq_resume() meet the
> > > expectations?
> >
> > Yes=EF=BC=8Cwe found an issue with cpufreq schedutil governor on kernel=
4.14,
> > and I think the issue should haven't been changed on the latest
> > version of kernel.
> >
> > In the function dpm_suspend_start(), dpm_suspend() would not be
> > exceuted if return error from device_prepare() [1]. So
> > cpufreq_cpufreq() will not be called,
>
> I guess you mean cpufreq_suspend().
>
> That should be OK .
>
> > then cpufreq_remove_update_util_hook() will not be called either, and s=
o
> > cpufreq_update_util_data will not be NULL.
> >
> > In the dpm resume flow, sugov_start() will be called, in which
> > sg_cpu.update_util will be set to 0.
>
> Which code patch does this?
>
> Surely not cpufreq_resume(), because that checks cpufreq_suspended which
> cannot be set if cpufreq_suspend() has not been called (because it is the=
 only
> place setting cpufreq_suspended).

Right, I saw that, then there's no issue indeed. I just need to
backport the patch which added checking of cpufreq_suspended to
cpufreq_resume.

Thanks for your review!

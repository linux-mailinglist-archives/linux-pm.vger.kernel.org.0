Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705CB86768
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbfHHQqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:46:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44567 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHQqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 12:46:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so70985605otl.11;
        Thu, 08 Aug 2019 09:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gg6fUCiCEsxLN5L/xPRw12xlRpWyI1qROMx6U7rtlCU=;
        b=ZeCWRsYvjTdCv/7V2ObGrr0K/NhPsbm8h+ICjP9pQ0Eh1QvDIiqnrTv1hih9AEllAm
         R6vsMSBNVYELGWQnTtRMc850Xhb8J1EMIab+hvnIhnffqL/Cj6F+nibcuPwGFlqID6QI
         BT4goBHxwTg50y47LL4EZUvIdG8/5QVoUPW1QcSatGj2ZURsYZYArbGg5nFj3di8BOTd
         /Qn4By2OJFHGrMvcvVM+1jvPgABQgFURACVmJ2CuxZpFcpXGcxU3KXotHPFhwYRuOzvN
         XPqR8oDsvLfJwthaUahdHIU8+7qMdwGlSdOS8YWKHgTMTlqkciKq+/nN0qrEyoz3yQf+
         X5Qg==
X-Gm-Message-State: APjAAAVP28900ZFLX/SoLA2a/UFh4CvwC94YVxV6/oSdfYJdaeDftZXX
        M6oNZq0d+EhiW/bSKqKwHFh1wO83SU3khqBUCQ4=
X-Google-Smtp-Source: APXvYqw/qRt2BmPlOiyuS5ZiKDdODeZAGYBGQnpdm2kcwkHNvMgf0/0HJVGQTjjEPvGqmXMzB00LhwTV0V7RwBQsYHs=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr14373474otq.262.1565282806529;
 Thu, 08 Aug 2019 09:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
 <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
 <000601d54e05$e93d0130$bbb70390$@net>
In-Reply-To: <000601d54e05$e93d0130$bbb70390$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Aug 2019 18:46:35 +0200
Message-ID: <CAJZ5v0hnMXUqJP62t1LYb0TRsi-HSg+Zk+DZGLr+5Yd=_wNBNQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported
 freq constraints
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

, On Thu, Aug 8, 2019 at 6:25 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.08.07 00:06 Viresh Kumar wrote:
>
> Thanks for your work on this.
>
> > Intel pstate driver exposes min_perf_pct and max_perf_pct sysfs files,
> > which can be used to force a limit on the min/max P state of the driver.
> > Though these files eventually control the min/max frequencies that the
> > CPUs will run at, they don't make a change to policy->min/max values.
> >
> > When the values of these files are changed (in passive mode of the
> > driver), it leads to calling ->limits() callback of the cpufreq
> > governors, like schedutil. On a call to it the governors shall
> > forcefully update the frequency to come within the limits. Since the
> > limits, i.e.  policy->min/max, aren't updated by the driver, the
> > governors fails to get the target freq within limit and sometimes aborts
> > the update believing that the frequency is already set to the target
> > value.
> >
> > This patch implements the QoS supported frequency constraints to update
> > policy->min/max values whenever min_perf_pct or max_perf_pct files are
> > updated. This is only done for the passive mode as of now, as the driver
> > is already working fine in active mode.
> >
> > Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Tested by: Doug Smythies <dsmythies@telus.net>
> Thermald seems to now be working O.K. for all the governors.
>
> I do note that if one sets
> /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> It seems to override subsequent attempts via
> /sys/devices/system/cpu/intel_pstate/max_perf_pct.
> Myself, I find this confusing.
>
> So the question becomes which one is the "master"?

For the min freq limit, the max of (scaling_min_freq, re-scaled
min_perf_pct) should be used.

For the max freq limit, the min of (scaling_max_freq, re-scaled
max_perf_pct) should be used.

Overall, the setting that "wins" is the one that causes the set of
available frequencies to be narrower.

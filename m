Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E309838CB50
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhEUQyi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 12:54:38 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46972 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhEUQyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 12:54:37 -0400
Received: by mail-ot1-f46.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso18560422otb.13
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 09:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WvCJtauja42PE7SIYjK07qC1NQryN4Kvq8gBFY97W0=;
        b=ByTjU7g7iah6uGiNzsroX4OomyrBX508gtHg2xPgCElcTNsn0/rtPfzgEEss3A/f1Z
         0NUfPBUuxFSa8ck+eah91YlZmXODxjOG+HzDFdeYWvcLQXlVF+uf3ltCX7LTpgFtf+CJ
         c8ecxQ+k5gRs6GX6fidn1a3Lp/SQIPOYwDpbel8+jACUIUrDaiuzwXfexQ/ueSNUsb8R
         w/bdzTyGyOj9+CCphUyfy4FeP6tQlVdLCs2e8VcMBt0HCYH7AKophZpXt3iwDNoBt3yE
         ECcuVTJxjazCnH5ifx/OIZxQ256rnVv5Kw9TXrWSKMoBcY/119ocnNKAI3Rtsp8tJePm
         6oig==
X-Gm-Message-State: AOAM5333500fiUdBNzcu2gf9T196OLpU4Z6S7uWKFPPHS0J46lC+Vn+T
        8za2rHK31+IqPRWoiVL/rjz42wEuVFZAgU4OdYA=
X-Google-Smtp-Source: ABdhPJzOPbT3BAzPNjwShYI3KG4WnbXIR7hXBiiafRZVyhymZmCj4A55SezohBOJQuLKtrLdqNhXAA1ylZoDNxcZbrI=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr9525933otc.206.1621615993168;
 Fri, 21 May 2021 09:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210503161840.26771-1-rdunlap@infradead.org> <20210504062245.hfn7n7ghm27oxehx@vireshk-i7>
 <23673b12-6e46-f511-e326-d6f5342b0013@infradead.org>
In-Reply-To: <23673b12-6e46-f511-e326-d6f5342b0013@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:53:02 +0200
Message-ID: <CAJZ5v0hrYgZP1Eay6syEtbztEOA46sSPmY8u-NuLLREdRDctTA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sc520_freq: add 'fallthrough' to one case
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 19, 2021 at 12:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/3/21 11:22 PM, Viresh Kumar wrote:
> > On 03-05-21, 09:18, Randy Dunlap wrote:
> >> Quieten an implicit-fallthrough warning in sc520_freq.c:
> >>
> >> ../drivers/cpufreq/sc520_freq.c: In function 'sc520_freq_get_cpu_frequency':
> >> ../include/linux/printk.h:343:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >> ../drivers/cpufreq/sc520_freq.c:43:3: note: in expansion of macro 'pr_err'
> >>    pr_err("error: cpuctl register has unexpected value %02x\n",
> >> ../drivers/cpufreq/sc520_freq.c:45:2: note: here
> >>   case 0x01:
> >>
> >> Fixes: bf6fc9fd2d848 ("[CPUFREQ] AMD Elan SC520 cpufreq driver.")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: linux-pm@vger.kernel.org
> >> ---
> >> Found in linux-next but applies to mainline.
> >>
> >>  drivers/cpufreq/sc520_freq.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> --- linux-next-20210503.orig/drivers/cpufreq/sc520_freq.c
> >> +++ linux-next-20210503/drivers/cpufreq/sc520_freq.c
> >> @@ -42,6 +42,7 @@ static unsigned int sc520_freq_get_cpu_f
> >>      default:
> >>              pr_err("error: cpuctl register has unexpected value %02x\n",
> >>                     clockspeed_reg);
> >> +            fallthrough;
> >>      case 0x01:
> >>              return 100000;
> >>      case 0x02:
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
>
> Rafael, ping?

Applied as 5.14 material, thanks!

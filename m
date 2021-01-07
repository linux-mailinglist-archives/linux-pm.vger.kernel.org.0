Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953D2ED57E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbhAGRZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 12:25:22 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43308 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGRZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:25:21 -0500
Received: by mail-ot1-f45.google.com with SMTP id q25so6976171otn.10;
        Thu, 07 Jan 2021 09:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpG41d5OlWzv+km3h3m9vib/u3YyCF2qCiMVKCMnb60=;
        b=TMFIPPBdJYf5nZNqSU2isyQKiQzZuSII4JRr4Acw4wTS3glMfVjdL4uiPL5Mhzpbs8
         UDmVzl1YzIfqdk0msihtkZ2Luso22fM8IsE1oNR2oI0qpAXkMw5Xnj4hfH2y4z6OIrSD
         PD3R/Fbwx/WeQZUm5Wk4dx+PphVNZuJd/VSJOuPRBDk7v8jBDLyN1jmYF2++9IRGZYWf
         f0ocx/vHNTW7A/Wd7R+fi45vGbMrlCHKbTRIdikwhOM73R09ftXbVI0UAkNuCCeKOIog
         xfh8XGED3qICVBVLokYNK4phA6X26CI/2F/d15LiJn2hygCzuv2XfKhRW+QI3w7bKBXL
         CJNw==
X-Gm-Message-State: AOAM532gMrajuL2QKi2raJWsqPZ4vWhuS5bhYSg7kL9q/YWIufR9xv6Y
        GsQ2Kd7swmsEKFPaw0eu0qe/F3tbeAYQ9B/lGSBDFtT1
X-Google-Smtp-Source: ABdhPJz5DgAMGWr6iSStmHQMd/2CDd8grSugukgatJ9GG7ZsCYqPZrvkdXmbcN4C5rfTLry0vCdbCwXKNgTPfm3ktdg=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr7383389otn.321.1610040280622;
 Thu, 07 Jan 2021 09:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20201221051320.18391-1-lukas.bulwahn@gmail.com> <20201221222015.GA3389117@ubuntu-m3-large-x86>
In-Reply-To: <20201221222015.GA3389117@ubuntu-m3-large-x86>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 18:24:29 +0100
Message-ID: <CAJZ5v0hv8zzwQm3SwD3V76n+NENKANwBVktETNt2vV+GdHSzPA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: remove obsolete functions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 11:21 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Dec 21, 2020 at 06:13:20AM +0100, Lukas Bulwahn wrote:
> > percent_fp() was used in intel_pstate_pid_reset(), which was removed in
> > commit 9d0ef7af1f2d ("cpufreq: intel_pstate: Do not use PID-based P-state
> > selection") and hence, percent_fp() is unused since then.
> >
> > percent_ext_fp() was last used in intel_pstate_update_perf_limits(), which
> > was refactored in commit 1a4fe38add8b ("cpufreq: intel_pstate: Remove
> > max/min fractions to limit performance"), and hence, percent_ext_fp() is
> > unused since then.
> >
> > make CC=clang W=1 points us those unused functions:
> >
> > drivers/cpufreq/intel_pstate.c:79:23: warning: unused function 'percent_fp' [-Wunused-function]
> > static inline int32_t percent_fp(int percent)
> >                       ^
> >
> > drivers/cpufreq/intel_pstate.c:94:23: warning: unused function 'percent_ext_fp' [-Wunused-function]
> > static inline int32_t percent_ext_fp(int percent)
> >                       ^
> >
> > Remove those obsolete functions.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
> > ---
> > applies cleanly on current master and next-20201221
> >
> > Srinivas, Len, Rafael, Viresh, please pick this minor non-urgent cleanup patch.
> >
> >  drivers/cpufreq/intel_pstate.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 2a4db856222f..0e35dd247986 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -76,11 +76,6 @@ static inline int ceiling_fp(int32_t x)
> >       return ret;
> >  }
> >
> > -static inline int32_t percent_fp(int percent)
> > -{
> > -     return div_fp(percent, 100);
> > -}
> > -
> >  static inline u64 mul_ext_fp(u64 x, u64 y)
> >  {
> >       return (x * y) >> EXT_FRAC_BITS;
> > @@ -91,11 +86,6 @@ static inline u64 div_ext_fp(u64 x, u64 y)
> >       return div64_u64(x << EXT_FRAC_BITS, y);
> >  }
> >
> > -static inline int32_t percent_ext_fp(int percent)
> > -{
> > -     return div_ext_fp(percent, 100);
> > -}
> > -
> >  /**
> >   * struct sample -   Store performance sample
> >   * @core_avg_perf:   Ratio of APERF/MPERF which is the actual average
> > --

Applied as 5.11-rc material, thanks!

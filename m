Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB31BDAAC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD2Laz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 07:30:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40706 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgD2Laz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 07:30:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id t199so1461892oif.7;
        Wed, 29 Apr 2020 04:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heSLd4npprlNejenb5g45wkQja+dNAq9zzOcbGYSaDc=;
        b=WnjWbi3/V2pjffEx2+R4V6Llf7vZNCwlWzTK8tTRktZTEohSbxSafSYTz3Dh8O0C7c
         Zbfl+nPHx2ZnpvtLIeM7/AWRE2Bli79IenKso5MhO3rwCJGp+ka9f4xW7HMVbmbYyi/+
         ZUWAYm9SmVRh3I7hopGRlCfEa6JsjTZrpf8l9PCl4hO2yT5QGqYRAMJXeBLYia33MpHJ
         zEaw/UqgFOGXMsryhAfrtQK/L+SRzJB//CmQhH5c2ATnEQhkBj1fDkkm3zi+imPNGIzW
         oX2kbORf6wPhlqahqUkBAqsqUdRUAep8LbeyohPmAtJGGW80HxN4XPGxtaDtQP6OO5bN
         m1cQ==
X-Gm-Message-State: AGi0PuYMHY3idDJXetPKuqRjvv9lD5Kmb3Ud4CBOjs67vgJ4SRFwXRfl
        pKZoecjqIqzyAIhgtNQPAx59tBXzdCNCst1thL4=
X-Google-Smtp-Source: APiQypL2VJCwN8MUXctgcgltHppclMxwktU0GxZbf5xmOkgYPSjcfg5KRmGgzF7wKzviwEGyKJ4dDwf4LmIZiY4bQcY=
X-Received: by 2002:aca:c441:: with SMTP id u62mr1351091oif.110.1588159854355;
 Wed, 29 Apr 2020 04:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200428132450.24901-1-ggherdovich@suse.cz> <20200428132450.24901-3-ggherdovich@suse.cz>
In-Reply-To: <20200428132450.24901-3-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 13:30:43 +0200
Message-ID: <CAJZ5v0gQ8zJfeeyqH=GK=VFb=_ziGX1NgFnTGH1G3uqz5Yqb6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, sched: Bail out of frequency invariance if turbo
 frequency is unknown
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 3:25 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> There may be CPUs that support turbo boost but don't declare any turbo
> ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> scale-invariant calculations can't be performed.
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/smpboot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 4718f29a3065..ab2a0df7d1fb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1991,9 +1991,11 @@ static bool intel_set_max_freq_ratio(void)
>         /*
>          * Some hypervisors advertise X86_FEATURE_APERFMPERF
>          * but then fill all MSR's with zeroes.
> +        * Some CPUs have turbo boost but don't declare any turbo ratio
> +        * in MSR_TURBO_RATIO_LIMIT.
>          */
> -       if (!base_freq) {
> -               pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> +       if (!base_freq || !turbo_freq) {
> +               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
>                 return false;
>         }
>
> --
> 2.16.4
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC22DC7B
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2MMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:12:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35862 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfE2MMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 08:12:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so1770931otr.3;
        Wed, 29 May 2019 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XjaYpK8Rsg46AR4Gtit0a5QnhHGfewPp+tzF3TFTKK8=;
        b=QfqcTP932tiOW4eCsLKgIS8SbhVqWpXSL0xLNpCWHkbyrnxW1VIuaXO7JRGGnSRBZF
         VWfI5dSN9JLGRyd8XBVr45CiSp99xIq1Kvo4jNN5R3eMyMcmNMbhLOR99gvb0eXYaX/+
         oA9KW0c1EM5p45jO/GNHMmmXnE6UZEUHOoIHrZztceSudZpwS9NGmoMkPE0UV5Bl8LUh
         KjyDQDxGYiom02p/1gZ1nA6qlgILkOSvSNK5VJ9ZX6phqvDpVtMIfS15BWMedFsahMHi
         Pz1ArK7I6XMPD4Soslb4KE640iZ/7/CxLt0Rf2UcdfZarBjuHEZhng8EMG4blY5QfKTI
         B3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XjaYpK8Rsg46AR4Gtit0a5QnhHGfewPp+tzF3TFTKK8=;
        b=QTVtSN28yKKmYpN7TN3/RnOgDWnhO6BrpAPkl8W+nlFC0T4QbWeFb5pUGnH6R8l6mA
         oQLZm0q3fj70f4XpeXoNs0Go+JDa3JOnXiDuZwcNOeFk5r1AwbZWdcq9nDKb5Dk/6/fQ
         czVw2lJ+5lIRF9wE9dso6+hlYEsDy2+PPJ7loKAbmu7FjhtIFfBRXdzX+9MFTKjUnGl1
         nTlOQL1rduMCHDpsa72SFRzzGGiTozRlgB9JmrcnBV/2ZOBqTqx9/SSF9lP7tsAZluAL
         BHyXx0ZJSvwpokZRcCbEedMg7l/kK6okTJZOZg5n5UPlhy06Evme6I+vmzbENWSB0a7W
         eXEQ==
X-Gm-Message-State: APjAAAVmuRisOgwve+B16e9jG8F9r0YgEeD214pecS/j6A9XFpoBgaus
        UebMhRpxoeu27Znjl9vjYkhEUQBVP57ZQYeFRUM=
X-Google-Smtp-Source: APXvYqwqXgO6Nr1j5LgxSA44mlg7nIFGhe5cAirmiZcDAqDrRjRpU8hCTqBPRbJrd0d4aa5w6Ogzuu9pDnv/wdqByjs=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr54132otf.162.1559131965416;
 Wed, 29 May 2019 05:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190529093033.30068-1-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190529093033.30068-1-huntbag@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
From:   Gautham R Shenoy <ego.lkml@gmail.com>
Date:   Wed, 29 May 2019 17:42:34 +0530
Message-ID: <CAHZ_5Ww2fMBGUR4gzNRZs-uV16j-hAevxT-vbNULRPsmKA7dow@mail.gmail.com>
Subject: Re: [PATCH] cpupower : frequency-set -r option misses the last cpu in
 related cpu list
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     trenn@suse.com, shuah@kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

On Wed, May 29, 2019 at 3:02 PM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> To set frequency on specific cpus using cpupower, following syntax can
> be used :
> cpupower -c #i frequency-set -f #f -r
>
> While setting frequency using cpupower frequency-set command, if we use
> '-r' option, it is expected to set frequency for all cpus related to
> cpu #i. But it is observed to be missing the last cpu in related cpu
> list. This patch fixes the problem.
>
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/cpufreq-set.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 1eef0aed6..08a405593 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -306,6 +306,8 @@ int cmd_freq_set(int argc, char **argv)
>                                 bitmask_setbit(cpus_chosen, cpus->cpu);
>                                 cpus = cpus->next;
>                         }
> +                       /* Set the last cpu in related cpus list */
> +                       bitmask_setbit(cpus_chosen, cpus->cpu);

Perhaps you could convert the while() loop to a do ..  while(). That
should will ensure
that we terminate the loop after setting the last valid CPU.


>                         cpufreq_put_related_cpus(cpus);
>                 }
>         }
> --
> 2.17.1
>


-- 
Thanks and Regards
gautham.

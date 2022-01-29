Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A885B4A2B8E
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 05:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbiA2EKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 23:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiA2EKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 23:10:42 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B0C06173B
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 20:10:41 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id o9so7696325qvy.13
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 20:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4Lf1TnT0Pcqk5oV6l/C2rZINNCB+v1VbsrorTZOtDg=;
        b=vcjmUBT7vZvEQ7XtlY/4gJrb0jglLdfakbX7LrVnurEzO0sqHYKFJvXNYrNXyDPEIA
         G4EGCvlJcNWco5/C2kplbki1UUQTxytOednDDSBUqNuWzDtkVurlHBQOT8diuVWRTZ/V
         zt0D+EZY3OkELZJZbvsanu4yvJ/3ANkvMZcSifg0z2RVHRdjMp7h1UWnfyUt5MRmm7yk
         mTrhrU/gti/5EA/1ZSH0gd7aVZ15dOXah9SCmRx8diErLXLRBO+gticChqxiIhaV06V5
         NpMoc3wRuLMaoZaNRIDTBOvqnvrKL2ep/DgJ6GDSRboqIP4blNybARndH7YF2psnSJXK
         8Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4Lf1TnT0Pcqk5oV6l/C2rZINNCB+v1VbsrorTZOtDg=;
        b=RQj3senZkiHcEto9gumkgXFuC2sjih5QHP/Z0BtlNIlvOuhBwa8z7Y3e+KryYfuuu4
         XI3kjTD5wnvEb1tMOeG8GKOEpj9jp0RRCby6Z3sphOMfIKJSjUiU6zP/CL5jDLYdmVjJ
         SledH6GC/RG7dWw8C96oQGxV6zwWPY3VtBJdPKFP3ur/idCcqzZ78aQxmenmXDsq6mRA
         BOne4nxR2T5Ae3jRgP1HwhdIjBoh3O2TZtTHh9ZFkpZKdaxeDUE8/LjpnsrLT7cvPwQy
         BpbxMLNrXsY5gU5m8liQAQtf6iUozEnjVAv3jjqoEEKPMaD6v4pbZ2XBfMRSIh2fHPKW
         GroA==
X-Gm-Message-State: AOAM533/OpNyUTWY+0/5Z3rtIBovnZMmeY9uA/CatlpaL2nbWEp2gbyY
        VaucEKLO5pKmXFZRApjFnqnTb9rLPKkQjXlAyXyrAw==
X-Google-Smtp-Source: ABdhPJxitrKVz1BvX4K8YA0JPZ7P1zLYokkrXpyfe5xR/tkBJHMB25GhyiBNaKQ7hs+jrRuRypQ0wpbQjhH0W001FwQ=
X-Received: by 2002:a05:6214:29cd:: with SMTP id gh13mr9811402qvb.122.1643429440974;
 Fri, 28 Jan 2022 20:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
 <20220128161002.2308563-3-bryan.odonoghue@linaro.org> <CAA8EJpqvDqTH3+ATsdC2pwtfT-OWpLNSUgOPmeU_Tpu8Uqa1+g@mail.gmail.com>
 <251a8515-7f8d-2535-e222-17443266f275@linaro.org>
In-Reply-To: <251a8515-7f8d-2535-e222-17443266f275@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 29 Jan 2022 07:10:29 +0300
Message-ID: <CAA8EJpoSjaMsYn42X9arPQan-8Ex6LFJf4ZKQMmyts3J7VTcyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: msm8939: Merge snoc and snoc_mm
 into one
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 29 Jan 2022 at 02:23, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 28/01/2022 22:24, Dmitry Baryshkov wrote:
> > This would lead to higher frequencies being set on both 'normal' and
> > mm snoc clocks, thus (possibly) increasing power consumption.
> >
> How so ?

If I remember correctly, bus clocks are set to max(sum(avg_bw),
max(peak_bw)) calculated over all bandwidth paths (nodes).
If you merge snoc and snoc_mm, the resulting sum(avg_bw) would be a
sum of (older) snoc's and snoc_mm's sums.
Thus the bus clocks (both bus and bus_mm) would be set to higher frequencies.

>
> There are four clocks
>
> bus
> bus_a
> bus_mm
> bus_a_mm
>
> The last two clocks
>
> SNOC performance points are
> 0 | 19.2  | XO
> 1 | 50    | GPLL0
> 2 | 100   | GPLL0
> 3 | 133.3 | GPLL0
> 4 | 160   | GPLL0
> 5 | 200   | GPLL0
> 6 | 266.6 | GPLL0
>
> SNOC_MM performance points are
> 0 | 19.2  | XO
> 1 | 50    | GPLL0
> 2 | 100   | GPLL0
> 3 | 133.3 | GPLL0
> 4 | 160   | GPLL0
> 5 | 200   | GPLL0
> 6 | 266.6 | GPLL0
> 7 | 320   | GPLL0
> 8 | 400   | GPLL0
>
> Its GPLL0 being set, the snoc_mm clocks really just map back to GPLL0



-- 
With best wishes
Dmitry

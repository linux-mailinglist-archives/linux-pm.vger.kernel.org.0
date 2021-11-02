Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676AC44341A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 17:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhKBQ5v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 12:57:51 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42657 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhKBQ5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 12:57:50 -0400
Received: by mail-ot1-f44.google.com with SMTP id v19-20020a9d69d3000000b00555a7318f31so18758998oto.9
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 09:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To6Ko6Gb52pzhxdQAB06u40uOhTDZbJPfaxQ9g15+Zo=;
        b=yxZRrKXqS5KsAjp3gldqhIxVxDtzwsiQt8W06bMiSwk90Swa+Aw8WaAdkxNblMkvWT
         /AaE3GiIsuFlnkX3sfOHMc93p0NK96jz7ZdtSf54LysWhEXZ0yO4ois4T0SD2a3aKfTh
         6byipt5zSbm7Js8jNTuUlBQ3uXY0CBBMohNm4EUkcATqYsBczvdVfpZH39Jv2BFaoeAZ
         9yJFYW0o1JO61FqVRwUgIiOReVuRQLh0zmhHCPHUqrfsRYOvfTvEvHIa+w0v5huIPXft
         OluAWfgABk4yJVy5in/qV/oTtg/9K+IARpJFYgpq5qLfqo+SmWSLhV6Hjaa4tV1geuqr
         6xYA==
X-Gm-Message-State: AOAM530reRZUqQVrIWun4ipg6CHCFv9f+ZyNpNz2zTBUkR3CVZ4XuNMq
        FXOaG5wiM+N3mbiiGnfLgY1Jlf76DBXgc4t5LTA=
X-Google-Smtp-Source: ABdhPJy6KqWsBfr0nBtiN95IxfF1h68lyAgkrRLFMhi4QDss4cUv/LpIdV1Zl0PRyAhe/v7RiDTKgFQC13K895CYeBM=
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr11147573otu.254.1635872115278;
 Tue, 02 Nov 2021 09:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211102035847.52yvfw4ywbxrtqhf@vireshk-i7>
In-Reply-To: <20211102035847.52yvfw4ywbxrtqhf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Nov 2021 17:55:04 +0100
Message-ID: <CAJZ5v0inzRNAU3SAFahmobEkudHgzRETWHPZED4jgcBFN9S5Xg@mail.gmail.com>
Subject: Re: OPP updates for 5.16-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 2, 2021 at 4:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Fix return value of _opp_add_static_v2() helper (YueHaibing).
>
> - Fix required-opp handle count (Pavankumar Kondeti).
>
> - Resource managed OPP helpers, type update to
>   dev_pm_opp_attach_genpd() and update to their devfreq users, and
>   minor DT binding change (Dmitry Osipenko).
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
>
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 7ca81b690e598fdf16a6c738a466247ef9be7ac7:
>
>   dt-bindings: opp: Allow multi-worded OPP entry name (2021-11-02 09:25:05 +0530)

Pulled, thanks!

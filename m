Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAEC2D30BF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgLHROs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:14:48 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36016 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbgLHROs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:14:48 -0500
Received: by mail-oo1-f66.google.com with SMTP id j8so56689oon.3;
        Tue, 08 Dec 2020 09:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjn7ENoQqrYSXRLrl/wMY90f6nn1P7GX4qELPCsk/Y8=;
        b=UmW3rj95Llnp/GCbgEuBpCxxLRDbwOwsKZE/TorI4DmPVGL46spBQShuc/MBSJ8wcL
         f8QRyxwRTuJ5KeUJnWBWDPgtpYG4wVbA4iKmJV8J7WMW/SWblRpZKnyraYs5vsqShm4R
         s00DuAEwG10leu7PRJsLEl5aDtYQCLce9RsxMydykoG1oNgGZUdAeER5s67szmTD5sBL
         /Qi11PbHVRg9Wg2IsW4G14tx2G/wldN4etazEk+iUsdnfE5RjQQQwf5/uLV2LDNXouMZ
         e76QYd33C/l3cck7cJcCgQx+uCK3AQS3siSTHXo++8B7/0XvabekiJ3qtT5TI1BZ4m8X
         ijYA==
X-Gm-Message-State: AOAM531CaZq9Vmqa6bhjYZTD+1XKIRWLE0a4CYEvMGO/ywsL/a8ykym9
        /ig0zDDEf3jdBjYIoq4vkz2PFKo8SemzJusBK+XDT9+k
X-Google-Smtp-Source: ABdhPJyJZiKtd9SkK9eAON4ljKf2z7jyUuSwud6szg2JQ/ZXGtiaB9MuLKsISoRl57PElSyUAw3KqefS3Jb8EMMPqPg=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr3338555ooi.44.1607447646975;
 Tue, 08 Dec 2020 09:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <1607445035.2673.64.camel@suse.com>
In-Reply-To: <1607445035.2673.64.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 18:13:56 +0100
Message-ID: <CAJZ5v0j2u7MrO82+ubx01kvyhDUKo11mfyofF-TAqdSLx_i3Ng@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpufreq: Allow drivers to receive more information
 from the governor
To:     Giovanni Gherdovich <ggherdovich@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 8, 2020 at 5:31 PM Giovanni Gherdovich <ggherdovich@suse.com> wrote:
>
> On Mon, 2020-12-07 at 17:25 +0100, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This is based on the RFC posted a few days ago:
> >
> > https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/
> >
> > The majority of the original cover letter still applies, so let me quote it
> > here:
> > [...]
>
> Hello Rafael,
>
> I'd like to test this patch, as I have concerns on how it performs against the
> current intel_pstate passive + HWP + schedutil (which leaves HWP.REQ.DESIRED
> untouched).

The performance will be worse in some cases, which is to be expected,
but the point here is to counter the problem that in some cases the
frequency is excessive now.

> I'll get results within a week. Do you mind holding back the merge until then?

Sure, the series is still under review.

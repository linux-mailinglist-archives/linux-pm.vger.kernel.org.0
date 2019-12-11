Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D907F11A901
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLKKgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:36:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46877 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLKKgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 05:36:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so12747844oii.13;
        Wed, 11 Dec 2019 02:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzWfsrctS/OvrNmJWRtq7fIkwpfX2ax0AgvptVC1CZo=;
        b=nP6gxFp6fEgly+i0Ii92w+mQwYO8yzXFQNWVD9Pkavjy6qHgBUOK54NFG5kvDJ8oKK
         gnxouNsClmUVImjMZzqLwAT8bt91zsyu1QNv381FR4v99tQftLvaM/OHlutmEXIfm5+a
         8u8ICsUhsqsMiTFUIsx9OdDpIAEbBHOYHAiZhm23h2UoAeVf1zTMYZcz0fUJJZAdxCiB
         NFiHMbE4RDiWkqR0VNdIPlndEOdRn8GZw9VQUQCjTVgi8H98xb4XDIiY5iDKQnYP3eRC
         p2zNYvTxv/jGe3k+sNpxUJKpoJ1Tt47/VndQK5YNy3cYzV/Re55CTKwsLalBt9CT1ZOy
         B/LQ==
X-Gm-Message-State: APjAAAVybuyTFYrxNwM3x1tVxPjxzCSB8SwRW9g0krFaegsguAU3CjDk
        nXiQOGEVZlEuzkQKFzPBOzdW1ZsjS64Ax1oGb1LGcQ==
X-Google-Smtp-Source: APXvYqy8VTgCiy2+jbdGNGtPRDWAvsLcAYmxtMyXUQoncoLKYGdrusa8xv4mynzHPPBJH7OksMSLazUJIuVwwT++IAw=
X-Received: by 2002:a54:488d:: with SMTP id r13mr2056650oic.115.1576060570368;
 Wed, 11 Dec 2019 02:36:10 -0800 (PST)
MIME-Version: 1.0
References: <9680649.eAqxiQ8Vpk@kreacher> <744357E9AAD1214791ACBA4B0B90926377677DF1@SHSMSX108.ccr.corp.intel.com>
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926377677DF1@SHSMSX108.ccr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Dec 2019 11:35:59 +0100
Message-ID: <CAJZ5v0gr=ja9qvnS-sGbaoh7cgNhccAMxmj0JPyfpF+ErxwSAg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Drop unnecessary type cast in cpuidle_poll_time()
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 11:33 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Wednesday, December 11, 2019 6:31 PM
> > To: Linux PM <linux-pm@vger.kernel.org>
> > Cc: LKML <linux-kernel@vger.kernel.org>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>
> > Subject: [PATCH] cpuidle: Drop unnecessary type cast in cpuidle_poll_time()
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The data type of the target_residency_ns field in struct cpuidle_state is u64,
> > so it does not need to be cast into u64.
> >
> > Get read of the unnecessary type cast.
>
> s/read/rid

Indeed, thanks!

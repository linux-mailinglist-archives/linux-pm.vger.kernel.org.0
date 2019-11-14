Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61384FD1B2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 00:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKNXvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 18:51:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37013 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKNXvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 18:51:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so7037903oie.4;
        Thu, 14 Nov 2019 15:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHfMiUUVf21vrOAowS60/ZyQjI/GeiFC0sX+7phyAMY=;
        b=tvwCSV+VIISIAL+JVAp/7y1AL2NrYvTJpdTdzUZTzT/6heDLvYCY0f3HWs7bgjHM0k
         ebg2/0zkV6HjGFDAccFRhL6o1jBC4UEppH4qjUKKsntXKtkieSqy5cxfufRxDJ4SJn0f
         D8JGw7yQ+1CxUIuCkfL/2yjRbV4DpMwY4hwtCY/JLCqDGb4zH49BcBLl2ZRSSrjFzCtE
         88wSeIB17ELoIpoTRLAqDfXAMcmfwkacj/J2Im2YfKcGVIy/tYyGlRPIwW1TlWEt5PSg
         3KiTqAeyIeHH/RyRZNDopVl9Zs1ee7mfET9csqLg1TVpXI+NtuGJz5cYvTQqHCH7CcsU
         ejSw==
X-Gm-Message-State: APjAAAVfBagE0Sh708XQB6TQdCZF8Z9iPlVKrmbwyHBi9knCDjkt3uba
        9xB0+brnPa11/Q5XiEw7QEPhoAJWoeJ6FxFEkX7crA==
X-Google-Smtp-Source: APXvYqz1oz0mGhNU9dC3k2Q8lD0sWp3lWMkzNAFTfTfJNvknNCti3JvLc3oylbZtTJE98bbXhyca2OB2X5JMKiJFrL0=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr5510309oig.68.1573775471571;
 Thu, 14 Nov 2019 15:51:11 -0800 (PST)
MIME-Version: 1.0
References: <13588000.TfE7eV4KYW@kreacher> <3144686.I8R4d9A2JO@kreacher>
In-Reply-To: <3144686.I8R4d9A2JO@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 00:50:59 +0100
Message-ID: <CAJZ5v0jiBrx2xxf2EdvGrqke0ByK5YWXEw0R2rpHZYAJjgwJmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpuidle: teo: Avoid expecting unrealistic idle times
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 1:11 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If an idle state shallower than the one "matching" the time till the
> next timer event is considered for selection, expect the idle duration
> to fall in the middle of the "bin" corresponding to that state rather
> than at the beginning of it which is unrealistic.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -360,7 +360,14 @@ static int teo_select(struct cpuidle_dri
>
>                 if (max_early_idx >= 0) {
>                         idx = max_early_idx;
> -                       duration_ns = drv->states[idx].target_residency_ns;
> +                       /*
> +                        * Expect the idle duration to fall in the middle of the
> +                        * "bin" corresponding to idx (note that the maximum
> +                        * state index is guaranteed to be greater than idx at
> +                        * this point).
> +                        */
> +                       duration_ns = (drv->states[idx].target_residency_ns +
> +                               drv->states[idx+1].target_residency_ns) / 2;
>                 }
>         }

This change turns out to cause the governor to choose idle states that
are too deep or too shallow too often, so I'm withdrawing it.

Thanks!

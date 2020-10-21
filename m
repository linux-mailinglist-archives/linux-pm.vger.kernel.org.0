Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD857294AC4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441507AbgJUJvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 05:51:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46997 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409054AbgJUJvk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 05:51:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id l4so1437240oii.13;
        Wed, 21 Oct 2020 02:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHwcObPuWf2kMl9N8xINOLanTJv1EDYL2WCahfPUuSg=;
        b=CkgkjhUOGkzvYEadCdIes8jCvHNddDHkd0ChDois8J5jURx0RlpOYG/57KjBmYj86L
         oEsRRvHNAd8JpCaObfby7MKSGGpne63hfFVnrfHuK2TM0TYIDY8T8b578h+wg80A7XBM
         LOnSiESQfRO8yG4tE8d4XJU4SZCcRh6M2VXXX4KZsquU1mqLUYlagbpiCiEwUoF5rsi+
         r09VbIClHvT/rAp10hXDjy4KAub4Yo2p1UXKaIf01qZot1wiLLwwtGSb2oTXTuDpKHoM
         0lXgdmn2EcfsP6ndTNw5fH9ErixlROo3Bx0aqZSOhpa08cOA1doAHlYHDejWf/Ay4TdU
         aFwg==
X-Gm-Message-State: AOAM533J2N493andyHxg2ToQJfw1iEyWp4LXAh0lzvQCP2abspsFlQaP
        9cX74RYcSEY5h1ZMbY8NoladEjEdOFrufWfCluA=
X-Google-Smtp-Source: ABdhPJzzVmJGhYxpqlx3tO8gD6zynDrvHEkDFMkcfmY5gW+1Q/gFOtgY3QaC8yuWY+fPgQwFCgRnEnh44A2ZnSft1n0=
X-Received: by 2002:aca:724a:: with SMTP id p71mr1640718oic.157.1603273900242;
 Wed, 21 Oct 2020 02:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201021020947.2069441-1-josephjang@google.com>
In-Reply-To: <20201021020947.2069441-1-josephjang@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Oct 2020 11:51:29 +0200
Message-ID: <CAJZ5v0hBkJ5VMQ1PYg7n=kdrwx1s3nMXN95coKfmMDsg4F=L2g@mail.gmail.com>
Subject: Re: [PATCH v2] power: suspend: Replace dpm_watchdog by sleep timer
To:     Joseph Jang <josephjang@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 21, 2020 at 4:09 AM Joseph Jang <josephjang@google.com> wrote:
>
> Since dpm_watchdog just cover device power management, we proposed sleep
> timer to cover not only device power management hang issues, but also
> core power management hand issue.
>
> Add sleep timer and timeout handler to prevent device stuck during suspend/
> resume process. The timeout handler will dump disk sleep task at first
> round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SLEEP_TIMER_TIMEOUT.

Let me repeat the point that Greg has made already: Please don't
replace the existing watchdog with something else, but try to extend
it to cover your use case.

As it stands, the patch is not applicable IMV.

Thanks!

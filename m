Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4228B242
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgJLKbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:31:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44126 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgJLKbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 06:31:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id x62so18209939oix.11
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 03:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVWp/Q4Y06s9l9IsSXNdU2diHV6oPXkJE9vei1JyoKg=;
        b=WvxYwBGCVkp2E58JG4j0ZsWYkapxv3zz6gkT7SQ5FH4FWkwLD38MgybCMxkdSF/Cx0
         Ulj3Mtkboo2TpmZm5uhF2EC/8rM+Zfti3ZvMd2g679gwqlRN9ruEKRZjy1+De5Mgt3ku
         qN5NSwbn0tIkYMUTCfbykydvrI+CP7M18jj7JabKDOpjWQLy7AUAZuwfC9wet90VLVf8
         7SycWdrS/mCIve8ShG/cinXhOF5s9EWfBm5AqxzFCiO3GDAVJwYItcvhpvZTllKUM/X+
         uuRrDs3RUa1my3T0DCTyI1H/6Y5hwVMgFkAIkzOdoxsBejdabhU1DIsHHYea8wmfwG0H
         BO/g==
X-Gm-Message-State: AOAM533DFuFzeboPOCG7wprCM1QWxqhh4tFV2baZ3Gv1CzVe5AyqS/vn
        ODMz94L6emOhZjjiIe2CjABYDh2Lk5n820jVW0U=
X-Google-Smtp-Source: ABdhPJzLIBydeKdh5a/2NqYUc8RszWA1m/FeP6ClvZwRXS0a5ivE2moxoMOPbQSev20PsRUl3EfK/quMK2NyYr1I9tc=
X-Received: by 2002:aca:724a:: with SMTP id p71mr10555025oic.157.1602498677060;
 Mon, 12 Oct 2020 03:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <1602461364-17300-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1602461364-17300-1-git-send-email-jeff@labundy.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 12:31:02 +0200
Message-ID: <CAJZ5v0jmnWxnpwHEV3k04_v4YV+oOAm7JE3OyMbKe-K18x8OsA@mail.gmail.com>
Subject: Re: [PATCH] PM / sysfs: Add the ability to call PM operations manually
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 2:09 AM Jeff LaBundy <jeff@labundy.com> wrote:
>
> During driver development, it's useful to be able to call a device's
> suspend and resume operations for test purposes without having to
> involve the rest of the PM subsystem. Such an ability would be handy
> for measuring power consumption, checking interrupt function, etc.
>
> The PM subsystem does have debug hooks for limiting the scope of
> suspend or excluding devices that shouldn't suspend, but there can be
> overhead in configuring these hooks that is often inconvenient during
> early bring-up.
>
> This patch introduces the pm_op_test attribute, to be used as follows
> (random I2C client used as an example):
>
> 1. echo 'suspend' > /sys/bus/i2c/devices/1-0044/power/pm_op_test
> 2. Measure power consumption at one's leisure, check wake-up interrupt
>    behavior, etc.
> 3. echo 'resume' > /sys/bus/i2c/devices/1-0044/power/pm_op_test

This is utterly incorrect.

In general, the suspend and resume callbacks specific to system-wide
PM cannot be executed in the working state of the system safely.

Thanks!

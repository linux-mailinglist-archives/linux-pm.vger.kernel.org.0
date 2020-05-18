Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773901D7419
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgERJcU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgERJcT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 05:32:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A80C05BD0A
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d191so8395018oib.12
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=p+4e8OGbkl4jtB21Kp0Taies1F3UglkyxEVlBRQUQ1JCB7uuaBDtommPyyPp+nFWc3
         1Xguh2oulhrEM1GT03E7NzWVydFgKZNO9PxIrx2t4zUNhN2e2Yzekzb5Kd8ItHWtaWJ+
         DJRzZRP0Zod3TVkJ8lxGJbG7FIMvQZ7pP+Yi5IcziQk+yOTY+8Ijv+n/4M4sTFnh95o/
         YyGb1xwUv7sa8c9Jbj4KOSqiGGjhEjVMmHGmH4kDJ/f+dly1SZSizUV2p+nmhaft5URq
         EUcitTFvt2xe/bdolmFD5KvRRInAoLbZB0WCOCNiPysMYx9wph5eWaErFcbLXSzPw6Y3
         SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=iOoxTXE+Xuqg0msQjsoOrFlSzSgsIsXQCVY+R+E5+rI7obtpRYxT9twTC7gdlbzBWt
         3UeveiIMug2577e0H3IplDp8glz4vkQMW3L1ox/bDNylNVnsZVk2VwZKO0QG+1mQx1+3
         FTEPu67AlsCis7UEHZsWfn44Uh3FhZWxJ5qR2z3duWMQCLI8JDYZWLWwBwD+OdEtPfDP
         KX798/T9Y/kHfE4NQ8200m8EJZ5lgCCJN0N62w22psIXMlMUvOpJjCRa8V1NHQvQzsFe
         eUI0glsxOsBGxKpYsPShlox6UwJRM0gsJsz341bPwOOu73XP/UfytSuLvpTHRtVMwI0T
         H3sQ==
X-Gm-Message-State: AOAM532EGoMXhxgM9mfInOuNenEKZ4PZ5+BBx+DMGi3Kzcc2Twk/sDp/
        wqRLOXeHcd8O6HQIR3QieiWhsHCg3TWIImPpkjnXyQ==
X-Google-Smtp-Source: ABdhPJyrEJAISIZWsXEyVlyc4BlPLuXVfhVNfJE1HrEOPfH8Lbw8GOfGkNCHlNzM0DGX7IOc1TiEmiYBdJ1xs3xDRQ4=
X-Received: by 2002:aca:ea46:: with SMTP id i67mr9709314oih.152.1589794337493;
 Mon, 18 May 2020 02:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher> <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 18 May 2020 17:32:06 +0800
Message-ID: <CAB4CAweV+U_pPv9877S+j6UVUPjcTzJq26rarxnJfwc6on1ESA@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 18, 2020 at 4:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Flushing the EC work while suspended to idle when the EC GPE status
> > is not set causes some EC wakeup events (notably power button and
> > lid ones) to be missed after a series of spurious wakeups on the Dell
> > XPS13 9360 in my office.
> >
> > If that happens, the machine cannot be woken up from suspend-to-idle
> > by a power button press or lid status change and it needs to be woken
> > up in some other way (eg. by a key press).
> >
> > Flushing the EC work only after successful dispatching the EC GPE,
> > which means that its status has been set, avoids the issue, so change
> > the code in question accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Chris,
> >
> > Please check if the key press wakeup still works on your system with this patch
> > applied (on top of https://patchwork.kernel.org/patch/11538065/).
>
> Hi Chris,
>
> Since I haven't heard back from you and the problem at hand is a
> regression on the machine where it happens, I'm going to push this
> patch for merging.
>
> If it causes the key press wakeup issue to reappear on your machine,
> I'm afraid that we'll need to quirk it in the EC driver.
>
> Thanks!
>

Sorry that I missed this email. I'll apply this patch and test again.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F522843DF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJFBrP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 21:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFBrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 21:47:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9473C0613CE;
        Mon,  5 Oct 2020 18:47:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so11110219ejb.6;
        Mon, 05 Oct 2020 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwV09/w/RjxBfz8l5wIfRzn/NkiJgzZyHVb8PU5aPKc=;
        b=XBD+nkpC+gN+dhdYzuY0IosVUQQMvXWIT4hMmWDJGgdGIiT8gchvbbEe3nJelN3V5F
         7FPqoEbSPVlWsEP3d2hoDbJoAXN65CycixLYsWa5WOyKfnU0/y0zU8uM0US6eaqeUSuq
         xTZJUwHvmbmBsugBu7iXe5a90/ZByVMh7Rv1EqgsVlMhePaOzjdVS4uNzxfVboifP765
         rDhYApcDY4HpHORiwTJvyBPnUBRWQ2N5bfRfb1KxiXkw4FR1VQi4lULVHJambHMrbQiZ
         FWJgFHA6ibN7/C9yQKYOQzRGl0Gln0kEdeu3Ph3AH+UScgR4LT6C6U6tkgrVTPwoFWun
         oACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwV09/w/RjxBfz8l5wIfRzn/NkiJgzZyHVb8PU5aPKc=;
        b=c43fNMo/Guvidf02Yb5la5oLtQMVWVUcfzJVTYjm/qJKd5AIbyBOwKnZ+pLVCHb4y4
         5QDowOy3RwpewRgzxDt9TUQBjBsjvKq4N4LGDEm5bCYypPQXjm5JhfEYAINAHfuyJ2/C
         AAGEGUvfxpGekt2cGdF+FTgBY8oKp4xTX+zRHQFhGS/3GVm7DO25Mc/7do47tapBfPGJ
         LWehLFokV17lMmNe58+yUreCpC5bf6C4pdVweh2mCvZ+8N3GHoloO7/nQT4VsKIMxMX2
         +nngL5wv9BVLo833L6bO/77mZCDDyxtbbvSblQ+wF5n8DWYm9yJyakroFKtSo0A5dlYE
         DnIA==
X-Gm-Message-State: AOAM531Qq4fmmRx6nCVRA6AxnSUBarRcXWsW81dBM13Vn27gvd4wZX2j
        Q4eiwdkuCU63ErQaZ3hEkUwYkZecpIX3kedZErE=
X-Google-Smtp-Source: ABdhPJzGaUJBfnhyfiAmVMJA9fZxeOWClmaZqreZTN3WSSqp8jg8groI8CWdu5H9A3KRycQX+9Bn0ZXp8TUHg1gMsIA=
X-Received: by 2002:a17:906:7254:: with SMTP id n20mr2599660ejk.382.1601948833392;
 Mon, 05 Oct 2020 18:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYrYdDYF_Y_TwQ65u=Ymu2_8Rs9KWm_TfXcaPGTwucT=jg@mail.gmail.com>
 <20201005222953.GD2804081@piout.net>
In-Reply-To: <20201005222953.GD2804081@piout.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 5 Oct 2020 21:47:01 -0400
Message-ID: <CAMdYzYpHxD4qSCM=-jhj0byBpoPv0LqBuCpkYH=QCX0NrvEAtA@mail.gmail.com>
Subject: Re: [Question] rtc wake behavior and sysfs
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        len.brown@intel.com, pavel@ucw.cz,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 5, 2020 at 6:29 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 05/10/2020 09:13:08-0400, Peter Geis wrote:
> > Good Morning,
> >
> > While testing suspend to ram on the Ouya, I encountered an interesting
> > issue with the rtc-tps65910 driver.
> > Attempting to use rtc-wake on the default configuration returned:
> > rtcwake: /dev/rtc0 not enabled for wakeup events
> > This is due to:
> > eb5eba4ef722 drivers/rtc/rtc-tps65910.c: enable/disable wake in suspend/resume
> > This commit changed this driver's behavior to not enable wakeup by
> > default, but enables it when entering sleep mode.
> > This seems to be odd behavior to me.
> > Looking at a few other rtc drivers show they simply enable themselves
> > as wakeup sources by default.
> >
> > I also found the sysfs entries are at /sys/devices/ ..
> > /tps65910-rtc/power but are missing at /sys/class/rtc/rtc0/power/
> >
> > I have two questions.
> >  - Should the sysfs wakeup entries be missing at /sys/class/rtc/rtc0/power/ ?
>
> I would be in /sys/class/rtc/rtc0/device/power
>
> >  - Shouldn't a rtc be enabled as a wakeup source by default?
> >
>
> The short answer is no, the reason being that not all RTCs are connected
> to an IRQ or a pin that can wakeup or start the platform. What should be
> done is enabling wakeup only when interrupts are available or the
> wakeup-source property is in the rtc device tree node.

Thank you for your explanation.

So it would seem we have two issues.
- The sysfs wakeup entries are not populating in
/sys/class/rtc/rtc0/power when they are populating in
/sys/devices/<..>/tps65910-rtc/power.
- The wakeup-source property is not being applied to the tps65910-rtc
sub-device when it is applied in the tps65910 devicetree node.

Should wakeup-source handling be the tps65910-rtc driver's
responsibility, or is that a limitation of the driver core that needs
to be fixed?

>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

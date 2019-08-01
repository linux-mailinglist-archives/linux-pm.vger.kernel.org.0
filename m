Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59217D6F3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfHAIJf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 04:09:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33744 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfHAIJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 04:09:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so53240167oiv.0;
        Thu, 01 Aug 2019 01:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnrQp5j1m0yFk+XdNNI7T+UuldEPxUP37dAU4GQXquY=;
        b=YmOjuJQB5BoWZ0dvhzl9cd9RqUngcwaJDa1j+nUuc997r21zv048ssyh+nz1L2fCMP
         tWJEdcU7BQsPXaYr1ZP4J0vLW/6/9uBNibvOEtiriH08NzgHImccvaMOTYh+mW9Qy/kF
         49lsVribuZ/CCE68KzwwYnFQscDQt2zNF6kUhWwbpWXvgjLiSH0lV4M7FlEr7Qoa/eHY
         aMBBpKM088IujE5d9pXzNOzSbNfw9F0b2A4QsqNyeCRlDrHfwSQgXvhpV89fCzX1Yvhi
         ffSEmLE9iEVtG8qvO6MWO1OZSXxW78c2bSMKQbQOzF82Yl8VK++YE3Zt82zrGlOGpGhc
         wD+Q==
X-Gm-Message-State: APjAAAWc2wZsoAITkDS+bWURnx9ZeRmD4TfPQUOTkB8f0K9xdCwQwjhj
        CxMuJTU8CKgox3ebZ1aa60dP55O8DkpV+XTa8IE=
X-Google-Smtp-Source: APXvYqzw3njB9ouhlA9TZZ9d/96/mZWajsV43NsasZuiZZnxUQr6RbPGUXkds+37hfGpZV4wqdGAsFChtqmH9xAHMFs=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr62367385oib.57.1564646974249;
 Thu, 01 Aug 2019 01:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <5d423637.1c69fb81.62114.ca6f@mx.google.com>
In-Reply-To: <5d423637.1c69fb81.62114.ca6f@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 10:09:22 +0200
Message-ID: <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 2:45 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Stephen Boyd (2019-07-31 16:45:31)
> >
> > This approach also nicely detects duplicate wakeup source names in the
> > case that the string passed in to wakeup_source_register() is already
> > used on the virtual bus.
>
> This was clearly untested! Here's a better one. This is what I see on my
> device with this patch squashed in:
>
> localhost ~ # cat /sys/kernel/debug/wakeup_sources
> name            active_count    event_count     wakeup_count    expire_count    active_since    total_time      max_time        last_change  prevent_suspend_time
> 1-1.2.4.1       0               0               0               0               0               0               0               0   0
> 1-1.1           0               0               0               0               0               0               0               0   0
> gpio-keys       0               0               0               0               0               0               0               0   0
> spi10.0         0               0               0               0               0               0               0               0   0
> a88000.spi:ec@0:keyboard-controller     0               0               0               0               0               0           0
>                 0               0
> alarmtimer      0               0               0               0               0               0               0               0   0
> cros-ec-rtc.1.auto      0               0               0               0               0               0               0           0
>                 0
> a8f8800.usb     0               0               0               0               0               0               0               0   0
> a6f8800.usb     0               0               0               0               0               0               0               0   0
> localhost ~ # ls -l /sys/class/wakeup/
> total 0
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 alarmtimer -> ../../devices/platform/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.auto/cros-ec-rtc.1.auto/rtc/rtc0/alarmtimer

So why is this not "(...)rtc0/wakeup/alarmtimer" ?

This particular bit looks kind of inconsistent.

I guess without your patch you'd see "(...)rtc0/wakeup/wakeup0" instead, right?

> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup0 -> ../../devices/platform/soc/a6f8800.usb/wakeup/wakeup0
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup1 -> ../../devices/platform/soc/a8f8800.usb/wakeup/wakeup1
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup2 -> ../../devices/platform/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.auto/cros-ec-rtc.1.auto/wakeup/wakeup2
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup3 -> ../../devices/platform/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/a88000.spi:ec@0:keyboard-controller/wakeup/wakeup3
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup4 -> ../../devices/platform/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/wakeup/wakeup4
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup5 -> ../../devices/platform/gpio-keys/wakeup/wakeup5
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup6 -> ../../devices/platform/soc/a8f8800.usb/a800000.dwc3/xhci-hcd.7.auto/usb1/1-1/1-1.1/wakeup/wakeup6
> lrwxrwxrwx. 1 root root 0 Jul 31 17:43 wakeup7 -> ../../devices/platform/soc/a8f8800.usb/a800000.dwc3/xhci-hcd.7.auto/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4.1/wakeup/wakeup7
>

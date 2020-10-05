Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F367283656
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJENN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 09:13:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6173C0613CE;
        Mon,  5 Oct 2020 06:13:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so9267513edk.0;
        Mon, 05 Oct 2020 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d4eE4p3+B8xLEYjWkMENxr3kighOszJ8l95I4ulqQBU=;
        b=CUWdgsqpaVHkMUxSJagvGvjIaXWLvO6Gw78iwM00JIjl8bR576GAndbcVvtg9m5qK7
         XjN9p5XWyp0+8G5E9NfxwPqdjju1GHGjcxetCWqMW2frJd9mbOOlQmdGdd2R6T7TcLXm
         I2b6ZC6cfEsxttx9DOuDU4RC0lSK5cQ1Fk+uyMmTTf5QmHFbNAw8Pp1Bp7Zlzw53CeG4
         MjSD4QwtdbwhUTqOHkPdylhCpH9ytsrc8RDSPbgasXrKisjLh3xd+FpUFxTsn8grj9NZ
         ujjkVsv9tDPAjhX4cYhQavPaPvqRwFNIqZ11lag5RmgIOFMjxMiRUwiAGrMHXPSNvd8x
         1tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d4eE4p3+B8xLEYjWkMENxr3kighOszJ8l95I4ulqQBU=;
        b=fqvWUgi/Anp5YKhOcTJUp4pbJoN1RS2nEQcmGDGJDvhgQtSrkECqEbzLX9zKgtWl1s
         +vsI7HlC53pWg0gdO9j9H5hMu8ReDwHRQr5jE3Yc+C2L249z4YIFibegz++OV7q7rLOu
         ae6t7jcs19qhxmmYwXUPNbX+8gi4NsAPbYKXwE9AW63j2vrINcBEr8tH5QbFG0LM95/0
         5r8nKCDCc/QPSzHijcLviC6/E0QegZTvsvfYwWhA+hXlOoE62bd0ZFGilOMcn3NPHUWX
         lES+tEGIZMI54hI8vULHpKCwremtSPe1KcwUy07jbVvfQKvtN1pG4F/PdwFH55lqKMcr
         F6dA==
X-Gm-Message-State: AOAM533M7KA37UhMwv8XKCRlMMBOasiNUbLSJz9va8E5BkVT+ZMAKepo
        O77oqj22yKb8635DJE6RwJ6w26Yvag6dEZviMHM=
X-Google-Smtp-Source: ABdhPJztT80xgdZTWATqu2sjbwP0+IzNt4mBZ2D5udiHdWCMr7qGwJa9JKyLjIjFFtEbU2JV7gu1SfEdMj8tAe/PvC8=
X-Received: by 2002:a50:bb0c:: with SMTP id y12mr17418331ede.355.1601903600367;
 Mon, 05 Oct 2020 06:13:20 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 5 Oct 2020 09:13:08 -0400
Message-ID: <CAMdYzYrYdDYF_Y_TwQ65u=Ymu2_8Rs9KWm_TfXcaPGTwucT=jg@mail.gmail.com>
Subject: [Question] rtc wake behavior and sysfs
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com,
        pavel@ucw.cz, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good Morning,

While testing suspend to ram on the Ouya, I encountered an interesting
issue with the rtc-tps65910 driver.
Attempting to use rtc-wake on the default configuration returned:
rtcwake: /dev/rtc0 not enabled for wakeup events
This is due to:
eb5eba4ef722 drivers/rtc/rtc-tps65910.c: enable/disable wake in suspend/resume
This commit changed this driver's behavior to not enable wakeup by
default, but enables it when entering sleep mode.
This seems to be odd behavior to me.
Looking at a few other rtc drivers show they simply enable themselves
as wakeup sources by default.

I also found the sysfs entries are at /sys/devices/ ..
/tps65910-rtc/power but are missing at /sys/class/rtc/rtc0/power/

I have two questions.
 - Should the sysfs wakeup entries be missing at /sys/class/rtc/rtc0/power/ ?
 - Shouldn't a rtc be enabled as a wakeup source by default?

Thank you for your time.

Very Respectfully,
Peter Geis

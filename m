Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2563B1084DE
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 21:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKXUAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 15:00:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36346 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKXUAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 15:00:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id d7so5468060pls.3;
        Sun, 24 Nov 2019 12:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAkvtA+FujiuAlWNHJbFKlI8RrNl2D/+TL63UgwL7cI=;
        b=IQryhIVQL9nlTHi2qcxXLlvK01ioMZtLaMI5FtOHpmMl98yr5F2P2TWlqJSCf2puLv
         HTMA0XWVT0WNmlJT4oWQ98Ou4H0FEMaYqXSkahRVD1RT0O82g7n3gry64q8JyHIGB2C2
         fI2l8booR3+DTWhfSLbhPrge4nIHD2VVUrNi1sQKQrJjvMFg8k4xUY6uf+0PUgxpMmYu
         3agkNHi1TL2WVO+CnO8sQGVdsKh6pFkvUGpRtgyALeaRJ/jMP+cw220OdmO4+Yxc71k3
         Hefrtemkkfh1obEKv3TO8n22Gl9AM156hEmu2axAp2yHwuMSbITT6AH7d3PvyDIlRS4F
         tj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAkvtA+FujiuAlWNHJbFKlI8RrNl2D/+TL63UgwL7cI=;
        b=OgoVyfkL7vqaFhVg28CC2jSCaVZf1Y/TPCTxnX+w1IBsW8QnsdpczlAIaUkfFImRw2
         qOb9pBzVTaXHvCIz6bl+VmnYaiSRmX+cJbSmzU6tYV/8B4Z4nbZEBREnfb0FNJ/vJabR
         GTIMW38+zsnJr8DuILB09R/IF5iw0afAPWxQlL5S+LCqzEWADIRYbqEIkxvCYPM+sf4G
         KKSp2vEucocP2kQxHq5KPokNu4CAqfoTma4mRn7jkN5sXBIP4imT89AR50dsJRdZtpA4
         hTSddeKrW06qQx51gAK36m4f6XGygOaIX+Zan8bCQRJfqIiH9fozwdX1VMp73fucYCJr
         hRnw==
X-Gm-Message-State: APjAAAUnt9dPaI/CpTzO8CikAHtzcIK47GE4HSGnpAzxZ/pVuhFWeDq3
        isY6HkaVRG+fudyqgrnCQ15RTNqzoq7rOgd14Bw=
X-Google-Smtp-Source: APXvYqyeHqs18DrwoOZOMY+pvM9NcPjCohZteEBqokEPOIb2+8bN1DfF4b7bh4S7SnvP2Sp/XvVA8o0VXMPTvfCWANE=
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr25590236plp.18.1574625642136;
 Sun, 24 Nov 2019 12:00:42 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com> <1574604530-9024-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1574604530-9024-9-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Nov 2019 22:00:31 +0200
Message-ID: <CAHp75Vc6e8xq==QGtEX0MGLoV8QCGQf+vP0x-SauNHyjveZrnQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] thermal: remove kelvin to/from Celsius conversion
 helpers from <linux/thermal.h>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This removes the kelvin to/from Celsius conversion helpers in
> <linux/thermal.h> which were switched to <linux/temperature.h> helpers.
>

> DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET() is only used by ACPI thermal
> zone driver and the usage is specific to the driver.  So this macro
> is moved to the ACPI thermal driver rather than generic header.

I didn't get this point. If we split all helpers, let's do it for all,
and not spreading macro per driver.

-- 
With Best Regards,
Andy Shevchenko

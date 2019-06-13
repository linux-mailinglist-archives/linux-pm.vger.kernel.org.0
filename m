Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECA14466F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfFMQvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 12:51:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36026 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbfFMDbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 23:31:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so7479698plr.3;
        Wed, 12 Jun 2019 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nzGBiH9Q2cHj69v2s9SzWAcskIQxRVWhnxjtOISSfH0=;
        b=P3+W71Z7wOq9r8J9vPu4J49YzWsvoiYpKSpycf1qS/PpM52rE88Oag+c2qaNi7/2f2
         B2vFG4DCa0POM6uTUi0Zia+afz9c3sPd6I4KV5yof6kGAQs+wplvUjZPekYBSx5fGRfw
         +RgrUpwADxnUhYoWW4zzACqtWio9HSLHDq2kPVjGwEgfIL8KvX4tj4qgL7zEFUmbBbLA
         fAQqbaAXYmEZrxgMUCdtaTvmGUzPNRutOqnFkECRPCyp18KKI/5d5CCF2qMj488IJZb5
         eqs1bvGTk80kDWb/pJhk8MxZWrTH65Zeuptnjgmpmnl0K8snjNv/+SmrSTJJAwpKMh+1
         9A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzGBiH9Q2cHj69v2s9SzWAcskIQxRVWhnxjtOISSfH0=;
        b=L6Rh++OzU7tNRihLb7sEEh+hrmsbPkOp4SEq7wxe8o4t2zeHDfzQoyiNyP8sv41oQc
         9pQJlY1LrKqG+DCf5Tl+tFhVX6tPAey7VS7Z/UQQEWiU3N29g1XSK4A+Jv3HEPz/8NH+
         1924y7yx4BJXQNROdq1TJ7fPOAhtmIra0ki9JIp9djVcrrezN8HmwhPgJi3SF0CImB42
         xV5N/3KCooVUPRa3n6nxIWzm8GkHMvA0f8GhJod/cpftWuyi/AJCxgl7jAZpgte5YETE
         FckcSODYutKqIjfPWzmE5Xb0smDnhwmq6k1ZSnXtGDRLlY4Qss1rIrOIZpqPmXvCK0ss
         8iXg==
X-Gm-Message-State: APjAAAUTOe7xTpfil6hmfsBK1+hEHzzyPJH6CZiyE5lgQFkOYg6/Nnxu
        rlejrYtYWRrXe1N8aRRQ5ghLekJp
X-Google-Smtp-Source: APXvYqzWKE85pfVmqmvHVbcmT2pdlkwsEpSroa8BFRjBzzgBTWFi6CVwqLEqha4xH+IoiFuJd4jOMA==
X-Received: by 2002:a17:902:b594:: with SMTP id a20mr5329327pls.259.1560396714089;
        Wed, 12 Jun 2019 20:31:54 -0700 (PDT)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h6sm5445482pjs.2.2019.06.12.20.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 20:31:53 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] cpufreq support for Raspberry Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <6a9e1450-80ad-a13c-59d2-d0b39f25f67e@gmail.com>
Date:   Wed, 12 Jun 2019 20:31:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612182500.4097-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/12/2019 11:24 AM, Nicolas Saenz Julienne wrote:
> Hi all,
> this aims at adding cpufreq support to the Raspberry Pi family of
> boards.
> 
> The series first factors out 'pllb' from clk-bcm2385 and creates a new
> clk driver that operates it over RPi's firmware interface[1]. We are
> forced to do so as the firmware 'owns' the pll and we're not allowed to
> change through the register interface directly as we might race with the
> over-temperature and under-voltage protections provided by the firmware.
> 
> Next it creates a minimal cpufreq driver that populates the CPU's opp
> table, and registers cpufreq-dt. Which is needed as the firmware
> controls the max and min frequencies available.
> 
> This was tested on a RPi3b+ and RPI2b, both using multi_v7_defconfig and
> arm64's defconfig.

How do we go about merging this? Stefan, will you pick up patch 3, 6 and
7 and submit them for 5.3/5.4? Viresh has already picked up patch 4.

> 
> That's all,
> kind regards,
> Nicolas
> 
> [1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> 
> ---
> 
> Changes since v3:
>   - Fix sparse warnings in clk-raspberrypi.c
>   - Minor cleanups
> 
> Changes since v2:
>   - Fixed configs to match Stefan's comments
>   - Round OPP frequencies
>   - Rebase onto linux-next
>   - Minor cleanups & checkpatch.pl
> 
> Changes since v1:
>   - Enabled by default on the whole family of devices
>   - Added/Fixed module support
>   - clk device now registered by firmware driver
>   - raspberrypi-cpufreq device now registered by clk driver
>   - Reimplemented clk rounding unsing determine_rate()
>   - Enabled in configs for arm and arm64
> 
> Changes since RFC:
>   - Move firmware clk device into own driver
> 
> Nicolas Saenz Julienne (7):
>   clk: bcm2835: remove pllb
>   clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
>   firmware: raspberrypi: register clk device
>   cpufreq: add driver for Raspberry Pi
>   clk: raspberrypi: register platform device for raspberrypi-cpufreq
>   ARM: defconfig: enable cpufreq driver for RPi
>   arm64: defconfig: enable cpufreq support for RPi3
> 
>  arch/arm/configs/bcm2835_defconfig    |   9 +
>  arch/arm/configs/multi_v7_defconfig   |   2 +
>  arch/arm64/configs/defconfig          |   2 +
>  drivers/clk/bcm/Kconfig               |   7 +
>  drivers/clk/bcm/Makefile              |   1 +
>  drivers/clk/bcm/clk-bcm2835.c         |  28 +--
>  drivers/clk/bcm/clk-raspberrypi.c     | 315 ++++++++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm           |   8 +
>  drivers/cpufreq/Makefile              |   1 +
>  drivers/cpufreq/raspberrypi-cpufreq.c |  97 ++++++++
>  drivers/firmware/raspberrypi.c        |  10 +
>  11 files changed, 456 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
> 

-- 
Florian

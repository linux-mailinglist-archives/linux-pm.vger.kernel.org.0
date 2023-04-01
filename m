Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882D56D3351
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDATFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDATFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 15:05:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE76AD18
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 12:04:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so25502048wrb.11
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680375898;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m98PBJ4u06sVFb+2thOqdSIivC6c7g7mGdj5jNvYhaE=;
        b=N8jVwiJWykSOq4wihv5KjwnWrisRqU8Bidp4gX+tsyBkNfqmGowG4mG4zKzRKh0tCG
         nrKLl3ZQEd0apqsRqOTwk1+Otgv/8W7qX9HP4isfP+sU9OemXWsnRDBe/Cw0IBX/anpt
         MF4ksEBnQdAcfND2LUlOKrCGFbET+Hf9a3haFa4wBCVoztg1C0/sYm0AoQxx2OGj/mJ2
         dPgIfF61hJbe0OXjtja5gO2Epq37ocSB/K3X8+65NrHirnGrqcdsk3Zaun/FXeDegaMu
         bmoNdhC+iWAtKp3f+ARzmgcOfTeCQF4tRPGo4zSwUte33xi+6hWeaKGsNDz9TZg5kYLK
         ByIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375898;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m98PBJ4u06sVFb+2thOqdSIivC6c7g7mGdj5jNvYhaE=;
        b=EOmpMQEFOU5pPKSDV62M7S8vqo/rhGPjMjZmPBzgMhpsMtv33tWlg9AWMixCemLEKW
         NlIxk3exZgulNJDdbfvdB4fzQwatwnFBO2B8LXb0ze34SAWrGf1wXohrU0098SaBWQgj
         E9PaZvMcoDOY3ZTIdrmaoQtj+8bQCDjgf8WfzGkcmlXQqZw1S6jB+NgaWiuDAjVe3RzD
         b/cSlGd9njhVMfEn6XtFasjzOEQTRyBHmeO5UEWI5/MHAhDM8onLGUPE7hy3KAmH1Nxb
         szCZ8DOKZyMqHLQ0sajiKKnCf6/Bgb5vwarTRi+DxJRH/XFg1QEDWeIbNZUz7Mggh32u
         UH6A==
X-Gm-Message-State: AAQBX9fr/Bspa4FgRQXCZpzDCKKzftDGbA0nQr1GKFC4Ieg7lbiw4qIa
        /VhbGkr9p7EcDGTLReYT193sq8SNkxDKDdMC60g=
X-Google-Smtp-Source: AKy350bHmieCk/E+JXDNuyqlg93a0oSgsfoHhnTSq5oZQpaNCvPJ9GsaR9wRh/WemcSxev436nY8vQ==
X-Received: by 2002:a5d:5601:0:b0:2d2:ac99:a72 with SMTP id l1-20020a5d5601000000b002d2ac990a72mr26085616wrv.46.1680375898029;
        Sat, 01 Apr 2023 12:04:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id r10-20020a056000014a00b002d2f0e23acbsm5534110wrx.12.2023.04.01.12.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 12:04:57 -0700 (PDT)
Message-ID: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
Date:   Sat, 1 Apr 2023 21:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v6.4-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 2b6db9efa50799fa75ce609f24b355f29504bd9a:

   Merge branch 'thermal-core' into thermal (2023-03-08 14:03:56 +0100)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.4-rc1-1

for you to fetch changes up to 0c492be4002b7411a1587b429e68e0cf3f562488:

   thermal/drivers/ti: Use fixed update interval (2023-04-01 20:51:45 +0200)

----------------------------------------------------------------
- Add more thermal zone device encapsulation: prevent setting
   structure field directly, access the sensor device instead the
   thermal zone's device for trace, relocate the traces in
   drivers/thermal (Daniel Lezcano)

- Use the generic trip point for the i.MX and remove the get_trip_temp
   ops (Daniel Lezcano)

- Use the devm_platform_ioremap_resource() in the Hisilicon driver
   (Yang Li)

- Remove R-Car H3 ES1.* handling as public has only access to the ES2
   version and the upstream support for the ES1 has been shutdown 
(Wolfram Sang)

- Add a delay after initializing the bank in order to let the time to
   the hardware to initialze itself before reading the temperature
   (Amjad Ouled-Ameur)

- Add MT8365 support (Amjad Ouled-Ameur)

----------------------------------------------------------------
Amjad Ouled-Ameur (1):
       thermal/drivers/mediatek: Add delay after thermal banks 
initialization

Daniel Lezcano (6):
       thermal/drivers/imx: Remove get_trip_temp ops
       thermal/drivers/imx: Use the thermal framework for the trip point
       thermal/core: Relocate the traces definition in thermal directory
       thermal/drivers/db8500: Use driver dev instead of tz->device
       thermal/drivers/stm: Don't set no_hwmon to false
       thermal/drivers/ti: Use fixed update interval

Fabien Parent (2):
       dt-bindings: thermal: mediatek: Add binding documentation for 
MT8365 SoC
       thermal/drivers/mediatek: Add support for MT8365 SoC

Markus Schneider-Pargmann (1):
       thermal/drivers/mediatek: Control buffer enablement tweaks

Wolfram Sang (1):
       thermal/drivers/rcar_gen3_thermal: Remove R-Car H3 ES1.* handling

Yang Li (1):
       thermal/drivers/hisi: Use devm_platform_ioremap_resource()

  .../bindings/thermal/mediatek-thermal.txt          |   1 +
  drivers/thermal/Makefile                           |   3 +-
  drivers/thermal/cpufreq_cooling.c                  |   2 +-
  drivers/thermal/db8500_thermal.c                   |   7 +-
  drivers/thermal/devfreq_cooling.c                  |   2 +-
  drivers/thermal/gov_fair_share.c                   |   2 +-
  drivers/thermal/gov_power_allocator.c              |   2 +-
  drivers/thermal/gov_step_wise.c                    |   2 +-
  drivers/thermal/hisi_thermal.c                     |   4 +-
  drivers/thermal/imx_thermal.c                      |  19 ++--
  drivers/thermal/mediatek/auxadc_thermal.c          | 107 
+++++++++++++++++----
  drivers/thermal/rcar_gen3_thermal.c                |  52 +---------
  drivers/thermal/st/stm_thermal.c                   |   1 -
  drivers/thermal/thermal_core.c                     |   2 +-
  drivers/thermal/thermal_helpers.c                  |   3 +-
  .../thermal.h => drivers/thermal/thermal_trace.h   |   6 ++
  .../thermal/thermal_trace_ipa.h                    |   6 ++
  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   8 +-
  18 files changed, 131 insertions(+), 98 deletions(-)
  rename include/trace/events/thermal.h => 
drivers/thermal/thermal_trace.h (97%)
  rename include/trace/events/thermal_power_allocator.h => 
drivers/thermal/thermal_trace_ipa.h (96%)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

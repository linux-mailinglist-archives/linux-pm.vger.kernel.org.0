Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4731FEECB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgFRJjS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgFRJjS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 05:39:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77558C06174E
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 02:39:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so5344395wru.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y0bpfyCrWt4zdb6/EXasOU3eozhBYxN9FnwzUj24PuQ=;
        b=HrFXgaGS7FFW9ZOTUWlteIRaEZJwVITr5ZAu2e5bdEoy147Js7Q5r2LGOa4voki6g8
         HkoaScEFNyzMmgarJOTQIWYtKS2qHA8iuwffCBbKyjMEU/xsL66QRzxXXiTTxYxun0OF
         O1qgqkUB5Futt/bNmPzw94+KN/bBBXSFNzt5WTx9JX2P5LjOGiKaToAJT4rD/uMd4Pj7
         YZQlvsFNqR7PgKAv1NA1KA7XZCIa0H2iU4Oqj4ajoneQMHMFUkjYTM/47M1vR1tWh0C+
         vcNilQK19bPM6sz20IYs5wp/LjD7xhS9wqZXFwsgP0M67BqdGJsduLgNZAnvFB0Rk41f
         D6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y0bpfyCrWt4zdb6/EXasOU3eozhBYxN9FnwzUj24PuQ=;
        b=Khu1gQxiDxDp2DVaLQy3yKvLCUblPCUh7krDjIZj0ZbDSM58ANIItDAY3FbWeZRV+k
         8BKy/KtPHCoPOpxZbuBv8/F8zXvdgSSjPWbv+dE70jvB/4f3qsbL7c5PCM7wP+D/67+a
         UHZPgAjwnQPDSI7QRmV8q4LQhqngO1niZyOA7VU5ldpvna0VKuucgmWbE9QonQGxkwAh
         dVI5tnKUyUkHfSvqxsrIkoUxDfS6o3YZJ9huGMhrUnhdUqt8VZ0wQ4GwK1sAOuW3AszG
         Smqz5btxZx6Z3Oy/mniO4nKdfqeHGB+ktrjO5+klQByptMCeiAeHZaANMT52sniNEvWS
         AgRQ==
X-Gm-Message-State: AOAM531TvwfLqNrNBNkArqJy9C13z/j84TpocrJ8d1r91YuCTNu9KElS
        NcsRKEoELdRV23PWu5UIvf/1rw==
X-Google-Smtp-Source: ABdhPJyny8MDP2sg5Mtlq0GbaCcSgZBavlAzzJe7n1sbnDyHK+gk5UBc1SkF5CD/s9Dt8tirFraflQ==
X-Received: by 2002:adf:db47:: with SMTP id f7mr3801168wrj.101.1592473154635;
        Thu, 18 Jun 2020 02:39:14 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id d11sm2912413wrm.64.2020.06.18.02.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 02:39:13 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] mfd: Add support for Khadas Microcontroller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     khilman@baylibre.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200608091739.2368-1-narmstrong@baylibre.com>
 <20200618081957.GD2608702@dell>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <0421002f-5e09-b292-9066-310bd6a5ead8@baylibre.com>
Date:   Thu, 18 Jun 2020 11:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618081957.GD2608702@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 18/06/2020 10:19, Lee Jones wrote:
> On Mon, 08 Jun 2020, Neil Armstrong wrote:
> 
>> The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
>> connected via I2C.
>>
>> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
>> boards.
>>
>> It has multiple boot control features like password check, power-on
>> options, power-off control and system FAN control on recent boards.
>>
>> Thie serie adds :
>> - the bindings
>> - the MFD driver
>> - the Thermal Cooling cell driver
>> - updates MAINTAINERS
>> - add support into the Khadas VIM3/VIM3L DT
>>
>> Changes since v2 at [3]:
>> - Removed NVMEM driver for separate submission
>> - fixed MFD driver, header and Kconfig
>> - fixed Thermal Kconfig
>> - fixed MAINTAINERS files and path
>>
>> Changes since RFC v1 at [2]:
>> - moved hwmon driver to thermal-only
>> - moved the SM1 thermal nodes in a separate serie
>> - added the bindings review tag from rob
>>
>> [1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
>> [2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com
>> [3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre.com
>>
>> Neil Armstrong (5):
>>   dt-bindings: mfd: add Khadas Microcontroller bindings
>>   mfd: add support for the Khadas System control Microcontroller
>>   thermal: add support for the MCU controlled FAN on Khadas boards
>>   MAINTAINERS: add myself as maintainer for Khadas MCU drivers
>>   arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
> 
> I'm a bit concerned by the missing patches from my inbox.

Oops sorry, I'll resend the full serie with you in CC

> 
> Looks like you omitted to send me patch 3 and 5.
> 
> Hopefully the Thermal patch doesn't depend on the MFD one!

It does ! It includes the include/linux/mfd/khadas-mcu.h file

Amit reviewed the thermal patches already.

Neil

> 
>>  .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 +++++
>>  MAINTAINERS                                   |   9 +
>>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
>>  drivers/mfd/Kconfig                           |  21 +++
>>  drivers/mfd/Makefile                          |   1 +
>>  drivers/mfd/khadas-mcu.c                      | 142 ++++++++++++++
>>  drivers/thermal/Kconfig                       |  11 ++
>>  drivers/thermal/Makefile                      |   1 +
>>  drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
>>  include/linux/mfd/khadas-mcu.h                |  91 +++++++++
>>  10 files changed, 517 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>  create mode 100644 drivers/mfd/khadas-mcu.c
>>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>>  create mode 100644 include/linux/mfd/khadas-mcu.h
>>
> 


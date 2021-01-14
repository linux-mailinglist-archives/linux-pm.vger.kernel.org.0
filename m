Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943332F62CD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhANONl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 09:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbhANONk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 09:13:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA0C061574;
        Thu, 14 Jan 2021 06:13:00 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so8198567lff.9;
        Thu, 14 Jan 2021 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dx0pSimPO+7al3kZsg71712ZkypN/dzE6boWLCtFmRY=;
        b=YPO1KgE2uePmIPhVS5tdBZsbV3DhscA8oOwrY77tPNWdL5Y+FJPuPX1OkmJSDQuFEG
         fpGoIlwIgFNmtlS1x6mfyUx+YZgWpqq46EVJvOpGzFN3hWmIHdJwMMa/wdTTJmWgRWBa
         GqOqLmbFxeIztIf098yTaENYXO3SqamEfXl2K69R7+0AlBhTvZowvc4JX44mZ+FQz5lo
         JIVvzYTKCsKve7oIhrQ6R/mJ+EhDdFHcEDzpx5sxAHdoRRFt8nLfNPvBvCR6JKTvHMsd
         50B74GkQE2yjaJaLe+VWlLlWgyqdhcCdXFaX5Qond6lL/jiMuPqcs+1JgSxLLR3QzbFN
         3fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dx0pSimPO+7al3kZsg71712ZkypN/dzE6boWLCtFmRY=;
        b=fUYFv+2694tmQs24DMT9ArhGu2UkTrv6yTwVkPkSDVUqhrcZ73SYmtZEXHY7+lepvq
         pXSoALPa+FbyNTVMAIYTsPXOXz/MrTNvwGP19gRKbxrSJDhjizk2mjOk+Rv9qjP+h4xg
         gzANf13fN71EKYsefZu/PlXOkQvz6TDWI1DESxYeYB/N876yZZaJBbBrb1zQ+0wcwsas
         2yrj4eleeiftoGRT1pnRLXIAyNihNMn7Vl4l4+YwL/CvdjhRn53SSrSkQSFvCHZ8JCtp
         /myIE2UClyns8BqLrG5+7LgMrO0Zdtx3nc6eF5a716OhA8MlqXgPKWsAxAXJsS5B8HSA
         aqVA==
X-Gm-Message-State: AOAM530sxhMOwzYvBitxUAnyYhF+EFlNBzit8qX43nIqvelMNagNv3Th
        sKU+Yj/i/3v4QYQrUesqnXDGL+hjVG8=
X-Google-Smtp-Source: ABdhPJx95LKJ5umiJwjUs/3t/gR7xRGz5wZ/2HLwvhnns7vMFzWsXIO89o/vcuqMW7zO8A++x07wRQ==
X-Received: by 2002:a05:6512:248:: with SMTP id b8mr3439835lfo.371.1610633578588;
        Thu, 14 Jan 2021 06:12:58 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id i27sm438837lfo.213.2021.01.14.06.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 06:12:57 -0800 (PST)
Subject: Re: [PATCH v8 2/3] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
To:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201228160547.30562-1-digetx@gmail.com>
 <20201228160547.30562-3-digetx@gmail.com> <20210114134753.GY3975472@dell>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <796fb7fd-38e3-7204-555b-82ffbf40272c@gmail.com>
Date:   Thu, 14 Jan 2021 17:12:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210114134753.GY3975472@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.01.2021 16:47, Lee Jones пишет:
> On Mon, 28 Dec 2020, Dmitry Osipenko wrote:
> 
>> Acer Iconia Tab A500 is an Android tablet device, it has ENE KB930
>> Embedded Controller which provides battery-gauge, LED, GPIO and some
>> other functions. The EC uses firmware that is specifically customized
>> for Acer A500. This patch adds MFD driver for the Embedded Controller
>> which allows to power-off / reboot the A500 device, it also provides
>> a common register read/write API that will be used by the sub-devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mfd/Kconfig        |  11 ++
>>  drivers/mfd/Makefile       |   1 +
>>  drivers/mfd/acer-ec-a500.c | 202 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 214 insertions(+)
>>  create mode 100644 drivers/mfd/acer-ec-a500.c
> 
> Looks good to me:
> 
> For my own reference (apply this as-is to your sign-off block):
> 
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Do you have a merge plan?
> 

Thanks, you could take the DT binding and the MFD patches into the MFD
tree right now.

Perhaps will be better to merge the battery patch via the Power tree
since it doesn't have build dependency on the MFD patch. The battery
patch was reviewed by Sebastian, but not acked, as I see now.

Sebastian, could you please take the battery patch?

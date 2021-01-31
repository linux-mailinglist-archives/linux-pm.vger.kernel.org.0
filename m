Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C5309C89
	for <lists+linux-pm@lfdr.de>; Sun, 31 Jan 2021 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhAaOFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jan 2021 09:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhAaKfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2021 05:35:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F4C061573;
        Sun, 31 Jan 2021 02:34:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so10149261wml.4;
        Sun, 31 Jan 2021 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W9CKV72LQw4/n8DHvLlfFWWqWP3t9mTNcTVq9zgFDBI=;
        b=ml8PKnnmBVwUtJhYLrAps2xa09WZPf+AXeAAXBnX2G3emw7Vy1EEUdoJaQrdVgaG1r
         9mezcZR0R+t+DnxSH8YPChK16hDbrqz1tr0GfLDx2lGbNbfAHV7cjlTWV2UG4b/kVHzL
         i7/HURt8gH3+WkwoP5l//hg4TjAzrZSWrbmAUG0KyVaDrK8OKr+GKvChOykALEPlgLUZ
         dVZLalDzCfDlP1Fiisl28ZP8dH4XVahGOMF0epO+eCMkiBrw0QySknwCco2CpRkGObdD
         yfk9dIbJUVsfqd9cZgOTxHalWseyCADX9lZouQpB+CSFS4DTZXJzxsTPZXrb/MCVV9Me
         0SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W9CKV72LQw4/n8DHvLlfFWWqWP3t9mTNcTVq9zgFDBI=;
        b=Jgp8DUo1EhEGOrw2E1y/dyYlbLvynAYwHoZewCg9zRhcmxIdK55mVgvb+XysYiCxpU
         nQ/YFNXFzem7E6toWl768HHFCQCMlci7sFB9J3BmWkYb+qOynVxA0BTJHXShuVLwZXc5
         Yi3I8TS6pgwjbT6T3muLkPhrdMXpvkZzUDvGlAALNRRV+n2wOEkhO8EaUvzZOaOBI7Fl
         hRT6VWU3Uhg+MVAhOcksKKSZEJ7PuYP5MkrD6Gt9895qd3wf5KX1BGfj2igV9AqdbZ6G
         r9Tj3coJOWhH+y4mh76JDQli4smOZXJ6Plqmrx2gEU4VDzFSYl/ohh0xbyt7LLqVYFH5
         +h4Q==
X-Gm-Message-State: AOAM530q7zapT+QwwH58DvqfVa4/7WGTqZLWq5Iv2i7A/dqsPeyJjW91
        cDCxv9vyUP+ChfZEfKlUUsM=
X-Google-Smtp-Source: ABdhPJwPTJI1CsqFftboMFqkzFWZVTHNIT+DTDdAe3T0tcfqcLxYyFtEaR4/kluCLCarlg8Hk4ZwdQ==
X-Received: by 2002:a1c:6289:: with SMTP id w131mr2504113wmb.0.1612089269557;
        Sun, 31 Jan 2021 02:34:29 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d17sm13134357wma.2.2021.01.31.02.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 02:34:28 -0800 (PST)
Subject: Re: [PATCH v10] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
To:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wsd_upstream@mediatek.com
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <49f4400f-c803-f044-4974-f4e8703876e7@gmail.com>
Date:   Sun, 31 Jan 2021 11:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29/12/2020 07:17, Hector Yuan wrote:
> The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
> The driver implements the cpufreq driver interface for this hardware engine. 
> This patch depends on MT6779 DTS patchset[1] submitted by Hanks Chen.

This dependency got resolved, the patch is mainline since v5.11. Please delete
it in further revisions of the patch set to minimize confusion.

Thanks!

> 
> From v8 to v9, there are three more modifications.
> 1. Based on patchset[2], align binding with scmi for performance domain.
> 2. Add the CPUFREQ fast switch function support and define DVFS latency.
> 3. Based on patchser[3], add energy model API parameter for mW.
> 
> From v7 to v8, there are three more patches based on patchset v8[4].
> This patchset is about to register power table to Energy model for EAS and thermal usage.
> 1. EM CPU power table
> - Register energy model table for EAS and thermal cooling device usage.
> - Read the coresponding LUT for power table.
> 2. SVS initialization
> - The SVS(Smart Voltage Scaling) engine is a hardware which is
>   used to calculate optimized voltage values for CPU power domain.
>   DVFS driver could apply those optimized voltage values to reduce power consumption.
> - Driver will polling if HW engine is done for SVS initialization.
>   After that, driver will read power table and register it to EAS.
> - CPUs must be in power on state when doing SVS. Use pm_qos to block cpu-idle state for SVS initializing.
> 3. Cooling device flag
> - Add cooling device flag for thermal
> 
> [1]  https://lkml.org/lkml/2020/8/4/1094
> [2]  https://lore.kernel.org/lkml/20201116181356.804590-1-sudeep.holla@arm.com/
> [3]  https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c250d50fe2ce627ca9805d9c8ac11cbbf922a4a6
> [4]  https://lkml.org/lkml/2020/9/23/384
> 
> 
> Hector.Yuan (2):
>   cpufreq: mediatek-hw: Add support for CPUFREQ HW
>   dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
> 
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  116 ++++++
>  drivers/cpufreq/Kconfig.arm                        |   12 +
>  drivers/cpufreq/Makefile                           |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c              |  370 ++++++++++++++++++++
>  4 files changed, 499 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADFAE7D31
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 00:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfJ1Xsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 19:48:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44176 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1Xsg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 19:48:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id v4so5695295lfd.11;
        Mon, 28 Oct 2019 16:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q6EMHyEMqasbwBZsEfT0R2vQ55XJFS+NFj3xXGhBU+s=;
        b=m9j6/Cg7tRFSSZ5FB1BdpF4D3YkwLwZcDlIfc2zybuOfGLo4Wig0UzhBj7VsS2NDyg
         SY6OyxIMkF/B/mmXClhsCErc3tSLtefxSrida05uMRPigObCfa+8ZO5F88ZfgbGchoz7
         uIzmoOKBFtPrDMo5B8MFPG2zn22pjUw00ToGZ+BSCnxqgxTeRPS7lM2JTXMs5aBONfMO
         ygvIOOQ0fEVU79JLJ4scSqDg7Gfp3d1FfboVv1ZdJ25CQ1AOI2omufsqP+0XoCALEEEH
         39ZULvucVQRxJi/oG1fMqKeIKmCERLUa/dTdFa9bN0cnX+u2hfQGab+76lnzi8M7gphz
         XFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q6EMHyEMqasbwBZsEfT0R2vQ55XJFS+NFj3xXGhBU+s=;
        b=R7o8WLQjL6L9xLMV5Ql2jBWq1G+qah7uIszLrnYPWe69SOEwrxBBJar0OI5l8rSJKT
         2oqc0U4ebXpeyEXEsDQD2mpRsahNd/VyjTTh7FYz/2tsIj65UkbCZBHlW5174k4nRMMw
         l7/F+zUmmb4LUxWAAsDCZXaq9FA0SDGMitsLgEK+4LudZOpOVSWdHp1bhNVbRZbbAKRV
         +7Pxb2xSXSubqdIMwtTLqxEq2q/ZsabdJd+Qm37f9cNokYt4PYZyK5CKAt8OxIUwOykP
         GXhc6EN7i+sikJ4BNHVlbx3Z3jeqfdstZa6vKygWdLkiE78D+5cBsykjbds2Lr9GD2ES
         S6Gg==
X-Gm-Message-State: APjAAAXhbBrKBm89GBF/yyZIUpZ0jZfD/h6lDUcbIgyrVZCOzynTegJu
        AHMYldqZfR3oR/VgCw93nuYAXyTK
X-Google-Smtp-Source: APXvYqzEriIIo84/gTbWsLp4g6q3Dbr2B3JSuhaWyOO/FZUxl+8+KJhf/3hDABF6A4ann3gIJgdFng==
X-Received: by 2002:a19:e017:: with SMTP id x23mr257683lfg.88.1572306513365;
        Mon, 28 Oct 2019 16:48:33 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id b4sm4260809ljp.84.2019.10.28.16.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 16:48:32 -0700 (PDT)
Subject: Re: [PATCH v1 01/17] clk: tegra: Add custom CCLK implementation
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-2-digetx@gmail.com>
 <20191028145706.GF27141@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2e35c210-8d76-c096-69b6-91b6ed577605@gmail.com>
Date:   Tue, 29 Oct 2019 02:48:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028145706.GF27141@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.10.2019 17:57, Peter De Schrijver пишет:
> On Wed, Oct 16, 2019 at 12:16:02AM +0300, Dmitry Osipenko wrote:
>> CCLK stands for "CPU Clock", CPU core is running off CCLK. CCLK supports
>> multiple parents and it has internal clock divider which uses clock
>> skipping technique, meaning that CPU's voltage should correspond to the
>> parent clock rate and not CCLK. PLLX is the main CCLK parent that provides
>> clock rates above 1GHz and it has special property such that the CCLK's
>> internal divider is set into bypass mode when PLLX is set as a parent for
>> CCLK.
>>
>> This patch forks generic Super Clock into CCLK implementation which takes
>> into account all CCLK specifics. The proper CCLK implementation is needed
>> by the upcoming Tegra20 CPUFreq driver update that will allow to utilize
>> the generic cpufreq-dt driver by moving intermediate clock handling into
>> the clock driver. Note that technically this all could be squashed into
>> clk-super, but result will be messier.
>>
>> Note that currently all CCLKLP bits are left in the clk-super.c and only
>> CCLKG is supported by clk-tegra-super-cclk. It shouldn't be difficult
>> to move the CCLKLP bits, but CCLKLP is not used by anything in kernel
>> and thus better not to touch it for now.
> 
> ..
> 
>> +	super->reg = reg;
>> +	super->lock = lock;
>> +	super->width = 4;
>> +	super->flags = clk_super_flags;
>> +	super->frac_div.reg = reg + 4;
>> +	super->frac_div.shift = 16;
>> +	super->frac_div.width = 8;
>> +	super->frac_div.frac_width = 1;
>> +	super->frac_div.lock = lock;
>> +	super->frac_div.flags = TEGRA_DIVIDER_SUPER;
>> +	super->div_ops = &tegra_clk_frac_div_ops;
>> +
> 
> This is not right. The super clock divider is not a divider, it's a
> pulse skipper.

For the reference: on #tegra Peter explained to me in a more details
what was meant here. Turned out that T30+ has a real CCLK divider and we
won't use the pulse skipper for T20 nor for T30+, I'll update clk
patches accordingly in the next revision.

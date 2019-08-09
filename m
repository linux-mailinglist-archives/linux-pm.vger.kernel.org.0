Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94386879B6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406740AbfHIMUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:20:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38088 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406739AbfHIMUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:20:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so91890197ljg.5;
        Fri, 09 Aug 2019 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scz3HNd4I/lEmliM5yrhOJ2y0CgErN/gqkMHsAAbWBs=;
        b=AKKFUTSUeshHqfnIpgsadrTMDKQOI9nY1rUSygMeho63nVaGXFPK2IZ0YZ7LzfduoR
         qZ2FzKTyeQu0yv0/90tGEVl9ZKBVTXv9kUdtI6Ojm/WBk9H905V/7GL397fbETdO97Fw
         lbFKbAvAojHNTnX0b6kWyF8VgA/lEPF5x/IHkzBHujn1iDARGku59GtVUpCWKhB6VfKQ
         EqcM6fjdNVaYn+yF9l9vWznwEBLUUHTCj6wGZ0GzmTNeWz+8QUtNsLqW2Miil2xC3YXv
         j9zosCotoLEV8NYKlSqdNJNcT4YvC/mYegemww9d4o7YytgYSX881JwlY2+2v+h9yA0Q
         ZE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scz3HNd4I/lEmliM5yrhOJ2y0CgErN/gqkMHsAAbWBs=;
        b=ILY3xDO84d7GWr+G/sEs0dJNKJigl/8sNZQNVRj0sVB2m6VvGS0LNzQzB32whRJnT0
         P6fgIWFVodjS7RkPIzLHH90pWTKu5HMXhDnlJo2VEYoa/O240SPf8PoaDP6b5+HnhzWV
         eY6HzVc/rwImHLCFAzFIRYs/pCjT3ItEQToOcSldgQbi49q3xFVlwRO/a4q5ytivaPUi
         6iuoA8+v786ZcQP9PXOXs+qA+Dn1qN7/eYNVBRTJY3UwVg8pxMZm/dqxZ8URkmBPyUbx
         PbqRXeNmzRxwhoDKVXGvInixrGMznBgJ139o7ywhC8ekh9hkbgf7lHE8/TONE6snjmFQ
         MiCg==
X-Gm-Message-State: APjAAAWAjduR5u1NgGNj2zg9jbcMk8upNixZdflPNgRcoqX2lK0biwza
        mfN6Id0h/mmNUZ34WJirNoPruGif
X-Google-Smtp-Source: APXvYqwwFdDxnvCmTjeGxpi7RsPWwgau+7HJXKoDobtoiLEazJVAJow3gPgwHS0eMEZpYC9dzp4xyA==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr11207581ljn.111.1565353203926;
        Fri, 09 Aug 2019 05:20:03 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id j3sm17490995lfp.34.2019.08.09.05.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:20:03 -0700 (PDT)
Subject: Re: [PATCH v8 08/21] clk: tegra: periph: Add restore_context support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-9-git-send-email-skomatineni@nvidia.com>
 <5a5f9fb9-9cdd-5d91-4b0e-9bdb95b2625e@gmail.com>
Message-ID: <0f8259d8-08f2-671c-331c-fe2d83518be0@gmail.com>
Date:   Fri, 9 Aug 2019 15:20:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5a5f9fb9-9cdd-5d91-4b0e-9bdb95b2625e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 14:55, Dmitry Osipenko пишет:
> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>> This patch implements restore_context support for clk-periph and
>> clk-sdmmc-mux clock operations to restore clock parent and rates
>> on system resume.
>>
>> During system suspend, core power goes off and looses the context
>> of the Tegra clock controller registers.
>>
>> So on system resume, clocks parent and rate are restored back to
>> the context before suspend based on cached data.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/clk/tegra/clk-periph.c    | 18 ++++++++++++++++++
>>  drivers/clk/tegra/clk-sdmmc-mux.c | 12 ++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
>> index 58437da25156..c9d28cbadccc 100644
>> --- a/drivers/clk/tegra/clk-periph.c
>> +++ b/drivers/clk/tegra/clk-periph.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
>>   */
>>  
>> +#include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/export.h>
>>  #include <linux/slab.h>
>> @@ -99,6 +100,20 @@ static void clk_periph_disable(struct clk_hw *hw)
>>  	gate_ops->disable(gate_hw);
>>  }
>>  
>> +static void clk_periph_restore_context(struct clk_hw *hw)
>> +{
>> +	struct tegra_clk_periph *periph = to_clk_periph(hw);
>> +	const struct clk_ops *div_ops = periph->div_ops;
>> +	struct clk_hw *div_hw = &periph->divider.hw;
>> +	struct clk_hw *parent = clk_hw_get_parent(hw);
>> +	int parent_id = clk_hw_get_parent_index(hw, parent);
>> +
>> +	if (!(periph->gate.flags & TEGRA_PERIPH_NO_DIV))
>> +		div_ops->restore_context(div_hw);
>> +
>> +	clk_periph_set_parent(hw, parent_id);
>> +}
>> +
>>  const struct clk_ops tegra_clk_periph_ops = {
>>  	.get_parent = clk_periph_get_parent,
>>  	.set_parent = clk_periph_set_parent,
>> @@ -108,6 +123,7 @@ const struct clk_ops tegra_clk_periph_ops = {
>>  	.is_enabled = clk_periph_is_enabled,
>>  	.enable = clk_periph_enable,
>>  	.disable = clk_periph_disable,
>> +	.restore_context = clk_periph_restore_context,
>>  };
>>  
>>  static const struct clk_ops tegra_clk_periph_nodiv_ops = {
>> @@ -116,6 +132,7 @@ static const struct clk_ops tegra_clk_periph_nodiv_ops = {
>>  	.is_enabled = clk_periph_is_enabled,
>>  	.enable = clk_periph_enable,
>>  	.disable = clk_periph_disable,
>> +	.restore_context = clk_periph_restore_context,
>>  };
>>  
>>  static const struct clk_ops tegra_clk_periph_no_gate_ops = {
>> @@ -124,6 +141,7 @@ static const struct clk_ops tegra_clk_periph_no_gate_ops = {
>>  	.recalc_rate = clk_periph_recalc_rate,
>>  	.round_rate = clk_periph_round_rate,
>>  	.set_rate = clk_periph_set_rate,
>> +	.restore_context = clk_periph_restore_context,
>>  };
>>  
>>  static struct clk *_tegra_clk_register_periph(const char *name,
>> diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
>> index a5cd3e31dbae..8db48966b100 100644
>> --- a/drivers/clk/tegra/clk-sdmmc-mux.c
>> +++ b/drivers/clk/tegra/clk-sdmmc-mux.c
>> @@ -194,6 +194,17 @@ static void clk_sdmmc_mux_disable(struct clk_hw *hw)
>>  	gate_ops->disable(gate_hw);
>>  }
>>  
>> +static void clk_sdmmc_mux_restore_context(struct clk_hw *hw)
>> +{
>> +	struct clk_hw *parent = clk_hw_get_parent(hw);
>> +	unsigned long parent_rate = clk_hw_get_rate(parent);
>> +	unsigned long rate = clk_hw_get_rate(hw);
>> +	int parent_id = clk_hw_get_parent_index(hw, parent);
>> +
>> +	clk_sdmmc_mux_set_parent(hw, parent_id);
>> +	clk_sdmmc_mux_set_rate(hw, rate, parent_rate);
> 
> For the periph clocks you're restoring rate at first and then the
> parent, while here it's the other way around. I'm wondering if there is
> any difference in practice and thus whether rate's divider need to be
> set to a some safe value before switching to a new parent that has a
> higher clock rate than the old parent.

Although, I guess that all peripheral clocks should be disabled at this
point of resume. Correct?

>> +}
>> +
>>  static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
>>  	.get_parent = clk_sdmmc_mux_get_parent,
>>  	.set_parent = clk_sdmmc_mux_set_parent,
>> @@ -203,6 +214,7 @@ static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
>>  	.is_enabled = clk_sdmmc_mux_is_enabled,
>>  	.enable = clk_sdmmc_mux_enable,
>>  	.disable = clk_sdmmc_mux_disable,
>> +	.restore_context = clk_sdmmc_mux_restore_context,
>>  };
>>  
>>  struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
>>
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751482FF5D5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbhAUU1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbhAUU11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 15:27:27 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3EC061756;
        Thu, 21 Jan 2021 12:26:47 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id p13so4033712ljg.2;
        Thu, 21 Jan 2021 12:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HRTfbG4emabSLFelmlx+vEEglKRLfy1gL/MezAi/ZM=;
        b=Wmpj3uR+B0oz7EbHGBH0A/9/umuq3HtC70vKmknXE/bVji4YOs7D1DVYHD5yuI0mcI
         rhxEp0Yr0sg5kAIEbnC2sQ6MFHGa77WLAIQUTBLVaAXTgfG3RMHgoAH9brIk0RlVFIZi
         kBQwEl/lTlkkRiJqbRwZC1NSLZO8lLKnAMfio+iQrD+6GBEHDX0ToT6qUCCuCIrT6sy9
         IIsBCKprxdFHSTsB4zVRt+YXOQ7N6hO1HT3vHdrjZ40Kh2UdL/5oKL2SUe6Cfj8irMNL
         cjDWbZGfdpZX/BkGISTFxt1MrKPB8u+lZlFV4V7Oty91HcIUt6yDLfBuY07u70csd96Y
         w6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HRTfbG4emabSLFelmlx+vEEglKRLfy1gL/MezAi/ZM=;
        b=P5IDwIbrXRgMqOCWtU4tWIiujMAEjEhZbuaYvdHKM87oAetkMOOvPOSAfqbh8lYis7
         q4mFU/I+VRtbSY3zY2sKZW2psTEmUi59qaV7DLzuKuW3r0oc80XM+OsPOuQHV3wR/LQ/
         L2TGIMtUuBkch1UaEcEOf7c/g2FOkaFJHK24iQ9b2tBDZxU+gjjyi2X9fJU05DRfYVNA
         NQD5ePctxv/jzcMAXaCGDMj8ORWcNcNS5jaH8CMIr2Bbn5zJ4/YP0JtjGB8KulSu+Fg6
         aMQ0RLM/eyZHe+FjNJrNXBaahI9UultYqhFNVndYwymLQkEzUxoSYR03HIEYaacdUZxj
         kHbA==
X-Gm-Message-State: AOAM531dvnof7Dbuo8YJ9G79hQVODMIaFQUqULLBBMP2XCAfbfN8eVAs
        g46+TuNSgJcahSZZ/8+DXg/cRMCOrLc=
X-Google-Smtp-Source: ABdhPJztFRGAPddrobgjhvcdhiqrWAqsLj6Hf8+fRw2jY6qn6Z2O41UhIeIZis2JIksLu/TG8DVIKA==
X-Received: by 2002:a2e:8350:: with SMTP id l16mr538281ljh.403.1611260805366;
        Thu, 21 Jan 2021 12:26:45 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id m25sm633354lfb.144.2021.01.21.12.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:26:44 -0800 (PST)
Subject: Re: [PATCH 07/13] opp: Allow _generic_set_opp_clk_only() to work for
 non-freq devices
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b2638e6-b842-8737-e5a0-aeeb84927fce@gmail.com>
Date:   Thu, 21 Jan 2021 23:26:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 14:17, Viresh Kumar пишет:
> In order to avoid conditional statements at the caller site, this patch
> updates _generic_set_opp_clk_only() to work for devices that don't
> change frequency (like power domains, etc.). Return 0 if the clk pointer
> passed to this routine is not valid.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
...

Hello Viresh,

Thank you very much for yours effort! I gave a quick test to this series
and instantly found one small issue in this patch.

> +	/* We may reach here for devices which don't change frequency */
> +	if (unlikely(!clk))

I replaced dev_pm_opp_set_voltage() with dev_pm_opp_set_opp() in the
Tegra PD driver and got a crash, which happens because the above line
should be:

	if (IS_ERR(clk))

The opp_table->clk is initialized to ERR_PTR(-ENOENT) if device doesn't
have a clock, like a power domain device in my case.

Everything works good after fixing this patch. I'll keep testing and
will be taking a closer look at the rest of the patches over this weekend.

For the record, here is a backtrace of the crash:

Unable to handle kernel NULL pointer dereference at virtual address 00000016
...
(clk_set_rate) from (_set_opp)
(_set_opp) from (dev_pm_opp_set_opp)
(dev_pm_opp_set_opp) from (tegra_genpd_set_performance_state)
(tegra_genpd_set_performance_state) from (_genpd_set_performance_state)
(_genpd_set_performance_state) from (dev_pm_genpd_set_performance_state)
(dev_pm_genpd_set_performance_state) from (_set_required_opp)
(_set_required_opp) from (_set_opp)
(_set_opp) from (dev_pm_opp_set_rate)
(dev_pm_opp_set_rate) from (host1x_runtime_resume)
(host1x_runtime_resume) from (genpd_runtime_resume)
(genpd_runtime_resume) from (__rpm_callback)
(__rpm_callback) from (rpm_callback)
(rpm_callback) from (rpm_resume)
(rpm_resume) from (__pm_runtime_resume)
(__pm_runtime_resume) from (host1x_probe)
(host1x_probe) from (platform_probe)
(platform_probe) from (really_probe)
(really_probe) from (driver_probe_device)
(driver_probe_device) from (device_driver_attach)
(device_driver_attach) from (__driver_attach)
(__driver_attach) from (bus_for_each_dev)
(bus_for_each_dev) from (bus_add_driver)
(bus_add_driver) from (driver_register)
(driver_register) from (__platform_register_drivers)
(__platform_register_drivers) from (host1x_module_init)
(host1x_module_init) from (do_one_initcall)
(do_one_initcall) from (kernel_init_freeable)
(kernel_init_freeable) from (kernel_init)

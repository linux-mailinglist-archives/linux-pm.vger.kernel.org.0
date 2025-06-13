Return-Path: <linux-pm+bounces-28634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B6AD84DC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D45C16AAAB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1E2E2F1F;
	Fri, 13 Jun 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fasy3afW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9A2DFA28
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800396; cv=none; b=eL42Oi9fkh22XrjWZgXrO4lPQAZ9ehU0P98OiUMvnPKMG79cW/5YW6PkYp1WSvVSwPiLf22pHcwk4VDTKa/hs3A7wvQFtok1tHFS+QS+dEJW66FY5M3kif66DpODML5A+cv5umIUT9hYM28SgxuUMmVlpG5rh2pzYYiyY4INk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800396; c=relaxed/simple;
	bh=+dfNvnlucquygPNJUXz34kJj8KjOh8qnQZM+R8On/k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTlaU10oZy5/DNjsUX8CpgNcZCZNtsL2ctYb1co1CdUNd5EfdjVDluVAft0JRTcSOSsm0GINzHQGaPEfNafilQlz8fux15nJzVcrZPq5qCH2d2dUI7bSGOH/zGCitFn0sbSvrQzvRoUVAcJmRvI0J6FIXGeURru8/maJffmD/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fasy3afW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad93ff9f714so309848966b.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749800393; x=1750405193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WG5vFd300oZUUzuglhUpNUIOh7+mLg7x9fAoLYnof8=;
        b=fasy3afWKHV21OM6aF1XKx61L3stVQdDNrBQHqJgqgV5ydoCJKUVVrR+x+lngcNBlT
         FqI9YMWN51yePi1+vJDgEZh/HKSBrP7f/+Sy6QLoE2pI7UN2CQEl8ZgsthNj0RVFb9u2
         CC7HQuVcLUH2G1IefV1rrMWb3ubCB/dKutfb4FD+KjWOJDaSHdTNrJjW7eX3H6Hsa9Tj
         q7eo4cehIBPaWl0wTyZhBva/r2HLh7T+jOqbqlRH1fvoZQApFPT3IapclD7rU/4Q3kyo
         M0QEhcUdfR2Mlb6wYCUl5R/xASWIfSIBXgtroRKKEyrXPL37sOzh7BtOjsenMBIWjTF+
         e4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800393; x=1750405193;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WG5vFd300oZUUzuglhUpNUIOh7+mLg7x9fAoLYnof8=;
        b=cNxHdlDEZ8XYnoBAfmsflHxkBLRDAUdGWDNN+kQuZGjf3hXj783s0jPofKLZkJcQNq
         Qt6PjqMedfRv0S9qGuwq/yPv1S1XzgSzhBg1IebKe4r+ih8IWXu1Cah6IwoNtr0qxk5o
         hULSwKRVu4VmebOONWXHnSqKQEFzO5LBpTelqpvw94ocdirfmwdhwfDeCv8E7Ej5xdTp
         3ki5sKqyeXn8hQqUxM9naUM0Ljb7sLjc78rpDo+XtNzDiPA6Mn+lBn7ehhQlH68BtkYs
         kucD/RGKLBFGPdQHpUzFwNMKyqukB0d7JL6ATpOk1vcVY+UPx+Y4W+JXof6duZ5T7uPy
         ZI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU46+RsbAGxCBJ1lBH1tUBmIU0iwsMIJcd3/jrl8wBfe+JQOwqS721kaFc8/6/i6wdf+ctELgstvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymHprZjfceYm1Xxw9/aZn12vvjxIeftEqldNIJVDFFYQPtyYkg
	tugdaG5NtoxwXhlzCH0at6FlrNCWubPwBq//GRsUEpd65k4Vp8myoZFVeLvAuPYjQRU=
X-Gm-Gg: ASbGnctBG5kB30YI9jUSkgfHV+En590/2KqWBlCQCQJMLPpC+Fgwh6iU54L9deCCGtx
	xcNwGLBurTahyxOz+Zw+2a3HWrD0E+1sNQEtItegnYQ736YxehF+TX7gbxjVTmxgE9uzfz+vFV6
	0TAOcq6YH1Y3WcYJyoIE6VfTcxw9qxVNGiTqUhxoVcVE5GS4xemeHO3mT+pHVIm+3nQ4ythEI/7
	8MufPfU2yGC6Rmg85FYh2DAF6Hu6LkuIGxyEe/xrBSFAWTAKUaZD3zLCVNleaLIS4SzcCFdPVcT
	q7mBTx8Sd3s6pO78hyIVp6NdLvTaawh7pbzLdQwhChkArr+s4+wYR66roTHNS/30szAWjj4=
X-Google-Smtp-Source: AGHT+IHbT7oRQDXuk6B3wIxt0+oLJne2jQCVvWqR8ZSuXEeabN4NtHdvIe5vWvmjryMj3KG0rPYYUg==
X-Received: by 2002:a17:907:944c:b0:ad8:a88c:84e3 with SMTP id a640c23a62f3a-adec5cb381cmr157457966b.33.1749800392513;
        Fri, 13 Jun 2025 00:39:52 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff425sm84059666b.87.2025.06.13.00.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 00:39:52 -0700 (PDT)
Message-ID: <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev>
Date: Fri, 13 Jun 2025 10:39:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org,
 dakr@kernel.org, len.brown@intel.com, pavel@kernel.org,
 ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei>
 <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafael,

On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> On Sat, Jun 7, 2025 at 3:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Fri, 6 Jun 2025 22:01:52 +0200
>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>
>> Hi Rafael,
>>
>>> On Fri, Jun 6, 2025 at 8:55 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
>>>>> On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>>
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The dev_pm_domain_attach() function is typically used in bus code alongside
>>>>>> dev_pm_domain_detach(), often following patterns like:
>>>>>>
>>>>>> static int bus_probe(struct device *_dev)
>>>>>> {
>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>     int ret;
>>>>>>
>>>>>>     // ...
>>>>>>
>>>>>>     ret = dev_pm_domain_attach(_dev, true);
>>>>>>     if (ret)
>>>>>>         return ret;
>>>>>>
>>>>>>     if (drv->probe)
>>>>>>         ret = drv->probe(dev);
>>>>>>
>>>>>>     // ...
>>>>>> }
>>>>>>
>>>>>> static void bus_remove(struct device *_dev)
>>>>>> {
>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>
>>>>>>     if (drv->remove)
>>>>>>         drv->remove(dev);
>>>>>>     dev_pm_domain_detach(_dev);
>>>>>> }
>>>>>>
>>>>>> When the driver's probe function uses devres-managed resources that depend
>>>>>> on the power domain state, those resources are released later during
>>>>>> device_unbind_cleanup().
>>>>>>
>>>>>> Releasing devres-managed resources that depend on the power domain state
>>>>>> after detaching the device from its PM domain can cause failures.
>>>>>>
>>>>>> For example, if the driver uses devm_pm_runtime_enable() in its probe
>>>>>> function, and the device's clocks are managed by the PM domain, then
>>>>>> during removal the runtime PM is disabled in device_unbind_cleanup() after
>>>>>> the clocks have been removed from the PM domain. It may happen that the
>>>>>> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
>>>>>
>>>>> Don't use devm_pm_runtime_enable() then.
>>>>
>>>> What about other devm_ APIs? Are you suggesting that platform drivers
>>>> should not be using devm_clk*(), devm_regulator_*(),
>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
>>>> dev_pm_domain_detach() that is called by platform bus_remove() may shut
>>>> off the device too early, before cleanup code has a chance to execute
>>>> proper cleanup.
>>>>
>>>> The issue is not limited to runtime PM.
>>>>
>>>>>
>>>>>> If the driver specific runtime PM APIs access registers directly, this
>>>>>> will lead to accessing device registers without clocks being enabled.
>>>>>> Similar issues may occur with other devres actions that access device
>>>>>> registers.
>>>>>>
>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
>>>>>> device is detached from its PM domain in device_unbind_cleanup(), only
>>>>>> after all driver's devres-managed resources have been release.
>>>>>>
>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 state
>>>>>> arguments, one for the domain state on attach, one for the domain state on
>>>>>> detach.
>>>>>
>>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced at
>>>>
>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?
>>>
>>> Yes, among other things.
>>
>> Maybe naming could make abuse at least obvious to spot? e.g.
>> pm_domain_attach_with_devm_release()
> 
> If I'm not mistaken, it is not even necessary to use devres for this.
> 
> You might as well add a dev_pm_domain_detach() call to
> device_unbind_cleanup() after devres_release_all().  There is a slight
> complication related to the second argument of it, but I suppose that
> this can be determined at the attach time and stored in a new device
> PM flag, or similar.
> 

I looked into this solution. I've tested it for all my failure cases and
went good.

> Note that dev->pm_domain is expected to be cleared by ->detach(), so
> this should not cause the domain to be detached twice in a row from
> the same device, but that needs to be double-checked.

The genpd_dev_pm_detach() calls genpd_remove_device() ->
dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain = NULL. I can't
find any other detach function in the current code base.

The code I've tested for this solution is this one:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..5e9750d007b4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device *dev)
        dev->dma_range_map = NULL;
        device_set_driver(dev, NULL);
        dev_set_drvdata(dev, NULL);
-       if (dev->pm_domain && dev->pm_domain->dismiss)
-               dev->pm_domain->dismiss(dev);
+       if (dev->pm_domain) {
+               if (dev->pm_domain->dismiss)
+                       dev->pm_domain->dismiss(dev);
+               dev_pm_domain_detach(dev, dev->pm_domain->detach_power_off);
+       }
        pm_runtime_reinit(dev);
        dev_pm_set_driver_flags(dev, 0);
 }
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..2459be6aecf4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1400,11 +1400,8 @@ static int platform_probe(struct device *_dev)
        if (ret)
                goto out;

-       if (drv->probe) {
+       if (drv->probe)
                ret = drv->probe(dev);
-               if (ret)
-                       dev_pm_domain_detach(_dev, true);
-       }

 out:
        if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1419,6 @@ static void platform_remove(struct device *_dev)

        if (drv->remove)
                drv->remove(dev);
-       dev_pm_domain_detach(_dev, true);
 }

 static void platform_shutdown(struct device *_dev)
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 781968a128ff..4bd1e3c7f401 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
        if (!ret)
                ret = genpd_dev_pm_attach(dev);

+       if (dev->pm_domain)
+               dev->pm_domain->detach_power_off = power_on;
+
        return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..12e97e09e85c 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -748,6 +748,7 @@ struct dev_pm_domain {
        void (*sync)(struct device *dev);
        void (*dismiss)(struct device *dev);
        int (*set_performance_state)(struct device *dev, unsigned int state);
+       bool detach_power_off;
 };

Rafael, Ulf, Dmitry, Jonathan, all,

Could you please let me know how do you consider this approach?

Thank you,
Claudiu


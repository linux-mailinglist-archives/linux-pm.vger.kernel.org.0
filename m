Return-Path: <linux-pm+bounces-13736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C750496E559
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 23:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393CAB222C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859841AD9FA;
	Thu,  5 Sep 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="inahXklX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7631AB52C
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573471; cv=none; b=XGZBBDJNm8J4qdAyAeYa9IIt7zk8YlECPuqrSF3vl8CMTtQS1OsQTP1Cd5T5f3AZI1wVojDDMP+zaFXS2RTDy9/7BGQuMEs3WJ+n7qCCM9LIdIyztFPUbNiiYZW6MUfjhPxmbAJcnYpL/5exxhQt/scortOaZyxNqgJXjcgwC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573471; c=relaxed/simple;
	bh=M10+2gBvslwFCp+kpoSUyjoPQFPwJ4+aDuI1AUobETg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=el5F6weh6eO8zUIH3bWwagkZzJNTcJORP0EmbHHdCBe9Nv/Sbz2tHD8aMVXGM9Kz1I7EH7ZLbn+mXUIggeoq698RCgzl12eSATee4QqfN3daSl5D7yjrKlqNIuccUagKhlo9/Rx1tbhsMU2OvaE3O2pc/h14yJzsDCo0wOzi54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=inahXklX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714287e4083so1110492b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573468; x=1726178268; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5uxU3Mym+2GWfPnVlq3auuUpj09qNie62HH+eIuAv4=;
        b=inahXklXHug8gW2bybYXFJm0PujkkJ/3zYJDfiJZzTXfyAeH49Mpi9OvsdbUfbVoxW
         nbPXLyS7Ise5AvbLiEHguotvcqlxnClhLAxCCS0WGwlshmpAj7HWZ7UXaTkyaOxfQZYJ
         v8jx8q0UQ/+J0HZTFL16t9x1nXT7buVKT2z/8egTBElhgTA+/DFUyxGwBLVp9ioMditC
         xuSucRD/8Y57r/qsAQVOEAu4VffNm+L9a17jpYQfxwrrRnGXSoO89ndembgJjbYR989P
         XqDk807hD500ZVDJqFJA4XaV4Sa95EDj2TXIRDEteyUX2PoSQXn2cKGvf8GPV2aco6mG
         jRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573468; x=1726178268;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5uxU3Mym+2GWfPnVlq3auuUpj09qNie62HH+eIuAv4=;
        b=ajqjaJ2FrpmQpudYH//ox6DjrDEfMvj8iM+B/MQlthIQEji/lL+CHE2ASBas9U/v7G
         x5UzxfEGZ+W4qa44tO9vbClxAaX1hJ/HKS8eDJb1lRkOE6Gb72RWypFfnFL2NE4/rDOS
         4T/QUVPUW+mIHJ0o65dQ7dAskfpHRCzjakJt6z6MTJ0onUoi2Z3QBZ5+e5v7dbvbl54g
         etOtHxENA6EeEFjLvlN9QP8zzMqGMLSIiN9BT5dc0rCcZRUxOswraf6s8g75sxtpy0tS
         9Aj47mbTdOv+yTKn+hqWNY9aQ17M/bjfdMnsMg0ROzlKA3ptS1ksvQNyPY0xCjcPJgG6
         Tw8g==
X-Gm-Message-State: AOJu0Yyamg6LD8ZrHrzZhrc4BVOAoPLpr8P19kKJKxszM84Wu2IGlFvt
	1cALJqg5ZfwHfH3hK7crIN8kP4N2s2ays1bsvT7Y+9tDzZPfv2BKb1ZFzHSdCUU=
X-Google-Smtp-Source: AGHT+IHAPn3RVf2uJDWJ+hk2j9RtamPe9RCojFCbc6OeYtlorF2xMrn6wBlQMxhRU6Ra9JTw9o4xYw==
X-Received: by 2002:a05:6a21:170f:b0:1c0:ede4:9a73 with SMTP id adf61e73a8af0-1cf1d059a9amr442963637.7.1725573467903;
        Thu, 05 Sep 2024 14:57:47 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71782eb5352sm2675469b3a.154.2024.09.05.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:57:47 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pmdomain: ti_sci: add per-device latency
 constraint management
In-Reply-To: <CAPDyKFrCyvSLYh9DoC661M-2D33oU9x5tFOe+Oem04V5KfqG3A@mail.gmail.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <20240819-lpm-v6-10-constraints-pmdomain-v2-1-461325a6008f@baylibre.com>
 <CAPDyKFrCyvSLYh9DoC661M-2D33oU9x5tFOe+Oem04V5KfqG3A@mail.gmail.com>
Date: Thu, 05 Sep 2024 14:57:47 -0700
Message-ID: <7hv7z9ahlw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> For each device in a TI SCI PM domain, check whether the device has
>> any resume latency constraints set via per-device PM QoS.  If
>> constraints are set, send them to DM via the new SCI constraints API.
>>
>> Checking for constraints happen for each device before system-wide
>> suspend (via ->suspend() hook.)
>>
>> An important detail here is that the PM domain driver inserts itself
>> into the path of both the ->suspend() and ->resume() hook path
>> of *all* devices in the PM domain.  This allows generic PM domain code
>> to handle the constraint management and communication with TI SCI.
>>
>> Further, this allows device drivers to use existing PM QoS APIs to
>> add/update constraints.
>>
>> DM firmware clears constraints during its resume, so Linux has
>> to check/update/send constraints each time system suspends.
>>
>> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> ---
>>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 1510d5ddae3d..963272fa387b 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/slab.h>
>> +#include <linux/pm_qos.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/soc/ti/ti_sci_protocol.h>
>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>
>> @@ -51,6 +53,29 @@ struct ti_sci_pm_domain {
>>
>>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>>
>> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
>> +{
>> +       return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> +}
>
> Should we perhaps add a generic helper function for this? Seems like a
> similar check is done at other places in the kernel too.

Maybe, but I don't see a lot of this same usage under drivers/*.  But
I'll have a closer look for a follow-up patch that might be able to make
a common helper for this.

>> +
>> +static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>> +{
>
> Looks like you may want to turn this into a static void rather than
> static int. At least the caller, below, doesn't care about the return
> value.

Yup, OK.

>> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> +       struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> +       const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> +       int ret;
>> +
>> +       ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
>> +       if (ret)
>> +               dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
>> +                       ret);
>> +       else
>> +               dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
>> +                       pd->idx, val);
>> +
>> +       return ret;
>> +}
>> +
>>  /*
>>   * ti_sci_pd_power_off(): genpd power down hook
>>   * @domain: pointer to the powerdomain to power off
>> @@ -79,6 +104,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>>                 return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>>  }
>>
>> +static int ti_sci_pd_suspend(struct device *dev)
>> +{
>> +       int ret;
>> +       s32 val;
>> +
>> +       ret = pm_generic_suspend(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> +       if (ti_sci_pd_is_valid_constraint(val))
>> +               ti_sci_pd_set_lat_constraint(dev, val);
>> +
>> +       return 0;
>> +}
>> +
>>  /*
>>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
>>   * @genpdspec: DT identification data for the genpd
>> @@ -188,6 +229,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>>                                 pd->pd.power_on = ti_sci_pd_power_on;
>>                                 pd->idx = args.args[0];
>>                                 pd->parent = pd_provider;
>> +                               /*
>> +                                * If SCI constraint functions are present, then firmware
>> +                                * supports the constraints API.
>> +                                */
>> +                               if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
>> +                                   pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
>> +                                       pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
>>
>>                                 pm_genpd_init(&pd->pd, NULL, true);
>>
>>
>> --
>> 2.46.0
>>
>
> Other than the minor things above, this looks good to me.

Thanks for the review!   Will spin a v3 shortly.

Kevin


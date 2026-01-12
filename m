Return-Path: <linux-pm+bounces-40652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CAD1203E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23C7530703E8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50234A775;
	Mon, 12 Jan 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b="E48zNa7Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81F34B1AF
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214893; cv=none; b=gehbYaWbhI9Z1JmAeSWdksmSFw4I6oNj+vTF+TJ3UZgyVm8LF7Z0bf4sqR8612LWCLSSJZ+2gAR8e8qKbX4J4mmgwJ9yp3IAjc6Z9LKbl3uoCDtGcvSMsiY1+vBZly9/00DTn/ZyWYcizgmPI2mbPV7T8Y0bzcnL2Ftug2PmWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214893; c=relaxed/simple;
	bh=h9irR6eVurAKciv1oXiCxDlOjpaZDVtUtq4Z9myQB5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODyJEOXMedTli0PqQYoDMgdurGsSXzkfFii0TGVX/DQKYl5+qKRDc5DmRyOcbb9prLQ6biZV7JZFyvLUp7up2ZjSc7PMq4P5cSHbBbSoCJ30n1WjdMVLxkmaHMplhX4t5eGHYikzrQlrXtcofTVLn38z97tfpKistcVwY/srPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net; spf=pass smtp.mailfrom=summations.net; dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b=E48zNa7Q; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=summations.net
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fba1a1b1eso75368137b3.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 02:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=summations-net.20230601.gappssmtp.com; s=20230601; t=1768214890; x=1768819690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYqnD643rP0xFCjQr1d58+6MQqBgB19G/KQFekbT4n4=;
        b=E48zNa7QgIsiDM+/VfNv2N5LbC2E8RoIoB+iUzN0+D5FlCOUUkqJ5fhRDVKGz7ATM7
         qlj/moOY0pmZ9F152DGWGTM73glzQNCVBevGRmK1njq6/7pEx+BS3Ap3ofQZ9l34YgMz
         4qZYPRugvrofzX/jB6QErWrKvZ50nUh9fIpCas3LMWdaMtjgWR8f7ikRAXkpNXAeaEi0
         rcYrDYIjp4K0kcMjaiP3NZf2OhSSpjeyfzhTrAyEwcIgKB/nTrS7lT5A8l4kuouSl1T1
         ssWzx14T1CPDymF6HEyjFyuBNbKUB9c/7p1W9CA5asGQVxccIn4vh8d/9ZJos1c1jEGF
         2nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214890; x=1768819690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYqnD643rP0xFCjQr1d58+6MQqBgB19G/KQFekbT4n4=;
        b=LDwnPDZF7NXdNF0A/dmmUv/uLW9YhFJKNnCM9YtmoqLB1dM3kXmWmSSBS+OCeBu1Ly
         zTHWFxtWMXRqetq4t1l1dA3CFUsAFWBQwhBgqv3VocLzKxUKXMsfDdfOATFohYyBgMNt
         BpDpdX8dnT5HxfT/B93s/beapi/yDU1+qyLSJEn0/HlLgN9jzFeKJVSc0uonB3WHGyLE
         7me+W4GVonB5oJzBYMbJ6Waa3WXmJlt4AxMis4CEf4hHfbprF0ju8QsEk/LxvbB8p3jD
         X0HOz5DuJAFlsigUtCBDboDAtzolDZViE6ZnCqf0D3gfntYT1hezDi8YFrF1g39UI8lI
         w0nA==
X-Forwarded-Encrypted: i=1; AJvYcCX1bMMdA+jEkBvfy3Cg9RY6dGyExNLfN90CrTkqn8c25lF5kgSLD/olitBiA+P+JDq4CVCaSu6lsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVLtOtNe2IwzraeYhu6To/tl3ENsO+3S/YPJpGaSmFLyFzGRQ
	epkLfG12n4ytIwRtLhylm20C8rtBeTWsMd7YWPbYHzIUztE4N6uNp3sJsGOWAAN7BTZDBLKBPb/
	iquVXyGWiCc2SS0KcQBG2lCojtUAd/09qc5SIsUZvjCw=
X-Gm-Gg: AY/fxX7U9SiwxA3Rir7FC/XVGVrEDrRdjZD9vzQBZxlNVI9RYP92ziavQVHrsEyPrAe
	XoCK9xXbtS4h4DW8MCZYcMpc1GBx2OwIqNYOduwM4QqYfhY+xAV3ZXJ27hlN7AS0tx1fqzXYa7O
	t9xI3h4jjPz3x1Lhlh8BgwG630LJ7LugZHITq/h2G+fGBuSarO2mnSi1oC27bd22J7V7gYvjlO8
	y1lfRtYxqcKPj1HjFrtwS9KYJaT37xQoVwPwPBWQTppe8IlPV42R18iP+Y17d/i/CNvmAZTfWGt
	rqPhHwdpQu0vXj3JPhnw0iBFJqo=
X-Google-Smtp-Source: AGHT+IGSd6S45oI12lA93B0VdFuPS8wsqAp/AtTqvdaME97V+b32RqcikLawp2CIt2dWylh/hgMjUjHf3u3+tihHgL0=
X-Received: by 2002:a05:690e:1209:b0:645:54a9:11d2 with SMTP id
 956f58d0204a3-64716657fdcmr12415884d50.14.1768214889924; Mon, 12 Jan 2026
 02:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com> <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
In-Reply-To: <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
From: Rahul Pathak <rahul@summations.net>
Date: Mon, 12 Jan 2026 16:17:59 +0530
X-Gm-Features: AZwV_QioIQXKqToGHL2PxilyAAbfzG3wtMScBzGleyYaV375JeLJ3r4qOh6p77M
Message-ID: <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: anup@brainfault.org, leyfoon.tan@starfivetech.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, rafael@kernel.org, 
	viresh.kumar@linaro.org, sboyd@kernel.org, jms@oss.tenstorrent.com, 
	darshan.prajapati@einfochips.com, charlie@rivosinc.com, 
	dfustini@oss.tenstorrent.com, michal.simek@amd.com, cyy@cyyself.name, 
	jassisinghbrar@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +
> +static int rpmi_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rpmi_perf *mpxy_perf;
> +       struct rpmi_ctx *mpxy_ctx;
> +       int num_domains = 0;
> +       int ret, i;
> +
> +       mpxy_ctx = devm_kzalloc(&pdev->dev, sizeof(*mpxy_ctx), GFP_KERNEL);
> +       if (!mpxy_ctx)
> +               return -ENOMEM;
> +
> +       /* Setup mailbox client */
> +       mpxy_ctx->client.dev            = dev;
> +       mpxy_ctx->client.rx_callback    = NULL;
> +       mpxy_ctx->client.tx_block       = false;
> +       mpxy_ctx->client.knows_txdone   = true;
> +       mpxy_ctx->client.tx_tout        = 0;
> +
> +       /* Request mailbox channel */
> +       mpxy_ctx->chan = mbox_request_channel(&mpxy_ctx->client, 0);
> +       if (IS_ERR(mpxy_ctx->chan))
> +               return PTR_ERR(mpxy_ctx->chan);
> +
> +       ret = rpmi_cpufreq_attr_setup(dev, mpxy_ctx);
> +       if (ret) {
> +               dev_err(dev, "failed to verify RPMI attribute - err:%d\n", ret);
> +               goto fail_free_channel;
> +       }
> +
> +       /* Get number of performance domain */
> +       ret = rpmi_perf_get_num_domains(mpxy_ctx, &num_domains);
> +       if (ret) {
> +               dev_err(dev, "invalid number of perf domains - err:%d\n", ret);
> +               goto fail_free_channel;
> +       }

The domain space in RPMI performance for CPU and Device
is not separate and a domain can be either CPU or a Device.
How the driver will make sure that the domains which are returned
are CPU only and not the device.

> +MODULE_DEVICE_TABLE(of, rpmi_cpufreq_of_match);
> +
> +static struct platform_driver rpmi_cpufreq_platdrv = {
> +       .driver = {
> +               .name = "riscv-rpmi-performance",
> +               .of_match_table = rpmi_cpufreq_of_match,
> +       },
> +       .probe = rpmi_cpufreq_probe,
> +       .remove = rpmi_cpufreq_remove,
> +};
> +
> +module_platform_driver(rpmi_cpufreq_platdrv);
> +
> +MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
> +MODULE_DESCRIPTION("CPUFreq Driver based on SBI MPXY extension");

NIT: CPUFreq driver based on SBI MPXY extension and RPMI protocol   -
something like this

> +MODULE_LICENSE("GPL");


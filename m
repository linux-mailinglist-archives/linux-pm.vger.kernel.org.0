Return-Path: <linux-pm+bounces-11560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06593FB5B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A82CB229FF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43F181328;
	Mon, 29 Jul 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh/61DJg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4A15ECFD
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270916; cv=none; b=Cko1OWrMvXd2+yg1Gcv26SkjKzw7lpnh0qKs1IagbhlXnO3nbKEglub4RT7GFkM1QeErwXgtNkwuhuZBCkoy5n98/K6bNsK9oJfOSRuXiNsgrvYVR5ejinp2cn+gdwheCnpljiwWxNkFMiHJfxBhlLAfeuB7gqTPTsBja1ntB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270916; c=relaxed/simple;
	bh=YivJhrS46E/GMBdB3MPzAIrHwOVuwiVqrlMsjU1mbgE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=E91HiXKnUpIe+h6Fz3AB9dmF2zZeaNH3x3SuzprY0opCZsKV5MlmqXOeWe7McEf10U09oZlswUa2g/6py6EyTagBoD7o/KjJluUgm14rfW7f5ukXlLV5JMT5vu3M3YEMDMawXgtruG2rmzv8p5raq/dVIfRdw9ne50w6N2qzWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh/61DJg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9e13ef9aaso2442784b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722270913; x=1722875713; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7/CXCNfNGG1B7dfzfqv7Kqbq6aGcDQ7TbuaG3In5pk=;
        b=Nh/61DJgmevi3wt8eu1Jo1KhCd9lwOb7DGfzbG0eIbuj3B2evMsBCt8qz9U4Xd3V3P
         2RaQGk2wVbcnxNRu0QykqTmaLh+g9j1md+jwwIU0frTXhFQJO2iY7uI3tjQV0f8cyCyg
         lC6No7AgKQ8IwQ7ZESwV4B9Eljow7kLu+pA9cTV7RGz9eC7lHfjjGixQSXN/tQoUneAF
         WCLo67q0A3GEiQ2kYDUWPVlfojQaZn4YtF36lkUbPG4Lot/MweKihaUCsYPhl5YBOevi
         XmkS+pE5T/GfFuXkS/pbJHMLyVHu3QrgjchbMMkHCrBE03mI+m25L13u2L/xpWJhJv63
         HNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722270913; x=1722875713;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7/CXCNfNGG1B7dfzfqv7Kqbq6aGcDQ7TbuaG3In5pk=;
        b=XqzAZVd2ESzhtdl/vKWPqWcZhZJJM0+2zGNTblowQ9vx8QrV3fipGU+UTg+GaiXDFx
         eW5WvxjroMRQs5xF9oPvMlv3y4q3dp+adYYl0YSIlfvfSJxmaDyI2GzC+r55/IbSG4Em
         /jLjzI3YN7F4efHIf6Hj9U4+arQ2HoZ8R3WUOWuaWngoNFmldMfmphG9l/wgejgE/5YM
         ZFVfffHQo3GWxEqDEh4H/RieO/S4YgJougLunCSPL6UsDfwV5ypfSNPgjb9kPfxQaGqX
         GsLmNmXwd8L+MiKkAT/135vyop1bNR4sYHGnW1r3ALXFhED0Cwzkj0iAzk9vMBf6dwD1
         uYHw==
X-Gm-Message-State: AOJu0Ywd0bC/xf+P3vdNFBNTqDGjkhDSI/vbMiXrumXTGJJvqVGfjY2a
	vZA6E40BtYixn6CYNvpIuwGo3SAs16X8S9opX9kWpwEMeUtoyl6lFd2erV1S
X-Google-Smtp-Source: AGHT+IGnnGNHZwUnMsSqRJbWQbOFqHS9kJPL2JJmlAF6P44fTPU/YsGyY77kv18UJ7kv2ZXnD/MycQ==
X-Received: by 2002:a05:6808:ecb:b0:3da:a6b7:47f3 with SMTP id 5614622812f47-3db2389b4a4mr12539830b6e.1.1722270913385;
        Mon, 29 Jul 2024 09:35:13 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:e419:4505:26ee:7c64:b4ed? ([2401:4900:1c7e:e419:4505:26ee:7c64:b4ed])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8753ce7sm6337317a12.41.2024.07.29.09.35.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 09:35:13 -0700 (PDT)
Message-ID: <872ea739-632a-4344-9e3d-49f8fb846f8a@gmail.com>
Date: Mon, 29 Jul 2024 22:05:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pm@vger.kernel.org
From: Anish Rashinkar <rashinkar.anish@gmail.com>
Subject: Need help setting asynchronous CPU frequencies.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, I am really not sure if this is the correct place to ask this, 
but I have tried almost everywhere but to no success.


In short, one of my cores in my processor is defective/degraded. It 
can't run at max frequency or else it will crash. Either I have to lock 
down the frequency of all the cores to a lower value, or set that core 
offline.

Access to turbo ratio limits is restricted by the firmware, or otherwise 
it would have been easy to set the working cores to max frequency while 
keeping the defective core to a lower speed. Voltage controls are also 
locked, which could have fixed the problem, and I have already put a lot 
of time trying to gain the access, but it's too risky (firmware modding).

It's an HP Elitebook 840 G5 laptop, with an Intel Core i5 8350U. 4 cores 
with 8 logical threads, It boosts up to 3600 MHz. I have to lock the 
whole processor frequency to around 3 - 3.1 GHz, but it is getting worse 
and might crash on that as well. Or if I choose to disable the core, I 
have to disable CPUs 2 and 6, which is the third core. I have noticed 
that disabling idle states (C states) gives me a bit more stability so I 
can probably raise the frequency a bit more.

All I want to know is if there is a way to run the 3 cores at max 
frequency, while running that one core at a lower 3 GHz frequency?

All my attempts included trying to get the userspace governor working, 
but it is a big mess. Using tools like cpupower or cpufreq 
(cpufrequtils), I can't load the userspace governor directly. The 
userspace governor loads if I disable intel_pstate or put it to passive 
mode, but it doesn't seem to have any effect. After loading it, any 
frequency I set using cpupower/cpufreq doesn't apply. I also tried with 
intel_pstate hwp on/off. And I of course tried manually choosing the 
core in cpufreq but either the changes don't apply, or it gets applied 
to all cores. I also kind of tried manually setting the frequencies in 
the kernel files (/sys and those), but they didn't really work. I also 
tried "intel_pstate=per_cpu_perf_limits" kernel parameter, but that 
didn't really help (I couldn't get the intel_pstate folder under all 
CPUs, and instead I still got it under .../cpu/ like always).

I am currently running Ubuntu 24.04 LTS.


Return-Path: <linux-pm+bounces-27194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0444AB8487
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A21B61DC7
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4252980C6;
	Thu, 15 May 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab91m0vv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF022157B;
	Thu, 15 May 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307449; cv=none; b=KznxCR4ukUWbdKzUoIdd+jOhgihUqjywl7tekQECDJVK9YMSWZtxutN/+BQlnuzhKTso03brUQAJYwzAoudDvXdlfWt/G+2LX5UBwu8HL2iL1mDf3deb+4iwhoLLFvHbn9TTosOIsou/GHpiRIuSTSOxCyvylJGtJcONoBJNXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307449; c=relaxed/simple;
	bh=8MM7pRUzi/+tIllmEpUGU5whAaivVspfR2Lc0gn83vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hipGmudiU4ASbTeZuOQkkuJRo8MdaSsrZHJX2XWwdxM0TgK/Rd+fwTEEokA7H+EnbK3fgqgghKBytHay7/k3HtSE2/Tl57zkymdKpwgLNjNOcIp3Ggwybc98dNHvsBciDK9VBQI0XiOPKsQpL7frXv/+hCBCtcChugEGlHAy0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab91m0vv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so134531266b.3;
        Thu, 15 May 2025 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747307446; x=1747912246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH93pyrIEPQfVMzkjhmhq8lcyU/jh4Z97QhhnrcpdMM=;
        b=ab91m0vvW+GbwgqSmUW7xzVzvPXLSZznSNnS9HC8QCmOcWtndqNyevTooDI0lsqbRb
         PpJIFDRZsMITUtR6MlWHDIK1gEJ9GiiKtLtKZwY4Z3VLJ27KQ0rQ1vlNo9rR7Pou3dHZ
         nk320qT/zxa9tMWkvtG/X1uYKdfzOjBLyCjO2ZWZhFiz7sSuJfoof+SpixX7H0/1CIDU
         NBYcDdZ8Gj8++b0kNZ8vF2HusQjl3RE0LiuscZWCm/vMtpvcpBHUwFw57z+Vv58h0IK8
         /Pwol50PhAIYqHK6mGSFZ8fnFUEMm/V5NK6MS92fCfY9k7aVU6i+M1lp3klHyGohtGBE
         OY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307446; x=1747912246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH93pyrIEPQfVMzkjhmhq8lcyU/jh4Z97QhhnrcpdMM=;
        b=AilVx+ro/UzbjdmCnIiN6v8ienneLW75p0pXQaA1xcIc3iWfYO1lHeMhoOMo84bdeD
         6JXBMECUcvtKEnWu/AlDe2mCI84NwYIbDzUWhZRw9VhVR9Uva5rpvNWU+ueJyMmQ5SQx
         u5ZRYGUh1/MQou4UUnSP6aGEYcu93kXfpV36y6kwW1bgsVt7npc7ooODM3N0NRlouweS
         E922DXQ+wimvX4K644KJVZ7594A2I71N6sOdyKysxrTKFab7A4FydLu6Y0n7ZURuhXD+
         YTon3+jLOwmDZr72tq3tyPB3LM3GzSDz9I30MNPCQ9pyCHeqa7B5AYXJLJcugjKfXmrq
         dhoA==
X-Forwarded-Encrypted: i=1; AJvYcCUMGcCbMYRziR2V62VRoPR3CMdn0s+BslFiVuyDoKfIKs7hMXdlupZGvTR7b83rPktQeFFXMWoPWrxk9OeJe71Tp2M=@vger.kernel.org, AJvYcCUXGArjV2MqveFgv13/SE50Jpbyiv3qahGIpe/eBJU+E5Yxj52QXWoCV6SDV3spKQG8EkvDiEHTXS0To8g=@vger.kernel.org, AJvYcCW4ZADvp7eymEmeC4cVT+1qByTYq2R7NBsd0/pCcaYaQwgbN8f9+yCWn/Vc+2giP2/4Lo6wzmiIXSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQepqUD8BmxaSKw1Vh38M8Ivck3+is3atzn21q3t+xFbT2h7tt
	RUrkaeSgHXv18ljw0tHg5WgUqBzgZTOXix13qWkAX237RnC4+oPqKC+sNkZE0SiPs6qeICZiJ/V
	SKgktJzGROzbpB88W4XUoF4Cpm3k=
X-Gm-Gg: ASbGncvpUoZAbF2TPQ8wG0P6mGV3jjOZsC3u6wjSeGxduQkpCmlrRoAnaRA9Qaf7a5Q
	Gdvc0uPzk2O0VZzB2pkTvADhT9lPyDy5N6iTTaxYJI1N0RhXh/JStNomlStBupBHZVr3hJ85teQ
	jRxqNx1nHds1WEj6Xl95buHRAQKm44Vo6oSCPs8vUSow==
X-Google-Smtp-Source: AGHT+IE0xGxRoRc2hiMiqEaYs/R8BerbabBDK4/6SGlmW7kn9vsBtzHGwphHTBRO8aoYTAxznhm63Sb3LeSpgXFd/NQ=
X-Received: by 2002:a17:906:730e:b0:ac7:e815:6e12 with SMTP id
 a640c23a62f3a-ad4f717d80dmr692300366b.33.1747307445484; Thu, 15 May 2025
 04:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430123306.15072-1-linux.amoon@gmail.com> <aCR9RzGMWEuI0pxS@mai.linaro.org>
In-Reply-To: <aCR9RzGMWEuI0pxS@mai.linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 15 May 2025 16:40:27 +0530
X-Gm-Features: AX0GCFs2e1Pkh4MEeMLO4mfbxvj7Hh0TOcnvMLseg8q2U30qPhgLXLwcneYB4S8
Message-ID: <CANAwSgSA-JHMRD7-19wijOY=TSWD-sv6yyrT=mH+wkUJuvxFAw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 14 May 2025 at 16:53, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On Wed, Apr 30, 2025 at 06:02:56PM +0530, Anand Moon wrote:
> > Hi All,
>
> Hi Anand,
>
> if the goal of the changes is to do cleanups, I recommend to rework
> how the code is organized. Instead of having the data->soc check all
> around the functions, write per platform functions and store them in
> struct of_device_id data field instead of the soc version.
>
> Basically get rid of exynos_map_dt_data by settings the different ops
> in a per platform structure.
>
> Then the initialization routine would be simpler to clean.
>

Thanks, I had previously attempted this approach.
The goal is to split the exynos_tmu_data structure to accommodate
SoC-specific callbacks for initialization and configuration.

In my earlier attempt, I tried to refactor the code to achieve this.
However, the main challenge I encountered was that the
exynos_sensor_ops weren=E2=80=99t being correctly mapped for each SoC.

Some SoC have multiple sensor
exynos4x12
                    tmu: tmu@100c0000
exynos5420
                tmu_cpu0: tmu@10060000
                tmu_cpu1: tmu@10064000
                tmu_cpu2: tmu@10068000
                tmu_cpu3: tmu@1006c000
                tmu_gpu: tmu@100a0000
 exynos5433
                tmu_atlas0: tmu@10060000
                tmu_atlas1: tmu@10068000
                tmu_g3d: tmu@10070000
exynos7
                tmu@10060000

It could be a design issue of the structure.or some DTS issue.
So what I found in debugging it is not working correctly.

static const struct thermal_zone_device_ops exynos_sensor_ops =3D {
        .get_temp =3D exynos_get_temp,
        .set_emul_temp =3D exynos_tmu_set_emulation,
        .set_trips =3D exynos_set_trips,
};

The sensor callback will not return a valid pointer and soc id for the get_=
temp.

Here is my earlier version of local changes.
[1] https://pastebin.com/bbEP04Zh exynos_tmu.c
[2] https://pastebin.com/PzNz5yve Odroid U3 dmesg.log
[3] https://pastebin.com/4Yjt2d2u    Odroid Xu4 dmesg.log

I want to re-model the structure to improve the code.
Once Its working condition I will send this for review.

If you have some suggestions please let me know.

Thanks
-Anand


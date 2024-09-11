Return-Path: <linux-pm+bounces-14024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1F9754DB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139EB1C23166
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D771A3035;
	Wed, 11 Sep 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5f2Qp0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294719E99A;
	Wed, 11 Sep 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063075; cv=none; b=CzmvrtTrzrnsjJb0c6L8X3Dt4EcLu0fn4K75XeQDfBxYrKO6oWb473cHiIdPV6pKQp1q7+hNfsSTA8shpv8x6SQTR8Z7CXuCCogSH5c/A7caWq61+Qiu2EFLae9IvkcrCTqpLUqSHQE7f6J82sVjLzs3dSipReXyw3bVQjru0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063075; c=relaxed/simple;
	bh=r1NGD5raJ2MQjrf5GxAcVcEO1jL57R2JVyy0BogRuxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AA/HKSQsTPH4UYs/mx2gr+tZXYpDnyJ4kUErSvXAMHRei8AoK78fuNzdISBY/j+JvAJdsK6N1YRT1TH+0Cv7AyPA5hbk+DkOX/6mNmF242J8CnLvL3/bgjHy/nUiXQuIT23gJcsXSFlV7bn06b03yQG1jIHF5CZOFhtmuMk346c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5f2Qp0W; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8b68bddeaso4974303a91.1;
        Wed, 11 Sep 2024 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726063072; x=1726667872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=846S//ahiRsd62tWfKpR4CzIL/lJ28fHFQICJLblNNo=;
        b=G5f2Qp0Wk2ivvth8puYgdlnhnBMOrCbOz35OkrXlblcqqd9vY2OvLGnvtQETDlSdC6
         M26KZMqPWBodIeS4QduiKKdcfJVKlBdgm8laILX1zRxescAMB8e/1StnYOa90nFJ8sHV
         95P8JWid25x9sfZHK0RbrBDf/gORZTcoKRovtDdPkCz41Q91MGOkGYQgFSV+yMKsZ5Ig
         /uTGtiSrv8UzuuxJ0E7PhmVNQQ5GJoDZ39iFljxlXEsgSKKMzoB9PqVisMN1huZfp5M7
         SsB9WctCZX008TBtcSnng/zH7HLvHA+pu25c6EFGG75Pv5wfnxuNIjwHyekrvVwTeo8Y
         zx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063072; x=1726667872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=846S//ahiRsd62tWfKpR4CzIL/lJ28fHFQICJLblNNo=;
        b=OKeQz4eq3dUHKVKwUcYHnDkPPyA0EcVKNa4ZMVlYQCU90gq+QqpwuIbJS691HqyWxf
         AXALpPKP5omvS6uXL+JcXj8nJpvZacUMVEGDxRL3G6QOUZlszhTLWqFZXnDBh/lRViJY
         crwqvejMayueX5/659ifTqApsU0Dv+KKF/nA9lBBT4TEBSWZNL5fDI5TyiW8EKGNbTfH
         vINLOx9ihGDRF17s9NgxZen7+KK4iFWXCSMQbZT36KZO7HdQX3Ak/MxJe8CTy9DeZYWT
         u8Wx2KV8f/GtrFQnt3h8UdPcXiYPVrHzxVJfiToDKclXdsWXvJ6+XJe4qbRknttgtjJx
         4/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUXXagaEKZ2HYDEj9XvhBG3B0IMsBEGLI1M8OEyRUFben7l/gjhjwHsBpMQnqEH8613MRv5vTVg1O5FGDIn8NM=@vger.kernel.org, AJvYcCUh1vuZerr4ZfsXcqRHVoALmRXhZfvql4lAdeK4YQrCyTXppcKzaS1lrnoO5gQGK6IxqLstelLhjiW6aw==@vger.kernel.org, AJvYcCUyJTr+TNOIBthPqUGP3S7n9odmX3eSPjfwOBMkmN1v+jkXskhRzTUj+OIkE1p1KBq9EoHDHyizIBvp@vger.kernel.org, AJvYcCVFUwjU04HOGvN3Hp/IhaFMttDmjj191BJzX7OHiHMhDCNlSQfq9T1l0O0HW37Y2EPy/PBZCgxCr/+rNt4c@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMKftaUKSrOAQkdU4hH3hVqVbCviVUOzCtfeQjqF6HyF74jKO
	IVeufdfeGscOfqsswV6G/oJAMH4C/zjk87Dx2oQlzcC9Y9lQg6Ns
X-Google-Smtp-Source: AGHT+IF+D8o83DifRxkHZGsBX543GxpJQvmmcjGhnns7oCQONqsTQQMnbr/5DaBmGPF4/ggGOfDp/Q==
X-Received: by 2002:a17:90b:4acd:b0:2cf:c9df:4cc8 with SMTP id 98e67ed59e1d1-2dad50fa064mr19574703a91.38.1726063072225;
        Wed, 11 Sep 2024 06:57:52 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db8c85c327sm1336350a91.14.2024.09.11.06.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:57:51 -0700 (PDT)
Message-ID: <dd27d389-99ed-45f7-b2ae-c15f2633610d@gmail.com>
Date: Wed, 11 Sep 2024 21:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
Content-Language: en-MW
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
 linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki"
 <rafael@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, Will Deacon <will@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, asahi@lists.linux.dev
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <172606224294.90706.12818129202356312350.robh@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <172606224294.90706.12818129202356312350.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/9/2024 21:50, Rob Herring (Arm) wrote:
>=20
> On Wed, 11 Sep 2024 16:40:50 +0800, Nick Chan wrote:
>> Hi,
>>
>> This series adds device trees for all A7-A11 SoC based iPhones, iPads,=

>> iPod touches and Apple TVs.
>>
>> The following devices has been excluded from this series:
>>   - All T2 devices (A10-based): bootloader does not work (yet)
>>   - HomePod: Not tested, and it's also a different form factor
>>
>> This series supports the following on all devices:
>> - SMP (spin-table)
>> - UART
>> - simple-framebuffer
>> - watchdog
>> - timer
>> - pinctrl
>> - AIC interrupts
>>
>> The following is supported on A7-A10:
>> - gpio-keys
>> The buttons on A11 based devices like the iPhone X is a SMC subdevice,=

>> and cannot be supported in this way.
>>
>> The following is supported on A10:
>> - cpufreq
>>
>> A10(X) has performance and efficiency core pairs that act as single lo=
gical
>> cores, and only one type of core can be active at a given time. This r=
esults
>> in a core that suddenly have its capacity lowered in low p-states,
>> so the frequencies of the low p-states must be adjusted.
>>
>> Patch dependencies:
>> - The required AIC patches[1] has been sitting in linux-next since
>> next-20240906, through the tip tree.
>> - The important serial fixes[2] will go through the samsung tree and s=
hould
>> be in good shape though those have not been merged.
>> - The optional patch to disable 32-bit EL0 on A10(X)[3] has not receiv=
ed
>> any comments (v1 or v2).
>>
>> Authorship information:
>> - The commits to actually add the dts files are mostly made by Konard,=

>> and Konard's sign-off is added by me with permission. I also updated t=
he
>> Konrad's email in the actual dts files. Konrad can confirm this.
>>
>> - Everything else is entirely made by me, including the cpufreq additi=
ons
>> into the dts file for A10.
>>
>> [1]: https://lore.kernel.org/asahi/20240901034143.12731-1-towinchenmi@=
gmail.com
>> [2]: https://lore.kernel.org/asahi/20240911050741.14477-1-towinchenmi@=
gmail.com
>> [3]: https://lore.kernel.org/asahi/20240909091425.16258-1-towinchenmi@=
gmail.com
>>
>> Nick Chan
>> ---
>>
>> Konrad Dybcio (8):
>>   arm64: dts: apple: Add A7 devices
>>   arm64: dts: apple: Add A8 devices
>>   arm64: dts: apple: Add A8X devices
>>   arm64: dts: apple: Add A9 devices
>>   arm64: dts: apple: Add A9X devices
>>   arm64: dts: apple: Add A10 devices
>>   arm64: dts: apple: Add A10X devices
>>   arm64: dts: apple: Add A11 devices
>>
>> Nick Chan (14):
>>   dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
>>   dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
>>   dt-bindings: cpufreq: apple,cluster-cpufreq: Add A10 compatible
>>   dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
>>   dt-bindings: arm: apple: Add A7 devices
>>   dt-bindings: arm: apple: Add A8 devices
>>   dt-bindings: arm: apple: Add A8X devices
>>   dt-bindings: arm: apple: Add A9 devices
>>   dt-bindings: arm: apple: Add A9X devices
>>   dt-bindings: arm: apple: Add A10 devices
>>   dt-bindings: arm: apple: Add A10X devices
>>   dt-bindings: arm: apple: Add A11 devices
>>   arm64: dts: apple: t8010: Add cpufreq nodes
>>   arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE
>>
>>  .../devicetree/bindings/arm/apple.yaml        | 160 ++++++++++-
>>  .../devicetree/bindings/arm/cpus.yaml         |   6 +
>>  .../cpufreq/apple,cluster-cpufreq.yaml        |   4 +-
>>  .../bindings/pinctrl/apple,pinctrl.yaml       |   5 +
>>  .../bindings/watchdog/apple,wdt.yaml          |   5 +
>>  arch/arm64/Kconfig.platforms                  |   4 +-
>>  arch/arm64/boot/dts/apple/Makefile            |  52 ++++
>>  arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |  52 ++++
>>  arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |  52 ++++
>>  arch/arm64/boot/dts/apple/s5l8960x-j71.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j72.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j73.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j85.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j85m.dts   |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j86.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j86m.dts   |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j87.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-j87m.dts   |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |  52 ++++
>>  arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi |  13 +
>>  arch/arm64/boot/dts/apple/s5l8960x-n51.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x-n53.dts    |  14 +
>>  arch/arm64/boot/dts/apple/s5l8960x.dtsi       | 147 ++++++++++
>>  arch/arm64/boot/dts/apple/s8000-j71s.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8000-j72s.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8000-n66.dts       |  15 +
>>  arch/arm64/boot/dts/apple/s8000-n69u.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8000-n71.dts       |  15 +
>>  arch/arm64/boot/dts/apple/s8000.dtsi          | 179 ++++++++++++
>>  arch/arm64/boot/dts/apple/s8001-j127.dts      |  14 +
>>  arch/arm64/boot/dts/apple/s8001-j128.dts      |  14 +
>>  arch/arm64/boot/dts/apple/s8001-j98a.dts      |  14 +
>>  arch/arm64/boot/dts/apple/s8001-j99a.dts      |  14 +
>>  arch/arm64/boot/dts/apple/s8001-pro.dtsi      |  45 +++
>>  arch/arm64/boot/dts/apple/s8001.dtsi          | 167 +++++++++++
>>  arch/arm64/boot/dts/apple/s8003-j71t.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8003-j72t.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8003-n66m.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8003-n69.dts       |  15 +
>>  arch/arm64/boot/dts/apple/s8003-n71m.dts      |  15 +
>>  arch/arm64/boot/dts/apple/s8003.dtsi          |  19 ++
>>  arch/arm64/boot/dts/apple/s800x-6s.dtsi       |  50 ++++
>>  arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |  44 +++
>>  arch/arm64/boot/dts/apple/s800x-se.dtsi       |  50 ++++
>>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |  50 ++++
>>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |  18 ++
>>  arch/arm64/boot/dts/apple/t7000-j96.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7000-j97.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |  51 ++++
>>  arch/arm64/boot/dts/apple/t7000-n102.dts      |  49 ++++
>>  arch/arm64/boot/dts/apple/t7000-n56.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7000-n61.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7000.dtsi          | 147 ++++++++++
>>  arch/arm64/boot/dts/apple/t7001-air2.dtsi     |  44 +++
>>  arch/arm64/boot/dts/apple/t7001-j81.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7001-j82.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t7001.dtsi          | 154 ++++++++++
>>  arch/arm64/boot/dts/apple/t8010-7.dtsi        |  45 +++
>>  arch/arm64/boot/dts/apple/t8010-d10.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t8010-d101.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-d11.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t8010-d111.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-fast.dtsi     |  27 ++
>>  arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |  45 +++
>>  arch/arm64/boot/dts/apple/t8010-ipad7.dtsi    |  15 +
>>  arch/arm64/boot/dts/apple/t8010-j171.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-j172.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-j71b.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-j72b.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8010-n112.dts      |  48 ++++
>>  arch/arm64/boot/dts/apple/t8010.dtsi          | 227 +++++++++++++++
>>  arch/arm64/boot/dts/apple/t8011-j105a.dts     |  14 +
>>  arch/arm64/boot/dts/apple/t8011-j120.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8011-j121.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8011-j207.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8011-j208.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |  45 +++
>>  arch/arm64/boot/dts/apple/t8011.dtsi          | 175 ++++++++++++
>>  arch/arm64/boot/dts/apple/t8015-8.dtsi        |  12 +
>>  arch/arm64/boot/dts/apple/t8015-8plus.dtsi    |   9 +
>>  arch/arm64/boot/dts/apple/t8015-d20.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t8015-d201.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8015-d21.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t8015-d211.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8015-d22.dts       |  14 +
>>  arch/arm64/boot/dts/apple/t8015-d221.dts      |  14 +
>>  arch/arm64/boot/dts/apple/t8015-x.dtsi        |  15 +
>>  arch/arm64/boot/dts/apple/t8015.dtsi          | 269 +++++++++++++++++=
+
>>  88 files changed, 3257 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j71.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j72.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j73.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n51.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n53.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-fast.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
>>  create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi
>>
>>
>> base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
>> --
>> 2.46.0
>>
>>
>>
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in thi=
s
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warning=
s
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to rep=
ly
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy apple/s5l8960x-j71.dtb apple/=
s5l8960x-j72.dtb apple/s5l8960x-j73.dtb apple/s5l8960x-j85.dtb apple/s5l8=
960x-j85m.dtb apple/s5l8960x-j86.dtb apple/s5l8960x-j86m.dtb apple/s5l896=
0x-j87.dtb apple/s5l8960x-j87m.dtb apple/s5l8960x-n51.dtb apple/s5l8960x-=
n53.dtb apple/s8000-j71s.dtb apple/s8000-j72s.dtb apple/s8000-n66.dtb app=
le/s8000-n69u.dtb apple/s8000-n71.dtb apple/s8001-j127.dtb apple/s8001-j1=
28.dtb apple/s8001-j98a.dtb apple/s8001-j99a.dtb apple/s8003-j71t.dtb app=
le/s8003-j72t.dtb apple/s8003-n66m.dtb apple/s8003-n69.dtb apple/s8003-n7=
1m.dtb apple/t7000-j42d.dtb apple/t7000-j96.dtb apple/t7000-j97.dtb apple=
/t7000-n102.dtb apple/t7000-n56.dtb apple/t7000-n61.dtb apple/t7001-j81.d=
tb apple/t7001-j82.dtb apple/t8010-d10.dtb apple/t8010-d101.dtb apple/t80=
10-d11.dtb apple/t8010-d111.dtb apple/t8010-j171.dtb apple/t8010-j172.dtb=
 apple/t8010-j71b.dtb apple/t8010-j72b.dtb apple/t8010-n112.dtb apple/t80=
11-j105a.dtb apple/t8011-j120.dtb apple/t8011-j121.dt
>  b apple/t8011-j207.dtb apple/t8011-j208.dtb apple/t8015-d20.dtb apple/=
t8015-d201.dtb apple/t8015-d21.dtb apple/t8015-d211.dtb apple/t8015-d22.d=
tb apple/t8015-d221.dtb' for 20240911084353.28888-2-towinchenmi@gmail.com=
:
>=20
> Error: arch/arm64/boot/dts/apple/t8010-n112.dts:21.18-19 syntax error
Note: this is caused by missing #include <dt-bindings/input/input.h>
This was not caught due to another error: It was not included in the
Makefile.


> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:129: arch/arm64/boot/dts/apple/t801=
0-n112.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:478: arch/arm64/boot/dts/apple] Er=
ror 2
> make[2]: Target 'arch/arm64/boot/dts/apple/t8010-n112.dtb' not remade b=
ecause of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: apple/t801=
0-n112.dtb] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> make: Target 'apple/s5l8960x-j71.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j72.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j73.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j85.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j85m.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j86.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j86m.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j87.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-j87m.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-n51.dtb' not remade because of errors.
> make: Target 'apple/s5l8960x-n53.dtb' not remade because of errors.
> make: Target 'apple/s8000-j71s.dtb' not remade because of errors.
> make: Target 'apple/s8000-j72s.dtb' not remade because of errors.
> make: Target 'apple/s8000-n66.dtb' not remade because of errors.
> make: Target 'apple/s8000-n69u.dtb' not remade because of errors.
> make: Target 'apple/s8000-n71.dtb' not remade because of errors.
> make: Target 'apple/s8001-j127.dtb' not remade because of errors.
> make: Target 'apple/s8001-j128.dtb' not remade because of errors.
> make: Target 'apple/s8001-j98a.dtb' not remade because of errors.
> make: Target 'apple/s8001-j99a.dtb' not remade because of errors.
> make: Target 'apple/s8003-j71t.dtb' not remade because of errors.
> make: Target 'apple/s8003-j72t.dtb' not remade because of errors.
> make: Target 'apple/s8003-n66m.dtb' not remade because of errors.
> make: Target 'apple/s8003-n69.dtb' not remade because of errors.
> make: Target 'apple/s8003-n71m.dtb' not remade because of errors.
> make: Target 'apple/t7000-j42d.dtb' not remade because of errors.
> make: Target 'apple/t7000-j96.dtb' not remade because of errors.
> make: Target 'apple/t7000-j97.dtb' not remade because of errors.
> make: Target 'apple/t7000-n102.dtb' not remade because of errors.
> make: Target 'apple/t7000-n56.dtb' not remade because of errors.
> make: Target 'apple/t7000-n61.dtb' not remade because of errors.
> make: Target 'apple/t7001-j81.dtb' not remade because of errors.
> make: Target 'apple/t7001-j82.dtb' not remade because of errors.
> make: Target 'apple/t8010-d10.dtb' not remade because of errors.
> make: Target 'apple/t8010-d101.dtb' not remade because of errors.
> make: Target 'apple/t8010-d11.dtb' not remade because of errors.
> make: Target 'apple/t8010-d111.dtb' not remade because of errors.
> make: Target 'apple/t8010-j171.dtb' not remade because of errors.
> make: Target 'apple/t8010-j172.dtb' not remade because of errors.
> make: Target 'apple/t8010-j71b.dtb' not remade because of errors.
> make: Target 'apple/t8010-j72b.dtb' not remade because of errors.
> make: Target 'apple/t8010-n112.dtb' not remade because of errors.
> make: Target 'apple/t8011-j105a.dtb' not remade because of errors.
> make: Target 'apple/t8011-j120.dtb' not remade because of errors.
> make: Target 'apple/t8011-j121.dtb' not remade because of errors.
> make: Target 'apple/t8011-j207.dtb' not remade because of errors.
> make: Target 'apple/t8011-j208.dtb' not remade because of errors.
> make: Target 'apple/t8015-d20.dtb' not remade because of errors.
> make: Target 'apple/t8015-d201.dtb' not remade because of errors.
> make: Target 'apple/t8015-d21.dtb' not remade because of errors.
> make: Target 'apple/t8015-d211.dtb' not remade because of errors.
> make: Target 'apple/t8015-d22.dtb' not remade because of errors.
> make: Target 'apple/t8015-d221.dtb' not remade because of errors.
>=20
>=20
>=20
>=20
>=20

Nick Chan



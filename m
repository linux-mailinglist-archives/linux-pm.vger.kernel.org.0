Return-Path: <linux-pm+bounces-33625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9CB3FA6C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BFF3AC3EE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6F2EAB73;
	Tue,  2 Sep 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrEsmS4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A8275AE4;
	Tue,  2 Sep 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805409; cv=none; b=JuLXT1T1Bi34AEkiB1/vPmjU+AEqiMOCXbnAYUcTPBG9ozOaKrhmB68Gui7rJIIbgnv/MS9d+4+FlhMmGUtpAOzX1XU4BsoYWPVH+XzYBlBEwKZ8Ng+zzyWNf3eOXHuXaIWPehJsd8TQli7/4JYWCNNOqahYSgaeHB1UuguD89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805409; c=relaxed/simple;
	bh=aLweEdgVdtXKhjU2Dm0VS5DMHPmFRxoY7Gp6xg4UMnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acovlMLPeyPxmgc7oH10so4HKsN2yyuNXCX1K8HHPxWIftgThC+vs1YvVPACuaPWVfEA+/NThwj5bpN4AeKK30GzYSGmDqTbeVelUDIwW3eGh38DOY9daamsuBmaenGy5Y/6B69qbOTYaWZk42IKH6LIVdpBBYSkrbINAJXgFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrEsmS4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FEBC4CEF7;
	Tue,  2 Sep 2025 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805408;
	bh=aLweEdgVdtXKhjU2Dm0VS5DMHPmFRxoY7Gp6xg4UMnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IrEsmS4SJcBW4kwpziEUSQq8HfC2G+ftvwtZxv2r8gDapBrRk2eosUhiNxm0xrfQf
	 EqZP9i4I9UuzHtGS9p8l7yXB3HL1sY43Y9wAhNyf0vS3P5lKnu1iAPQPe5ryKRaHnt
	 e2qnZe8txMvJZNBV6olHXMRy8Yw/6sbHO5gkXaIzGKf/onlRJsn8HahaEtlT5hQDh7
	 j5yekU3PlW4snc8thZ4GI257jH8OtawjUHkm47SHjTT0p9LKPgYqJ0GWATFOeubB3c
	 /D68kVwshl7sOP/3UHAv5whbQOtrD4CPsbHm/uvDvAxKad/WibQXaEBY6fStzVribG
	 akmOlpRmkfyyw==
Message-ID: <3fc54ddb-3947-4c2b-825c-01c16d4c7dab@kernel.org>
Date: Tue, 2 Sep 2025 11:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: exynosautov920: Add tmu hardware binding
To: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>,
 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
 "'Rafael J . Wysocki'" <rafael@kernel.org>,
 'Daniel Lezcano' <daniel.lezcano@linaro.org>,
 'Zhang Rui' <rui.zhang@intel.com>, 'Lukasz Luba' <lukasz.luba@arm.com>,
 'Rob Herring' <robh@kernel.org>, 'Conor Dooley' <conor+dt@kernel.org>,
 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250825064929.188101-1-shin.son@samsung.com>
 <CGME20250825064933epcas2p40a7c491366097f90add675bc36822ef9@epcas2p4.samsung.com>
 <20250825064929.188101-4-shin.son@samsung.com>
 <e573cfc8-be9c-482c-9b06-4eedbb92d520@kernel.org>
 <000501dc1be8$e9ac0640$bd0412c0$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <000501dc1be8$e9ac0640$bd0412c0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/09/2025 11:06, 손신 wrote:
> 
>>
>>> +		cpucl0right-thermal {
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see Documentation/devicetree/bindings/writing-
>> schema.rst or https://protect2.fireeye.com/v1/url?k=004c918d-61c784be-
>> 004d1ac2-000babff9bb7-06e007e7dc12091d&q=1&e=d6a22592-2d45-41f5-b737-
>> a90830cceaeb&u=https%3A%2F%2Fwww.linaro.org%2Fblog%2Ftips-and-tricks-for-
>> validating-devicetree-sources-with-the-devicetree-schema%2F
>> for instructions).
>> Maybe you need to update your dtschema and yamllint. Don't rely on distro
>> packages for dtschema and be sure you are using the latest released
>> dtschema.
>>
> 
> Actually, I also updated both dtschema and yamllint and ran "make CHECK_DTBS=y W=1 exynos/exynosautov920-sadk.dtb", but no other issues were detected.

Thanks

> I assume that the problem you mentioned about "cpucl0right-thermal" might be related to the regex.

You actually fit exactly in the limit.

Best regards,
Krzysztof


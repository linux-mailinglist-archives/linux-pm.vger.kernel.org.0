Return-Path: <linux-pm+bounces-14501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89CB97CE9E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35FE1C2200F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA014387B;
	Thu, 19 Sep 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bot40MdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA22B9B8
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779688; cv=none; b=qDNfxBxWVbJd5tpEsUrPDlf8Xtqol4g7WIgLArQW/ybOlbQ/Soc/RHOwjcMf5m7wPelNqZzoZhZUYGT0ArO4Sgy1msvuPCNwuWuwTSx1XrZZUCMQ5k+8Fv4JYWEDsOJWRL8AAX3GIUOdSWxPIfhUDMj/3ErxGvOfBekSY0mvYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779688; c=relaxed/simple;
	bh=/IAYqVgnqJ3z4TN4X7jBK/t1/qCLeiqkdJchA9131AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5xNlVUBOESjN0nEyEJBA/K9VPLfBIiWIrYFdY/DsaKySmXIPTU9IzkXl6o/Tv5zmwqIcYEEymHlwNgcgZr5Zmrp77ac+vs6MD6pCM1LbGjgbta9JE+/GPq9/UMLRDjvOoUD/Bl6JSj3O1Vf3SUVD1AUBO9P4xpVMfLdVP5b/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Bot40MdD; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726779662;
 bh=ysV7DgRTroxxirI/BOSZHtoFA/sZ7Gtm5p2xeaatD/o=;
 b=Bot40MdDSgssinmEy6CSoZy2qhKkP5SUg2s2+K3F4eQcvVeZN8YguJ+zSeS+B5q59I1JIEHwz
 sCUYCwDR8qNuPXdONGoAfCkSuScYul30i9WnmdW4bgarklyNcnjcpHpcNJqHGrC6xGcaU9UGABY
 pKho5CyDSI+NGVAzjnTCr3k3cL75pMlAiS+yUXwQs0VfXRvBeXISQLZqdlV2RDgLtH1JqqyXdXS
 VDhyPOeEkEj9wnFKN3KrVnnO7Tq/VlrJm1XEC0Sy/PVPpoiq/Pjjk7vG09N7kzTnDSKmSk5Lf56
 vN9Mg3A+UWJqc7oL0jXZ7qO1LgINqSBASTEFsztE65fA==
Message-ID: <e55c3d9b-52fb-48bf-8336-238f8922dfe5@kwiboo.se>
Date: Thu, 19 Sep 2024 23:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: rockchip: Add GPU power domain
 regulator dependency for RK3588
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Elaine Zhang
 <zhangqing@rock-chips.com>,
 =?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
 <20240919091834.83572-7-sebastian.reichel@collabora.com>
 <a4d94eab-8543-45e1-b657-fa7f12470538@kwiboo.se>
 <zvzrjkacazxbv4cjxcnihv4rb2t3tu2zjd6zkny63ygfifpz7i@j4saijws5rcp>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <zvzrjkacazxbv4cjxcnihv4rb2t3tu2zjd6zkny63ygfifpz7i@j4saijws5rcp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ec910b64435c8d6510b3aa

Hi,

On 2024-09-19 21:27, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Sep 19, 2024 at 01:33:25PM GMT, Jonas Karlman wrote:
>> On 2024-09-19 11:12, Sebastian Reichel wrote:
>>> Enabling the GPU power domain requires that the GPU regulator is
>>> enabled. The regulator is enabled at boot time, but automatically
>>> gets disabled when there are no users.
>>>
>>> If the GPU driver is not probed at boot time or rebound while
>>> the system is running the system will try to enable the power
>>> domain before the regulator is enabled resulting in a failure
>>> hanging the whole system. Avoid this by adding an explicit
>>> dependency.
>>>
>>> Reported-by: Adrián Martínez Larumbe <adrian.larumbe@collabora.com>
>>> Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts         | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                | 2 +-
>>>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi          | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts               | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts             | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts           | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts              | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi               | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts           | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts        | 4 ++++
>>>  arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts          | 4 ++++
>>>  12 files changed, 45 insertions(+), 1 deletion(-)
>>
>> Any reason why following rk3588 DTs was not updated?
>>
>> rk3588-evb1-v10.dts
>> rk3588-quartzpro64.dts
> 
> These two I skipped initially, since they have the GPU regulators
> always enabled due to the coupling. I'm not 100% sure if the GPU
> or the GPU-MEM regulator (or both) are required for the GPU power
> domain.
> 
>> rk3588-nanopc-t6.dtsi
>> rk3588s-gameforce-ace.dts
>> rk3588s-odroid-m2.dts
> 
> ... And these I missed, since they are new.

Great, so no technical reason :-)

> 
> I don't have enough time to prepare a v3 before my vacation.
> Note, that not describing the regulator just keeps the current
> behaviour.

Yeah, remaining boards can be updated in a separate/follow-up series.

> 
>> I also expect we may need to define domain-supply for the npu on
>> rk3588 and also both gpu and npu on rk356x in a future series.
> 
> Yes, I already discussed that in Vienna with Heiko and Tomeu. The
> binding change also allows adding a regulator to the NPU power
> domain.

Great and good to know.

> 
>> Similar freeze issue has been observed on rk356x when booting vendor
>> kernel with npu support enabled using mainline U-Boot and DT [1].
>>
>> To work around that issue on rk356x the npu regulator could be changed
>> to always-on/boot-on to get past the kernel freeze [2].
>>
>> [1] https://github.com/armbian/build/pull/7025#issuecomment-2291067748
>> [2] https://github.com/Kwiboo/u-boot-rockchip/commit/da31da4b68f858f54364a21b0dd00fef2ab0d0d6
> 
> Yes, that looks like the same issue and I guess the changes to the Rockchip
> power-domain driver should also work for rk356x. I don't have one, though.

I will test this series and try to add domain-supply for GPU and NPU on
a few rk356x boards, should help avoid possible issues in future.

Will also send a U-Boot series to enable RK806 PMIC support on a few
more rk3588 boards, should help ensure always-on/boot-on PMIC regulators
are enabled before Linux is started.

Regards,
Jonas

> 
> -- Sebastian



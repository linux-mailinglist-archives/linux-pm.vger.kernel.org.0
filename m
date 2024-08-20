Return-Path: <linux-pm+bounces-12590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F999590C1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 00:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7D82855B5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2A1C8240;
	Tue, 20 Aug 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="GY0lVgmt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="exyd1ygN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149591C7B6B;
	Tue, 20 Aug 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194652; cv=none; b=iC5QfIBi2/LrhCMVxEkhOzmtQ1gxtn4sc5xNKICh7qUsygGLgy+Vu3k3H1rv7Th6RjRffQo/oXwp3AXj0BfYrk8FDqr5abmB9pY9jBpgbgt4UONzHWkBJsRBgtCELLMrU64o4MC3PNAMolVIAzj/sbc5zPO6lCJvnxzAu3mbhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194652; c=relaxed/simple;
	bh=oGNqyxMTBnf5CEHIGtzGKsN9OqtijAcamHqYU9u7TOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLY1wgTQX9ybRMWH8XWhxFjzjTRFR1VDB8lIKeR0m1/mgKTnUtCqIIGK4ZJytCRiVpshIHN3f4dr7CmZef1L8bmkwDb4nwsRtn/ptQCTBTuRnS4fgjXgg0ynpp11ADjghYalteqdrNkiDp1s5tw59D6ZmmLIpc9TIbHsM3g1Y6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=GY0lVgmt; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=exyd1ygN; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=vwrbeD1s0ZUH8KYAay1+8ES8I9sXnkLa/vjL4IPaw+k=;
	t=1724194649;x=1724284649; 
	b=GY0lVgmtthM9QdVQ+3Ih8HIiRchsRPe/uQ4+qR8h/5x/w/IR4NyJVwZqMPnH0i9fc7wTbEpfpj9cSQnMur7ggdmtaGnplygShEDYLsCaJgAZ+8W34T4kLYNWvi/Tq2MyS/suwlbbakGO515rgo2yzYSplRZmpr3d/H5E6bUtmJQ=;
Received: from [10.12.4.27] (port=41228 helo=smtp53.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sgXmx-008WK6-Cg; Wed, 21 Aug 2024 01:57:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=vwrbeD1s0ZUH8KYAay1+8ES8I9sXnkLa/vjL4IPaw+k=; t=1724194639; x=1724284639; 
	b=exyd1ygNee1iJhmVfkuH4iPUfVA7aGSad+9Vg+plo2NIm7TbbizF6zV0Cxnyu8O6XTR9uOOgH0q
	1yXh1GAC62Baay9KirYCIi7KE2NcsKzSyA4IqADm+dTZLBLs6bV1SrUwp8/FPXXjc8PqfgOEXkLX5
	UudqnX0HXGfFryT2i9Y=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sgXjz-0000000GNxU-1kQ0; Wed, 21 Aug 2024 01:54:16 +0300
Message-ID: <16b934a2-790a-4ac4-8ff5-40371bba17fc@jiaxyga.com>
Date: Wed, 21 Aug 2024 01:53:44 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
To: Konrad Dybcio <konradybcio@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
 quic_rjendra@quicinc.com, davidwronek@gmail.com, neil.armstrong@linaro.org,
 heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
 linus.walleij@linaro.org, lpieralisi@kernel.org,
 dmitry.baryshkov@linaro.org, fekz115@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, danila@jiaxyga.com
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-9-danila@jiaxyga.com>
 <90a95443-65c5-44e8-8737-26145cda1e35@gmail.com>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <90a95443-65c5-44e8-8737-26145cda1e35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD93D5A650E6D4F687EA368CFCD50A579C26BC8BA9A143473E3182A05F5380850403EDF3585AB1C33CC479CDAE959BF6424E182FF048F7445654C35F6AAE6F2F55F2A407B5933F66546
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77DA205A7C6971420C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE795530B80AF2ADB7BEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36AE2346A62B98862FF42258DB4154486C524172F484B1C819A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3FD59DAE6580CC3C3117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF767A2104B63FB6E3BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B66040CC107394EA4476E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CDDB9BF3B882869D543847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A58670FA3E082EDBF25002B1117B3ED696DBDEC4C3A462A85D4869453249F34FA4823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DABDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9DA68E31ED717FD7627C262F985FA2056C286B6B5C8FE427DBC40ABBAE269DA2EB3733EA1EE6A1F2D14E51FF79EEE603FF10C8D3F7177B1EF82D60FA28E7E662ABA3A6A33CB01D045218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojObjYaDouKIxLN2U4L8NKgw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949813B13A47B4B72064804DE63E6493D460555108C68A5762622862595860A988FAE2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B48C57FD6B8CC3B424390429A196B69D19035DC1BC96C411AC049FFFDB7839CE9E287F2334823BA3356C4F1F7472B9B603B1F746005E81039BB3421FA2CA483764
X-7FA49CB5: 0D63561A33F958A56BF5A0430E06AB6452E041DF2CB2AF2FB07EE11AED78F12B8941B15DA834481FA18204E546F3947C540F9B2D9BA47D56F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637E12249F0E86D8F40389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3D5430F8B4ED6768135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojObjYaDouKIxeX5oWV92Orw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 8/20/24 03:48, Konrad Dybcio wrote:
> On 8.08.2024 8:40 PM, Danila Tikhonov wrote:
>> From: Eugene Lepshy <fekz115@gmail.com>
>>
>> The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
>> is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).
>>
>> It uses the Kryo670.
>>
>> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
>> new file mode 100644
>> index 000000000000..5b4574484412
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
>> @@ -0,0 +1,17 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Eugene Lepshy <fekz115@gmail.com>
>> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
>> + */
>> +
>> +#include "sc7280.dtsi"
>> +
>> +/* SM7325 uses Kryo 670 */
>> +&CPU0 { compatible = "qcom,kryo670"; };
>> +&CPU1 { compatible = "qcom,kryo670"; };
>> +&CPU2 { compatible = "qcom,kryo670"; };
>> +&CPU3 { compatible = "qcom,kryo670"; };
>> +&CPU4 { compatible = "qcom,kryo670"; };
>> +&CPU5 { compatible = "qcom,kryo670"; };
>> +&CPU6 { compatible = "qcom,kryo670"; };
>> +&CPU7 { compatible = "qcom,kryo670"; };
> This is a meaningless marketing name. As you mentioned in your
> reply, cpu0-3 and cpu4-7 are wholly different (maybe cpu7 even
> has a different MIDR part num?), we should do something about it :/
>
> Please post the output of `dmesg | grep "Booted secondary processor"`
>
> Konrad
Sure:
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
[    0.020670] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[    0.036781] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[    0.052717] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[    0.070194] CPU4: Booted secondary processor 0x0000000400 [0x411fd411]
[    0.089236] CPU5: Booted secondary processor 0x0000000500 [0x411fd411]
[    0.109298] CPU6: Booted secondary processor 0x0000000600 [0x411fd411]
[    0.126140] CPU7: Booted secondary processor 0x0000000700 [0x411fd411]

Best wishes,
Danila


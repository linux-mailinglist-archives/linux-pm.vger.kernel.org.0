Return-Path: <linux-pm+bounces-12391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E32955EB9
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85E51C20C64
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9795D14A095;
	Sun, 18 Aug 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="kdZ55mMd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="hB8capu5"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590249652;
	Sun, 18 Aug 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724009645; cv=none; b=MQtP0pva1TLC2dI09zaLzhjgxUBsZhNlW84MiR/G6myLuxllirFkS7p3WRr30RVPuJyfm87OlFRDKp7vPtEn8alYT7+bts24m236IgLXUoZh8H3Vx0Kp9jSxQOfxZ8aUFlwzBzkhfY/lIkX6v1X2GDK6QwnfSB3etyacgpqk+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724009645; c=relaxed/simple;
	bh=fFNHhBw7SepXzc4a+MSRVJIgxPJEfucKkKS49yTR+Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjK2AYfBDAeG9z/bnjWnPibHgDyyH0XW0pp5XyjbuuLKNiPmfDY3hzlV0KaWPB5qIrNCY1cwxNGaOWQijvF9/0gJkS0eQI9O4/GvuyBkEKdQKMu0gCjR89Njf2e0hxZm7DPKlqHA/IC1ybNYaVNhi+00DBWuLDJFVU3vnC3m3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=kdZ55mMd; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=hB8capu5; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=o4HZngv5rT/F7nsPp7nt2xKTa8/c2OQBUvaQfl8HL50=;
	t=1724009643;x=1724099643; 
	b=kdZ55mMd27DEcCdZt9iwNXtPi7G3DJTmw+v420f0r6BMrxNlHgD9CptjNQpxhd6712vdqL4pdRDuhggx8NwiHoYqzEnk6fHthrzNwfkBIKVdIw6B5O10y7JEYVwwYiN2jXuBzkOBMYTgw5PJpGA7dQC/1zyC0AcWPomtNw8Y27s=;
Received: from [10.12.4.18] (port=58814 helo=smtp45.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sflf0-00F15U-O1; Sun, 18 Aug 2024 22:33:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=o4HZngv5rT/F7nsPp7nt2xKTa8/c2OQBUvaQfl8HL50=; t=1724009634; x=1724099634; 
	b=hB8capu5s0GD9KDaoX/mRK1inzTrR59mHF1wmPEX8OJKdVHXWVhlXRGt3u/zSOkQJ0o4Dio9MPR
	+sPgv+PQkgDXf/rQ0NIH/R5D3AdZhRUJbi9oUxA64nr025qY9gYL1U25D8p7+VYlbHse7EidNZ6xI
	YIdhUFgowY84YsVRzDM=;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sflek-0000000FQjW-1vei; Sun, 18 Aug 2024 22:33:39 +0300
Message-ID: <e07928be-0557-4ffd-94bc-af27c20e33f1@jiaxyga.com>
Date: Sun, 18 Aug 2024 22:33:12 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
 quic_rjendra@quicinc.com, davidwronek@gmail.com, neil.armstrong@linaro.org,
 heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
 linus.walleij@linaro.org, lpieralisi@kernel.org,
 dmitry.baryshkov@linaro.org, fekz115@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-hardening@vger.kernel.org, danila@jiaxyga.com
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-9-danila@jiaxyga.com>
 <20240808213840.GA2186890-robh@kernel.org>
Content-Language: en-US
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <20240808213840.GA2186890-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9DAB542EDD08389FEC0D4D473505DD1DFA118E75647FAA451182A05F5380850404C228DA9ACA6FE27F22E522AFCF42B6F411046492FDDF806A43285A420280F99254A407EEDDCE0FFECA116FACD37B17E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77FFAFB2D05C67BA5C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7F1942E6D70B4A2F0EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F364FCAE00AC63E4D344E0FA9B1E382502B34085D59ED5AE7D6A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE71AE4D56B06699BBC9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFDAEA9A8D61B93628BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6E235F5DB53CB48D176E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CCD798FA1FEA6F93543847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A515A109684F90559B5002B1117B3ED69677F6881DED10522FB2920F75BA9A967F823CB91A9FED034534781492E4B8EEADA333A05395E4745BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4719DA0A4BDE4E13B03224382D39891DE4A752C9C77792DDB215187008F1B1865585C02E945303B3ABF86C07854D9473764F887D24D13FA9020A672009A07231C3ABF2E6E3ACDC07F3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxd0rRjfnTmYB1ygV5EDysA==
X-Mailru-Sender: A29E055712C5B697A0B4B50D4D88F0E89028E65C052CC894B951B70A5BD4BD8E190E4F3972368560F43CCAED39DA92F1210985D6C440852E55B4A2144138A88088F510C62CFD139357C462056C5AD9112068022A3E05D37EB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B401572549E177C9B7D4324AF0E71CFA3412DBEA2A235AFE98049FFFDB7839CE9E4D3E270CF25C1BA899EADCEB3EDF85C710D6FFF6664A2A9344C3625B2484981A
X-7FA49CB5: 0D63561A33F958A5B0A153F8AF8C32D584B7A1AAA7F71869D82399AE838F212A8941B15DA834481FA18204E546F3947CD7F4798FD4FA8F52F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CFE05210CFCCB54F389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3798C2A1F5A143BF035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxd0rRjfnTmavKFLmE+T3og==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 8/9/24 00:38, Rob Herring wrote:
> On Thu, Aug 08, 2024 at 09:40:22PM +0300, Danila Tikhonov wrote:
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
> No PMU? Because PMUs are also a per CPU model compatible string.
>
> I fixed most QCom platforms recently.
>
> Rob
A patch has been sent to fix this in SC7280:
https://lore.kernel.org/all/20240818192905.120477-1-danila@jiaxyga.com/

Best wishes,
Danila


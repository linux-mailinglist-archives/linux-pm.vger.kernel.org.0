Return-Path: <linux-pm+bounces-12387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E148195593F
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3292827AA
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7D155393;
	Sat, 17 Aug 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ByX+mSsp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="EL1yu9zo"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FB28EB;
	Sat, 17 Aug 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723918271; cv=none; b=PwTQQMsXw2m8tHPzazRd4UWqhVApk9Nv3kOysj+Xi+apgHwdFKg35EDlkIj3vypFNfIwcPtyI+vHqPdyrNEl2zZBf8BXbpvJAtA6lUPjCQ7fJBk4unSRZ414MmLD1WWhrORWinCAD4tRWx1efzdjha4z6sW5pav6nAz5N9C99WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723918271; c=relaxed/simple;
	bh=AVp//s0lSnFT/gjcaoLYmtUIGkRGxlizOY521JiEB6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHVpX6cmDjuIyGuS4/DKeITLvF+Id2kVdbSwgcCnKUyVIZeYA0msQeGrv5jQnXOrfOaPhFuM+rViRVZ7zgZ3czgYv7o75F9ykX/clAUCqy5PovjnZ4TvZ9X/MrLd+X+6qashWeo/Z15Zkijpzx6z5BwfYiXwBSVV26XUFpP/B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ByX+mSsp; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=EL1yu9zo; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=zlgf2AOwePqK6FG+w95xqWUqsbdk8Vbbx7fJaiNZjDI=;
	t=1723918267;x=1724008267; 
	b=ByX+mSspjQz7AXHL1W6ZvCMFsqa9lEFmaIgNKXynW+/xww3wf3LMdJhR+ntN3pqPzmsqCKGshW98pZpX4eQLcy2cSFTH+vt1r9rNMYoVoNFvdpYVCj89S2V0NiOWcTSJmWv6+udiq4mnqSjLMaUtNPAQpDbc5NxY4rTum1JtKb4=;
Received: from [10.12.4.11] (port=38818 helo=smtp36.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sfNtC-00CANR-DJ; Sat, 17 Aug 2024 21:10:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=zlgf2AOwePqK6FG+w95xqWUqsbdk8Vbbx7fJaiNZjDI=; t=1723918258; x=1724008258; 
	b=EL1yu9zoLrhrG5ya9Tp0pQ7+WvuQa2XXCNfUGpCz5EU1I2gxz9PoS0SE+Q6bc2E/3jpL6+YXhpQ
	b9D/XoXuuiKcp6fS12yQxJZO7gJAv4Ea5cJMOjGZlaKuFRLMgu633migwn2jwTDriS6ap6J0f9kb2
	9a5F7XIYzf/8q9xDEag=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sfNss-000000026Hs-3AW4; Sat, 17 Aug 2024 21:10:39 +0300
Message-ID: <95143a74-fc99-44c5-b531-7ee6592e90fd@jiaxyga.com>
Date: Sat, 17 Aug 2024 21:09:36 +0300
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F97E3C14763C38E2B49BF32E3CF5E697820AD0F0F569587B182A05F5380850405DD4E28DF80797D4F378A8CA21F699D63FF6E942EC97826550495EDABC3E26FF28F6E30EDECEFBB7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE707FD2F46D4FEEE7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE742D9BD90C58D50E0EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F362622D9C046E6C2F9BFA450558D76F9A7A1E70F4AA8C8D3C5A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C353FA85A707D24CADCC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249C90CCF169561558D76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B1058D73F572F8C9C3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F7900637B8FA30D9455089A722CA9DD8327EE4930A3850AC1BE2E735B58781B77DE60D36C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A575888A723E2F1A535002B1117B3ED6965A82F56E873D118AE41E333F9D1358D5823CB91A9FED034534781492E4B8EEADD8DFB5E8F7680678
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC83A27923899AECF1FB2A639080F8BE89A2DF1F7CA3C971E5A176CE007B5F0A1ABDA6BB679979B95ABF86C07854D947323A4DFD6A1FC2D8EE3E210255DE06DA338850D7DA067A4D3F3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojIe453ei104iebaOCsq8W0Q==
X-Mailru-Sender: A29E055712C5B697A0B4B50D4D88F0E812B81114E1CFE4BCB951B70A5BD4BD8E106330280E48AAB1816609AA8FC7A761210985D6C440852E55B4A2144138A88088F510C62CFD139357C462056C5AD9112068022A3E05D37EB4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B401572549E177C9B7D4324AF0E71CFA34F55FA1609B84649E049FFFDB7839CE9E4D3E270CF25C1BA8D7D7543F117F32A52A611564838E62DFAB7393533C27C09B
X-7FA49CB5: 0D63561A33F958A52619C82CD0D4DAC8F82334E4AC32B7C745D63D456A2A8FA38941B15DA834481FA18204E546F3947C874EE23814B0CD5BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A020B077D7195691389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3271F372ED763686635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojIe453ei104jd03IubReQHA==
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
Sorry for my long reply and thank you for your feedback.

You are absolutely right. But at the moment I can't confirm that the
sc7280 doesn't use cortex a55 and a78 either. I would fix that in the
sc7280 DTS right away if I could confirm it. I am almost certain that
the qcm6490 uses cortex a55 and a78 just like the sm7325 (and I
hope Luca Weiss can confirm that too)

If anyone with a sc7280 can read /proc/cpuinfo I would be very grateful.

Best wishes,
Danila


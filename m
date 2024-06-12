Return-Path: <linux-pm+bounces-9017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B7905303
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 14:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514FDB232B7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE517BB27;
	Wed, 12 Jun 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIpK+x9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC517B50C;
	Wed, 12 Jun 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196777; cv=none; b=crkdssjU7t43QVx2/iW66M5MD7zZB5pNOUia2HNHc2Hkc3HSviema7JE+q+fsSzxe+9sqvnQryBoRLpK1b6dE2soImrMYQGs66wN1ShD5w1EuJbtdLmwWPQDWhR/TuxbIbxZ/QxBnxEQuSKOYe1V1NzTpG+chNATZUQaOZxRKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196777; c=relaxed/simple;
	bh=UJ4JudAfMWR1kYmv/khSHntL+ff+3UTdSYyO7febHfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWs7Hjnfic5gMeOQUWNXpkP80ETs4cywj/O8MQuPF4ggLV/BwOinkcspUlE89ARIobHArhuPdmLMxYjRACu215qbg52pbagisKWT2FFD1QO9tbsAg9NVPwq3z6OuTzSX9fHwMxmx23D06LNCYIhdNsN0+8TIaQDRrv60NftoYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIpK+x9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD71C3277B;
	Wed, 12 Jun 2024 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718196777;
	bh=UJ4JudAfMWR1kYmv/khSHntL+ff+3UTdSYyO7febHfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIpK+x9mXFva2OYweYMjCSux8vWn5J5v/aJqWoVm+ATzMjGtGEAYmI+7O5DFPfYfy
	 WBZvR5Uqwl7lrkcGStsaHJWnTxySi5/ae9AJLMgzi7RwzsJ+UY9jmKHZZIh9z81NY0
	 GQBwRbcepXzHDwqrYwfhr2YE8iC2tjfEI0GAC+4Pke+yIzytho7+riZOUe8dJtecNT
	 lAVf9MN1liynoKwkVBM5jvs6QmMV0AXhCMeqpsa8SyiYPsH26lp6Sqh9xPDkp3bIc/
	 zkdQduCZp1FVmH7468ScwcdlFBAH8rpTbk8L15UH5kbNmOd6r664VxC2Kexnsia/b4
	 3r7JPkcyXGrYQ==
Message-ID: <8e32a8be-dbbf-49ca-92a1-2fe3c8bfb571@kernel.org>
Date: Wed, 12 Jun 2024 15:52:51 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
 <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
 <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
 <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
 <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
 <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.24 13:28, Varadarajan Narayanan wrote:
> On Wed, Jun 12, 2024 at 11:48:17AM +0300, Georgi Djakov wrote:
>> On 12.06.24 9:30, Varadarajan Narayanan wrote:
>>> On Tue, Jun 11, 2024 at 02:29:48PM +0300, Georgi Djakov wrote:
>>>> On 11.06.24 12:42, Varadarajan Narayanan wrote:
>>>>> On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
>>>>>> On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
>>>>>>> On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
>>>>>>> <quic_varada@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
>>>>>>>>> Hi Varada,
>>>>>>>>>
>>>>>>>>> Thank you for your work on this!
>>>>>>>>>
>>>>>>>>> On 2.05.24 12:30, Varadarajan Narayanan wrote:
>>>>>>>>>> On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
>>>>>>>>>>> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
>>>>>>>>>>>> On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
>>>>>>>>>>>>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
>>>>>>>>>>>>>> there is no NoC scaling. Linux itself handles these clocks.
>>>>>>>>>>>>>> However, these should not be exposed as just clocks and align
>>>>>>>>>>>>>> with other Qualcomm SoCs that handle these clocks from a
>>>>>>>>>>>>>> interconnect provider.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hence include icc provider capability to the gcc node so that
>>>>>>>>>>>>>> peripherals can use the interconnect facility to enable these
>>>>>>>>>>>>>> clocks.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>>>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>
>>>>>>>>>>>>> If this is all you do to enable interconnect (which is not the case,
>>>>>>>>>>>>> as this patch only satisfies the bindings checker, the meaningful
>>>>>>>>>>>>> change happens in the previous patch) and nothing explodes, this is
>>>>>>>>>>>>> an apparent sign of your driver doing nothing.
>>>>>>>>>>>>
>>>>>>>>>>>> It appears to do nothing because, we are just enabling the clock
>>>>>>>>>>>> provider to also act as interconnect provider. Only when the
>>>>>>>>>>>> consumers are enabled with interconnect usage, this will create
>>>>>>>>>>>> paths and turn on the relevant NOC clocks.
>>>>>>>>>>>
>>>>>>>>>>> No, with sync_state it actually does "something" (sets the interconnect
>>>>>>>>>>> path bandwidths to zero). And *this* patch does nothing functionally,
>>>>>>>>>>> it only makes the dt checker happy.
>>>>>>>>>>

[..]

> 
> nsscc_ipq9574 was not using icc_sync_state. After adding that, I
> can see the following messages printed from icc_sync_state. I
> also added a print to confirm if 'p->set(n, n);' is called.

Ok, that's good! So now when all providers are using sync_state, we
can go back to the initial comment from Konrad. I think you should
re-check the tests that you did, as the current results just lead to
more questions than answers. Maybe it was just the sync-state that
was missing, or there is some other issue.

BR,
Georgi

[..]
> 
> The gcc based interconnect paths are referenced by PCIe controller
> nodes. Please refer to this patch
> 
> 	[PATCH V5 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
> 	https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-5-quic_devipriy@quicinc.com/
> 
> Sorry, did not post the nsscc related patches since this base ICC
> patch hasn't reached closure. The nsscc patches are very similar
> to this gcc based series. Wanted to gather the issues raised in
> this and address them in nsscc so that it is in a more acceptable
> shape.
> 
> Thanks
> Varada



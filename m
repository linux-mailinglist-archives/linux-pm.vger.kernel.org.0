Return-Path: <linux-pm+bounces-13686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A596D72A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861E51C24D78
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC03199EA1;
	Thu,  5 Sep 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH3Vu9Nk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380019882C;
	Thu,  5 Sep 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535928; cv=none; b=CfVINWhm6gENBgTVuQGoSSY47pQezbumSoJPrXVrCZFbrCRIXW0Sj4cqLGT29aJe8ghh983B4fwagzF6qNQ0nEHRlv3ZqGqxTLjqKu60hl9ZeeCjGwRc+nr9fk8IvA1oLWx0PlkrxZ7Vrwt23jQ+QGu7k4EAAA/w3zcAkQYoHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535928; c=relaxed/simple;
	bh=vFGbvJgagX7pycnyLSyGLOXNpMsQbEA2VPqFK/LxMVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZMR412JR+QMz70uA/soNxlvUTiGDzd2ipAe2n3C1tCx3hZ2xSpD+Wd3WJpO3yIw049gS/vjtrGWWlZjpeuXAqXtIg7oJVQvp8eU+y89v7ZmOakrFwVn9E5yColBxo7/m7VUAmimj8MAjuqXCqE1Mk1i318t48FmTZcE3+qKkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH3Vu9Nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28182C4CEC3;
	Thu,  5 Sep 2024 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535928;
	bh=vFGbvJgagX7pycnyLSyGLOXNpMsQbEA2VPqFK/LxMVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MH3Vu9NkIaVJTQRY9bsxF4XNon84qFN6htU9jBkoaQ7SFxX7RTdsVJB/Q/qf4NI2A
	 jUp9aP4Y+T27yUjaWKGGauYE7M5Si171BzXITROP99aiQ8I/FOGh9FybE+ftgc8kMR
	 lPovjw3wz7+v4ErmLt0m8Wz+dxEpnNU549csr9aNQPt34wO7Rpg/DgNwoXSdbFUvlI
	 jiWAB75ckfrwgUK30aji2MTlbeLSAwHd5EwIydhzaGmqf/ypZCi5HKnqygFhGx0kU0
	 liahfy3EgC5Qx5ZS9nBBcbxkjJc+Wt7RJJbUhg2pmICo8kAnIZ6yNSY5WzHZztsoqc
	 owEeW++rAZtdA==
Message-ID: <8ad6d902-8d19-49a5-b12d-d0d8b0b17cb6@kernel.org>
Date: Thu, 5 Sep 2024 13:31:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] dt-bindings: power: rpmpd: Add QCS8300 power
 domains
To: Konrad Dybcio <konradybcio@kernel.org>,
 Jingyi Wang <quic_jingyw@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Jassi Brar
 <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Shazad Hussain <quic_shazhuss@quicinc.com>,
 Tingguo Cheng <quic_tingguoc@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-6-d0ea9afdc007@quicinc.com>
 <d5e338fe-bd38-49f7-b69f-fc27f9f87495@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <d5e338fe-bd38-49f7-b69f-fc27f9f87495@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5.09.2024 1:30 PM, Konrad Dybcio wrote:
> On 4.09.2024 10:33 AM, Jingyi Wang wrote:
>> From: Shazad Hussain <quic_shazhuss@quicinc.com>
>>
>> Add compatible and constants for the power domains exposed by the RPMH
>> in the Qualcomm QCS8300 platform.
>>
>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>>  include/dt-bindings/power/qcom-rpmpd.h                | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> index 929b7ef9c1bc..be1a9cb71a9b 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> @@ -32,6 +32,7 @@ properties:
>>            - qcom,msm8998-rpmpd
>>            - qcom,qcm2290-rpmpd
>>            - qcom,qcs404-rpmpd
>> +          - qcom,qcs8300-rpmhpd
>>            - qcom,qdu1000-rpmhpd
>>            - qcom,qm215-rpmpd
>>            - qcom,sa8155p-rpmhpd
>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>> index 608087fb9a3d..7dd7b9ebc480 100644
>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>> @@ -4,6 +4,25 @@
>>  #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
>>  #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
>>  
>> +/* QCS8300 Power Domain Indexes */
>> +#define QCS8300_CX	0
>> +#define QCS8300_CX_AO	1
>> +#define QCS8300_DDR	2
>> +#define QCS8300_EBI	3
>> +#define QCS8300_GFX	4
>> +#define QCS8300_LCX	5
>> +#define QCS8300_LMX	6
>> +#define QCS8300_MMCX	7
>> +#define QCS8300_MMCX_AO	8
>> +#define QCS8300_MSS	9
>> +#define QCS8300_MX	10
>> +#define QCS8300_MX_AO	11
>> +#define QCS8300_MXC	12
>> +#define QCS8300_MXC_AO	13
>> +#define QCS8300_NSP0	14
>> +#define QCS8300_NSP1	15
>> +#define QCS8300_XO	16
> 
> Some time ago we moved RPM*h*pd to common defines.. we should
> definitely do the same here. Please reuse the RPMPD_xxx definitions
> from [1] and credit Rohit in the commit message, as he did some
> processing on that to make sure they're ordered based on usage

Oh no, this is actually rpmhpd... drop this patch and use RPMHPD_x
from include/dt-bindings/power/qcom,rpmhpd.h

Konrad


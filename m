Return-Path: <linux-pm+bounces-10304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4A91EB5A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E54281D9B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D010171660;
	Mon,  1 Jul 2024 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7zaLcu9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86222F29;
	Mon,  1 Jul 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876760; cv=none; b=ahz8YDmaidJK8Z3R3+elz3k75bshGPwrYpqYDeJgiIFqNwf7hmE82nHlNmzyybVTNCdw2DD7HNYPlyL5m6qYu/CVrtHi/PsbARu+2k+yfoxCilUrUgFDZPjL1d7dmjPJwQ0Da9SJRMDUaRaZ8t0Ddpw44DLerLyrwQSB1n8ElnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876760; c=relaxed/simple;
	bh=QzziNSGKG9wOhMxJd38Ynxsrqkm6AIs2nSS0ifsTVog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S693uPmBsHLWTtQHca9apXE2VoH5b8/1ASvxnpzuuooF4GHkqpYma3QqXjC9ot/sFIjlbSoXLZ/q870rxsGxtN6O94n1A4yjs6TNC3qgZl6QKo5jFgxj0ueL+SF0T0kP6jqwt8PYra/L1lVyaR/v9MsU30U2PYk8lb8kAfujx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7zaLcu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFAC116B1;
	Mon,  1 Jul 2024 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719876759;
	bh=QzziNSGKG9wOhMxJd38Ynxsrqkm6AIs2nSS0ifsTVog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T7zaLcu9s5XC/DeDAErSiRbc6ErcdOdi6YtBox1oaQ8CvdieSQp08QD6Uqrbm5UFp
	 apSNdEbMb08RteSKFwBhziX5XRIHZkPszZQSy3EjlE/kWzYSbCT3L2dqR74PAXve2T
	 oQPO14h4BzFsyDItxEAJDjFodOFhbfUtrdBEBaOt+ex6L1Y1ZnwReg7mwQCtwe40hz
	 ryhyZbFRsXamxXo6yMXIgrhz9DarV7SE2R3hMHR+9fevAv6Ew/fDrYArP5spqIxyO6
	 EXIg9KOJdW6EQWb5xXJj9DgoWsI/gKmaqo8GArWxWhpiKcUzFjpUJMSlEy5zaZVmE0
	 bhAPBhipApxrg==
Message-ID: <a7b959ff-a041-4380-86dd-05cdbc11fab4@kernel.org>
Date: Tue, 2 Jul 2024 02:32:32 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
To: Bjorn Andersson <andersson@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-3-quic_okukatla@quicinc.com>
 <ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1.07.24 19:42, Bjorn Andersson wrote:
> On Fri, Jun 07, 2024 at 11:09:25PM GMT, Odelu Kukatla wrote:
>> Enable QoS configuration for master ports with predefined values
>> for priority and urgency forawrding.
>>
> 
> This patch causes QCS6490 RB3Gen2 to hit a bus timeout and crash during
> boot, unless the associated DeviceTree change (adding clocks) is
> present.
> 
> The two patches are reaching linux-next, and hence mainline, through
> different code paths we now have periods where rb3gen2 is not bootable.
> But more importantly, devices with current .dtbs installed can not boot
> the new kernel.
> 
> 
> It is not acceptable to introduce non-backwards compatible changes in
> drivers (unless there's extraordinary reasons to do so).
> 

Thanks for the report, Bjorn! The intent of the patches is to keep it
backwards compatible. I think that the patch below should fix it.
I'll try to validate it and get it merged.

BR,
Georgi

-->8--
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 93047defd5e2..487e562dbd22 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
  		}

  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks < 0) {
+		if (qp->num_clks <= 0) {
  			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
  			goto skip_qos_config;
  		}


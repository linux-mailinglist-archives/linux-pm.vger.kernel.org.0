Return-Path: <linux-pm+bounces-794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3743580890C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11321F21126
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFF405DD;
	Thu,  7 Dec 2023 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXrrkKzy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43883DBAA;
	Thu,  7 Dec 2023 13:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B9BC433C8;
	Thu,  7 Dec 2023 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701955388;
	bh=I6VKUBz8o9t+7VdPGnfzwU3XXwc4tF4BarRxfr/X83k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aXrrkKzycQXF1DaodPy9EJobslQMnXI0fllif8Ux+xDjbWBqC/2Fwc8pRbfkxoumD
	 cb2L5XnVGYt6TSjJETgI11pn+XZCwCU6AvFWGHo+o9E0jQyD+RNlLZLX3izgCiYaUr
	 IOrLyv+qH27KhC/79h8C6G7e/1WrNJM6GWDx4okJ3N4oFk1cGNoX8Uv7uo5n/gBTmu
	 s5rDZdi1uCtvGfcG3AHEbCkBhus2sHP8BlZkJjxGlZmcUeJi7P2oKhcCkr+V3PzFne
	 IWdJmxIYXmpcseziC24K2fAYIogq5qYsgNz+QHN7lFellBNzsOZ1Owm6ukg7wvBhio
	 4d3oKW+3GlzGQ==
Message-ID: <5f0d75dc-dd44-45b7-bad3-551a3c33e9ae@kernel.org>
Date: Thu, 7 Dec 2023 15:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] SM6115 interconnect
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.23 16:41, Konrad Dybcio wrote:
> As it says on the can.
> 
> Georgi, Bjorn, can we please set up an immutable branch with the bindings?

Thanks for the patches, Konrad. Here is the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm6115

BR,
Georgi

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v3:
> - Actually define clock-names before using it in conditional blocks (oops)
> - Link to v2: https://lore.kernel.org/r/20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org
> 
> Changes in v2:
> bindings:
> - Remove unnecessary '|' after description:
> - sort property definitions in a manner that resembles their proper ordering
> - define clock{s/-names} before using them in conditional blocks
> - drop unnecessary allOf:
> - move unevaluatedProperties after the conditional blocks
> - disallow clock{s,-names} when unnecessary
> - fix up the example
> C:
> - Apply my own fixup (ebi channel configuration)
> - Link to v1: https://lore.kernel.org/r/20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org
> 
> ---
> Konrad Dybcio (2):
>        dt-bindings: interconnect: Add Qualcomm SM6115 NoC
>        interconnect: qcom: Add SM6115 interconnect provider driver
> 
>   .../bindings/interconnect/qcom,sm6115.yaml         |  152 +++
>   drivers/interconnect/qcom/Kconfig                  |    9 +
>   drivers/interconnect/qcom/Makefile                 |    2 +
>   drivers/interconnect/qcom/sm6115.c                 | 1427 ++++++++++++++++++++
>   include/dt-bindings/interconnect/qcom,sm6115.h     |  111 ++
>   5 files changed, 1701 insertions(+)
> ---
> base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
> change-id: 20231125-topic-6115icc-a187f5989af7
> 
> Best regards,



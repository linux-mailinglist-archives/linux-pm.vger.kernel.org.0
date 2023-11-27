Return-Path: <linux-pm+bounces-272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43497FA23B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D781C20DC6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAC30FB9;
	Mon, 27 Nov 2023 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd0+u8SN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B33159D;
	Mon, 27 Nov 2023 14:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359FDC433C9;
	Mon, 27 Nov 2023 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701094588;
	bh=hLHjKJzz8IdTK+ucHC/mbOa5ERIt+OH27L69qBoQ2xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zd0+u8SNJtgR+IDLZNKBjj8S5xHR+n/l92lz/sdgcAgyPBHN3gYUhpJvDL5syOXe9
	 /1kdSNfj3KZQjzOzyVFXFScgPgMMYnhNac6QT+vHr4FK5lvepEXOo0EhXZvfUlJT0r
	 CYIlyorzvdpZsmRlnyjZnCBXXuopc1R9YG/yhFiTXpkEXa6UPH3imZqFpmU4CXyiZo
	 BRyUyywllkDN+C/4r5sil2gSKXp5yg3ZkzylY24/gX2FvdyyvFOMzyrZ3g6E7Necg2
	 +jNRq53AMyRDLQb0FxU/nvcVq1qUtZ57AQOqZhWoLn0XcvPSjNEXTh8kvWOUcywJwf
	 Shk6Nw48jv4Qg==
Message-ID: <1356b1fc-fcdb-42af-a8df-0f7c2e2be9f3@kernel.org>
Date: Mon, 27 Nov 2023 16:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] interconnect: qcom: Introduce interconnect drivers
 for X1E80100
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc: agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
 abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
 neil.armstrong@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
References: <20231123135028.29433-1-quic_sibis@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231123135028.29433-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.11.23 15:50, Sibi Sankar wrote:
> This series adds interconnect support for the Qualcomm X1E80100 platform,
> aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> V3:
> * Fix the index numbers of pcie_center_anoc nodes. [Georgi]

Thanks for updating the patches, Sibi! Now LGTM.

Hi Bjorn,

Here is a stable branch with the DT header in case you need it:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-x1e80100

Thanks,
Georgi

> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Fixup required property ordering [Krzysztof]
> * Pickup Rbs.
> 
> Dependencies: None
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 
> 
> Rajendra Nayak (2):
>    dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
>    interconnect: qcom: Add X1E80100 interconnect provider driver
> 
>   .../interconnect/qcom,x1e80100-rpmh.yaml      |   83 +
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/x1e80100.c          | 2328 +++++++++++++++++
>   drivers/interconnect/qcom/x1e80100.h          |  192 ++
>   .../interconnect/qcom,x1e80100-rpmh.h         |  207 ++
>   6 files changed, 2821 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
>   create mode 100644 drivers/interconnect/qcom/x1e80100.c
>   create mode 100644 drivers/interconnect/qcom/x1e80100.h
>   create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
> 



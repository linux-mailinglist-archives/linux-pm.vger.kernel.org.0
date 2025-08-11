Return-Path: <linux-pm+bounces-32205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73EB21719
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 23:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224363B50B4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6F2E2DED;
	Mon, 11 Aug 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MckaMkDZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393062DBF5E;
	Mon, 11 Aug 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946688; cv=none; b=FqNV6mFyufP8HpNlVUuR9Ru07fgREN268G3imc/eqgEODfD/ZkUnHyDYoEvPj4LjUqdYLEq3htLn8VhLI1ziALC/w3bfs84+DZm03YKx2hRoSJsnBdnk8rpq0ORFLLxqpeo3StQx6Q6GMmNMXzaF+l5h8bvH8PASpIDRUegoDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946688; c=relaxed/simple;
	bh=bMFJMg+JfLXKlkC5wAUM3n6+D/HjWIAcPX4kjmfvdYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YI2jWGSS7UdZxOyZW3Uqk9gqs/5YnRsQH/tICewYdpLtcODu+9UybechBa4eFT/4YCdsyQPvwoIGi7iLv70D0LRN6iUe/C0xl3fnwplI41mW0iCsAOPO3WBuuWXrPmOHUbaHN0hX5xwh+mhKmzphQY6ztlO7BFHZ9OZGdgAN+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MckaMkDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7200C4CEED;
	Mon, 11 Aug 2025 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754946687;
	bh=bMFJMg+JfLXKlkC5wAUM3n6+D/HjWIAcPX4kjmfvdYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MckaMkDZvm2/GN4sU8l1Jp5BDDLyteoMMrOV5XidYYTvenJuWUVqxd+Gt+E0MeioZ
	 Ja8PlcRm7/JZ1bjA7up7vZHLLJrnRSZNARpF9uvUQ77l9f+KngpgsTdB0LvpP5hqw5
	 zZQiiqJuzCt9gG+64qIjqTlabt+u3Tr0Bs2p/klxNKBZTyA1EmYVBvzY3KAjHsB3rI
	 aYoqc/hWEPFej08/mub/FXhTbqnvGkX4cjMQ79dZNb8uYvcD0eonDtp4NRViKrG1EN
	 EiQHXKkDAdUTRAkrIoMXrAo0HmR0pc9tKN06jd5SUMYz5s534lRFmhvbFqUpLRFlnq
	 e5wuiT/ZUxVgQ==
Message-ID: <642f8456-982f-4cb3-9cd1-8b18232387b2@kernel.org>
Date: Tue, 12 Aug 2025 00:11:21 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Md Sadre Alam <quic_mdalam@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250811090954.2854440-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 12:09 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> The RCG and PLL have a separate register space from the GCC.
> Also the L3 cache has a separate pll and needs to be scaled along
> with the CPU.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related changes ]
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v7: Fix 'Reviewed-by' placement
> 
> v6: Add 'Reviewed-by: Krzysztof Kozlowski'
>      Drop 'clock-names'
> 
> v5: Remove previous maintainers
>      Change clock@fa80000 to clock-controller@fa80000 in example
>      Have one item per line for clocks and clock-names in example
> 
> v4: Add self to 'maintainers'
>      s/gpll0/clk_ref/ in clock-names
>      s/apss-clock/clock/ in example's node name
> 
> v2: Add #interconnect-cells to help enable L3 pll as ICC clock
>      Add master/slave ids
> ---
>   .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 55 +++++++++++++++++++
>   include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
>   .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +

Acked-by: Georgi Djakov <djakov@kernel.org>



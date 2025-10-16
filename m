Return-Path: <linux-pm+bounces-36256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E5BE3AF4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E54069BD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD43191DD;
	Thu, 16 Oct 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9t0vcS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDB5FDA7;
	Thu, 16 Oct 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621029; cv=none; b=G4817AtiVxZiKz1SIkw7mSAETpzSP44NAwrnMWXkVTOM4smMZ85d/7DadkjhZgT5MmvLMOTcCq0dU1/cPguo1VJZUEZbK+f1yuN1IzGT6zr2Lwej7vFv/5MnDgL3pC67+5HtRoSgw57FaibCMvEd7SKvRBTCekjNyyuDwco12jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621029; c=relaxed/simple;
	bh=oPb0Im8WtoroK+cXhb4e0SOwboGZR2dvctqtPYfvUIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8loUwy7/ik5985TYymtAHHp//JgnHFityRJBOoCVZsUVip7mH6+KK9GkQ3DIgREGxxxn2Ps9q4LLMAZofvdr7V2gPTVn3qT4g8Z7ngx7wLkcuu2e4+7lejxA9/vgxo/e6P/GBN4irAjD1GJLTbMFiR+aqPqn6/1OWOTGOKGf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9t0vcS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7691BC4CEF1;
	Thu, 16 Oct 2025 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621027;
	bh=oPb0Im8WtoroK+cXhb4e0SOwboGZR2dvctqtPYfvUIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B9t0vcS99VjyCpDyIB6uqcqQGWz9LAGxV80HpxxpMm3HGRqgPFbM9bHyVP6SakKjC
	 qmGnig8LnrGh1RH5kKmzOmB70G+OQepzITjcuwQLCHOpUuZP6A5gIJ+567krB35ei0
	 u4hTtrZKoEXtTck2oisBK6TrJN6ewX/kMHmZ0dcf4kwK54rl9w4y5qJpdTligM/xVd
	 sinTmQrGSM6Lwr5oQB9i5cUmIhNJDpCHodXoiHBAOCVkPDBhg+WyCuS90UP6R9VFhZ
	 LQ9DEEGKG32yYLCjweZ7r2cFyhMUwbyFyR1w+b4eSu8nuYcfep96kYpE0EjNsO4Jjp
	 anJRi/+6Rqofw==
Message-ID: <6e8fa195-d168-4a52-ae67-6a5be74e01b2@kernel.org>
Date: Thu, 16 Oct 2025 16:23:39 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com, quic_pavir@quicinc.com, quic_suruchia@quicinc.com
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
 <20251014-qcom_ipq5424_nsscc-v7-3-081f4956be02@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-3-081f4956be02@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 5:35 PM, Luo Jie wrote:
> Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
> (NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
> that provides the interconnect services by using the icc-clk framework.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   include/dt-bindings/interconnect/qcom,ipq5424.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 


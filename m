Return-Path: <linux-pm+bounces-37667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E18C42C8E
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 13:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048023AEEAD
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AB2F659F;
	Sat,  8 Nov 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F23qxnQc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E006258EDE;
	Sat,  8 Nov 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762603759; cv=none; b=mUdmu+dFm3jSKwTbjTRwjPso0SlqsChkvt3dIYy+8tzSMVwDUfBKuhtD3btDq6PGaRsJ128Vo2aoZ3ElAAaO8lSC7NTja6+aa+1+i8PNIbSH0aOXwj48Dcob+JW48cBVRexMMeE1VCIpgrlZIlDfTRaXP0xj3wgUCWlk6cIHKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762603759; c=relaxed/simple;
	bh=l/wR/w2JeNcCn+Q/4CiTEWMUzEWNSmOqLkW7J+H1bT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osrbKbzNWh505exfWV+tnFFKE04FK0k9v38fD/Fzk3+ueF7Xp6C0KtCyKRx6Bu0QWPT0lMm9v8faWJFpyfcTcLuM6DbYl6Ix0zYELFd4LccYNtJXw0Av94QKPfjpzZJ37jqeUdg61oRaijz0Y+GcqS99C/OrmE3bQrwKfgTFXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F23qxnQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309ABC4CEF7;
	Sat,  8 Nov 2025 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762603758;
	bh=l/wR/w2JeNcCn+Q/4CiTEWMUzEWNSmOqLkW7J+H1bT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F23qxnQcAVA1jVlpxV6Pq37CsMqrIvX7tlOstRiin/g/axLJkhQwuI548w4SJtW4q
	 0MBRPa5o5Yposib3JkJzmbyb2z2EBVmz6n28CxlbFMEyB4xLIr3fNHPnN/qkWP504+
	 vRSZdg2yeyWW2zSYcldiOPBG5EbEf2gcCEkrYyF5aIH015+VRGMV+GSx7FbkDVGh76
	 ZeXwJLkqxCRfKfybbpgXmMqKxXJu0DtLT6Z8r/EkKWkIjwUf49qYW6hdcLc2H0an9w
	 +zhwkadFPc65FHSqdm0ULpFBJ3052Sryii0zjrBoi1hNCYUvqui1t6DSbTckR4ksq5
	 QmsnxohfX+9sw==
Date: Sat, 8 Nov 2025 13:09:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: interconnect: qcom,sm6350-rpmh: Add
 clocks for QoS
Message-ID: <20251108-evasive-illegal-mayfly-fd8675@kuoka>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-1-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-1-8275e5fc3f61@fairphone.com>

On Fri, Nov 07, 2025 at 05:08:47PM +0100, Luca Weiss wrote:
> Add the clocks for some interconnects to the bindings that are required
> to set up the QoS correctly. Update one of the examples to aggre2_noc to
> have an example with clocks.
> 
> Also while we're at it, remove #interconnect-cells: true as that's
> already provided from qcom,rpmh-common.yaml.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/interconnect/qcom,sm6350-rpmh.yaml    | 65 ++++++++++++++++++----
>  1 file changed, 54 insertions(+), 11 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



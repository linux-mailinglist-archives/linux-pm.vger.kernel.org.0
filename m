Return-Path: <linux-pm+bounces-19507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B99F7835
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144E7164ED9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57B221DA8;
	Thu, 19 Dec 2024 09:19:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B05155756;
	Thu, 19 Dec 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599990; cv=none; b=Qko7mg7t9ZCvo3dJUBaY6uZFrnusSC9AUWG1P5aBUAEPsJJd+DeiYGgFUojOTDHnI4RY7bdSJ2+jJN2rl5MZX+tkkJy0FbcUdKw5fEwu/nKETPQO8GsO7HuTH28namtx438H+g2djXybSdxqylF+hcGPDXo1ZocFj7U/cCrQMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599990; c=relaxed/simple;
	bh=TzpEg3e7g2Gwn7WITPJIV8P9M39xjKN5UygubSc/4Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDAeccmsBsq4+q3XNegYX7F666b+O/OjBdeL3YizuX0SMaQPFR/niyhCPcceGFq5dXUU/9/AOTdNaMsnH1PXZN8tMphkMYLULCf8GxZQLCZSa+3mtXIY37us/lXjB3XvC8BbAZnxr2YWOaIrZ79mpTMPygBi0RaTN4wzWQ+loPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A10BC4CECE;
	Thu, 19 Dec 2024 09:19:49 +0000 (UTC)
Date: Thu, 19 Dec 2024 10:19:47 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document
 QCS615 bwmon compatibles
Message-ID: <35doix7q2x7uel4t5vgjbkfjtaugrqbhdbuq5nxarhqndvnmjt@pncqandctdlh>
References: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
 <20241218-add_bwmon_support_for_qcs615-v1-1-680d798a19e5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218-add_bwmon_support_for_qcs615-v1-1-680d798a19e5@quicinc.com>

On Wed, Dec 18, 2024 at 06:39:38PM +0800, Lijuan Gao wrote:
> Document QCS615 BWMONs, which includes one BWMONv4 instance for CPU to
> LLCC path bandwidth monitoring and one BWMONv5 instance for LLCC to DDR
> path bandwidth monitoring.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



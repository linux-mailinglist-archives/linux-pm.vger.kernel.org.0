Return-Path: <linux-pm+bounces-30973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC35B084D4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 08:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A273BD356
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDC215773;
	Thu, 17 Jul 2025 06:23:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78A2147E6;
	Thu, 17 Jul 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733423; cv=none; b=ksWKIqP7qDIsR6bus9M3g2bTZYj2rr3NzXiUj4HzxExdfNhf6osH+ZUmx6Wt9S41IPYQrzW5gaysxpRw3DY+/IQaW5HoYOLlGN4XjllzyG2kIHsNUhLgw25kx1Fe0tBsfkZSNex5iW8O8a/CPkHs1vsdR2/zuOonV+SPYykoFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733423; c=relaxed/simple;
	bh=yibcBDh2HavI8c3LCPjyI4o1JTWK9DiSzETRYuw5KZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0hz70V6AdZilTe8UzW18t84+VR5mR7qtGMAb4t/T3B87hnS5BF8wK2qDstbXMKRV1uC2skfus7H/0LtGiJGWbDOHZWWzVudGAN7oPm18xOOsQseMZeBow2Lm0HoBbvRH25J8mW5UxH/uVTwPWbPaFK/xSGjlBIikjHtjipUQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB145C4CEED;
	Thu, 17 Jul 2025 06:23:42 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:23:40 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Allow 'nonposted-mmio'
Message-ID: <20250717-lumpy-auspicious-pillbug-aa7d77@kuoka>
References: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
 <20250716-8750_cpubwmon-v4-1-12212098e90f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716-8750_cpubwmon-v4-1-12212098e90f@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 02:25:46PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> One of the BWMON instances on SM8750 requires that its MMIO space is
> mapped specifically with the nE memory attribute.
> 
> Allow the nonposted-mmio property which instructs the OS to do so.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



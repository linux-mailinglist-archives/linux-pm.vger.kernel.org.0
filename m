Return-Path: <linux-pm+bounces-30101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD06CAF89E4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386A11723DF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A447128467B;
	Fri,  4 Jul 2025 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiEPqmON"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75999282F5;
	Fri,  4 Jul 2025 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615228; cv=none; b=A8Q1eW8u2f/naYQWK5OguOpvoG5Ad+TTe/8tcg5SAMFA9J5PaFIWQPzhac4zryHsEamypqdNebtgupfnJxiJEO+qQOfviCjUxVwT6J4JrhP4fTwXdBo9FUek1cAuxW628b9de9zKPs+xyaLMtpNqfPcI+Tczjh9+e4nKh6IC+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615228; c=relaxed/simple;
	bh=lddv8ng09qASWJTNkdr/OgIEVP5qtV1K56DlaPa1ptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJKRKd/xZNlTA9GibCitiRDshkdzwTZVsxt7nERsYvhHdLtcYniXDAheQj0dMOVJRk2Gz2myw/wv8AjN998Qv9jrRMJ14sX6Dclbp9ygTa3eXEIShybwFKg/iSrpzULdLncpZWySPQM+DAwAKo/NObKSVwOS6IU9FZ2hooVDD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiEPqmON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53914C4CEED;
	Fri,  4 Jul 2025 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751615227;
	bh=lddv8ng09qASWJTNkdr/OgIEVP5qtV1K56DlaPa1ptU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiEPqmON6utZvwz7zzHO7i0AMSvLBdy9bPFtD2DvHveq8OZ9/vJInTNuYgIH/8zzq
	 yBypQ0NpXphW+hrL/JYR2yFOEzZm77ZZeuDGaUZEouCEr3ZqkFnaAOzxtIkrxPd1Cm
	 mhwCybWJWmQsZODeMHS6f4peWlEhulhKU0qFZL4VOJm29mbj+HQZpu0mFCgjpNORuO
	 bLlcviO5MaUprl095jsXB6KMsQDXKrmq5IK4zbk6yIE2twL2FJwchWyHEtuNu6DS2F
	 7KSjAQDLMAFBfHXLPK9EEUiiTfWf32zgHwZjS0vOgI1viOmfBj/in6ZJ4LnxBA/tEN
	 DVYWyAKMEkb2Q==
Date: Fri, 4 Jul 2025 09:47:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615
 compatible
Message-ID: <20250704-singing-gay-doberman-a1a4a5@krzk-bin>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>

On Wed, Jul 02, 2025 at 02:43:09PM +0530, Taniya Das wrote:
> Document compatible for cpufreq hardware on Qualcomm QCS615 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



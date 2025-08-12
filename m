Return-Path: <linux-pm+bounces-32210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A0B21BC7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E16428109
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 03:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B12571C2;
	Tue, 12 Aug 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A62MfAI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1901DF27F;
	Tue, 12 Aug 2025 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970386; cv=none; b=hKi6FfZ57cZr3Ay1eIKgae+LognnDmtlETYfK9DqJsn5gJMuNChUf7ZhK0y690vE3jecGl9EP2G/RZvr5JS64aUrcYw64+IhfMn2RkJrObrMKv5KFIU3qOczIwqKrNubCRJ6fV6WrdTx6CYS3S/RqlLFY7aGCLc8vrxQOlEiel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970386; c=relaxed/simple;
	bh=sMFke7zRm9HTPBn23ob80gOMzZ7jKNIHnlhCuWiE6bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGK9AHdi4Dstnov7mWBx66wkUZdwNt3Cb2dwinXdalgGasTxKvufRb94Ugo03CfKNWhkGTnql56TqyDxcdUW7WFP9Wjs4px4KynUsIRIaTLybTnwHETG5m4tHmGhJdX9l93SYCq/MwDtGREILeIRrU05n6REJksV0g0BASByDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A62MfAI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D314C4CEED;
	Tue, 12 Aug 2025 03:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754970386;
	bh=sMFke7zRm9HTPBn23ob80gOMzZ7jKNIHnlhCuWiE6bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A62MfAI4Ygz7OcXndn+3l/EGMTEjrIYkGfgNmvHr+2+cGJlZ2BWhNIDzMLyqkeilP
	 bSvP8wJ0gzsrZN6Z9z2RsTEulVNvrwQKfy5I6L+EM4iMA3zAkpyDHvL3auuPf1wthf
	 Btx2IscphhRsvsquyXL7/OW5o3kHfwVQwqriKpMcQzk02SDUSLjnL3vP6d5cI5pA6k
	 Qra9VtCu51XOUXXpDvnvzAlWkR9DAxcY55ylNp6nCfiT2mAhh7zyWkYWrIWCSdKRdy
	 RaJbl/PhSGNMe09+BBDe1x9nP7z+bzUm6oJu4D1oXoVTvO3OpCaqb2PWXy5C3/mdAa
	 IVgecwzqgxzCw==
Date: Mon, 11 Aug 2025 22:46:23 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615
 compatible
Message-ID: <3xki62glazqka7gngvrz3jifk36vkjlqjm6gv4mg7lqbhnnlsa@ryxyt2pcsfk2>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>

On Wed, Jul 02, 2025 at 02:43:09PM +0530, Taniya Das wrote:
> Document compatible for cpufreq hardware on Qualcomm QCS615 platform.
> 

@Viresh, @Rafael. Please merge this binding patch through your trees.

Regards,
Bjorn

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index e0242bed33420a39b8a8cff4229ba9eee994ca30..2d42fc3d8ef811368c990977173f41b26535e0c8 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -22,6 +22,7 @@ properties:
>          items:
>            - enum:
>                - qcom,qcm2290-cpufreq-hw
> +              - qcom,qcs615-cpufreq-hw
>                - qcom,sc7180-cpufreq-hw
>                - qcom,sc8180x-cpufreq-hw
>                - qcom,sdm670-cpufreq-hw
> @@ -132,6 +133,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs615-cpufreq-hw
>                - qcom,qdu1000-cpufreq-epss
>                - qcom,sa8255p-cpufreq-epss
>                - qcom,sa8775p-cpufreq-epss
> 
> -- 
> 2.34.1
> 


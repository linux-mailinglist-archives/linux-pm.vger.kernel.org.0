Return-Path: <linux-pm+bounces-15597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3199C1A9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2792EB24504
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFB14B972;
	Mon, 14 Oct 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQGK204I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31114A624;
	Mon, 14 Oct 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891618; cv=none; b=TwrQ7ReqI36Mgo+KDQYHHoNwgBFp9gAnV1HlOKT0m4NUq6mujfzg5YWHYC0oZwn5b3ZKztR1mOTynv0sZqEhZZOUjl7BXpoyNig8+gYlfi5HW09onNbUCF9XZodYbt79af8stIdP54Tt3WDabOkTQGhWBgc85U4+9kaOGQN3nuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891618; c=relaxed/simple;
	bh=Wcac2XZQHtmBThH5hyHn0l9csa4sK/TVqzzdehNcWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYp9CB8Ze/9O/9Mi+qPVHzZ1fAZXcpsrwWdFUD0nqif2+O9imaV4V0QAf7uZAosZNpaAzJ7n0I6z/lrRUiTtpsNh1v0GMLO9CnBgxjji64YPk2zYvnWgaXEr79EU69p6qXuP3yIezQLrzJqwO2X9Mio2Y+833lxHkokm0WVGTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQGK204I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F5CC4CEC3;
	Mon, 14 Oct 2024 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728891617;
	bh=Wcac2XZQHtmBThH5hyHn0l9csa4sK/TVqzzdehNcWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQGK204IOJEOFB2eQYIjXUxFQwV3E51A1qVpfa/WwbX7JCtebBipm/AbDpFfTdXZS
	 lXCF/bsJ6bi6tjRx+fzVjqhHLZzR9xOCPIO0pqeaXX2acNREA08hwdgtQzaXAcSTUR
	 ggXYB1HA6eXG2uV3uA0kxMlUa8Z/FPCgx3vKyzem0Zj6OCWfPzyRXLjvFnP86rp8ZF
	 q8Jos+wCeVyzdv7iMWKVFZI9rg2QOSoe6NhewPuZTyqdE7AOPAKatvbkQ7bKUDoxBJ
	 4fcReYuU738t5PJ663As+jiKA2tfAgqDkBuG2N3aBehdeQ52mxWo3DV05Ct4I9eT9P
	 7ZRUgJcciHR/g==
Date: Mon, 14 Oct 2024 09:40:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100: Add ACD levels for
 GPU
Message-ID: <5axuqj4hetfkgg2f53ph4um24b7xfyumktreglxqyzfsdhy25e@deucq7vqxq5l>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-3-1e5e91aa95b6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012-gpu-acd-v1-3-1e5e91aa95b6@quicinc.com>

On Sat, Oct 12, 2024 at 01:59:30AM +0530, Akhil P Oommen wrote:
> Update GPU node to include acd level values.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a36076e3c56b..e6c500480eb1 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3323,60 +3323,69 @@ zap-shader {
>  			};
>  
>  			gpu_opp_table: opp-table {
> -				compatible = "operating-points-v2";
> +				compatible = "operating-points-v2-adreno";

This nicely breaks all existing users of this DTS. Sorry, no. We are way
past initial bringup/development. One year past.

Best regards,
Krzysztof



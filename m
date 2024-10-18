Return-Path: <linux-pm+bounces-15919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518719A36C1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064BA1F248D6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396A188A3A;
	Fri, 18 Oct 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0U5j63X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61491885B8;
	Fri, 18 Oct 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235586; cv=none; b=B83Z3W65YVYQaHOSQkS83LfHJKF6EO6sXTq0GgNqdMwHR1TXQ4trH4ossGzcs21fKA8z3VJfp4DOGgMIMDBvLsX/U0iGfiBCzVpkUDk8uDEujNvffb+frzlZwo1B6mOPEE227QsQJYhK1OadYoyeUn+Ks4WMuRz5mXBW4N1BO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235586; c=relaxed/simple;
	bh=yJcOZAks+vGfnNhTXxGMgCAE8BYGPCDIIgBGlkHGgAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv5OVnl43+gUisMt5ZoncUxSwZVvT4J16BoEKX6gQhC+kLoG+brS0DtCS0YsMS1QJoGzPcSzYbaOQkPRbq+saU+yqE88JltqOs4568Xx26XuNhwjQG8oUjAGlvbDLq7nnrg06mR83DrNvyaSM3QUwrnBpfs6FyBFWXwc4pT+680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0U5j63X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8DEC4CEC3;
	Fri, 18 Oct 2024 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729235585;
	bh=yJcOZAks+vGfnNhTXxGMgCAE8BYGPCDIIgBGlkHGgAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0U5j63X9HRI7ogksW3IZu7ScnMG/5qEmtWUcmBKMamYDIR/w/y5jAmE7Ws7BaXzo
	 xGPK43z9kszHS9xZPctJugGt4dH2gIK0xbkzEXphHxUyWRIFGGePnv9bukQHBeey8f
	 3xAFWpPwszBVA77mCVsHGsv20h/NTTPFufGVkpESL5hJoSBtNCHtETR9raKn6culf+
	 0X7f8FAc8bq3kfw/vJ/qukae6kDI3pVJBix/iC4AupGGDRTCIAwE9E9u4ymiShJE9s
	 PFDoSq4xKtDxRSpVXtx2nVGoK7khzrcTcmBVelxpE479a2ZAWD3LCSTLownViGevpq
	 yuTZpZ0cfn51g==
Date: Fri, 18 Oct 2024 09:13:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom: document SAR2130P
 NoC
Message-ID: <3nk6wzhqvtebichahnmmntognir3f7vhkh4rlhd4ctrfjkoey3@xjijjqx6i4ut>
References: <20241017-sar2130p-icc-v1-0-bd3a8befa4aa@linaro.org>
 <20241017-sar2130p-icc-v1-1-bd3a8befa4aa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-icc-v1-1-bd3a8befa4aa@linaro.org>

On Thu, Oct 17, 2024 at 08:31:13PM +0300, Dmitry Baryshkov wrote:
> Add bindings for the Network of Connects (NoC) present on the
> Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sar2130p-rpmh.yaml  | 117 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sar2130p-rpmh.h  | 137 +++++++++++++++++++++
>  2 files changed, 254 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



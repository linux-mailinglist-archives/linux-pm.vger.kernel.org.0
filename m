Return-Path: <linux-pm+bounces-14332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A62979EA0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F832280EB8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F814A095;
	Mon, 16 Sep 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRgB6yP3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0850284;
	Mon, 16 Sep 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479894; cv=none; b=oh9Yw/D0FXTfPqVN58D9SGf+Ddl63Q2iKevM5j8YhxQmpSNIK945AQWkSsBBbl+xkaFMBgfIj8oBDEM/PLs5ULpn441O8qYAGGpAPJI1VZgXMdmEKZZ4bWvlok8/iyeWvD29IPRCTRW2qqv2TniPYJRNCR6tdtghiXeRqZGoU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479894; c=relaxed/simple;
	bh=XBHns7lIsGV3fhSomVNc6Im5cLOPXoTu21pGn5vhiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4coYuBGKDh/s8EhuNhJT/Y8UAN3IbWpAjXCltAviY+7UQmztGas0hYYV/X2IEZIBYq8Q74IOO6yc7DC9uQdtAhlOCtDmECiNnlfZ7P6/Cfu2fX0ehe4dsnvP2coUq4+bNVje2yh35JsTkWqRVEYnv/f8rNd8UjVVRZvYu4DEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRgB6yP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC33AC4CECD;
	Mon, 16 Sep 2024 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726479893;
	bh=XBHns7lIsGV3fhSomVNc6Im5cLOPXoTu21pGn5vhiIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRgB6yP3oG+MT62mk+/l+vQdOQJAvmLXfEJL2sEuiSE0rrflnr6utDQwir3n+WPTm
	 5xVu7jlgsJIq4Yv5npV6CR3qaZlmvDhxTlNZsSAoNxCKSlTwtdzIvqwIJAgUvtbCRe
	 xkc9a61CzUBn+3wasU/dFzJv5gtxOU8XpUdtk5+3sC73gpY7GTadMW5PYZVzwHem9z
	 /Z3PpzHDKBdHmXjE3VIUYu3hMlmWVwjUWfFmmdivTijl3EUz2ARhYBGCuhZ77AtylS
	 x13TU1Q1f6JAFVbeRJy1Y2arj8NE4LuxvLrxQj7M0E1pPoIVgT4KiDfqzyW+KmkE8W
	 PX4cp2wWNvLdg==
Date: Mon, 16 Sep 2024 11:44:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	quic_psodagud@quicinc.com
Subject: Re: [PATCH v3] dt-bindings: cpufreq: qcom-hw: document support for
 SA8255p
Message-ID: <crsuqys5tlgtf4667fwaojn5z5ri4uf3te4n5a2bcalidgobo2@up62meevaxwn>
References: <20240912175043.2262697-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912175043.2262697-1-quic_nkela@quicinc.com>

On Thu, Sep 12, 2024 at 10:50:43AM -0700, Nikunj Kela wrote:
> Add compatible for the cpufreq engine representing support on SA8255p.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
> 
> Changes in v3:
> 	- Added compatible to the correct constraint list
> 	- Removed the new constraint block added in v2
> 	- Removed the patch from original series[1]
> 
> Changes in v2:
> 	- Added new constraints
> 
> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof



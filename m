Return-Path: <linux-pm+bounces-37328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8FC2EED5
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB1D1897A67
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9821523E229;
	Tue,  4 Nov 2025 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7YPn9uJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82123ABBB;
	Tue,  4 Nov 2025 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222378; cv=none; b=qKBffjK21XROg99nb8eHfnsjCgQMm1PwQl/hlXe58k+6AEyaIoFTs1vukXXWlQdvic02v69QEpMvccGFScPORZAE7DxLUSUndWExIGvHIre6/Q6UEGeUqul1yukN/Q/7MyGGjJGotqYKVMuxgGJWxAsY0wEOOCLGSgtvVlKpHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222378; c=relaxed/simple;
	bh=CwKYixDai/ce4FpN4VpyncngImclkVszrfi3kTmADbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p44+l1w4vaeBKZwLs68HjVSwScNIDgtC73/HAETu1FDzoj+X6G9LnB4Tj68bsVMYXhPlAMdvNYXQOerFhGNPBteKN1+PDTXX7HZLarum+jYI1r2NOTOLbXZTWz87dC0V1YTpRbB/pjAR/ulmUAhBv2w2EWzHQK9Wz8rCuBBkhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7YPn9uJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613F7C4CEE7;
	Tue,  4 Nov 2025 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762222378;
	bh=CwKYixDai/ce4FpN4VpyncngImclkVszrfi3kTmADbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7YPn9uJNrJNg0RmmcWXnT/0rex0vLMKAwfTl4m03b5j2a+aADSR87LeMl+mXYF++
	 NDZsxBPJiKhQn9+i/8b796//9rbMHoasRqX0XN3Jk9c0xaqVp1XZW1XdTLdBVmFfKh
	 HeTYV4/Y+bGTuzf5ZthyhP6XB6SNyjlWc8e3W74DiWL7gv8kwA8fpq5p/yTTcBZ4re
	 LcXAfMDmquTM/Df6c9IubprSc0bV/zYBP6o2CDmPzqlrduC5X2AV+hQCaLRURpQxDo
	 yhz6lqTfuvrhDRVRkbcqPeUSOkadgu7fimmBN3E/ichBdrTpMmyYNh8HyTlb6KQdTK
	 yxeaImBo9RCaw==
Date: Mon, 3 Nov 2025 20:16:30 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Message-ID: <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> SCM can be used to support reboot mode such as Emergency Recovery Mode.

"such as"? Do we have any other useful bits in here?

> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index b913192219e4..c8bb7dacd900 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -121,6 +121,10 @@ properties:
>            - description: offset of the download mode control register
>      description: TCSR hardware block
>  
> +patternProperties:
> +  "^mode-.*$":

I'd only ever expect mode-edl = <1>. Do we have additional modes that
warrant the generic nature of this?

Regards,
Bjorn

> +    maxItems: 1
> +
>  allOf:
>    # Clocks
>    - if:
> -- 
> 2.34.1
> 


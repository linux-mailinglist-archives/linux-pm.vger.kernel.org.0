Return-Path: <linux-pm+bounces-11430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFA93D21A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1C2824E1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55817A592;
	Fri, 26 Jul 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY0zsxhQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111EA178CD6;
	Fri, 26 Jul 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992795; cv=none; b=HPsc1IrTi67ZOdKCuEC0AVJvWfyei/MX0cAcFaJy8pGdBv1LPfuHSE/pA5PW6zVopb3vwk6JQ1gaqvKDnFEOCsx8ZOgACgWnbxHw0nCBI190Eb5b8tZP2Fhkla2i7w/7r+4P/JVS5FdADH2u5e3Vd4uQ1mnyu9PXlRxdeUHafHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992795; c=relaxed/simple;
	bh=5EX99VlAmyGBICk/5y+ev5w0dqO1k1M1oQo5RWS/vR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjFt897A072wDc1zKij7yxpQkXEBjYqAfatVzRf+nMwUHf3ixcNYk3EW1rg9m+9M2VWhzuhDHJlY3OgSXwXCFuiaxYKX058O+GVBXpisnZ8nSlYdHDPPKMgvRNbNt4kh0shpC4sftzqmtAUe7MwVv9QXxOXwfs6/P0YMHTkyyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY0zsxhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9772C32782;
	Fri, 26 Jul 2024 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992794;
	bh=5EX99VlAmyGBICk/5y+ev5w0dqO1k1M1oQo5RWS/vR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jY0zsxhQPwxuJVf1w+/9Ks8LYDpMKauqwex0+oSaN5DJ6Vxx4tzHn2GHoTqcbr99H
	 MIjDZgS1PIKpBUmwvOwQK89nUuoEwDyesihbZcl2BlxdzgNnB3qiv56x3rTyRf1wQh
	 YgcL9PYDsL8GE+SyM0klC1w4+xUCipmwaM6RaBupwa3FL13ZMa2NWq96Y3CAx25dyL
	 GsAUvgVJgSpxG1/USf0bwP+F8PoUnWsGkBOffFCEZOcB0rX4oQ2+U2Bi6dyN3PCd6l
	 iRTXb2KniXl86bFGlJPc8YwuWYZ7ej6X0MuF6vowGI+17YrZQ5Hdo9TQ9mE4bKHXCj
	 G80PhhbJsPVQA==
Message-ID: <39a2303c-c89c-4fa3-a2e3-87589d242f4e@kernel.org>
Date: Fri, 26 Jul 2024 13:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update Konrad Dybcio's email addresses
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.07.2024 1:18 PM, Konrad Dybcio wrote:
> Patch 3 should probably go straight to Rob's dt-bindings tree
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
> Konrad Dybcio (3):
>       mailmap: Add an entry for Konrad Dybcio
>       MAINTAINERS: Update Konrad Dybcio's email address
>       dt-bindings: Batch-update Konrad Dybcio's email

Err, please excuse the mismatched From: address.. it is definitely
the same Konrad speaking..

Konrad


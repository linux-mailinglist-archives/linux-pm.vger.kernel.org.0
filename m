Return-Path: <linux-pm+bounces-40761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD17D1ABFE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E5923003FF6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6435029F;
	Tue, 13 Jan 2026 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMv91P1d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A452512C8;
	Tue, 13 Jan 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326818; cv=none; b=fYRp1gTJgQXyD29yabzRwe0QeaeB6ukOq/KkA2hRL5SY+xAemcA5UMuHRKacnh29kl8C4Aka4d++bXQIjKCcE4KTVAwGdw5lLH81M6tqcFYWLb5RhG2CgMi95qL/ukEB9pAD04YJGojQImr2TN1FwTYjnTg8IEG2gsK5kWvDTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326818; c=relaxed/simple;
	bh=F1vInnOYSpvuA91Us/ZN03izGJufnJDreuZUNp3v8Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goZiVoDtrA0AIQfmEeZnq4Oq1/yKU3dOkICYfQXmxbOa5aZIaJpBxRjVZHP1fPMUHz9Et/0bXMxBVQM4TD0bP7xwKeLKGEF1twS9rVMDKf5YLaL2lW+X58deKxrrFHXSM5/a2p0B7FEBzIrXrxHBakxGGS7Zf1wMnufafeb5+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMv91P1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67643C116C6;
	Tue, 13 Jan 2026 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768326817;
	bh=F1vInnOYSpvuA91Us/ZN03izGJufnJDreuZUNp3v8Qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bMv91P1djFhEGHZku+tNS9S1kWxeFTopzHURNZufQVHqSkwpjzN4AUNt/GCBP1Ukv
	 N4YuikfjLzZDae6VjCOZXqR/gkt+gj3sOw8g8ecVhJH9Pgfv69Ok09ItqMZlHy+e3T
	 gIkwpmHEYdG5ZJUAG96JXXdREjC0P0rhl8NpbI9lVReE4BGRqyi6INXcl3o8m19BGO
	 +ks0sCxkG7iDIfscgp/iDM23TYkb0WooK973cQa+aP+DWgxU0nbYhzlhubXclofrYF
	 k4SR19w4uyNMpibfQ63zc/o1E7qsPxPU3lG4uzoly91ZSGNojjpRlx+rCYLDQ8Jk8X
	 /+xVGKpAS2hwQ==
Message-ID: <8eb528dd-71fc-408e-a97c-d484198e4f81@kernel.org>
Date: Tue, 13 Jan 2026 19:53:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT] interconnect: qcom: implement get_bw with
 rpmh_read
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 6:46 PM, Neil Armstrong wrote:
> Since we can actually read back the APPS rpmh interconnect
> BCM votes we can actually implement the get_bw() callback
> and provide a coherent average and peak bandwidth at probe time.
> 
> The benefits of that are:
> - keep disabled BCMs disabled
> - avoid voting unused BCMs to INT_MAX
> 
> If the interconnects are correctly described for a platform,
> all the required BCMs would be voted to the maximum bandwidth
> until sync_state is reached.
> 
> Since we only get the BCM vote, we need to redistribute
> the vote values to the associated nodes. The initial BCM
> votes are read back at probe time in order to be ready when
> the get_bw() is called when a node is added.
> 

FWIW, I was able to finally test this on sdm845. Some nodes are indeed
showing reasonable bandwidth values instead of the default INT_MAX.

Tested-by: Georgi Djakov <djakov@kernel.org> #db845c

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Depends on:
> https://lore.kernel.org/all/20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com/
> ---
>   drivers/interconnect/qcom/bcm-voter.c | 36 +++++++++++++++++++++
>   drivers/interconnect/qcom/bcm-voter.h |  2 ++
>   drivers/interconnect/qcom/icc-rpmh.c  | 60 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 97 insertions(+), 1 deletion(-)
> 


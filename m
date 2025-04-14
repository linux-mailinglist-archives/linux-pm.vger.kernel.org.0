Return-Path: <linux-pm+bounces-25384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1CA8895D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2629C189484B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0828468E;
	Mon, 14 Apr 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfDaKYzN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1654918;
	Mon, 14 Apr 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650498; cv=none; b=TIVrAzCZuAl7KOTqevQVelTpxIwToClv0D/ItYMr10Du9NorQ09f+nLAnEJz2QimP5MNEAtPeTjEv3cfs9FJfggVytwwvXN3weQNOjwF86gKZfzp3N5ab2eR7wt06Rbmvinmx/w6O2pZoOJvupvW270xx+sPLJI3m4FBYcCHiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650498; c=relaxed/simple;
	bh=efSeeITh5nvzNa1dvzv5P6fHxOrUUaKwQWX+HNha6dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN4oUPMQO4fOXBHbdCc7Dg0AKShdNFMPR6Q1DdTTwxSuSKSGxBqwbeJIx+g0FQEMm/fyvbR+PIqAWVl6FTRkJvT37P444Pt1yRFj0PZ2ZCpidN5fGK/gCRd+TghRmLdKVdAAlZee28bWpnNll2/sDUz4IppfI6iKjBKh302pLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfDaKYzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEDC4CEE2;
	Mon, 14 Apr 2025 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744650498;
	bh=efSeeITh5nvzNa1dvzv5P6fHxOrUUaKwQWX+HNha6dM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HfDaKYzNUikNbkEAaL1gFf6odE2sLIMakR7G76X5ajAFT/vp6sNiTUilAsXxdXxhq
	 9gM3T/wMJ36D3Zg0/lEvx/Yk8lE2pvm4EbwM6mHJj/f944TuTizMNqd8g9hnFe8/3d
	 jBjMUpJ5W8To5GUMAhn/Kdb76AVm5y7ZIQmzIBs1KrEBzsVy3lAwQtTmlQ4jTnYgKR
	 WI/5ERAK0vA/uRvAvaLWHrXkVNcHWpOJ35i0oLs9k6gUIe+rGedgLmRYIfQ7ocJUPJ
	 ycjsp3YEqZ9CzhsdCzFz07mMSUNxraMi6MlJBuxv+jiNMVbPQLKlro070viXwI5qH2
	 rVrx6FgPt2z9Q==
Message-ID: <b9f90b0c-cae5-4dc3-817a-183b49f947b9@kernel.org>
Date: Mon, 14 Apr 2025 20:08:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7.04.25 18:16, Neil Armstrong wrote:
> Enable QoS configuration for master ports with predefined values
> for priority and urgency forwarding.
> 

Hi Neil,

Thanks for the patch! It looks fine, but i noticed that there should be also
QoS configuration for the qnm_apss_noc node, but it's missing from the driver.
Do you know if skipping it was intentional?

Thanks,
Georgi


> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/interconnect/qcom/sm8650.c | 327 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 327 insertions(+)
> 



Return-Path: <linux-pm+bounces-16232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA419AB235
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC932280F7F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D514EC71;
	Tue, 22 Oct 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMow07pd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BB2E406;
	Tue, 22 Oct 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611279; cv=none; b=mhFUD+iM/ZlFKoovzNXR/UnVOuw6gDGKUrccsOW1tFeZ01GtXsIBFSZ+h8MGuMUKV6c18tg97rIhlxrRIUDAuu+CfXUTlhbJGBHUGTvIZQrXxgqVu4KxSA/+alBwqCjVuYaOh7bjs6XXJXlrzJgd+bXEIt86amZQ4cfY1tcMpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611279; c=relaxed/simple;
	bh=IFCmy5e0se6HE7HVvLOgNzTCEkWt6JaKpUCzkD+Wm/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie4CovqeWL19Qgp3qVBmBpCNYrpkT55m6pBXhOeTYSH6wI8GiVeg6RM5dDo+Xg5pqGRWjbKjUTavAVIN4ZuO9+uSUolxXwg71gh6M25cJLN55djKLWwimIri3Hax2OyBc0KgzTLHCPNiJlFJkWxkVukZKuuJ7RFqcssEgl4ycTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMow07pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A7C4CEC3;
	Tue, 22 Oct 2024 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611279;
	bh=IFCmy5e0se6HE7HVvLOgNzTCEkWt6JaKpUCzkD+Wm/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMow07pd/YsU80zCSpxYqGr+VAVklxM8Fyu5aMRqROZGyij3R8K4Qy3336oxvZl1J
	 WYmjsjNB8sUXw6ah14TEbwqa0cZG4LKJVREiMPtx3zPDUJxzeiHqyxwerbWIB9efNC
	 5xF20GxbwzlZ8jfh7iYaIWBEyJIiaJVyVW3XKPDB4E377e7trlwvzjLtqMwmeO7ISP
	 nArHrUk9ckigKhdjpxdEOcOMDRTTm0Jm2nAclOZl86M3O9/+TV8SY069mTcG3GEQsu
	 GxVr6WnPZvPS2vldZeH8OjOBnTt2vCjV5+VMT6bV5cEklPAby6hAlpHpQdy9fXudLy
	 FfWlOE+MFa0Pw==
Message-ID: <8ef94b73-5901-49f8-a622-2cfe3e054e6a@kernel.org>
Date: Tue, 22 Oct 2024 18:34:35 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: msm8937: constify pointer to
 qcom_icc_node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240905151636.280065-1-krzysztof.kozlowski@linaro.org>
 <30697312-010e-4ed8-9d17-9076b61e6d9e@linaro.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <30697312-010e-4ed8-9d17-9076b61e6d9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.24 18:19, Krzysztof Kozlowski wrote:
> On 05/09/2024 17:16, Krzysztof Kozlowski wrote:
>> Pointers to struct qcom_icc_node are const.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This was sent 1.5 months ago. Any comments on it? Can it be applied?

Thank you for the patch! It was applied to my local branch that i
pushed 7 hours ago. Tomorrow it should be part of linux-next.

BR,
Georgi


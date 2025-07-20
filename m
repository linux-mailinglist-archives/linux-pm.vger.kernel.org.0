Return-Path: <linux-pm+bounces-31115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E782B0B68F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5597A9254
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A11F874F;
	Sun, 20 Jul 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psovXr+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90555192D83;
	Sun, 20 Jul 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023776; cv=none; b=hYFoxyINiFDkwki2yac27E+HNcGu0N4nKOZJPj+gxyE2rMhvETp+72Gwaa7mG9k8NRbzr0a84ZUBFLwRaFousDYnQnzt7wCen2NMHDOgs4gfBicXwpqNTEIyrQp6ASH59FtBe3zl7VM5R108oMLMoAH4rKwgUgSiyli5JyIttd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023776; c=relaxed/simple;
	bh=wmDjMVHr7JBTa1Q1zo0FqP/1Pgc3GRh/aCn12INDJZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZiwRvyfgcI5pClKAzr98TYZhpDgZMwqZaRwjx7l3hN8JEYRBEmOxR8TtnUiWA/aejz9gFNI6dawDpp0Qj+p80LAdB1NnLfIu07Ve6aYvKBX6njwHS8vLtfmWCQNESQisW7AXD+zy4/ccTdsnqnuQnPKTUtr8jPes4OBvGmjF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psovXr+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5EFC4CEE7;
	Sun, 20 Jul 2025 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753023776;
	bh=wmDjMVHr7JBTa1Q1zo0FqP/1Pgc3GRh/aCn12INDJZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=psovXr+jVWwSYuK8JfUpwMFl3hktbBOSqMzrUvHUjq1F1zIITvwVPlnwPPurN/T9U
	 7QquQHzbCPrSaxO8keqgSoAUVFsfGz6ROlcqFpkMlKyvKZ+iWAg2tEE8xlIeNUJ0To
	 U6tMUZK8e/Dv0y5agd3Pramlz7ypAFxAEWy7fuWHxD0vkgspJzLHiw8TeWYX8y7Vvd
	 HQ2fUMF3cwIBcKvLD2PfarcYb8OWXVpv/ekPODfBCmYt7i2ND1qnRvCPvu36ky0oEd
	 CqsGbmj8c8zC7aFwZuK6A0d2+eBPQiMvFBKPFOKQ5aSOUPLyKC/TnDT/PvJL5Gsrm3
	 KRJdYPr1hMHXw==
Message-ID: <ffc17695-25e1-44d4-843d-d06d17e8da32@kernel.org>
Date: Sun, 20 Jul 2025 18:02:48 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add glymur interconnect provider
 driver
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_rjendra@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
 <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
 <y5mqsl7ix7y54v54hltt54n5f3ofzg33lkgon4aoayy2nnkojk@r4qlsjd5wdqg>
 <0a1ff771-17c5-44d1-88da-5dd54c303d14@oss.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <0a1ff771-17c5-44d1-88da-5dd54c303d14@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/25 4:19 PM, Raviteja Laggyshetty wrote:
> 
> On 7/16/2025 8:58 PM, Dmitry Baryshkov wrote:
>> On Wed, Jul 16, 2025 at 08:45:35PM +0530, Pankaj Patil wrote:
>>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>
>>> Add driver for the Qualcomm interconnect buses found in glymur
>>> based platforms. The topology consists of several NoCs that are
>>> controlled by a remote processor that collects the aggregated
>>> bandwidth for each master-slave pairs.
>> I'd kindly ask to rebase on top of [1] unless Georgi says otherwise.
> 
> I think you intend to rebase on top of [1], but forgot to mention the link.
> 
> Please provide the link.

Rebasing on linux-next is usually fine. But why not use dynamic ids?

Thanks,
Georgi

> 
> 
> Thanks,
> 
> Raviteja.
> 
>>
>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
>>>   drivers/interconnect/qcom/Kconfig  |    9 +
>>>   drivers/interconnect/qcom/Makefile |    2 +
>>>   drivers/interconnect/qcom/glymur.c | 2259 ++++++++++++++++++++++++++++
>>>   drivers/interconnect/qcom/glymur.h |  185 +++
>>>   4 files changed, 2455 insertions(+)
>>>   create mode 100644 drivers/interconnect/qcom/glymur.c
>>>   create mode 100644 drivers/interconnect/qcom/glymur.h
>>>


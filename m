Return-Path: <linux-pm+bounces-31159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DFB0BDC3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C25318865C2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB8D283FD9;
	Mon, 21 Jul 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+wuZtKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA126BF7;
	Mon, 21 Jul 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083387; cv=none; b=QcS7MLWsS30eU2OqZwEkacWeLurQGKzC1WuSmm3ctnhGoVs4g3rPLCTu4s/w/7I33HWw4OqHdHRWLC5NjdTD3V5cCmhPtBS/BDx8IqxTluYuMlyZ3xApdA0aL1EJqkfOGbwN+g04wiM9chbZLZpD88Q6aAG+6+c2H0Z939oX+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083387; c=relaxed/simple;
	bh=nkI6N66P9qYEFq1N9Ho3IcR4AN93BL7mAD/A7fTOcoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9tG+LL83NLEgc2SOPfaTNUQbAsI4fikpQQtAXJOISF2wfbYwiczYQCCVbjKXf93iWlbGljr36MTlXf+rlQQsOpeomGEoHqKmstu0SOGb0oFBMWdns68YYO+MowmCdwqR5nWnLBIyzXYKab26sJG//VeBElBtuzdJJLl44eWfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+wuZtKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8659CC4CEED;
	Mon, 21 Jul 2025 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753083387;
	bh=nkI6N66P9qYEFq1N9Ho3IcR4AN93BL7mAD/A7fTOcoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M+wuZtKUR5V404eSLlmMhp+IvYraPKevOeeUqKg98S349HoeDLkVMy4cQucR0WaN3
	 T9aRAQ6RIBtGS8M35/kp14SZm57YGzfz3IdSYXBooDPts9aB2LcxR64Jyd/8blG4/3
	 H8psPcX3aj833/2tG8J15iNZT2brUztQjfspKMQ7d8hwCIdoN1D8CThCZVBW01SIcJ
	 v/Mo99a9OtlUtXxPP1TAYaagu73lkMbnrMAhCt5ann2MOmB0tnMfYONJxFWYIPeDDg
	 EqQywd54BVexEJ17kXGRX7y61lzDjYswRkym1UvUfZ/LFZxihvVh2DLGwq79OkxIJD
	 Gqz/7msvXjhPA==
Message-ID: <d8955532-9a3b-451f-b5c7-549cee7d749e@kernel.org>
Date: Mon, 21 Jul 2025 10:36:19 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
 <20250709-sm7635-icc-v3-2-c446203c3b3a@fairphone.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250709-sm7635-icc-v3-2-c446203c3b3a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca,

On 7/9/25 4:14 PM, Luca Weiss wrote:
> Add driver for the Qualcomm interconnect buses found in Milos based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/interconnect/qcom/Kconfig  |    9 +
>   drivers/interconnect/qcom/Makefile |    2 +
>   drivers/interconnect/qcom/milos.c  | 1837 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1848 insertions(+)
> 
[..]
> +
> +static struct qcom_icc_qosbox qhm_qup1_qos = {
> +	.num_ports = 1,
> +	.port_offsets = { 0xc000 },
> +	.prio = 2,
> +	.urg_fwd = 0,
> +	.prio_fwd_disable = 1,
> +};

Thanks for adding QoS!

> +
> +static struct qcom_icc_node qhm_qup1 = {
> +	.name = "qhm_qup1",
> +	.channels = 1,
> +	.buswidth = 4,
> +	.qosbox = &qhm_qup1_qos,
> +	.link_nodes = { &qns_a1noc_snoc, NULL },
> +};

It's very nice that you switched to the dynamic IDs, but please use the
current style of links (like in v1), as the the NULL terminated lists
are not merged yet. All the rest looks good!

Thanks,
Georgi


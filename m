Return-Path: <linux-pm+bounces-25364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D678A87C9A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2463B234E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB2265604;
	Mon, 14 Apr 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDcbPhRp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0C18BC3F;
	Mon, 14 Apr 2025 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624687; cv=none; b=B2/u+rOU5Pfor9sXGvMXhfC2qfVTokMGd3VEzqB1rHVYofAZ0VXAfQWBGeVuA7iDTzrGC4jWpGKn/n1HhRNypVNvPvYvIEXlQRsxBI9qcMwcQ540yjvybwufj2U434MyvJTz1TIlQRXJhu+XcYBfB0kEF+ONPB6COqq7ClQ/FbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624687; c=relaxed/simple;
	bh=uaSJgPqB1v1GlnR5cJtgoNbh6JzLoEdGEFovlyKRAxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rwhn0Kp4iQ9E1VdOzFRc2gy53OpEK4pmndTPLZroMnZwR3zaSqtPxPdHRntvcnPfBJC72of52xTTyJJqlZyRZTHLBZBDbDxy1jMVI7CNR+JWGL6qd1pOKWdqXJlrqKQ2fB3mhObt/XePYE/THikpFvCh9bjXh+Y59zd4fYWkKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDcbPhRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3983C4CEE5;
	Mon, 14 Apr 2025 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744624685;
	bh=uaSJgPqB1v1GlnR5cJtgoNbh6JzLoEdGEFovlyKRAxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nDcbPhRpNXrv4rtCzBXqAWis4gfMqYYtxXMQrktM2iGPk8YXGOjFCGtnzEReghBlD
	 csqOxEbzxcB5UAd+ZtsYhGC6A3XNaX1L+U882/7tRmh2AfCeAr4Yx2fr8EjUqLIzwC
	 KtyeRc6gmcditYUROzPtyL/hKEQVh0obll5HTjjzN9ItRcO2jmYziFg0SOVUyikNXr
	 4D8bA4VMYFNMuZpPEaMCIyhZ5qn2HiwgbkHY1Ll670zLGQRUgjoF/9MhVJcAVEJKG/
	 c8ZOCy1jcdk4nfHQn5TxCN9PZZb0PrS81JGexNQgXRdCGxGKk+skuKVnUIyRUfDLcF
	 M12X/IeOW3iKA==
Message-ID: <c923c877-3d34-47c1-96ae-5ba6c3a39ebd@kernel.org>
Date: Mon, 14 Apr 2025 12:58:00 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/7] interconnect: qcom: Add multidev EPSS L3 support
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-4-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250324183203.30127-4-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.03.25 20:31, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances, necessitating the creation of two
> device nodes with different compatibles due to the unique ICC node ID
> and name limitations in the interconnect framework. Add multidevice
> support for the OSM-L3 provider to dynamically obtain unique node IDs
> and register with the framework.
> EPSS topology includes a single master-slave pair within the same
> provider, the node linking logic is simplified by directly connecting
> the master node to the slave node.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>   drivers/interconnect/qcom/osm-l3.c | 36 ++++++++++--------------------
>   1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 6a656ed44d49..43e67d2116b9 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/args.h>
> @@ -48,16 +49,10 @@ struct qcom_osm_l3_icc_provider {
>   /**
>    * struct qcom_osm_l3_node - Qualcomm specific interconnect nodes
>    * @name: the node name used in debugfs
> - * @links: an array of nodes where we can go next while traversing
> - * @id: a unique node identifier
> - * @num_links: the total number of @links
>    * @buswidth: width of the interconnect between a node and the bus
>    */
>   struct qcom_osm_l3_node {
>   	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];

Please remove also the #define for OSM_L3_MAX_LINKS, as it's unused now.

> -	u16 id;
> -	u16 num_links;
>   	u16 buswidth;
>   };
>

BR,
Georgi


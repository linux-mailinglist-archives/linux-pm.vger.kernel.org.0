Return-Path: <linux-pm+bounces-23120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F0A484FB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25E2189610D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344361B041C;
	Thu, 27 Feb 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLpZjNOM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD01AF0CA
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673418; cv=none; b=DIEs/Ek392KYEAIZvUBctyW3ugJ4RylGyEfRQhNJu2v6RcqbCBbQg7ziFUN+5LGrqQ24xA2OxiUDpgqzYgF/sS1dGfdB6EThrcvBTPc4qixzUsxXJS7yT2s7yEjHF0TPx05eS8+zvHFBR7lQz+D/Fnv/dnn5Pa3KZUTvPICKMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673418; c=relaxed/simple;
	bh=5YhkK5NsT5ltdnX0vfaP6RpjugInQ8v2M8Z3YwxWTxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWNACssDjE9puGoed1zOiwaCoYhn7WhOBFGBdjPRcFvRQm3Nca45ccQzgofc6uHybgMmn8i+3kgokcu+qwGFrsIFtJF+78vlm4lJWwE3M568xZkfT41dUPmhQAo9UudYQIy7deyxsdDo/HREzF19os2Fh7if2NLZ5lQmaZf7GW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLpZjNOM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so10902621fa.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740673411; x=1741278211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0OL6Ar8p0CswJXM9MXG9G9bh4EBxJWRON4EOinfX/I=;
        b=jLpZjNOMuGih7r2tgkd+gN5Yhm+7LjOnxA4Gu9ANxDfLt1HwCEYSNxowfqwmwWfVIE
         Ojd0yMEp6CB5V3TKnnggE2PzUIUDePRgza92MJIfZqOob+XReXEpX2afCrB6aEVWY0Ed
         kA8O8sbFWq9asC2046o2AyKboWH77FX+NgVtgFhBYdAsABSrW+F+rSFg0sxMLBzomeFB
         tni6RME0J6Zw1EsG5ccRWbOconQYRmg8TXkjjDrHIX86EWT/x8G205wc75uBQTx/1hd7
         byjUDSmuOlagJ7ymGuO04wRkEr6QdrQVHCMTpDVNnY+Cz6W5LEVoWbhWSGuspEYTM1OP
         TnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673411; x=1741278211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0OL6Ar8p0CswJXM9MXG9G9bh4EBxJWRON4EOinfX/I=;
        b=kFVJf22+lS5De45JB3YfUCQDUefAGroRqSd34bI5lj4Nl22relqKBXTOZO8i8uK21g
         0VbAUDnze3hxbXdytBQyc8CxE8dvXl8BB6SBQ0OTGxUceiKKcI538+SgkLYfk+GkxZ+4
         +PmUsKjDa9BLLLbcyFJ+n4VNsv5ApnduTWKU6ezOszJK++ci0PNw+U7pEk3aS9dM8C6l
         0QHC7YLzjeO/5uh7uXJrAvPW0oU+W4+AuL/KnvDvFavUR0QGFyDV207Osms+02W5KIiP
         k/Ln8ZcRc43l80Iiu0KFStyEVokgGomkupNZy5yo88aY+9WUZJT9zbt/N15I2YgLiQMW
         FAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3oHpxNjxvvoVOGf5XWYN6rHWgpHDJ/clT7oPgwsoG7yCtid0ennj+YB6vxNhZh4G+WffpwHSYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97MFffTQiDxOwRFgtfriMgN8IGA2ucWk+aST6HfehCAk3NBar
	D3AmQIzv/TuHFzx1ZrkOj/o6vuydJHacR6kGHi9VfdlUT6lO1yvexUWSxJ0nVkU=
X-Gm-Gg: ASbGncuLHbSzZiQzKjJJ6N9W69vrhOL0gC7B8TyEAR1tNWNLt+/zD1H9jH5+IMpWQSV
	LkSFTVnpbFBKSQKXWN4sJZaij1B4qtkc//GmKuNK6NhHSCLI2j8RcP8Fn//X2v061rcOBCBpVEm
	cWFWsguw2bohxXtx8YHXFirBzkUKzykq9ZZBI1yTkg8YNcyDDVDd4THjolyx8vkQwDeTDSL+/EU
	6EVgsATMwyo/HTi30qA1WEBjpU7sk0xUgy+gVNR12idHrDTp0SlWhoxGbEqd2tBRI63PEPgPO0n
	CqRS2c8/oyQB+3m3f4pb/a8OPN12g+F8zwFlZNiGzpcg+8FLQTweeH/wv2ef9/e/Iv4BeHSaMgC
	voOJcUA==
X-Google-Smtp-Source: AGHT+IH9asczBC9HY+CyMsPCdI8ZNRiaNRFjpLtAX+WxrSWtmfKGv26c3Joe1vm1BLC7y8rlP9fVkQ==
X-Received: by 2002:a05:6512:3a90:b0:545:1049:eb44 with SMTP id 2adb3069b0e04-5494c3501f8mr10406e87.36.1740673410948;
        Thu, 27 Feb 2025 08:23:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b119dsm199034e87.138.2025.02.27.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:23:29 -0800 (PST)
Date: Thu, 27 Feb 2025 18:23:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 5/7] interconnect: qcom: sa8775p: Add dynamic icc node
 id support
Message-ID: <adnjrgmeexa54w3sp4ykuo6gzsmot2575sjyx3o6v7uyufpodb@p662ngeuc5zo>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-6-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-6-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:11PM +0000, Raviteja Laggyshetty wrote:
> Discard the static IDs from node data and set the default node ID
> to ALLOC_DYN_ID to indicate dynamic ID allocation.
> Update the topology to use node pointers for links instead of static
> IDs and forward declare the node pointer to avoid undefined references.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 1131 +++++++++++++--------------
>  1 file changed, 526 insertions(+), 605 deletions(-)
> 
>  
>  static struct qcom_icc_node qxm_qup3 = {
>  	.name = "qxm_qup3",
> -	.id = SA8775P_MASTER_QUP_3,
> +	.id = ALLOC_DYN_ID,

In the long term this assignment is just a bolerplate / noise: we are
going to switch all providers to the dynamic IDs. Could you please add a
flag to qcom_icc_desc instead? Or maybe even better, add
internal qcom_icc_rpmh_probe_common which takes a flag whether to use
dynamic IDs or static IDs. and then add qcom_icc_rpmh_probe_dynamic(),
which will pass true to that function. Then, once all icc_rpmh drivers
are converted we can drop old bits, instead of keeping (now useless) .id
= ALLOW_DYN_ID (or removing them in another pass over all the drivers).

>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_emac_0 = {
>  	.name = "xm_emac_0",
> -	.id = SA8775P_MASTER_EMAC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_emac_1 = {
>  	.name = "xm_emac_1",
> -	.id = SA8775P_MASTER_EMAC_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_sdc1 = {
>  	.name = "xm_sdc1",
> -	.id = SA8775P_MASTER_SDC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_ufs_mem = {
>  	.name = "xm_ufs_mem",
> -	.id = SA8775P_MASTER_UFS_MEM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_usb2_2 = {
>  	.name = "xm_usb2_2",
> -	.id = SA8775P_MASTER_USB2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_usb3_0 = {
>  	.name = "xm_usb3_0",
> -	.id = SA8775P_MASTER_USB3_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_usb3_1 = {
>  	.name = "xm_usb3_1",
> -	.id = SA8775P_MASTER_USB3_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +	.link_nodes = { &qns_a1noc_snoc },
>  };
>  
>  static struct qcom_icc_node qhm_qdss_bam = {
>  	.name = "qhm_qdss_bam",
> -	.id = SA8775P_MASTER_QDSS_BAM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qhm_qup0 = {
>  	.name = "qhm_qup0",
> -	.id = SA8775P_MASTER_QUP_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qhm_qup1 = {
>  	.name = "qhm_qup1",
> -	.id = SA8775P_MASTER_QUP_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qhm_qup2 = {
>  	.name = "qhm_qup2",
> -	.id = SA8775P_MASTER_QUP_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qnm_cnoc_datapath = {
>  	.name = "qnm_cnoc_datapath",
> -	.id = SA8775P_MASTER_CNOC_A2NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qxm_crypto_0 = {
>  	.name = "qxm_crypto_0",
> -	.id = SA8775P_MASTER_CRYPTO_CORE0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qxm_crypto_1 = {
>  	.name = "qxm_crypto_1",
> -	.id = SA8775P_MASTER_CRYPTO_CORE1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qxm_ipa = {
>  	.name = "qxm_ipa",
> -	.id = SA8775P_MASTER_IPA,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_qdss_etr_0 = {
>  	.name = "xm_qdss_etr_0",
> -	.id = SA8775P_MASTER_QDSS_ETR_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_qdss_etr_1 = {
>  	.name = "xm_qdss_etr_1",
> -	.id = SA8775P_MASTER_QDSS_ETR_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node xm_ufs_card = {
>  	.name = "xm_ufs_card",
> -	.id = SA8775P_MASTER_UFS_CARD,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +	.link_nodes = { &qns_a2noc_snoc },
>  };
>  
>  static struct qcom_icc_node qup0_core_master = {
>  	.name = "qup0_core_master",
> -	.id = SA8775P_MASTER_QUP_CORE_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_QUP_CORE_0 },
> +	.link_nodes = { &qup0_core_slave },
>  };
>  
>  static struct qcom_icc_node qup1_core_master = {
>  	.name = "qup1_core_master",
> -	.id = SA8775P_MASTER_QUP_CORE_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_QUP_CORE_1 },
> +	.link_nodes = { &qup1_core_slave },
>  };
>  
>  static struct qcom_icc_node qup2_core_master = {
>  	.name = "qup2_core_master",
> -	.id = SA8775P_MASTER_QUP_CORE_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_QUP_CORE_2 },
> +	.link_nodes = { &qup2_core_slave },
>  };
>  
>  static struct qcom_icc_node qup3_core_master = {
>  	.name = "qup3_core_master",
> -	.id = SA8775P_MASTER_QUP_CORE_3,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_QUP_CORE_3 },
> +	.link_nodes = { &qup3_core_slave },
>  };
>  
>  static struct qcom_icc_node qnm_gemnoc_cnoc = {
>  	.name = "qnm_gemnoc_cnoc",
> -	.id = SA8775P_MASTER_GEM_NOC_CNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 82,
> -	.links = { SA8775P_SLAVE_AHB2PHY_0,
> -		   SA8775P_SLAVE_AHB2PHY_1,
> -		   SA8775P_SLAVE_AHB2PHY_2,
> -		   SA8775P_SLAVE_AHB2PHY_3,
> -		   SA8775P_SLAVE_ANOC_THROTTLE_CFG,
> -		   SA8775P_SLAVE_AOSS,
> -		   SA8775P_SLAVE_APPSS,
> -		   SA8775P_SLAVE_BOOT_ROM,
> -		   SA8775P_SLAVE_CAMERA_CFG,
> -		   SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
> -		   SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG,
> -		   SA8775P_SLAVE_CLK_CTL,
> -		   SA8775P_SLAVE_CDSP_CFG,
> -		   SA8775P_SLAVE_CDSP1_CFG,
> -		   SA8775P_SLAVE_RBCPR_CX_CFG,
> -		   SA8775P_SLAVE_RBCPR_MMCX_CFG,
> -		   SA8775P_SLAVE_RBCPR_MX_CFG,
> -		   SA8775P_SLAVE_CPR_NSPCX,
> -		   SA8775P_SLAVE_CRYPTO_0_CFG,
> -		   SA8775P_SLAVE_CX_RDPM,
> -		   SA8775P_SLAVE_DISPLAY_CFG,
> -		   SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
> -		   SA8775P_SLAVE_DISPLAY1_CFG,
> -		   SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
> -		   SA8775P_SLAVE_EMAC_CFG,
> -		   SA8775P_SLAVE_EMAC1_CFG,
> -		   SA8775P_SLAVE_GP_DSP0_CFG,
> -		   SA8775P_SLAVE_GP_DSP1_CFG,
> -		   SA8775P_SLAVE_GPDSP0_THROTTLE_CFG,
> -		   SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
> -		   SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG,
> -		   SA8775P_SLAVE_GFX3D_CFG,
> -		   SA8775P_SLAVE_HWKM,
> -		   SA8775P_SLAVE_IMEM_CFG,
> -		   SA8775P_SLAVE_IPA_CFG,
> -		   SA8775P_SLAVE_IPC_ROUTER_CFG,
> -		   SA8775P_SLAVE_LPASS,
> -		   SA8775P_SLAVE_LPASS_THROTTLE_CFG,
> -		   SA8775P_SLAVE_MX_RDPM,
> -		   SA8775P_SLAVE_MXC_RDPM,
> -		   SA8775P_SLAVE_PCIE_0_CFG,
> -		   SA8775P_SLAVE_PCIE_1_CFG,
> -		   SA8775P_SLAVE_PCIE_RSC_CFG,
> -		   SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
> -		   SA8775P_SLAVE_PCIE_THROTTLE_CFG,
> -		   SA8775P_SLAVE_PDM,
> -		   SA8775P_SLAVE_PIMEM_CFG,
> -		   SA8775P_SLAVE_PKA_WRAPPER_CFG,
> -		   SA8775P_SLAVE_QDSS_CFG,
> -		   SA8775P_SLAVE_QM_CFG,
> -		   SA8775P_SLAVE_QM_MPU_CFG,
> -		   SA8775P_SLAVE_QUP_0,
> -		   SA8775P_SLAVE_QUP_1,
> -		   SA8775P_SLAVE_QUP_2,
> -		   SA8775P_SLAVE_QUP_3,
> -		   SA8775P_SLAVE_SAIL_THROTTLE_CFG,
> -		   SA8775P_SLAVE_SDC1,
> -		   SA8775P_SLAVE_SECURITY,
> -		   SA8775P_SLAVE_SNOC_THROTTLE_CFG,
> -		   SA8775P_SLAVE_TCSR,
> -		   SA8775P_SLAVE_TLMM,
> -		   SA8775P_SLAVE_TSC_CFG,
> -		   SA8775P_SLAVE_UFS_CARD_CFG,
> -		   SA8775P_SLAVE_UFS_MEM_CFG,
> -		   SA8775P_SLAVE_USB2,
> -		   SA8775P_SLAVE_USB3_0,
> -		   SA8775P_SLAVE_USB3_1,
> -		   SA8775P_SLAVE_VENUS_CFG,
> -		   SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG,
> -		   SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
> -		   SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
> -		   SA8775P_SLAVE_DDRSS_CFG,
> -		   SA8775P_SLAVE_GPDSP_NOC_CFG,
> -		   SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
> -		   SA8775P_SLAVE_CNOC_MNOC_SF_CFG,
> -		   SA8775P_SLAVE_PCIE_ANOC_CFG,
> -		   SA8775P_SLAVE_SNOC_CFG,
> -		   SA8775P_SLAVE_BOOT_IMEM,
> -		   SA8775P_SLAVE_IMEM,
> -		   SA8775P_SLAVE_PIMEM,
> -		   SA8775P_SLAVE_QDSS_STM,
> -		   SA8775P_SLAVE_TCU
> -	},
> +	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
> +			&qhs_ahb2phy2, &qhs_ahb2phy3,
> +			&qhs_anoc_throttle_cfg, &qhs_aoss,
> +			&qhs_apss, &qhs_boot_rom,
> +			&qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg,
> +			&qhs_camera_rt_throttle_cfg, &qhs_clk_ctl,
> +			&qhs_compute0_cfg, &qhs_compute1_cfg,
> +			&qhs_cpr_cx, &qhs_cpr_mmcx,
> +			&qhs_cpr_mx, &qhs_cpr_nspcx,
> +			&qhs_crypto0_cfg, &qhs_cx_rdpm,
> +			&qhs_display0_cfg, &qhs_display0_rt_throttle_cfg,
> +			&qhs_display1_cfg, &qhs_display1_rt_throttle_cfg,
> +			&qhs_emac0_cfg, &qhs_emac1_cfg,
> +			&qhs_gp_dsp0_cfg, &qhs_gp_dsp1_cfg,
> +			&qhs_gpdsp0_throttle_cfg, &qhs_gpdsp1_throttle_cfg,
> +			&qhs_gpu_tcu_throttle_cfg, &qhs_gpuss_cfg,
> +			&qhs_hwkm, &qhs_imem_cfg,
> +			&qhs_ipa, &qhs_ipc_router,
> +			&qhs_lpass_cfg, &qhs_lpass_throttle_cfg,
> +			&qhs_mx_rdpm, &qhs_mxc_rdpm,
> +			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
> +			&qhs_pcie_rsc_cfg, &qhs_pcie_tcu_throttle_cfg,
> +			&qhs_pcie_throttle_cfg, &qhs_pdm,
> +			&qhs_pimem_cfg, &qhs_pke_wrapper_cfg,
> +			&qhs_qdss_cfg, &qhs_qm_cfg,
> +			&qhs_qm_mpu_cfg, &qhs_qup0,
> +			&qhs_qup1, &qhs_qup2,
> +			&qhs_qup3, &qhs_sail_throttle_cfg,
> +			&qhs_sdc1, &qhs_security,
> +			&qhs_snoc_throttle_cfg, &qhs_tcsr,
> +			&qhs_tlmm, &qhs_tsc_cfg,
> +			&qhs_ufs_card_cfg, &qhs_ufs_mem_cfg,
> +			&qhs_usb2_0, &qhs_usb3_0,
> +			&qhs_usb3_1, &qhs_venus_cfg,
> +			&qhs_venus_cvp_throttle_cfg, &qhs_venus_v_cpu_throttle_cfg,
> +			&qhs_venus_vcodec_throttle_cfg, &qns_ddrss_cfg,
> +			&qns_gpdsp_noc_cfg, &qns_mnoc_hf_cfg,
> +			&qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
> +			&qns_snoc_cfg, &qxs_boot_imem,
> +			&qxs_imem, &qxs_pimem,
> +			&xs_qdss_stm, &xs_sys_tcu_cfg },
>  };
>  
>  static struct qcom_icc_node qnm_gemnoc_pcie = {
>  	.name = "qnm_gemnoc_pcie",
> -	.id = SA8775P_MASTER_GEM_NOC_PCIE_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_PCIE_0,
> -		   SA8775P_SLAVE_PCIE_1
> -	},
> +	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
>  };
>  
>  static struct qcom_icc_node qnm_cnoc_dc_noc = {
>  	.name = "qnm_cnoc_dc_noc",
> -	.id = SA8775P_MASTER_CNOC_DC_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_LLCC_CFG,
> -		   SA8775P_SLAVE_GEM_NOC_CFG
> -	},
> +	.link_nodes = { &qhs_llcc, &qns_gemnoc },
>  };
>  
>  static struct qcom_icc_node alm_gpu_tcu = {
>  	.name = "alm_gpu_tcu",
> -	.id = SA8775P_MASTER_GPU_TCU,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node alm_pcie_tcu = {
>  	.name = "alm_pcie_tcu",
> -	.id = SA8775P_MASTER_PCIE_TCU,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node alm_sys_tcu = {
>  	.name = "alm_sys_tcu",
> -	.id = SA8775P_MASTER_SYS_TCU,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node chm_apps = {
>  	.name = "chm_apps",
> -	.id = SA8775P_MASTER_APPSS_PROC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 4,
>  	.buswidth = 32,
>  	.num_links = 3,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC,
> -		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
> +			&qns_pcie },
>  };
>  
>  static struct qcom_icc_node qnm_cmpnoc0 = {
>  	.name = "qnm_cmpnoc0",
> -	.id = SA8775P_MASTER_COMPUTE_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_cmpnoc1 = {
>  	.name = "qnm_cmpnoc1",
> -	.id = SA8775P_MASTER_COMPUTE_NOC_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_gemnoc_cfg = {
>  	.name = "qnm_gemnoc_cfg",
> -	.id = SA8775P_MASTER_GEM_NOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 4,
> -	.links = { SA8775P_SLAVE_SERVICE_GEM_NOC_1,
> -		   SA8775P_SLAVE_SERVICE_GEM_NOC_2,
> -		   SA8775P_SLAVE_SERVICE_GEM_NOC,
> -		   SA8775P_SLAVE_SERVICE_GEM_NOC2
> -	},
> +	.link_nodes = { &srvc_even_gemnoc, &srvc_odd_gemnoc,
> +			&srvc_sys_gemnoc, &srvc_sys_gemnoc_2 },
>  };
>  
>  static struct qcom_icc_node qnm_gpdsp_sail = {
>  	.name = "qnm_gpdsp_sail",
> -	.id = SA8775P_MASTER_GPDSP_SAIL,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_gpu = {
>  	.name = "qnm_gpu",
> -	.id = SA8775P_MASTER_GFX3D,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_mnoc_hf = {
>  	.name = "qnm_mnoc_hf",
> -	.id = SA8775P_MASTER_MNOC_HF_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_LLCC,
> -		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
> -	},
> +	.link_nodes = { &qns_llcc, &qns_pcie },
>  };
>  
>  static struct qcom_icc_node qnm_mnoc_sf = {
>  	.name = "qnm_mnoc_sf",
> -	.id = SA8775P_MASTER_MNOC_SF_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 3,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC,
> -		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
> +			&qns_pcie },
>  };
>  
>  static struct qcom_icc_node qnm_pcie = {
>  	.name = "qnm_pcie",
> -	.id = SA8775P_MASTER_ANOC_PCIE_GEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC
> -	},
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_snoc_gc = {
>  	.name = "qnm_snoc_gc",
> -	.id = SA8775P_MASTER_SNOC_GC_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_LLCC },
> +	.link_nodes = { &qns_llcc },
>  };
>  
>  static struct qcom_icc_node qnm_snoc_sf = {
>  	.name = "qnm_snoc_sf",
> -	.id = SA8775P_MASTER_SNOC_SF_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 3,
> -	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
> -		   SA8775P_SLAVE_LLCC,
> -		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
> +	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
> +			&qns_pcie },
>  };
>  
>  static struct qcom_icc_node qxm_dsp0 = {
>  	.name = "qxm_dsp0",
> -	.id = SA8775P_MASTER_DSP0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
> +	.link_nodes = { &qns_gp_dsp_sail_noc },
>  };
>  
>  static struct qcom_icc_node qxm_dsp1 = {
>  	.name = "qxm_dsp1",
> -	.id = SA8775P_MASTER_DSP1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
> +	.link_nodes = { &qns_gp_dsp_sail_noc },
>  };
>  
>  static struct qcom_icc_node qhm_config_noc = {
>  	.name = "qhm_config_noc",
> -	.id = SA8775P_MASTER_CNOC_LPASS_AG_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 6,
> -	.links = { SA8775P_SLAVE_LPASS_CORE_CFG,
> -		   SA8775P_SLAVE_LPASS_LPI_CFG,
> -		   SA8775P_SLAVE_LPASS_MPU_CFG,
> -		   SA8775P_SLAVE_LPASS_TOP_CFG,
> -		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
> -		   SA8775P_SLAVE_SERVICE_LPASS_AG_NOC
> -	},
> +	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
> +			&qhs_lpass_mpu, &qhs_lpass_top,
> +			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
>  };
>  
>  static struct qcom_icc_node qxm_lpass_dsp = {
>  	.name = "qxm_lpass_dsp",
> -	.id = SA8775P_MASTER_LPASS_PROC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 4,
> -	.links = { SA8775P_SLAVE_LPASS_TOP_CFG,
> -		   SA8775P_SLAVE_LPASS_SNOC,
> -		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
> -		   SA8775P_SLAVE_SERVICE_LPASS_AG_NOC
> -	},
> +	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
> +			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
>  };
>  
>  static struct qcom_icc_node llcc_mc = {
>  	.name = "llcc_mc",
> -	.id = SA8775P_MASTER_LLCC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 8,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_EBI1 },
> +	.link_nodes = { &ebi },
>  };
>  
>  static struct qcom_icc_node qnm_camnoc_hf = {
>  	.name = "qnm_camnoc_hf",
> -	.id = SA8775P_MASTER_CAMNOC_HF,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_camnoc_icp = {
>  	.name = "qnm_camnoc_icp",
> -	.id = SA8775P_MASTER_CAMNOC_ICP,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_camnoc_sf = {
>  	.name = "qnm_camnoc_sf",
> -	.id = SA8775P_MASTER_CAMNOC_SF,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_mdp0_0 = {
>  	.name = "qnm_mdp0_0",
> -	.id = SA8775P_MASTER_MDP0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_mdp0_1 = {
>  	.name = "qnm_mdp0_1",
> -	.id = SA8775P_MASTER_MDP1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_mdp1_0 = {
>  	.name = "qnm_mdp1_0",
> -	.id = SA8775P_MASTER_MDP_CORE1_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_mdp1_1 = {
>  	.name = "qnm_mdp1_1",
> -	.id = SA8775P_MASTER_MDP_CORE1_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_mnoc_hf_cfg = {
>  	.name = "qnm_mnoc_hf_cfg",
> -	.id = SA8775P_MASTER_CNOC_MNOC_HF_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SERVICE_MNOC_HF },
> +	.link_nodes = { &srvc_mnoc_hf },
>  };
>  
>  static struct qcom_icc_node qnm_mnoc_sf_cfg = {
>  	.name = "qnm_mnoc_sf_cfg",
> -	.id = SA8775P_MASTER_CNOC_MNOC_SF_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SERVICE_MNOC_SF },
> +	.link_nodes = { &srvc_mnoc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_video0 = {
>  	.name = "qnm_video0",
> -	.id = SA8775P_MASTER_VIDEO_P0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_video1 = {
>  	.name = "qnm_video1",
> -	.id = SA8775P_MASTER_VIDEO_P1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_video_cvp = {
>  	.name = "qnm_video_cvp",
> -	.id = SA8775P_MASTER_VIDEO_PROC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_video_v_cpu = {
>  	.name = "qnm_video_v_cpu",
> -	.id = SA8775P_MASTER_VIDEO_V_PROC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qns_mem_noc_sf },
>  };
>  
>  static struct qcom_icc_node qhm_nsp_noc_config = {
>  	.name = "qhm_nsp_noc_config",
> -	.id = SA8775P_MASTER_CDSP_NOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SERVICE_NSP_NOC },
> +	.link_nodes = { &service_nsp_noc },
>  };
>  
>  static struct qcom_icc_node qxm_nsp = {
>  	.name = "qxm_nsp",
> -	.id = SA8775P_MASTER_CDSP_PROC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_HCP_A, SLAVE_CDSP_MEM_NOC },
> +	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc },
>  };
>  
>  static struct qcom_icc_node qhm_nspb_noc_config = {
>  	.name = "qhm_nspb_noc_config",
> -	.id = SA8775P_MASTER_CDSPB_NOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SERVICE_NSPB_NOC },
> +	.link_nodes = { &service_nspb_noc },
>  };
>  
>  static struct qcom_icc_node qxm_nspb = {
>  	.name = "qxm_nspb",
> -	.id = SA8775P_MASTER_CDSP_PROC_B,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 2,
> -	.links = { SA8775P_SLAVE_HCP_B, SLAVE_CDSPB_MEM_NOC },
> +	.link_nodes = { &qns_nspb_hcp, &qns_nspb_gemnoc },
>  };
>  
>  static struct qcom_icc_node xm_pcie3_0 = {
>  	.name = "xm_pcie3_0",
> -	.id = SA8775P_MASTER_PCIE_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
> +	.link_nodes = { &qns_pcie_mem_noc },
>  };
>  
>  static struct qcom_icc_node xm_pcie3_1 = {
>  	.name = "xm_pcie3_1",
> -	.id = SA8775P_MASTER_PCIE_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
> +	.link_nodes = { &qns_pcie_mem_noc },
>  };
>  
>  static struct qcom_icc_node qhm_gic = {
>  	.name = "qhm_gic",
> -	.id = SA8775P_MASTER_GIC_AHB,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +	.link_nodes = { &qns_gemnoc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_aggre1_noc = {
>  	.name = "qnm_aggre1_noc",
> -	.id = SA8775P_MASTER_A1NOC_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +	.link_nodes = { &qns_gemnoc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_aggre2_noc = {
>  	.name = "qnm_aggre2_noc",
> -	.id = SA8775P_MASTER_A2NOC_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +	.link_nodes = { &qns_gemnoc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_lpass_noc = {
>  	.name = "qnm_lpass_noc",
> -	.id = SA8775P_MASTER_LPASS_ANOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +	.link_nodes = { &qns_gemnoc_sf },
>  };
>  
>  static struct qcom_icc_node qnm_snoc_cfg = {
>  	.name = "qnm_snoc_cfg",
> -	.id = SA8775P_MASTER_SNOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SERVICE_SNOC },
> +	.link_nodes = { &srvc_snoc },
>  };
>  
>  static struct qcom_icc_node qxm_pimem = {
>  	.name = "qxm_pimem",
> -	.id = SA8775P_MASTER_PIMEM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
> +	.link_nodes = { &qns_gemnoc_gc },
>  };
>  
>  static struct qcom_icc_node xm_gic = {
>  	.name = "xm_gic",
> -	.id = SA8775P_MASTER_GIC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
> +	.link_nodes = { &qns_gemnoc_gc },
>  };
>  
>  static struct qcom_icc_node qns_a1noc_snoc = {
>  	.name = "qns_a1noc_snoc",
> -	.id = SA8775P_SLAVE_A1NOC_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_A1NOC_SNOC },
> +	.link_nodes = { &qnm_aggre1_noc },
>  };
>  
>  static struct qcom_icc_node qns_a2noc_snoc = {
>  	.name = "qns_a2noc_snoc",
> -	.id = SA8775P_SLAVE_A2NOC_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_A2NOC_SNOC },
> +	.link_nodes = { &qnm_aggre2_noc },
>  };
>  
>  static struct qcom_icc_node qup0_core_slave = {
>  	.name = "qup0_core_slave",
> -	.id = SA8775P_SLAVE_QUP_CORE_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qup1_core_slave = {
>  	.name = "qup1_core_slave",
> -	.id = SA8775P_SLAVE_QUP_CORE_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qup2_core_slave = {
>  	.name = "qup2_core_slave",
> -	.id = SA8775P_SLAVE_QUP_CORE_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qup3_core_slave = {
>  	.name = "qup3_core_slave",
> -	.id = SA8775P_SLAVE_QUP_CORE_3,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ahb2phy0 = {
>  	.name = "qhs_ahb2phy0",
> -	.id = SA8775P_SLAVE_AHB2PHY_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ahb2phy1 = {
>  	.name = "qhs_ahb2phy1",
> -	.id = SA8775P_SLAVE_AHB2PHY_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ahb2phy2 = {
>  	.name = "qhs_ahb2phy2",
> -	.id = SA8775P_SLAVE_AHB2PHY_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ahb2phy3 = {
>  	.name = "qhs_ahb2phy3",
> -	.id = SA8775P_SLAVE_AHB2PHY_3,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_anoc_throttle_cfg = {
>  	.name = "qhs_anoc_throttle_cfg",
> -	.id = SA8775P_SLAVE_ANOC_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_aoss = {
>  	.name = "qhs_aoss",
> -	.id = SA8775P_SLAVE_AOSS,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_apss = {
>  	.name = "qhs_apss",
> -	.id = SA8775P_SLAVE_APPSS,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  };
>  
>  static struct qcom_icc_node qhs_boot_rom = {
>  	.name = "qhs_boot_rom",
> -	.id = SA8775P_SLAVE_BOOT_ROM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_camera_cfg = {
>  	.name = "qhs_camera_cfg",
> -	.id = SA8775P_SLAVE_CAMERA_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
>  	.name = "qhs_camera_nrt_throttle_cfg",
> -	.id = SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
>  	.name = "qhs_camera_rt_throttle_cfg",
> -	.id = SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_clk_ctl = {
>  	.name = "qhs_clk_ctl",
> -	.id = SA8775P_SLAVE_CLK_CTL,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_compute0_cfg = {
>  	.name = "qhs_compute0_cfg",
> -	.id = SA8775P_SLAVE_CDSP_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CDSP_NOC_CFG },
> +	.link_nodes = { &qhm_nsp_noc_config },
>  };
>  
>  static struct qcom_icc_node qhs_compute1_cfg = {
>  	.name = "qhs_compute1_cfg",
> -	.id = SA8775P_SLAVE_CDSP1_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CDSPB_NOC_CFG },
> +	.link_nodes = { &qhm_nspb_noc_config },
>  };
>  
>  static struct qcom_icc_node qhs_cpr_cx = {
>  	.name = "qhs_cpr_cx",
> -	.id = SA8775P_SLAVE_RBCPR_CX_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_cpr_mmcx = {
>  	.name = "qhs_cpr_mmcx",
> -	.id = SA8775P_SLAVE_RBCPR_MMCX_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_cpr_mx = {
>  	.name = "qhs_cpr_mx",
> -	.id = SA8775P_SLAVE_RBCPR_MX_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_cpr_nspcx = {
>  	.name = "qhs_cpr_nspcx",
> -	.id = SA8775P_SLAVE_CPR_NSPCX,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_crypto0_cfg = {
>  	.name = "qhs_crypto0_cfg",
> -	.id = SA8775P_SLAVE_CRYPTO_0_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_cx_rdpm = {
>  	.name = "qhs_cx_rdpm",
> -	.id = SA8775P_SLAVE_CX_RDPM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_display0_cfg = {
>  	.name = "qhs_display0_cfg",
> -	.id = SA8775P_SLAVE_DISPLAY_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_display0_rt_throttle_cfg = {
>  	.name = "qhs_display0_rt_throttle_cfg",
> -	.id = SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_display1_cfg = {
>  	.name = "qhs_display1_cfg",
> -	.id = SA8775P_SLAVE_DISPLAY1_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_display1_rt_throttle_cfg = {
>  	.name = "qhs_display1_rt_throttle_cfg",
> -	.id = SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_emac0_cfg = {
>  	.name = "qhs_emac0_cfg",
> -	.id = SA8775P_SLAVE_EMAC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_emac1_cfg = {
>  	.name = "qhs_emac1_cfg",
> -	.id = SA8775P_SLAVE_EMAC1_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gp_dsp0_cfg = {
>  	.name = "qhs_gp_dsp0_cfg",
> -	.id = SA8775P_SLAVE_GP_DSP0_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gp_dsp1_cfg = {
>  	.name = "qhs_gp_dsp1_cfg",
> -	.id = SA8775P_SLAVE_GP_DSP1_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gpdsp0_throttle_cfg = {
>  	.name = "qhs_gpdsp0_throttle_cfg",
> -	.id = SA8775P_SLAVE_GPDSP0_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gpdsp1_throttle_cfg = {
>  	.name = "qhs_gpdsp1_throttle_cfg",
> -	.id = SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg = {
>  	.name = "qhs_gpu_tcu_throttle_cfg",
> -	.id = SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_gpuss_cfg = {
>  	.name = "qhs_gpuss_cfg",
> -	.id = SA8775P_SLAVE_GFX3D_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  };
>  
>  static struct qcom_icc_node qhs_hwkm = {
>  	.name = "qhs_hwkm",
> -	.id = SA8775P_SLAVE_HWKM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_imem_cfg = {
>  	.name = "qhs_imem_cfg",
> -	.id = SA8775P_SLAVE_IMEM_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ipa = {
>  	.name = "qhs_ipa",
> -	.id = SA8775P_SLAVE_IPA_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ipc_router = {
>  	.name = "qhs_ipc_router",
> -	.id = SA8775P_SLAVE_IPC_ROUTER_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_lpass_cfg = {
>  	.name = "qhs_lpass_cfg",
> -	.id = SA8775P_SLAVE_LPASS,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CNOC_LPASS_AG_NOC },
> +	.link_nodes = { &qhm_config_noc },
>  };
>  
>  static struct qcom_icc_node qhs_lpass_throttle_cfg = {
>  	.name = "qhs_lpass_throttle_cfg",
> -	.id = SA8775P_SLAVE_LPASS_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_mx_rdpm = {
>  	.name = "qhs_mx_rdpm",
> -	.id = SA8775P_SLAVE_MX_RDPM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_mxc_rdpm = {
>  	.name = "qhs_mxc_rdpm",
> -	.id = SA8775P_SLAVE_MXC_RDPM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pcie0_cfg = {
>  	.name = "qhs_pcie0_cfg",
> -	.id = SA8775P_SLAVE_PCIE_0_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pcie1_cfg = {
>  	.name = "qhs_pcie1_cfg",
> -	.id = SA8775P_SLAVE_PCIE_1_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pcie_rsc_cfg = {
>  	.name = "qhs_pcie_rsc_cfg",
> -	.id = SA8775P_SLAVE_PCIE_RSC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg = {
>  	.name = "qhs_pcie_tcu_throttle_cfg",
> -	.id = SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pcie_throttle_cfg = {
>  	.name = "qhs_pcie_throttle_cfg",
> -	.id = SA8775P_SLAVE_PCIE_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pdm = {
>  	.name = "qhs_pdm",
> -	.id = SA8775P_SLAVE_PDM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pimem_cfg = {
>  	.name = "qhs_pimem_cfg",
> -	.id = SA8775P_SLAVE_PIMEM_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_pke_wrapper_cfg = {
>  	.name = "qhs_pke_wrapper_cfg",
> -	.id = SA8775P_SLAVE_PKA_WRAPPER_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qdss_cfg = {
>  	.name = "qhs_qdss_cfg",
> -	.id = SA8775P_SLAVE_QDSS_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qm_cfg = {
>  	.name = "qhs_qm_cfg",
> -	.id = SA8775P_SLAVE_QM_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qm_mpu_cfg = {
>  	.name = "qhs_qm_mpu_cfg",
> -	.id = SA8775P_SLAVE_QM_MPU_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qup0 = {
>  	.name = "qhs_qup0",
> -	.id = SA8775P_SLAVE_QUP_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qup1 = {
>  	.name = "qhs_qup1",
> -	.id = SA8775P_SLAVE_QUP_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qup2 = {
>  	.name = "qhs_qup2",
> -	.id = SA8775P_SLAVE_QUP_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_qup3 = {
>  	.name = "qhs_qup3",
> -	.id = SA8775P_SLAVE_QUP_3,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_sail_throttle_cfg = {
>  	.name = "qhs_sail_throttle_cfg",
> -	.id = SA8775P_SLAVE_SAIL_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_sdc1 = {
>  	.name = "qhs_sdc1",
> -	.id = SA8775P_SLAVE_SDC1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_security = {
>  	.name = "qhs_security",
> -	.id = SA8775P_SLAVE_SECURITY,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_snoc_throttle_cfg = {
>  	.name = "qhs_snoc_throttle_cfg",
> -	.id = SA8775P_SLAVE_SNOC_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_tcsr = {
>  	.name = "qhs_tcsr",
> -	.id = SA8775P_SLAVE_TCSR,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_tlmm = {
>  	.name = "qhs_tlmm",
> -	.id = SA8775P_SLAVE_TLMM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_tsc_cfg = {
>  	.name = "qhs_tsc_cfg",
> -	.id = SA8775P_SLAVE_TSC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ufs_card_cfg = {
>  	.name = "qhs_ufs_card_cfg",
> -	.id = SA8775P_SLAVE_UFS_CARD_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_ufs_mem_cfg = {
>  	.name = "qhs_ufs_mem_cfg",
> -	.id = SA8775P_SLAVE_UFS_MEM_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_usb2_0 = {
>  	.name = "qhs_usb2_0",
> -	.id = SA8775P_SLAVE_USB2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_usb3_0 = {
>  	.name = "qhs_usb3_0",
> -	.id = SA8775P_SLAVE_USB3_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_usb3_1 = {
>  	.name = "qhs_usb3_1",
> -	.id = SA8775P_SLAVE_USB3_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_venus_cfg = {
>  	.name = "qhs_venus_cfg",
> -	.id = SA8775P_SLAVE_VENUS_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
>  	.name = "qhs_venus_cvp_throttle_cfg",
> -	.id = SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg = {
>  	.name = "qhs_venus_v_cpu_throttle_cfg",
> -	.id = SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg = {
>  	.name = "qhs_venus_vcodec_throttle_cfg",
> -	.id = SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_ddrss_cfg = {
>  	.name = "qns_ddrss_cfg",
> -	.id = SA8775P_SLAVE_DDRSS_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CNOC_DC_NOC },
> +	.link_nodes = { &qnm_cnoc_dc_noc },
>  };
>  
>  static struct qcom_icc_node qns_gpdsp_noc_cfg = {
>  	.name = "qns_gpdsp_noc_cfg",
> -	.id = SA8775P_SLAVE_GPDSP_NOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_mnoc_hf_cfg = {
>  	.name = "qns_mnoc_hf_cfg",
> -	.id = SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CNOC_MNOC_HF_CFG },
> +	.link_nodes = { &qnm_mnoc_hf_cfg },
>  };
>  
>  static struct qcom_icc_node qns_mnoc_sf_cfg = {
>  	.name = "qns_mnoc_sf_cfg",
> -	.id = SA8775P_SLAVE_CNOC_MNOC_SF_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_CNOC_MNOC_SF_CFG },
> +	.link_nodes = { &qnm_mnoc_sf_cfg },
>  };
>  
>  static struct qcom_icc_node qns_pcie_anoc_cfg = {
>  	.name = "qns_pcie_anoc_cfg",
> -	.id = SA8775P_SLAVE_PCIE_ANOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_snoc_cfg = {
>  	.name = "qns_snoc_cfg",
> -	.id = SA8775P_SLAVE_SNOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_SNOC_CFG },
> +	.link_nodes = { &qnm_snoc_cfg },
>  };
>  
>  static struct qcom_icc_node qxs_boot_imem = {
>  	.name = "qxs_boot_imem",
> -	.id = SA8775P_SLAVE_BOOT_IMEM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  };
>  
>  static struct qcom_icc_node qxs_imem = {
>  	.name = "qxs_imem",
> -	.id = SA8775P_SLAVE_IMEM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  };
>  
>  static struct qcom_icc_node qxs_pimem = {
>  	.name = "qxs_pimem",
> -	.id = SA8775P_SLAVE_PIMEM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  };
>  
>  static struct qcom_icc_node xs_pcie_0 = {
>  	.name = "xs_pcie_0",
> -	.id = SA8775P_SLAVE_PCIE_0,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  };
>  
>  static struct qcom_icc_node xs_pcie_1 = {
>  	.name = "xs_pcie_1",
> -	.id = SA8775P_SLAVE_PCIE_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  };
>  
>  static struct qcom_icc_node xs_qdss_stm = {
>  	.name = "xs_qdss_stm",
> -	.id = SA8775P_SLAVE_QDSS_STM,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node xs_sys_tcu_cfg = {
>  	.name = "xs_sys_tcu_cfg",
> -	.id = SA8775P_SLAVE_TCU,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  };
>  
>  static struct qcom_icc_node qhs_llcc = {
>  	.name = "qhs_llcc",
> -	.id = SA8775P_SLAVE_LLCC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_gemnoc = {
>  	.name = "qns_gemnoc",
> -	.id = SA8775P_SLAVE_GEM_NOC_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_GEM_NOC_CFG },
> +	.link_nodes = { &qnm_gemnoc_cfg },
>  };
>  
>  static struct qcom_icc_node qns_gem_noc_cnoc = {
>  	.name = "qns_gem_noc_cnoc",
> -	.id = SA8775P_SLAVE_GEM_NOC_CNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_GEM_NOC_CNOC },
> +	.link_nodes = { &qnm_gemnoc_cnoc },
>  };
>  
>  static struct qcom_icc_node qns_llcc = {
>  	.name = "qns_llcc",
> -	.id = SA8775P_SLAVE_LLCC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 6,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_LLCC },
> +	.link_nodes = { &llcc_mc },
>  };
>  
>  static struct qcom_icc_node qns_pcie = {
>  	.name = "qns_pcie",
> -	.id = SA8775P_SLAVE_GEM_NOC_PCIE_CNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_GEM_NOC_PCIE_SNOC },
> +	.link_nodes = { &qnm_gemnoc_pcie },
>  };
>  
>  static struct qcom_icc_node srvc_even_gemnoc = {
>  	.name = "srvc_even_gemnoc",
> -	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node srvc_odd_gemnoc = {
>  	.name = "srvc_odd_gemnoc",
> -	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node srvc_sys_gemnoc = {
>  	.name = "srvc_sys_gemnoc",
> -	.id = SA8775P_SLAVE_SERVICE_GEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node srvc_sys_gemnoc_2 = {
>  	.name = "srvc_sys_gemnoc_2",
> -	.id = SA8775P_SLAVE_SERVICE_GEM_NOC2,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_gp_dsp_sail_noc = {
>  	.name = "qns_gp_dsp_sail_noc",
> -	.id = SA8775P_SLAVE_GP_DSP_SAIL_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_GPDSP_SAIL },
> +	.link_nodes = { &qnm_gpdsp_sail },
>  };
>  
>  static struct qcom_icc_node qhs_lpass_core = {
>  	.name = "qhs_lpass_core",
> -	.id = SA8775P_SLAVE_LPASS_CORE_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_lpass_lpi = {
>  	.name = "qhs_lpass_lpi",
> -	.id = SA8775P_SLAVE_LPASS_LPI_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_lpass_mpu = {
>  	.name = "qhs_lpass_mpu",
> -	.id = SA8775P_SLAVE_LPASS_MPU_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qhs_lpass_top = {
>  	.name = "qhs_lpass_top",
> -	.id = SA8775P_SLAVE_LPASS_TOP_CFG,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_sysnoc = {
>  	.name = "qns_sysnoc",
> -	.id = SA8775P_SLAVE_LPASS_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_LPASS_ANOC },
> +	.link_nodes = { &qnm_lpass_noc },
>  };
>  
>  static struct qcom_icc_node srvc_niu_aml_noc = {
>  	.name = "srvc_niu_aml_noc",
> -	.id = SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node srvc_niu_lpass_agnoc = {
>  	.name = "srvc_niu_lpass_agnoc",
> -	.id = SA8775P_SLAVE_SERVICE_LPASS_AG_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node ebi = {
>  	.name = "ebi",
> -	.id = SA8775P_SLAVE_EBI1,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 8,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_mem_noc_hf = {
>  	.name = "qns_mem_noc_hf",
> -	.id = SA8775P_SLAVE_MNOC_HF_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_MNOC_HF_MEM_NOC },
> +	.link_nodes = { &qnm_mnoc_hf },
>  };
>  
>  static struct qcom_icc_node qns_mem_noc_sf = {
>  	.name = "qns_mem_noc_sf",
> -	.id = SA8775P_SLAVE_MNOC_SF_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_MNOC_SF_MEM_NOC },
> +	.link_nodes = { &qnm_mnoc_sf },
>  };
>  
>  static struct qcom_icc_node srvc_mnoc_hf = {
>  	.name = "srvc_mnoc_hf",
> -	.id = SA8775P_SLAVE_SERVICE_MNOC_HF,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node srvc_mnoc_sf = {
>  	.name = "srvc_mnoc_sf",
> -	.id = SA8775P_SLAVE_SERVICE_MNOC_SF,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_hcp = {
>  	.name = "qns_hcp",
> -	.id = SA8775P_SLAVE_HCP_A,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  };
>  
>  static struct qcom_icc_node qns_nsp_gemnoc = {
>  	.name = "qns_nsp_gemnoc",
> -	.id = SA8775P_SLAVE_CDSP_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_COMPUTE_NOC },
> +	.link_nodes = { &qnm_cmpnoc0 },
>  };
>  
>  static struct qcom_icc_node service_nsp_noc = {
>  	.name = "service_nsp_noc",
> -	.id = SA8775P_SLAVE_SERVICE_NSP_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_nspb_gemnoc = {
>  	.name = "qns_nspb_gemnoc",
> -	.id = SA8775P_SLAVE_CDSPB_MEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_COMPUTE_NOC_1 },
> +	.link_nodes = { &qnm_cmpnoc1 },
>  };
>  
>  static struct qcom_icc_node qns_nspb_hcp = {
>  	.name = "qns_nspb_hcp",
> -	.id = SA8775P_SLAVE_HCP_B,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 2,
>  	.buswidth = 32,
>  };
>  
>  static struct qcom_icc_node service_nspb_noc = {
>  	.name = "service_nspb_noc",
> -	.id = SA8775P_SLAVE_SERVICE_NSPB_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
>  
>  static struct qcom_icc_node qns_pcie_mem_noc = {
>  	.name = "qns_pcie_mem_noc",
> -	.id = SA8775P_SLAVE_ANOC_PCIE_GEM_NOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 32,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_ANOC_PCIE_GEM_NOC },
> +	.link_nodes = { &qnm_pcie },
>  };
>  
>  static struct qcom_icc_node qns_gemnoc_gc = {
>  	.name = "qns_gemnoc_gc",
> -	.id = SA8775P_SLAVE_SNOC_GEM_NOC_GC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 8,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_SNOC_GC_MEM_NOC },
> +	.link_nodes = { &qnm_snoc_gc },
>  };
>  
>  static struct qcom_icc_node qns_gemnoc_sf = {
>  	.name = "qns_gemnoc_sf",
> -	.id = SA8775P_SLAVE_SNOC_GEM_NOC_SF,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 16,
>  	.num_links = 1,
> -	.links = { SA8775P_MASTER_SNOC_SF_MEM_NOC },
> +	.link_nodes = { &qnm_snoc_sf },
>  };
>  
>  static struct qcom_icc_node srvc_snoc = {
>  	.name = "srvc_snoc",
> -	.id = SA8775P_SLAVE_SERVICE_SNOC,
> +	.id = ALLOC_DYN_ID,
>  	.channels = 1,
>  	.buswidth = 4,
>  };
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry


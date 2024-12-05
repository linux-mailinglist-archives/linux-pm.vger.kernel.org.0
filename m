Return-Path: <linux-pm+bounces-18605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BD9E4F4C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BEA18817C6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00BD1CEEB4;
	Thu,  5 Dec 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARwt+egT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF11CEE83;
	Thu,  5 Dec 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386112; cv=none; b=HYa8LmRjgItlRldUZilOcn2oOTx/aDekH3372ZsM082gISO0x1OLJ9JDKp26CSLFb4gWNsufvwSs4j3wArV6mEz+KCwpfk6xX285U3z5MZxHqDb3dHy7UxOJlYfai01EJh7JfndG66UGnf2ispP/eqhnRrGdvCSXuECmfwuEvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386112; c=relaxed/simple;
	bh=0XPBVm8XQVo+Eho5kSSzu8H/zE0gAJIp1ohiMKNlTfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXBqsYDsZ6xBmBjWUEwbUH+6GLuCMExNdbeo3nBlA1975GpCRnsAarIC1tPK1klnNnQSM9pF7F0iiu9kSG6IoYqok5Nw5RORcCsb2Jb8ZF8Jnad189bID7ZkD9uEhhnxkFWpzBg/RY7PrSzyGfGzmWUamtvUHVtwJbQ5zpE+rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARwt+egT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D49C4CED1;
	Thu,  5 Dec 2024 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733386112;
	bh=0XPBVm8XQVo+Eho5kSSzu8H/zE0gAJIp1ohiMKNlTfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARwt+egTYTrqk2OROjy8tBxHi0tjDbB8PAHQ9QjyvWQf2c8OjyMN0NZ/VQBLolZ+S
	 7RixT9vFAHoR7FWYmoWh6ljiSJhWXZSe4X6vHD4bi29GAD5dlWzHd+HtrCNqLjzFtu
	 Ky71/PVUtacUKgySoOHIzdO02pzWFo1dZW5XQkWW/B20CBzw5aS7qsTAPd9gn2B7Mb
	 jXBEMCPdoEZwm828WR/eGPBWDv1TmlVQkv+QmDVTZ1BifP63qsUZL3hu8osDmatxZq
	 qZ/YiZezES+miOrYWH4K5KazQRMQwK9ZFtl4NMdnHvHv9YIuBNb2FZTDxVSb+bPBwE
	 LdK5nufqWjBSg==
Date: Thu, 5 Dec 2024 09:08:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] power: sequencing: qcom-wcn: add support for the
 WCN6750 PMU
Message-ID: <4tzvbkm2ohicisgllkwsbd56uiorrcgv4zhipspnjjcuoc7dr4@ifqgn374ppjj>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-5-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-5-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:06PM +0530, Janaki Ramaiah Thota wrote:
> Enable support for controlling the power-up sequence of the PMU inside
> the WCN6750 model.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index 682a9beac69e..e38da79f0ada 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -293,6 +293,24 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6855_of_data = {
>  	.targets = pwrseq_qcom_wcn6855_targets,
>  };
>  
> +static const char *const pwrseq_wcn6750_vregs[] = {
> +	"vddaon",
> +	"vddasd",
> +	"vddpmu",
> +	"vddrfa0p8",
> +	"vddrfa1p2",
> +	"vddrfa1p7",
> +	"vddrfa2p2",
> +};
> +
> +static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6750_of_data = {
> +	.vregs = pwrseq_wcn6750_vregs,
> +	.num_vregs = ARRAY_SIZE(pwrseq_wcn6750_vregs),
> +	.pwup_delay_ms = 50,
> +	.gpio_enable_delay_ms = 5,
> +	.targets = pwrseq_qcom_wcn_targets,
> +};
> +
>  static const char *const pwrseq_wcn7850_vregs[] = {
>  	"vdd",
>  	"vddio",
> @@ -431,6 +449,10 @@ static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
>  		.compatible = "qcom,wcn7850-pmu",
>  		.data = &pwrseq_wcn7850_of_data,
>  	},
> +	{
> +		.compatible = "qcom,wcn6750-pmu",

Don't stuff things at the end of lists. Keep proper order instead.

Best regards,
Krzysztof



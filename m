Return-Path: <linux-pm+bounces-17977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F09D6793
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 06:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2737161391
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 05:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2215B554;
	Sat, 23 Nov 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGvj+ce3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742213632B
	for <linux-pm@vger.kernel.org>; Sat, 23 Nov 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732338147; cv=none; b=MOBGVzElHA61VWMjTAzJT1AB98C0gn7hrKYKskUci/OToqi0lE8DpFaZIcVdhrqcm7f5Fu2CTIQhWQerqGd0dB/A0/erESb7C0AvmW+IPt6hN2mRdXxcRY4euaf5nOVUBXEfTpKJ22Lgh7kJf3Z6aqZpfhIepRsKH4hoGuXF5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732338147; c=relaxed/simple;
	bh=zjOPzxhTRbw2j6+fIjCCFGQDW5uDtavAIV+YKEFNIEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZTznZ40GRU+wOGuIpIkZfrmpq/H9t30nFO0nrNWVAtuUSesRIvEUfBF3SG6L/EqRosuhmuO0X2ee+brc+Q5fKmYCnAUyAW8Jv/LlEQiLosQm/fRi3GNKzHIvbd2ZAlkPBx1LfD6A+fWm2agY+wbPfufB1AdLxFNGNsJcVw56Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGvj+ce3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so2884381b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 21:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732338145; x=1732942945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rhmp9T6hqY6qCxGgLf1l2rSHY8/g/1isCQt/alj6RtU=;
        b=UGvj+ce3u2G/ZUeF3lDlRjyzIcu1ha0OFG20YonXsfVLDlY81+JSf1u9IiMfHGwM24
         ZuWBbQ0TKHR+E3QyfLUvhv6LksCHEsIw23yDT36QgnsPPyMublPfhe711xU3xLxRjfvg
         ZZW588d6wEZFYsQqSbNZbQqj2pajZcPAnSX9mTgjkQ65XovX+FNwwsISLNPZNji7KZXl
         RVWJtmY5g8WRGa7USmbSaPZEXd9eKkMCTkbHnU2IhMmqMfigswwPeN2oj8ZhJkMKqA8T
         N/9BwiffIzdOPsz79O/4Xwpr5utyDPs8fpLCO2XGitvSdbe8eAGqjo/AeNpIYGn+i8O0
         maLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732338145; x=1732942945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhmp9T6hqY6qCxGgLf1l2rSHY8/g/1isCQt/alj6RtU=;
        b=LNbJHMqHxb3+Cfmx6ImFled2KSgqTDVLyzctkdHLw8rIb6AbOHXRugHuTEFaSRve1Y
         RQZDoHz29wsVzvn4V8nskbsLfhl3tsOnndjft047xkkY/IFcbc/9oHA0vGkBfcKeXdru
         Y61yG7cnRrojqUNBoHXZz0xCbymk72/T7GbaT21K/RgjQmLMwGiPkncvFygu2d9SZFX+
         W4vGRhO+nh+szGAbn51raPlMqx7gML4gdDXRgJfyj0ALLYRgzW6t07vM8AGR8zWbVf0K
         mKJgtqsj1+x4JvJsxUigLF9uALowZPl5yQubsggqJzsGV8GrY16Kx1pHXua+QiD5d5em
         g2IA==
X-Forwarded-Encrypted: i=1; AJvYcCXHnpqG+pbk9ZQGQYMLh0y+TR7GxufCGXpK7kZyiLTPdso6pZAjaF+H06JIxqqfNp1E38RyXRgZMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk31OJNiaIFTc1lGqhmfoThnVbsKdL4WGI4R3N5U56KzvA+udX
	QrJasUtJmtmzj3nxAjJNkbDqIT4uAmIauThejs0UmpJm4fGVo/Y3JCdE87v6xA==
X-Gm-Gg: ASbGnctZ0SjLkV6z3q/fJJczveSMxg6ezRgmY8NfVDo+kk9Scgv2Y3FP0M8sIza7EYo
	TVgBLSOktQYb5mHUVGf38K6V55TgVLvUf6xPSWYNuU9Awz/+NeYodPgDtRzxPu+7ivMLrlx1Qlx
	lZvYeK8Lj1pvAGcy5uj50lwaT3gVh4EUpD8YXgIf74yAJIq+WnJxQnoaKHGw4BTp/wS60+JpCV0
	FtaOZ5e+zBTXNyx0vMRBsLIl5rsa3EYbfokAE72Wxmd4sXzLHa73wbZp0PTQZdUFQ==
X-Google-Smtp-Source: AGHT+IGIoWjGItw7UGvc6ZH+fcq+M/D5fvZSF+vOrGMx1rf1QqGn6GShTrNo2FSHGH5NSI8p5dBK1g==
X-Received: by 2002:a17:90b:3d92:b0:2ea:5fed:4a32 with SMTP id 98e67ed59e1d1-2eb0cb9b800mr9292369a91.11.1732338145195;
        Fri, 22 Nov 2024 21:02:25 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eaca647808sm3437052a91.1.2024.11.22.21.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 21:02:24 -0800 (PST)
Date: Sat, 23 Nov 2024 10:32:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 5/7] scsi: ufs: core: Export ufshcd_dme_reset() and
 ufshcd_dme_enable()
Message-ID: <20241123050213.kq5u7qaoeenzddfg@thinkpad>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
 <1731048987-229149-6-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1731048987-229149-6-git-send-email-shawn.lin@rock-chips.com>

On Fri, Nov 08, 2024 at 02:56:24PM +0800, Shawn Lin wrote:
> These two APIs will be used by host driver if they need a different

s/host/glue drivers

> HCE process.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/ufs/core/ufshcd.c | 6 ++++--
>  include/ufs/ufshcd.h      | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 24a32e2..9d1d56d 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4039,7 +4039,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
>   *
>   * Return: 0 on success, non-zero value on failure.
>   */
> -static int ufshcd_dme_reset(struct ufs_hba *hba)
> +int ufshcd_dme_reset(struct ufs_hba *hba)
>  {
>  	struct uic_command uic_cmd = {
>  		.command = UIC_CMD_DME_RESET,
> @@ -4053,6 +4053,7 @@ static int ufshcd_dme_reset(struct ufs_hba *hba)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_dme_reset);
>  
>  int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
>  			       int agreed_gear,
> @@ -4078,7 +4079,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
>   *
>   * Return: 0 on success, non-zero value on failure.
>   */
> -static int ufshcd_dme_enable(struct ufs_hba *hba)
> +int ufshcd_dme_enable(struct ufs_hba *hba)
>  {
>  	struct uic_command uic_cmd = {
>  		.command = UIC_CMD_DME_ENABLE,
> @@ -4092,6 +4093,7 @@ static int ufshcd_dme_enable(struct ufs_hba *hba)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_dme_enable);
>  
>  static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
>  {
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 3f68ae3e4..b9733dc 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1360,6 +1360,8 @@ extern int ufshcd_system_thaw(struct device *dev);
>  extern int ufshcd_system_restore(struct device *dev);
>  #endif
>  
> +extern int ufshcd_dme_reset(struct ufs_hba *hba);
> +extern int ufshcd_dme_enable(struct ufs_hba *hba);
>  extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
>  				      int agreed_gear,
>  				      int adapt_val);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்


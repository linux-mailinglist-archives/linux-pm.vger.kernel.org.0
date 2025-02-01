Return-Path: <linux-pm+bounces-21215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01772A249F0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675B23A8294
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019111C54A2;
	Sat,  1 Feb 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdlqMDsn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12A1C4617
	for <linux-pm@vger.kernel.org>; Sat,  1 Feb 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424159; cv=none; b=R+V/OXYSz5cr0l3ujPG76XMijWlzgrdiO9mRFF8SlsFcxLiV2JhlmiyDziIgf+6JBY0Kv4iDMg73ZOVud0FBgtri/Nn9ESfMz6PBUEx+qkUQAFhBcMhtVq5WeV5jcnAEEYDTm8re/VVolFnyLg6SWYepxWZHBLIW/61GMoyXq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424159; c=relaxed/simple;
	bh=zdc+MNv+j9zAnb2Y2FpDgGxuLasNGKL5Lamfb9DXLyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePpefSjkktE+tk8z0a0LzKPTE8zZE6CY2I0/N7F6hjxCwOBQJJCdiE2ZwYiG0xSdf8s3XwpKbDId7dA/614LCFMxCnqj1mkWD58RKYIZWziZk+Ui+p7d/zL2A3Q8rmkCcoxumm4gnuru+s27AWeyn1K7UffJO3QBq6Ixl2SQY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WdlqMDsn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso50145285ad.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Feb 2025 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738424157; x=1739028957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NgK4G7cVRPxNbsx8fhvydaH8JOFZ6CJwy0WoHgTVDx8=;
        b=WdlqMDsn3+6qfS3MR6gez899T57GARhTDPJ7WarJEMDMuP+7fNHSHrMSbK0PsZf92f
         5S/rA2zVIdXTEgP73Z2AlVtN6Qj9fyAyDbKmeWsKxLiVlINqYm2zg/y6v8qjLyB5ohoa
         qtQx0y/WtpzDUzPF+W5XpoV5VQLlmBojVFPQBcYh2g5F8S3tac/i4g4qoGqelvAmmIKU
         GkDcJPZirXqGEir6N4S+m0ieMs/UKh7JGBCXhUotabX/ePF2DADaZQcaala2FPgkQGG5
         TzbKwerZfEmDDoYmn50T+t/M3hVK/mTzgEKwg50QhDs5PKMLf3a1EzMNER5RJW2GY1hz
         VVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424157; x=1739028957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgK4G7cVRPxNbsx8fhvydaH8JOFZ6CJwy0WoHgTVDx8=;
        b=g4aC639e66L6aHCn/lWtEbdXzAE4Ws6IVjR50bTFLBZMNy9s23C0NGljvfHVfeyq1g
         RUUMDW988i2Wgu72zIdAPl8+aaTFeGZ9stB3hzEEFlqJIf9GNVPOQG6cQ7EKoe14grT2
         tw7RFaGaojvlnPfspFzj08+uwiQeIYnoRRTzANoXTUrhkxLWNCVLbne/KT/F+4Y4sK8x
         iS2ziQQHIXSuVpYZnlKtdnRGbl8A94pDuSWXPewi6DW8GaVjfj/4740JIw7cafxwDE6O
         Y00yU7ITIt+qRG2EUhmvRwzFckpVHprD2wVSi4X+MeHgb4933tsRFycjE6bx1PO+uWld
         Ch1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFm+fXu9zqKulUFDTfGX1UtkJDPLj01pYmtv1Jo16qFOj+vE8sSYaB5dkufxdhhH7zxMFvBZzApg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWj05+Tk0H6i1l7qP9Rsxz/DuGASAN3TE3ueDEgjXf0QpjcNoL
	GZFHRaOS336/vUIkI6mcgLNd5FMnQrfZFdG40sfRtaLJlt3yM7kK+GzOD/6r3w==
X-Gm-Gg: ASbGncv/xuxWQmvx/5k7v8cWnYzH7YcHZw+cC/2mfRugkOX+5nZtuPGXtKsGkaiiiu0
	1DBC04JLRV4yjTpGTBw1IF/ftvPCxtDx3pJdcHw+TEBKjX7csB0RC86mdGCIrGdsHJDXkkaRyWX
	v/3JZpOa3qq+e4j2fqY8THYNjAbDrSQeMXwirvzYnXJSo1rWF3SILXOP4oRAFIHKhn88XGFRLHF
	hEDDlEJu09qor9k9zMpA7FpiwUk0QsuXSMw4/rxhC/QHOnxMO0M6CGOdy0MEnnPRWWx5rCxMDrZ
	fLrADZHqXbMalQ5yLPlp6f4C4Ls=
X-Google-Smtp-Source: AGHT+IGzlTHcr2GwqKspBtJB7T7HsAuTwQj90njS9oPWBHSKjkl6folIH9PdSTDNGx/ngMu4/vXRyg==
X-Received: by 2002:a05:6300:710f:b0:1ed:a565:f80e with SMTP id adf61e73a8af0-1eda566b50cmr5077054637.14.1738424157428;
        Sat, 01 Feb 2025 07:35:57 -0800 (PST)
Received: from thinkpad ([120.56.202.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec047944csm4891617a12.54.2025.02.01.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 07:35:56 -0800 (PST)
Date: Sat, 1 Feb 2025 21:05:49 +0530
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
Subject: Re: [PATCH v6 7/7] arm64: dts: rockchip: Add UFS support for RK3576
 SoC
Message-ID: <20250201153549.dusrfjrxxrizmcfa@thinkpad>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
 <1737428427-32393-8-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1737428427-32393-8-git-send-email-shawn.lin@rock-chips.com>

On Tue, Jan 21, 2025 at 11:00:27AM +0800, Shawn Lin wrote:
> Add ufshc node to rk3576.dtsi, so the board using UFS could
> enable it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Small nit below.

> 
> ---
> 
> Changes in v6:
> - remove comments suggested by Mani
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index 4dde954..bb786bd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1221,6 +1221,30 @@
>  			};
>  		};
>  
> +		ufshc: ufshc@2a2d0000 {
> +			compatible = "rockchip,rk3576-ufshc";
> +			reg = <0x0 0x2a2d0000 0 0x10000>,
> +			      <0x0 0x2b040000 0 0x10000>,
> +			      <0x0 0x2601f000 0 0x1000>,
> +			      <0x0 0x2603c000 0 0x1000>,
> +			      <0x0 0x2a2e0000 0 0x10000>;

Use 0x0 for consistency.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


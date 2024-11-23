Return-Path: <linux-pm+bounces-17978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D59D6797
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 06:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B7CB2134E
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0D15B554;
	Sat, 23 Nov 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xImdXQSk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44E4879B
	for <linux-pm@vger.kernel.org>; Sat, 23 Nov 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732338262; cv=none; b=aup/2vq4ug44zuuz0Ut3G5gVop3a98IJxW88J/dk/shX0QVUN0HVn0KoSfXsdnfCzWrEUbz342t/kLRl/l9F+P7DFBWBwzjwWUI8qFcvpaPPtgTDXyjQri98qekbmCpSeMF675QM5lzQttsPY79CG6OXf97IbuY0qV6lr/PfcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732338262; c=relaxed/simple;
	bh=h7sOQdKgslvytgzjqusSMgmQRkfNmvo2gwZJv5axaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPHBCzwaKC8inYDZkgnqsJ1kymh4W5oSlXcMtiENnxTCZ8neJRzENc4cHYhfS6dk5/n0sPjhGXBVvZXfbbSN77ra9BWIwHW2iWUB2l24BK1t7rrWUauep8mOt+dyNd3jyqfvTAa3m0YzJm7yLFGVVycF/Xv18MG2mp06wgX2SdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xImdXQSk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so1950938a12.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732338260; x=1732943060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jrrbLdcdGlY2ZcZW0mEDuIlBogzMm+C1CwwsMUranJU=;
        b=xImdXQSkzVoZT/f4ikoq8h/MHEXQ+juahpRuXmPcIOID0hxsX7ob1C4zNRgJCKejRQ
         IeWjb/8xHno/zhJvNayI7BVQNRF461S3mbhAoyHIQitzWIQQguIUtg4nndXHgEkyoNL5
         OSL+KAcor9vGDlXhl2EgHd1kDRutNf7RXPK8CRWATpnYIiII1CRASYdeCZHDKOlEnAv5
         4L5t8WZM3Ah7VFXerCVYMxidsP13M42FGiAJkh+1bvX/wzb5KT7YXRcUeW0Uy40j0RSc
         r23JD0cl8wyjrDE3gLrvJHyXTuE+ktk+d0HJDzw4Lp/6obriLU/TqSHkstwGpV6C4+sh
         jynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732338260; x=1732943060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrrbLdcdGlY2ZcZW0mEDuIlBogzMm+C1CwwsMUranJU=;
        b=WZ/aOKh0BgZ8nDglzZ1mmV5k4cVNS/ci/SkYQyTy1/HNAYunUzr11o42AF5+qWJjLv
         ToF4mdP1SRa+oj6FKnqH9lQLx7TuwPUDpUUIG5BkQKOU6KLMeuGENJOR7jdPLFwaMRzE
         EPVaKGqB1/f2kBAAKDEmKXlUgP2VvdQtCZ4MZd/ALFi7bJcYPqV0lt71o5yl/mmMja/r
         2NsKoX8t92SGXDhhaaM8DhOIegpKL0R0c1jHmnL3pjLpjxSMHcTSY47hcQ/EWDGIUqck
         k77zAfo/HMQqRgypJ540SraX1d3Ea3QOU5jgb/JeyrOFC0FjsVySUyFGQcPFOq0hddrX
         9Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCWbnfK35sUSpN3yp2h4C72LxR7JuyBbXnYSA7vb6/e0VoaMXoqTbCzXWBHWJZT+Ff7BnljDdqE94Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DzYFDXdn30dqryh17TPpnTUaVoGr69jht2Wj+bBlZFPdP4SH
	arTLBklxQ95WOJ/sxG66gUU1uAQnmzOrf6kmAwYJw8qZegWPqB5fFrExh7YYNQ==
X-Gm-Gg: ASbGncs9teh92tMz8Lnm5t0NfV8k02hEy82Mx3YeRjhHMkN+bg2oseexE71dS1bbbHa
	cySIZ18mxA39Qa12/9HmgFfFTZ38i+O0hIK+kuklIaCir5/UWPbh+rF1j2BYrW8cLfw7O8CzKqL
	974iQnw/SLA0SM5l1rcLsk8koxOaYzdJFfgqM6LpGyKLAyolcpC3+3OORO5oUp88I5sGwzQCvOV
	pIv9cYIAEbhdnbDFbl5u9bSEu8KIyrHAKqg2GfE/6Hm2uIgbajPLYi6GjtUtEItfw==
X-Google-Smtp-Source: AGHT+IHtEp73R31OmhWsYzXCA+I1V+Hri+7jEcS+EPxf7JnICgfkL145nhRT5ANnQ3iNY2Z3dlcmrA==
X-Received: by 2002:a05:6a20:7483:b0:1dc:c1c9:fc0a with SMTP id adf61e73a8af0-1e09e472aedmr7640085637.27.1732338260044;
        Fri, 22 Nov 2024 21:04:20 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532d0csm2519571b3a.116.2024.11.22.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 21:04:19 -0800 (PST)
Date: Sat, 23 Nov 2024 10:34:09 +0530
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
Subject: Re: [PATCH v5 7/7] arm64: dts: rockchip: Add UFS support for RK3576
 SoC
Message-ID: <20241123050409.7ynmaw6cqtfefqdy@thinkpad>
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
 <1731048987-229149-8-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1731048987-229149-8-git-send-email-shawn.lin@rock-chips.com>

On Fri, Nov 08, 2024 at 02:56:26PM +0800, Shawn Lin wrote:
> Add ufshc node to rk3576.dtsi, so the board using UFS could
> enable it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index 436232f..32beda2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1110,6 +1110,31 @@
>  			};
>  		};
>  
> +		ufshc: ufshc@2a2d0000 {
> +			compatible = "rockchip,rk3576-ufshc";
> +			reg = <0x0 0x2a2d0000 0 0x10000>, /* 0: HCI standard */
> +			      <0x0 0x2b040000 0 0x10000>, /* 1: Mphy */
> +			      <0x0 0x2601f000 0 0x1000>,  /* 2: HCI Vendor specified */
> +			      <0x0 0x2603c000 0 0x1000>,  /* 3: Mphy Vendor specified */
> +			      <0x0 0x2a2e0000 0 0x10000>; /* 4: HCI apb */

No need to add comments for each region. Bindings describe them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


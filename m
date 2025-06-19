Return-Path: <linux-pm+bounces-29044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AFADFD2E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41663A257F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6F242D81;
	Thu, 19 Jun 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp3C77lr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B5242D8A
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312015; cv=none; b=gGCcYRU1Dfl/imbwz0w2osX/vME2nrCYTm3h6DziKaIHfvHWoUjiSketX555ZePwZfMoqEaeMqaiRNBmE5Xo2zZIJzZtPIeRWq8vCSQzWnCPRNydTBRp2TH+BicMKks/WcweXUZOzHM5iZqM/ldSbQalnWrs7snxnSDZCrSrhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312015; c=relaxed/simple;
	bh=Bn70nPJu3HUp/M+KYcLviCtpjLHOrJf1pcJLvrjQ/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5JKJHBabdYAKTpLJkzETXuZDs4leZxhABQA96jRPTaIkqbj4QmpwzTDITsp4+1DKdfzft7eCFmVqZgsSawYcRyNnghogSSERm1KBfbeORl0jLjLBr5LGZoPpD1csnJqFb+z49SdPV0sOxJTNf5XteTKP1Vw9QXdxZmZnJAoAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dp3C77lr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso305613b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312013; x=1750916813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=Dp3C77lrzqGDO6ludV5D8bL0F7AwlrR8crpDyn/Om1g4MUBSXb13znlJ0KhQRNxPO1
         iHZvLYLhLoCFNdfPbHP7V913x1P470fwT5vyPQU48GeTAUoGkB+iTGucUdcJKqT5xawq
         NW316AlnSbmqgDW763um18OX0EuUelEzae+qHfrY6RFeyfjbZkZ5BoAD4YSemNfuudb+
         owq38O0EgaYHC1bsWj3w+hIwWAR/2vWdmg9LokuwCPgIn9X+SN1fpzBOvFdYlaT7ovIe
         GDRYIAInDBCxR2jqbrBS84ZGk4DhPb6j81zoQFeL59YtCj135C4gO5D9UbBbpTvGdvvO
         /hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312013; x=1750916813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=NUhUirRK9OIDdyJ/vLDRTZSNzkYTISswguzpAVbRILOpMBBVVt4QlTEa3eby6+vlPO
         3SOFRYWrKy/5RwHCNjJmh2l+mWJDfMkTBS8i3cwAptBiMeXuhwKKp+Dpawyu5tRL9rga
         oyFiXsdi5MmMG6TSs16oxkLx8mrtV2fAMZQ14s9IdkZOIiL0BO7c5Ik/pAXSOopnK2mH
         BibNhEzdXoVLu6/idHo5uQJ8oK6IeMn7sxmNw4DF0tFuBzmGOAuNy2U9SkSS4J1lCYb2
         M5z0xb32epWbphtC3yS6U2LWDlk4ytIbtQeFYMWTOEyDj0lcbnptZ8z0sXCTtAhUrp6o
         QRuw==
X-Forwarded-Encrypted: i=1; AJvYcCVA8tFyQhP5gbyNt2cSTXFGSD2C517JFRdDHHHZsy4czTVi0AyRKgvcCCRIBHV/gNUIYUWTQj4OqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyN4dJ3Q6Cpj3JX/oTaM+SIhvo/J42fro2m9AJV5Aem+B3XOT
	nbapvN+C4YIy5v5fWSs723ffL5dhL1IX0Bv02LPy4z80BB2reZPNy7qXHJLdUc6X540=
X-Gm-Gg: ASbGnctYqvs4xxVrvckk8oUDV/OY7Q/QWhpNRNiBE7GFz4DNLANAR+6GlF6aVZ545UQ
	Qsbi/vFc2yARKSX589WeqiNyrVakRBvthZWvIALoEQssAfMEapgUvBxx7cJ2q4eAVN7zFfoCE6M
	VnU0Y1TEserQ4JOTUQE9hhf9y1FENMJN+UDCSfD5mrt/oe+3GQxJzMUi0jIBLe0Jd3iaCZXFT8D
	Ucgbh/9PjDPMWrivfXds8/e2AcZIMvycKGUmArnyL8SIdZU6qIWzciW2WYL1wnfxLBcz32hVsOw
	FCRk3bKuh0Tj+KKL4oDln46wnztxkhw9vul3lYfKc2VWZJ9/RnAM7SjrJReXZPo=
X-Google-Smtp-Source: AGHT+IGx25UdEAzlmqfQKTPAu3rI0FpfbMxJfPd/PkIc3VTClQaEGNZW5YGAM1Nh7zWb+auXSU7+sw==
X-Received: by 2002:a05:6a00:10d2:b0:748:fd94:e62a with SMTP id d2e1a72fcca58-748fd94edb7mr1182029b3a.1.1750312013191;
        Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e86b5527sm2820713b3a.86.2025.06.18.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:46:52 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:16:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com,
	cenxinghai@h-partners.com, yubowen8@huawei.com
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Message-ID: <20250619054650.pl5ase2l5juu5pm2@vireshk-i7>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>

On 26-05-25, 19:30, Lifeng Zheng wrote:
> This patch series makes some minor optimizations for cppc_cpufreq.c to
> makes codes cleaner.
> 
> Lifeng Zheng (3):
>   cpufreq: CPPC: Remove cpu_data_list
>   cpufreq: CPPC: Return void in populate_efficiency_class()
>   cpufreq: CPPC: Remove forward declaration of
>     cppc_cpufreq_register_em()
> 
>  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>  include/acpi/cppc_acpi.h       |  1 -
>  2 files changed, 15 insertions(+), 45 deletions(-)

Applied. Thanks.

-- 
viresh


Return-Path: <linux-pm+bounces-32159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F3B20516
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E4817A817
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5D22FF2D;
	Mon, 11 Aug 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlbN+4Qz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C1226CF4
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907455; cv=none; b=ZdCAXntTueZ1e/Wh2npfVhy3dP5Ykc+b67qGPgh6EjjKKmol0+ItRYwbYGq6nf9V4xaMKhI12CrTnNEypaKnaAoqogQkPDraaF8IGfYRBhAL5LfKO219ahVbxNTP+kvPVILOu/eEW3Oec/COj7AAG9oYaW2NsFuF9hoNc7wBUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907455; c=relaxed/simple;
	bh=mvBDLINp1VPpRWMc3lvEklpu69BFO5OES2Bje9lreR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxtDj4z42GkpBKxYJjDH1wGohmR4XDho8M5H5flhxs08rjsRF74DBpXMaxwUytvKdN+8jAkxkg5lLV/qEXu3fwdJIZ7+6r63hY8/0w6FvQf2pyrYXH+aAn6DcGe1Mikx+8x0HhrmFzJV9+y3nDHQaM7/SAloxGuaJQFns47S9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlbN+4Qz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso3400600b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754907453; x=1755512253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wbGGcDhVg6bsq7Cl6LWsjPX/u/puNeXFalUsVt74Fg=;
        b=ZlbN+4Qz+zum4lZ4ULo7KkMWQOptvit+yL7i8RuYnHtRbFJuop2O+Be3q/DmEYaYzI
         y/drVnnR1yklX+s4Sz0PBffZct2vMY07wRoyZRe/xHHrUwcD3cvu+cXDcvQ6SCM2k3X8
         xZHHJvYGCO3SMyuZknvOqtOOF2fnX8fMwZvaASbjQ6TvNnDQu993UR9B5YPSG9n36ybB
         /+6+yY3SIkNGN+aFjPQbnwSbro+RS4xeeJ6nnInhr+cMVt+X9VUBlaODqa5TA9io1a1v
         su+dS1trVtHedBRtU0I856y3mFqyqq88HN4hIKGY9TvMjDB5Q8jAIrQHcJDT+UeLjahe
         rxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907453; x=1755512253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wbGGcDhVg6bsq7Cl6LWsjPX/u/puNeXFalUsVt74Fg=;
        b=TtxCsKYAQd3BfubBHZvF0HXTTNiR2uj2ME3K6CPqrjqk/8ntjCW3o92T74wVB4N0ah
         31GV9UMoAs8EPAGqJBq0uXPFsNRqFh4it85ayAnecriLV7mYytirc99rhlXydx1igxr0
         7rkq99Nxxm52p0oIEghtsRT6Iz/facUAr1KVuprsk1hjuOvSuN/eA5TdG6/1fcRcBGKS
         eTF8u36kGee7BZGYjlcxdrZ4hpg1RF2hGsQ/WveKRoMcvkm5Wan2huUVSKd6wWZyyzZ9
         ncaGD3Xqzr22cyUXBydYVArSsm/ppnsytdPILDJcZTvbM9AVTEjVZ61c9xrn2MuGR/WL
         17pA==
X-Forwarded-Encrypted: i=1; AJvYcCW5HtQAxcmT4THhdESGt3eD1+SUlyKmMs9QFLjXLuycXnk4hzUvA3TfC5+Whk3tOj/v6TQZgogxKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysr3EaktVV51BHOiuwttwu4Tjy0w8UwHw+iWWX/DzPMhDkaBHI
	65N8GDW/fV6MoUlVRsacnmhOuvN3TdpsrbZWTTejfULy7za7FFGHRjMCsiQGhaBCamU=
X-Gm-Gg: ASbGncter2jNuwuoAXBVSu6Bedl1R1AE+1b06hCZVUgVgeDQ7wC3eUX2ewajuQIguG9
	3xa3fUw0/+6mDjZxFATDYhdxm5g8Vrbvz2qTypdAPD0HTJaiYwWe5uQrqpNyMFQDsPC7vfYn5f6
	XZlJfbzY/t05vIEphlzdCiQsFnjUzA9pmOV0r/Sl9myp5Q40jm4I2tou3d7Gj7YKxexey6rpU+y
	sDFbDFuEINJu47v1ZU3ib3vGOoFQ5anRYPO9wVsfhNCXkpgb3YUloGvZdn/KakdoY7Z63R/aeJi
	JfA3S0JpU2LTQ9+b9aDnoAZ7R6O5FXY6N0x1clyjULEN37wsyQb4l6UGrNlo3OFqTQ39KhBqWZL
	lnJz4FoL220u/SEBjA9oSKnn8
X-Google-Smtp-Source: AGHT+IGiVNO/lD1AD0GKdCt2tByRFS8ki2OJyvqDGW58Bfs5Cn3qr9r9XSLQed8HgVBMo4CcSPmkjw==
X-Received: by 2002:a17:903:1b26:b0:240:99f7:6c10 with SMTP id d9443c01a7336-242c1ffb220mr210481245ad.1.1754907452644;
        Mon, 11 Aug 2025 03:17:32 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaf855sm269912785ad.168.2025.08.11.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:17:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:47:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250811101729.vwrtqg33lusk7h6p@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
 <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
 <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>
 <20250811084453.ocibslv6kxkib6po@vireshk-i7>
 <8e67bfa0-e62c-4060-9ac4-de212ae63570@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e67bfa0-e62c-4060-9ac4-de212ae63570@oss.qualcomm.com>

On 11-08-25, 15:35, Krishna Chaitanya Chundru wrote:
> Thanks Viresh for the suggestion. We will try this.
> Can you confirm this is what you are expecting.
> 
> dt change
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2214,13 +2214,23 @@ opp-2500000 {
>                                         opp-hz = /bits/ 64 <2500000>;
>                                         required-opps =
> <&rpmhpd_opp_low_svs>;
>                                         opp-peak-kBps = <250000 1>;
> +                                       opp-level = <1>;
>                                 };
> 
> -                               /* GEN 1 x2 and GEN 2 x1 */
> +                               /* GEN 1 x2 */
>                                 opp-5000000 {
>                                         opp-hz = /bits/ 64 <5000000>;
>                                         required-opps =
> <&rpmhpd_opp_low_svs>;
>                                         opp-peak-kBps = <500000 1>;
> +                                       opp-level = <1>;
> +                               };
> +
> +                               /* GEN 2 x1 */
> +                               opp-5000000 {

The node-name has to be different, but freq can be same. Something
like opp-5000000-N, where N = 1, 2, 3.

> +                                       opp-hz = /bits/ 64 <5000000>;
> +                                       required-opps =
> <&rpmhpd_opp_low_svs>;
> +                                       opp-peak-kBps = <500000 1>;
> +                                       opp-level = <2>;
>                                 };

> And in the driver I need to have a change in OPP framework which
> returns OPP based on both frequency and level something like
> dev_pm_opp_find_level_freq_exact(struct device *dev,
> unsigned int level, unsigned int freq);

I thought you wanted OPP based on freq and bandwidth ? But yeah, a new
OPP API like: dev_pm_opp_find_key_exact(dev, *key);

where,

struct dev_pm_opp_key {
        unsigned long *freq;
        unsigned int *level;
        unsigned int *bw;
}

and match all non-NULL values only to begin with.

-- 
viresh


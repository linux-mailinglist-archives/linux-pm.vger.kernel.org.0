Return-Path: <linux-pm+bounces-31000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE731B08B7C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 13:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E291C203E2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FE29A30E;
	Thu, 17 Jul 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mt6JiRx8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5421DB356
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750178; cv=none; b=eEt05XXBbEvpJdgmZ20d3ibjkWQHwU7Vi0AmzU1DTYsxtSKnBf/0Ohxq6chV+CeEcDwnHyR2vtIc3bmhwJB2pVrZ1a6FCHSQXoWndhxtgb+ixYnGpmiVQUgYKaVoylWsJSFcXoLG/C0N79yvs9wbTciLxuiNjwEllbjaeRcfo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750178; c=relaxed/simple;
	bh=z1PtktcRsZ/1y2GQDdgiGTLHoyuyjdCFmoAI6pe4z3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu524VDROWoypNHog5zKhsJdJrJI7Cv7kqGgqqGPnVebkkNV+3tH/bifkk5Uq7TMcf8Fc3K45sTwkukRy8g+FiD2QyGNL8cgLCPwtikml0zdQ9HF2pktgSeBZsNk2kV1ilv7mSxGB6M0jl4SiCqqr39qaE9Ytz/YR3XzUimtNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mt6JiRx8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so138568566b.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752750175; x=1753354975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1EndfwEVXqzSptJa18PcD8xERGQdTClp/Pdy2O1mJs=;
        b=mt6JiRx8orAmTsD9IwCfSUzPZOs1Y8km8b3NH1CHhJAQH+D7Ya3hxlDyla7q8bDnut
         I66ZfE8kBp9Nqyd3/Lq2kdMKjuNS3iLIC+ua2XQHRUSuyr8Y+FMkB21pt5ESOFOBrRh3
         pyBGCRGAnCLtJ7feb6oTfxxdNAuaqj4fPGf6UKK5elTaBLB5dAvJJkHD2qBMVHmbfp77
         OlQNhCa58ghLBpI9m2vULZkbm6dIS0bhT5vpYJWJLGClyhhb2N098w13qAXUHIIepUU0
         wkykluMIyzAhl/yo4D3u3+G03UwHMDPRO0w4N4Xm6yPnyYaWGUM8EluzGyl1NL6xx0Zr
         ElwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752750175; x=1753354975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1EndfwEVXqzSptJa18PcD8xERGQdTClp/Pdy2O1mJs=;
        b=prCqbdy5w/w8i2bj7pzYKq0XvT0dt1Ho932Gp+lcUugcRXmzjdy9mVN72T3vVUNV2l
         q+BZx4WPmb417SDhWFRsxQqNIrU/sTR6bNZyPMcpOtrA6k6nBJZpyV0R+tpG1tcxLdLZ
         F0HPvT/2++XEbsj6kHcxz1Xxg0pIWQupWJmZoe9QlmiQALwAHQLDTNJQXaXFG4Gr+hlu
         L08F90QoCXcbxZDwAtVHu/oe76UaL797P9q8ufOkBJuu2C3fejDPYcjP026hN3xDJD0y
         aDJRiDC7yYiJxBHBdEjc9ipuFzIiQKmhWpNnMP3huZYEjRKGwmzss8aKDxhm11m1b/Z/
         ibKg==
X-Forwarded-Encrypted: i=1; AJvYcCVbnlzj7n2qWvFQWkirGf3mQGtUmrGBQGkeFCLjKipKIYxIzwZI9O0iVFibNMfU0FIQvGGBSrVIDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoLTneNtbR0kPQVltbSeqqYzmRXf3bUVnLgNB2TSDtDnb/oKe
	3TwAhCXWeBBJHyYPsATUoqDF/U5g06QUBOJWi0qxTu7pmZ4fIPrZAM7kmaVRPCEwVlg=
X-Gm-Gg: ASbGncsKdZ3jT+1Dhqfsooeut9cB0ee+VfrgQP+VxTfh6Ki3vfuCtl4DfAyh4vZAj0F
	rdg04fBb2KStpJfcEMMLNPRXts/pK4LBg8oTivNNbyKc47LSdCeBrhhldVo4Ac+BwjlY2/xvUzL
	CpAjMeukVvv2dAFCgfOORHDPiwpMHPw5BIR+voQH03++MNTFI3iFA5Jv1Xo6riQqmLF7C2SDhOA
	PMJ0Bd+qc1vtSb3G+6FAHFuqkizNKYY+YBEnW2ZuAHdSkZ5AJKCoNhNcIlSFXuYxRp5UJcwRY+p
	wvM5MnE3krQEeLqI/Mr7dy1B3p7V39ClPsyeMbdhjMcvzoeAxq+c8hFsg+L9qyglih4w8noUMZh
	tCc5oU1tymD8O1CyYO9M=
X-Google-Smtp-Source: AGHT+IGeG4Q6tKxZC/ujOckjGsjHYhMxLU2nUMZOOzS48SXrFZHO4l2kj48NJp+pTDUjshnDsQO5FA==
X-Received: by 2002:a17:907:7f8f:b0:adb:2e9f:5d11 with SMTP id a640c23a62f3a-ae9c9af6f85mr650313366b.37.1752750175298;
        Thu, 17 Jul 2025 04:02:55 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294042sm1343873966b.119.2025.07.17.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:02:54 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:52 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ulf.hansson@linaro.org,
	konrad.dybcio@oss.qualcomm.com, quic_tingguoc@quicinc.com,
	quic_rjendra@quicinc.com, kamal.wadhwa@oss.qualcomm.com,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
Message-ID: <aHjYXFyQ2yTovMA9@linaro.org>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
 <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>

On 25-07-16 20:57:58, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMh Power Domains support for the Glymur platform.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>


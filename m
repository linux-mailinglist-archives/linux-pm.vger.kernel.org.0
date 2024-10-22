Return-Path: <linux-pm+bounces-16184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52C9A9980
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A721C25024
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDB146A6C;
	Tue, 22 Oct 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7XQzCVT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5141465BB;
	Tue, 22 Oct 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577641; cv=none; b=Gy8GCqOjoO0TQCq/MSAW/Jmts0uD9y8zuFtimd2JYoFHY6NK/AsuC8Q9OzuotRs183cHjZu6jDxkjkgX9ZYiiytw5e2flPBB3BqMNThyZhUBU9mqpPgrvBRmX2Jy6UGd2BMD0TmdMHvvWJlRl3blOs7Xx56j3kOpmNb7E7TijgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577641; c=relaxed/simple;
	bh=AB/iD/Ish0ulk5pbEH/+l4Y9rOdaPyDJ2x6ywDnaMhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXPYrymlNncqAali2I41RzPzcp8igQ0aMkS9Lsg3vRYUOR7qMRVy7/FEfkTisrd59gHrRmarj+vJ9ZExJf2B7tNnr4R6Iq00mVpCyK4JdfSeIBZ3Vba07UH2+iLFYvGUfFknLt5ASakbz6LXiTVivT0iWaiYcmsD1rIgldBC8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7XQzCVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F21C4CEC3;
	Tue, 22 Oct 2024 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577640;
	bh=AB/iD/Ish0ulk5pbEH/+l4Y9rOdaPyDJ2x6ywDnaMhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7XQzCVTFWWeqRwTbkBa7+DQUF06lR1vQuY1ltoAHUpD5++NTjFcmnjBW1rbBDj2n
	 WswcmRPCAko7aLm6/C7MSeQRYKALAj/7/U3zWzKSD78ro8e3jtFV8psdjqDZKOtvlM
	 kCHQegJXxNID12N7KSxS7H0ZqrWW2Au2dcGVW0rLCAIFriAXBU5WvFyIRovSnNYjNJ
	 8hH7u//xZQweWWnuJzt6kksrD/Rl5OtJfgzByqI58RijCPT0Z4bJ31zQ2HacyfYj+d
	 igWtZJ1hH5IxnjMS0jjpFa+KMPrPpN10TwnYsJXZD012uCo1xq4+vGvRqMTD1vUxvQ
	 zei6Rl8dUmhug==
Date: Tue, 22 Oct 2024 08:13:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Tingguo Cheng <quic_tingguoc@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Luca Weiss <luca@lucaweiss.eu>, Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Jishnu Prakash <quic_jprakash@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: power: Add additional RPMh levels
Message-ID: <wuq23gxg7xlec4epoztgaycvrezufjthj77iwu7xangf4t22f2@hmj7f7v3kvuv>
References: <20241021230333.2632368-1-quic_molvera@quicinc.com>
 <20241021230333.2632368-3-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230333.2632368-3-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:32PM -0700, Melody Olvera wrote:
> From: Jishnu Prakash <quic_jprakash@quicinc.com>
> 
> Add RPMH_REGULATOR_LEVEL_LOW_SVS_D3 and RPMH_REGULATOR_LEVEL_TURBO_L4,
> used by SM8750.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

This is not an independent patch, but part of SM8750 binding. Squash it.


> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 608087fb9a3d..df599bf46220 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h

Best regards,
Krzysztof



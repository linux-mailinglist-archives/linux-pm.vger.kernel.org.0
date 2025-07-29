Return-Path: <linux-pm+bounces-31561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16140B150C0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DABE1884B77
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2304299A84;
	Tue, 29 Jul 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcprfO4v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E229993D;
	Tue, 29 Jul 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804847; cv=none; b=kpy+m0RCnESjNC7ejm8ymqO65tYfUHS3lY7DWto5DeXWGFk1HIOT0oICqv/7PUP8Aynx2jIrVGozllum+9E/ipG61cUrlG2TyurRhi9c3syr55jAxuNK+B33wqF7ehy4cvkviFt0EW+JPYeNTNl9DC5oNDOAGBdH+iCbCz8FCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804847; c=relaxed/simple;
	bh=TCMPdRtOXj4efbdonsaSYdQteHNA9944aJwa1mzdHkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrS/ILBzqquCM6XVA4Qvea4bM6BTfuOU04ynUzum/BVfZTSi74nSATWU/k9i9cpFU3+2NwoiCtARILxYu0YLQML3svAlwpFGpuxGssFrss7D3+KgK8qPEOAQvB5Dn9MLiTJGXaLJkVF5vIJtXTi8brmzsRdm+Dqk2GQYEhLDvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcprfO4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AB9C4CEF9;
	Tue, 29 Jul 2025 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804846;
	bh=TCMPdRtOXj4efbdonsaSYdQteHNA9944aJwa1mzdHkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcprfO4v9oUE5nn1yy0aMQMt468W3UrhCN68plmhPvAvzJ6HqmZb7AJht42QJ1X2g
	 NjVbTizKt6o5ln5WZSx9hjNeRxPmK8MPBVT+wFq+m+tiIBKyiyHbQ36w4rDFODLEG1
	 nd8+Kqw8FRFazmTjrGGed4y8iruFx6mIfl3LshFAuStJB+BXffElGhQESaw4DLrnas
	 gM4DC4XnUhb2Q6HywtM5FdPM5MUHkM49wICFwckoLzgTzgs8kERVYt7mrsuAsti21S
	 jOpvtnlInK/AJ89ORKLP1Qgkn9+aQR1xFFTIwe5yyLlq/hsb43u8jDdIOTalqe5tUn
	 dPXoxFpsXzgyA==
Date: Tue, 29 Jul 2025 11:00:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: power: qcom-rpmpd: add generic bindings
 for RPM power domains
Message-ID: <175380484471.477616.2463594563710442595.robh@kernel.org>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-3-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-3-eedca108e540@oss.qualcomm.com>


On Fri, 18 Jul 2025 19:13:41 +0300, Dmitry Baryshkov wrote:
> Some of the Qualcomm RPM PD controllers use a common set of indices for
> power domains. Add generic indices for Qualcomm RPM power domain
> controllers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 121 +++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 51 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



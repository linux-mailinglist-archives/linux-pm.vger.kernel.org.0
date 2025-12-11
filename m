Return-Path: <linux-pm+bounces-39441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDACB66A1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 17:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3276D300E17B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666227587D;
	Thu, 11 Dec 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNhZZx2e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37408187346;
	Thu, 11 Dec 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468939; cv=none; b=Yn0Bxx7KgldshhXgz1M1l95P9znICmHH65otkePqpbe8rZbvQ5h2gALuWGAhUo/GEfqPQXzXH6ZKPu5E1pcNC+rX4/c+GHtiMXk2lFqEjB+knjy7aZijMeBTPZfjSky7bNZSuAnQQrwG/+GV5i7R01jfEcvRzdK9BsTptgYA3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468939; c=relaxed/simple;
	bh=splzzTOWiCi7v4VM3fCpkw5rSRNhTnMG/vb+Q1DRggM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anGhNixHds34OnOsnGgINBchk39jemap/ysoKarYD2yCZtnItKo518tj7M6W8ojMn0x90M/FTZExSyrUbAx0d6q2t66bNL+JowAMkD/UYdP8j7mC2EzM3INgL9RGwH62WfaGqZ1e/np+YSgnd9iR16LyO11XZuh/pY/RrU0KoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNhZZx2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD20C4CEF7;
	Thu, 11 Dec 2025 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765468938;
	bh=splzzTOWiCi7v4VM3fCpkw5rSRNhTnMG/vb+Q1DRggM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNhZZx2ewidLGbJzP9nu9UWEbnz95VSSHTpehAh3p82o/t7mAL+67TNvD9x7ddiKn
	 DJb5koRDehKhuXBEAPZBua7tYtfdP6B0xgHmliBF0Chdqds5tocPvhZcdarcEcoekp
	 ylMfRy3+uaaFf09YJX0mnJ6DxySt1paCKY4Szp3qOXESZf8j2CVzHCSAfTmHuyjh4X
	 WsspkccbsaT8s0OlR6fHKbJtL6N8ciZcx8fnn5ygCN/Ti4h7l9hCOdA+6n+n7jghFn
	 KxDLH82v5bU8y4luCanIfQjTLo+H2DQxS8UddGJM/1FQEuGThXIXfnYjwJ2Ka9mGvh
	 CWj84cvwR3BpQ==
Date: Thu, 11 Dec 2025 10:02:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: power: qcom-rpmpd: drop
 compatibility defines
Message-ID: <176546893559.1492200.17951281627744963247.robh@kernel.org>
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
 <20251211-rework-rpmhpd-rpmpd-v2-3-a5ec4028129f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-3-a5ec4028129f@oss.qualcomm.com>


On Thu, 11 Dec 2025 03:52:54 +0200, Dmitry Baryshkov wrote:
> Now as all relevant platforms were converted to RPMPD_ defines, drop
> compatibility defines from the qcom-rpmpd bindings.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 88 ----------------------------------
>  1 file changed, 88 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pm+bounces-31559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F065B150B7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 18:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1815C18A1EDC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5E220F20;
	Tue, 29 Jul 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejVbFu8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D71E3DCD;
	Tue, 29 Jul 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804825; cv=none; b=GpAUy1Jhwk01Na6STkwRqgb8WEm7Yxv60csx3mQAWg7VaIXpznyAI226gNdafJNj8YEoyUakFeXkMk+0mS8CNgyz+SNOqV4rKPoB7+DbwHjdkwT7vxTf0sY9v4YnClso4zPFV1lCw1GfZEsSx8qffVAZ07AFsTJB66YFGROn8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804825; c=relaxed/simple;
	bh=c4DUheHEAjhNDteVmo8TIru1qOwEcPiV6lNpXwF2j0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3ZDwKMtV0g2LT4N++kcbqlSNaT8n1YdHUNmzDA2+XCHUyBjfLMNaiSMXXC+39sNRYpIOLimX8IMY5y7vFYK8DArjf+PQk5xsAPEyW2GKS2WjCJC+d03kToMulRLdmIAhXqyPdI9T+AykRhOMQ7oERwa6QuclQVmUI0Ztwd3ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejVbFu8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43953C4CEF5;
	Tue, 29 Jul 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804825;
	bh=c4DUheHEAjhNDteVmo8TIru1qOwEcPiV6lNpXwF2j0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejVbFu8e9lTsguHbUg9V+2RetoTimiKNdJQ+xiaG8RDenDPwZ9gQW6bv+SCO2MX4O
	 u818tVFVxMjg1fCjQM7t4KKGLTN23TcVOeDmKTvlXiSqE4xMNUq+YA5GstAiVUoxH6
	 BDI6yzyPyI+SqZ5p3N5qaVDAotOoYp8ZIIigMFhmySClfLZa1mkLn4mRnJ+e+pw8Ya
	 JoEQd3ZrwWELMt0Fx5CWjY16zMdzw4raG05WBBvATV31909uOZCOqFA2hzSSa00akt
	 viNJ8HEoXZ0mNrumcgyf5IqDN3zvp31u2aouS/h90X9J6uO/T3ud4oF1RxMRfcIapt
	 JPrLsW39mUA8Q==
Date: Tue, 29 Jul 2025 11:00:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: power: qcom-rpmpd: split RPMh domains
 definitions
Message-ID: <175380482393.476968.18277499104379115216.robh@kernel.org>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>


On Fri, 18 Jul 2025 19:13:39 +0300, Dmitry Baryshkov wrote:
> Historically both RPM and RPMh domain definitions were a part of the
> same, qcom-rpmpd.h header. Now as we have a separate header for RPMh
> definitions, qcom,rpmhpd.h, move all RPMh power domain definitions to
> that header.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom,rpmhpd.h | 233 ++++++++++++++++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h  | 228 +------------------------------
>  2 files changed, 234 insertions(+), 227 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



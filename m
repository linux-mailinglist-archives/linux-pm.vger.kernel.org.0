Return-Path: <linux-pm+bounces-12279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29026953D67
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EDA2879CC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4F155314;
	Thu, 15 Aug 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAiS1evz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5915E88;
	Thu, 15 Aug 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761878; cv=none; b=WewMX0I7Qc1xR6nZn397Wttw2wtF5+3pGy5fB1qgoIMoVG9dSwv7gmfSthqGj+AIwxe9O0WVsV8gP5q8tZUuh6Gng7riTruzNI3bQxA5U6ufkDh5lqquIUATUQ9wwSGPl7Q7eaNX9RBflzxJvyW03Ri5HX5JSMIuIacOc1suzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761878; c=relaxed/simple;
	bh=VQVwGklaI3ZSA24hRUS3BioayMkSZq8f6rSuQ+wiwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A74Jc5XDfAkYx8Mg17KX0lM5gFTzhxLLm344x9oBmg0toNN0aDLDdmQ3EqTklJDynbW+OiMTSbJX8Ea5Ad2Re7GTJ08XoHsMzGgiUWOsK49BORn1lNkUBaCMA86HVZhl6W4UcQDSI7JYVrLynAgXnx3GqeOANoGcQnLdco2wVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAiS1evz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9291C32786;
	Thu, 15 Aug 2024 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723761878;
	bh=VQVwGklaI3ZSA24hRUS3BioayMkSZq8f6rSuQ+wiwm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAiS1evzyrbktfGk54uagHfLPIPhysQriDybBBU6lw5kJ9ScGMo9+MiJStry8jcDp
	 NmW9NOkV0IF5umkkuqO5lKi8BVCXD7t93P2jR2Wfad41I0tqBhuARa9lLgVQIXcM7z
	 Kts8mo5+nX6CDoiMoIJ0NSzZFnKk/lY5/bEkIE2lQHiTsd5gkSpcAsQIBUOwibm4j2
	 F34SOcTUzFoRqp91S8zDRFg+Se2uj6RkIi9U/8QFLegpfyn6TcQW6WtgvcUwCr6eM6
	 fA6hvZSooj8Y4rFBcAcVlxa1jN/ZH8IEVYynDf7f0toNZRlMkYjqzR7dvhhWxdeiw4
	 QBampIF7y8Eug==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Robert Foss <rfoss@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 00/11] arm64: qcom: set of fixes for SM8350 platform
Date: Thu, 15 Aug 2024 17:44:32 -0500
Message-ID: <172376187142.1033860.796127870290361446.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Aug 2024 08:40:04 +0300, Dmitry Baryshkov wrote:
> A set of fixes that target stability of the SM8350 platform.
> 
> 

Applied, thanks!

[09/11] arm64: dts: qcom: sm8350: add MDSS registers interconnect
        commit: 5e1cf9f1f397a3d24dc6b06eda069be954504a16
[10/11] arm64: dts: qcom: sm8350: add refgen regulator
        commit: 08822cf3de00f1b9edb01b995d926595e48a54eb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


Return-Path: <linux-pm+bounces-12276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ACB953BA8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7513328245C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EE155A43;
	Thu, 15 Aug 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyV/ygaH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4976155757;
	Thu, 15 Aug 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754467; cv=none; b=tnFvemv930pLwZAsFNaDlzAvCkyHO9baHC/YnqcBYWb+C/YphFPPo487Ed/JmItX2sWPj+/tqUOFc4DqxCCCuX+vLZmlEzETozbZYLx0p0BlRI+HUwdh+rxD49yyOBYtByxtZiGqHpsVfpqNtc1LwGx3j17UayQEJDXppZTHtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754467; c=relaxed/simple;
	bh=4KDaCGbSNqiZk9DvkwczOryM/7JAKZJoBwRV7J2iOQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oucv1yqp+5geZHklIO/7zjS5Yej1lspGa78BjtCABZwrGKwKFg604mNh62ngcgQDO2WXNI0R2QbSP/TjJE8+fZTqCBBsNXyFVEkfyrKu7KO8eFiExBSDWWzr4zXEAfFNYsDa+B69UPg9PC9aHO8ugbPs7N6Lx13lxXKa95TtJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyV/ygaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E154C4AF16;
	Thu, 15 Aug 2024 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754467;
	bh=4KDaCGbSNqiZk9DvkwczOryM/7JAKZJoBwRV7J2iOQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyV/ygaHxqLeDKcNLkST1W9hvqTOSm9jmWb3eevfspe1avEkHl0izyJ/ICLHIVGDr
	 FXcCSpbOUgj6QYs00c9z2hzGjnrKDlIaNGApf8FoqWmeGX69wyjuwRFDA7SHmWAp5i
	 PB2bmFUxh8LWTRR+aYlMDcib/q6klTC9QumA0GS9r1AHZakRoVGEbGyyArjtg9wEiR
	 1i0ViY52R1Ms2F55YvTBoRU4J8fcRbJ4Qh9Rms1BdJL+saZ+vQ7hIz67b2eg3PEKT5
	 givQyozG7FOX+qn8LZ/kn0sCCgDhmGal23HuhaZLEIpUvzumV7ptgJqEfb3jbgDgHM
	 xjD86fiQAawGA==
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
Date: Thu, 15 Aug 2024 15:40:24 -0500
Message-ID: <172375444824.1011236.1594911619896752687.b4-ty@kernel.org>
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

[11/11] arm64: defconfig: build CONFIG_REGULATOR_QCOM_REFGEN as module
        commit: 115c14ee54aae1d61d2405f9b31f67c1e8947f4e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


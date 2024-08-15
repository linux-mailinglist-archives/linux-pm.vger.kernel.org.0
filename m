Return-Path: <linux-pm+bounces-12277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F4953BF4
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 22:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EE6B2545B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BA16C688;
	Thu, 15 Aug 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkyz3b97"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752F16C436;
	Thu, 15 Aug 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754492; cv=none; b=UWqFLy8nmT+2JExpFOVNpF0FzXqgRklILk9kN6Pd/gr2cjOZqw6TBkafIqVqfZnpDAnxosys5E5H94Qg1gqZP0oRyIR1XglSHG+QSOYpgCdFLAAYZiriBtGSgJQuh3vFxuwApBdhSlHnnQFWS18U3haWnF+Dhrc1JpX2L25HJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754492; c=relaxed/simple;
	bh=6Yg4VOErxRIGVx9jYWkfRugfnVRJzKJ2bdstjdWe+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Els5TyGyJNamPIId4nMe4cc+fUsh7GEkQYh5Ech52UOWpxuCp+GBVDt+WIhj930czGW2nkGIHwwMUx17+MJruYWDWsyIAm0l6xej4QXk/UCYQWCjvBgasbn7wXC5V6KaTfKgRXV2lPbTNEhWMTdyyC67pqQfKYDadHCXmY8udYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkyz3b97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA0EC4AF13;
	Thu, 15 Aug 2024 20:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754492;
	bh=6Yg4VOErxRIGVx9jYWkfRugfnVRJzKJ2bdstjdWe+E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkyz3b972bBBJjN2ltd7Mu/7vaL/TkfrW65Qn5UlEm23wA3KKaab72FLpG9z+ZV2i
	 EoIhhOlVJrBV5bBLPURt4Z0R3oZW4IPDCaEnVK+iWYENtiOmzqpyf7lveG8GgUMFiS
	 FOUbGuuqDQGEPRLjCYcfWRPFdP2AcFcSzHp8D97eVZmtotAqZE7IN2XOnEOdvxnxO8
	 PMTSwjrKl2QU0WPq3Ki1OTWeF88G89ySUl3SGlJgtN865cg5EeUkCCeNtfQwsVtqqQ
	 xBPbDm5OAuwYWQyWkgAkLz4PumJzK3zi6aNGfkaxECxSvKswPYt63rOS+jaX5ojGpU
	 a6gK2j5VCN4kA==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Tengfei Fan <quic_tengfan@quicinc.com>
Cc: kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: qcom: Add BWMON support for SA8775p
Date: Thu, 15 Aug 2024 15:40:44 -0500
Message-ID: <172375444818.1011236.2343478351738195267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Jul 2024 15:16:09 +0800, Tengfei Fan wrote:
> Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
> SA8775p SoC.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
      commit: 1dd1a6d2b1851f8908643343c4e714af2e48352d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


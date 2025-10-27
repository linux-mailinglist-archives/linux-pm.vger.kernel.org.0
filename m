Return-Path: <linux-pm+bounces-36917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10131C0E526
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03306427E91
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E930B518;
	Mon, 27 Oct 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTIL6WRS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4230AD10;
	Mon, 27 Oct 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573994; cv=none; b=GUCUpBuaKLxLR7EFiD0PuQZ3lvWClvd7c0TDs9AUozSVbeLRTTgXuMzzkclqH7+TFfqwNSG98qeDFqPrUP/+CPFz1rJ/G1aAoFobZapzKKJixb2SoE9ahQLc1CZlzCAjt/+OdeoligZbc/sLwWZkjFM21p0fJaNDakJBmR2buKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573994; c=relaxed/simple;
	bh=QYT+Go/B5vKb+uKtNJ6OHFJJ9fIKx9dRJXaI27N7JHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzfJekoiadZSEqVFobFcbHWRQMiOZoFEYoTkdZog34tzRidQLj1OKWOBssgBn6bF3Nu0/Uf5i2GfWTsAtqXxy24JmeZAFTqO3J3GndbGKt0YyQeX9y8Cscl32bYd/2nvIlXf+H576M/1A2Qjm2+LeovpbSVDYmYia3OBv22v5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTIL6WRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E547C113D0;
	Mon, 27 Oct 2025 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573993;
	bh=QYT+Go/B5vKb+uKtNJ6OHFJJ9fIKx9dRJXaI27N7JHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTIL6WRS9til3BqgOyvmMD4W+wJcKaDdgtOBAfEIXQJ3NdX/egkY3dlEpk15fOpxV
	 j1Apzm309bKfFRrp9fZ7H72IPN6ZC+HiOoMyoLRc6VCngaAHia3PG+Br5H5cXq8e0u
	 MjriOK5zBN1QghSDtDbbMxrHtAia9kYa7N8vxiqoHe0rUwG+dM94l0aP/Yczf7ULTR
	 EDAYyvk1rU9oEXots+oIon3kz/MobgskNQdWi740505kyYv8/GX+HxtSpmqKNQvCoR
	 WeHdFznASTXQGih4fQl9mDCNbwjCpOw5zn6Y5XZg6E0WiybezmRq4uPNICXCA8+mZy
	 kHE2ytskvs5Ug==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-clk@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/4] Bring the IP0 resource from ICC to clk-rpmh on QCS615
Date: Mon, 27 Oct 2025 09:09:08 -0500
Message-ID: <176157405442.8818.7885007140359472063.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 27 Jun 2025 21:37:54 +0200, Konrad Dybcio wrote:
> This is how it should have been right from the beginning, but it seems
> like nobody took a good look at the initial submission.
> 
> This series is essentially the same as the previous [1] again.
> 
> Compile-tested only.
> 
> [...]

Applied, thanks!

[4/4] clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615
      commit: 17e4db05930e455770b15b77708a07681ed24efc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


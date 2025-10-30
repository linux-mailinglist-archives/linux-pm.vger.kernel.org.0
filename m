Return-Path: <linux-pm+bounces-37120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C1C21274
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C501A6267B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A593678C9;
	Thu, 30 Oct 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTulH5y5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2F3678BF;
	Thu, 30 Oct 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841363; cv=none; b=YxLl00kjCneKdbQ1LipO3eFDtQANsIFgWuZPM09UqYuSIfD67/iq3HjfUWsTgB6gV7M5lqoPcgSMsulxZfmmJflV9KJO23RUNHBlKQ9S8YV2iglF/+Zn1j2S7m5fcmOi7m22E8Tx2vb1POjIiHPCfAd5fLuF4kVoLMeX8xnbvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841363; c=relaxed/simple;
	bh=F5FzFRS+Jhcnqpnb75WyL11QJ+BKJhFruXmF+diqUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR/3bCuURX1a7ojXOeXmQkxu+/fpYlQWWtQvysx3SxvkFy14cgpJpXsaaBUDeIYNQPU0HgKOMG8S5uHSnIb8fWZYGnBxCA2l3OP/fvinATZKXMTQ+uS7wdurwzSl/9WAvPGnIQo1ilIDaX0D3eIio6J74bMLl3k5PglkDbs8v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTulH5y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A80DC4CEF1;
	Thu, 30 Oct 2025 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841362;
	bh=F5FzFRS+Jhcnqpnb75WyL11QJ+BKJhFruXmF+diqUkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTulH5y51+Vk6n5fQW9PxlcbZny3QE6ShEMnDcyDgnYVZkPbu/E5R528QuQz9PWPO
	 UtWFz53pgPlI7ORjEnifDD1kkTDSEUkqCmivHLleSXOq+cukuaRj55SRvEX6GJbfJ5
	 N9+inlMdUp14rtfn4EnXtNn/A426W8fMFwCOKwvtMbJTKzUmao7vDcFaFe05Db6+YM
	 wk5zJxjEEViHI5RJrHymx96LoEuqfBcM0Vfxfp+l56drprDbJG58D7UFjDtw+qye7k
	 CkTAQHRwWf7ZlXM0qLVcXhy24U3HLDaSrDwL1KJsOAvSa9B1vp2WPrsvpFKOiZmmcb
	 7AeeSD3zg2cPw==
From: Bjorn Andersson <andersson@kernel.org>
To: kernel@oss.qualcomm.com,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v6 0/2] power: supply: Add several features support in qcom-battmgr driver
Date: Thu, 30 Oct 2025 11:25:35 -0500
Message-ID: <176184154208.475875.3731365923943526201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
References: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Sep 2025 11:18:49 +0800, Fenglin Wu wrote:
> This continues the effort of updating changes which haven't been accepted
> in patch v5. Including:
>   1. Add nvmem cells for x1-crd device to enable reading back charger
>      control threshold.
>   2. Add handling for notification 0x83 to avoid unexpected error messages.
> 
> Rebase the changes on linux-power-supply.git@for-next
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: x1e80100-crd: Add charge limit nvmem
      commit: 74c2c1e0d0784a13d0709e6ec4dbac3ab1f29f97

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


Return-Path: <linux-pm+bounces-12278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB0953CFE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 23:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B722878BA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6EF154BFB;
	Thu, 15 Aug 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTjuq+HA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B1154433;
	Thu, 15 Aug 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758994; cv=none; b=TyD4u+YxwJrPcEoFyehlkBrd6Ik9gCqK/9V3KDD+XyDP6Nrn96EpOByT+ZoOedqSs/zyqFqcI0tjS5q3EGfCIWgglzvi/uZ2h830NUfjKU4LyikL1IhDGrd1NJG/Xl2lmeCai73mmZjm+2PJ7slpwQD/QvnOgw1NTzB/Bt/7k+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758994; c=relaxed/simple;
	bh=G74goXtz5dRNC7xoM58aKVjwD1023KnU05HNokO8g1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGuG0IdMLu6tIwrkAg6l7pHLVPUVTxQwsF7NWX2Hvr3O1mfF4tDjsdE2O+7//hI3mamMd2kj2agQTvfHtDyq/S3MfrPUCLIHXxGmfpaHV0Nv0R1dVD/mi2wj3kOfz3ir5asMKOMTkcvhxiHNRaNC8bIoaE6rblKeO2eCK7R22dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTjuq+HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC95C32786;
	Thu, 15 Aug 2024 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723758993;
	bh=G74goXtz5dRNC7xoM58aKVjwD1023KnU05HNokO8g1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTjuq+HAIkpjRp03T4XVv+/q5tB2OnTImljEzZ9N9sjufz1ynmeu3gqAf7jNAbO5N
	 XHYx3P34r50PKKVtoXtAmTEQN7teNsDWivnMlr9a7DDKRYi+9qgTubo7dRvja/bOBJ
	 9MMIZw79eFVVxKusgSeyP/IlFKxXB36HDQSogeh/CnphXPEUe5le5MDoZo2g26/3QA
	 8Q61cbsGS3MbwDcsOkLUqBG5ZqO6fNlMBLb+UGvAC0OWYEsLOm4xb0nhkgHE8debic
	 x5oN0w3tyWD5HHi0ACdxVq7iqX6lsrCl8hRQI/OV7irlnpNEjZNt3L8+OMzhBkOru7
	 KpUhDcfO8RWUQ==
From: Bjorn Andersson <andersson@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	ulf.hansson@linaro.org,
	andre.przywara@arm.com,
	quic_rjendra@quicinc.com,
	davidwronek@gmail.com,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	macromorgan@hotmail.com,
	linus.walleij@linaro.org,
	lpieralisi@kernel.org,
	dmitry.baryshkov@linaro.org,
	fekz115@gmail.com,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@mainlining.org
Subject: Re: (subset) [PATCH v2 00/11] Add Nothing Phone (1) support
Date: Thu, 15 Aug 2024 16:56:27 -0500
Message-ID: <172375898302.1019907.3760470354082742789.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808184048.63030-1-danila@jiaxyga.com>
References: <20240808184048.63030-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Aug 2024 21:40:14 +0300, Danila Tikhonov wrote:
> This series of patches adds support for the Nothing Phone (1), identified
> as nothing,spacewar. The Nothing Phone (1) is built on the Qualcomm
> Snapdragon 778G+ (SM7325-AE, also known as yupik).
> 
> SM7325 is identical to SC7280 just as SM7125 is identical to SC7180, so
> SM7325 devicetree imports SC7280 devicetree as a base.
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
        commit: c580e7bfc0cd140b8d3cf73183e08ca8b23326db
[02/11] soc: qcom: socinfo: Add Soc IDs for SM7325 family
        commit: 31150c9e87b4a8fe8e726a6f50ac0933f5075532
[04/11] soc: qcom: pd_mapper: Add SM7325 compatible
        commit: 79b26c110545530fa2945050a2ffbb3c4e270228
[05/11] dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
        commit: e6b666de995e993bcda883ff045164f090e5506d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


Return-Path: <linux-pm+bounces-31399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44882B1119F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D148B3ADFC7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10002ED86C;
	Thu, 24 Jul 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB4/NoIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A12ED865;
	Thu, 24 Jul 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385199; cv=none; b=UlNFnQsY0WGYRKulw+nPk6PY2Rp70+UDf2C2973w9BRFLcXLt6Updu7TZz/p1wQ0JejeFTx3KzWrd3+JzbnAulUA38t+2hODCZsLDnK4J8Ec1yPuZgvjy6roVWm0/wL/KvDlT9K5z4alBpkD2UMpqa1oykZvzTnXiIOU2b3zOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385199; c=relaxed/simple;
	bh=LPCMJci51tC1UjM8V6KF0RyaAzja7q+Mglu9ukqwvlw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=M89jDphQ2FTMFTR+KIyLepN/4CySLRBVYMYCdq4Rsfjj7tIBBEW6bPYnnHBtnZBGcEF+ftueCOnxjv7tP6J9UoD+X68K1M21fsFMRFUgcilTWGq8CDYs+IY6gWGBlRTIqxb6t8cvh1l9Z+rX8zOZOpbBvFv04o2AINNFADnFl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tB4/NoIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC4BC4CEED;
	Thu, 24 Jul 2025 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385199;
	bh=LPCMJci51tC1UjM8V6KF0RyaAzja7q+Mglu9ukqwvlw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tB4/NoIAj7PT/+Y86XoTZW9sbspRfKLyGuMCaEfBeHdi99hch6ggILYgOfzLEN3Fo
	 ZM+0ViYNfpQQnOC22PNvEDc5rylNsjYDGT0+KH21a3Wva/excuRBgayeBEmad5kimL
	 3xK3Hw2rRM5R/K35A/JofhggFZmepVHwqnejBCvJu4HxxDkrzxYajp1cRdzM9inW/+
	 QT11jhbL55SOP04kDUBmy2CH3iuj24gRSdbXECDV7eFI2Yhm0jq4WrSpWtxVHq/9oj
	 qcOG4P231D88XXBpZBDhIZtHfQkU1F0JaXiaECbTXsHImW3SIIHhsZt4BQopoFESIR
	 BCjWwT1a2eGXA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250717-bindings-double-colon-v1-3-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com> <20250717-bindings-double-colon-v1-3-c04abc180fcd@fairphone.com>
Subject: Re: [PATCH 3/3] dt-bindings: soc: qcom,rpmh-rsc: Remove double colon from description
From: Stephen Boyd <sboyd@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
To: Abel Vesa <abel.vesa@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, David Wronek <david@mainlining.org>, Dmitry Baryshkov <lumag@kernel.org>, Georgi Djakov <djakov@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, Iskren Chernev <me@iskren.info>, Jens Reidel <adrian@travitia.xyz>, Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Manivannan Sadhasivam <mani@kernel.org>, Martin Botka <martin.botka@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Priya Kakitapalli <quic_skakitap@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, Rob Herring <robh@kernel.org>, Robert Marko <robert.markoo@sartura.h
 r>, Shawn Guo <shawn.guo@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>, krishna Lanka <quic_vamslank@quicinc.com>
Date: Thu, 24 Jul 2025 12:26:38 -0700
Message-ID: <175338519842.3513.7440958226312827195@lazor>
User-Agent: alot/0.11

Quoting Luca Weiss (2025-07-16 23:54:46)
> No double colon is necessary in the description. Fix it.
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel=
.org/
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Applied to clk-next


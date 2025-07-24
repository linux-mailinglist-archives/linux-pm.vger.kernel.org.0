Return-Path: <linux-pm+bounces-31397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36345B11195
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD93B2FF2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF152EBDD5;
	Thu, 24 Jul 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCPrNc9i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1220126A;
	Thu, 24 Jul 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385189; cv=none; b=o4ZSnWDSXfDGy3UlrgjakS4OGUYaDOa6Gm3F03OJQdcc2+D76HpJxrFBUiw9c5yqYMx34v3ACfgxqjHJ+Q1uJzKfywtANyNcSP08z9M4kJedAwuyQPNPAfaWfrMc8hLBDiOpfTNZgGL96qA6kWEwen2ckTnkGrVAOib4DZUaAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385189; c=relaxed/simple;
	bh=xfsvX/sSwdyRpEMZfbnUT8tTJvTmoG3ftDvHhZaSh1Y=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=WrwfzFE4wjKhyex4yHItzWobNNn0j8n14qHYJafSOwT5f9KHwbCqEdta9wcgpgq82ds1yN9SvbFjCQgTE7p2s+z+dNhG1/RZoxIMU625jm1GnZXd/Ma5ZCrS5zHPfk8MHzy7MJU4FsftgR9ZusxaviP8WrXkqCfwQyGSBenIEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCPrNc9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A709BC4CEED;
	Thu, 24 Jul 2025 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385188;
	bh=xfsvX/sSwdyRpEMZfbnUT8tTJvTmoG3ftDvHhZaSh1Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZCPrNc9i/e+2FAh7K6Z5Apnzd8BU8aSRRdBKLk80TTk2vLg0jBGU30TMffqckvVlD
	 2yEKH085K8EMCIi6TK/CG+AoshWQ01nPjyXa6o103roGPOBXr0ApOtTsTCQ/1e097v
	 54+aRGnibXJsguj3RGWpWs+ZEo4lCDE4JrePswSfjhbmn+hb1n6WVK2V84bNJiA0Xz
	 49+sIdClhCfzscv9FRAKtMwPVVJBNYpKv55lg6mDkMkHMbsmZDMTfNctjmMDGP8z3F
	 UIuJ3Lr5Woq6MQSVjRhfFiLcvU+2I6Cv4xsHO3Nyi9I3JrkQgnLkyxDxWvgX6I5zkp
	 YupOwIUkp+ScQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250717-bindings-double-colon-v1-1-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com> <20250717-bindings-double-colon-v1-1-c04abc180fcd@fairphone.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Remove double colon from description
From: Stephen Boyd <sboyd@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
To: Abel Vesa <abel.vesa@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, David Wronek <david@mainlining.org>, Dmitry Baryshkov <lumag@kernel.org>, Georgi Djakov <djakov@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, Iskren Chernev <me@iskren.info>, Jens Reidel <adrian@travitia.xyz>, Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Manivannan Sadhasivam <mani@kernel.org>, Martin Botka <martin.botka@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Priya Kakitapalli <quic_skakitap@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, Rob Herring <robh@kernel.org>, Robert Marko <robert.markoo@sartura.h
 r>, Shawn Guo <shawn.guo@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>, krishna Lanka <quic_vamslank@quicinc.com>
Date: Thu, 24 Jul 2025 12:26:27 -0700
Message-ID: <175338518784.3513.15713025865524328468@lazor>
User-Agent: alot/0.11

Quoting Luca Weiss (2025-07-16 23:54:44)
> No double colon is necessary in the description. Fix it for all bindings
> so future bindings won't have the same copy-paste mistake.
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel=
.org/
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Applied to clk-next


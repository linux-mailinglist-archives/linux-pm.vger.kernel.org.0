Return-Path: <linux-pm+bounces-31400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E840B111AD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4251CE75BF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FC2ECEBA;
	Thu, 24 Jul 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSo8DHSR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2162EBDD5;
	Thu, 24 Jul 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385330; cv=none; b=T5n6S8SD2HL4S7fXSCfPwH90ztSA7KLJW/jCEu5wi7qqnJWtjTo3cArqpaylKSAtVZ4saKPttkLriEfdO2gyWwfBpCvOTX0GWrlNPzPhw8oKSYlIijsi1CYPBtxGdbo7jfiYHaHiecpKzquW0V49i24vlY8y2XcAAxMitvjwHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385330; c=relaxed/simple;
	bh=zz6114RfyNLdViaOJwvxusY+zYkN4XZPLtqQoGA6OOs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=OVMhlWSsPd5ZlF4eAz5KxT/UAGlYn9VWmqNRdJ0sIpB1s3VSlVzk2XkVjiulsGimekko6U8sQvC706/8nJ7ty1HmLNcp3ncVgFgqxZCo9CIr7PrCjvrfRst3nfMzJvnaawnR8reRsqNUEWXPG0QkPAUaDj8u3l/HPalpID2Fr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSo8DHSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4311EC4CEED;
	Thu, 24 Jul 2025 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385330;
	bh=zz6114RfyNLdViaOJwvxusY+zYkN4XZPLtqQoGA6OOs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nSo8DHSRK+AVCYXStQr8wxw6mQjfydIWqdGGhXbA7QYqQKW6qXR2t+rtgtJ1yIbIg
	 FUusTj3nTjAEhM1PFThnh3rcLfi1ue5z87VKMBU6ZdcQhX2ONTOr+KaML+JHJcNfmv
	 nSJuH/te0aoXasUZuHp7HOF1JNi/QGFwuX3y6MyW/oJluO2tzEyMnNzAJd8fVbBTGy
	 +NT8KT+3wB+CZpIba6K0783NHFs4E9H5l73RdE9rTKE/3hrIBcjKW4fK8VLCdP53cA
	 LeKxI609c0nvhm6TdTtoHOAgXb+roqFpimrU80vYYqK99Pl7tmIC3A291tMGocITBc
	 VX41muAwiv9WA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175338519230.3513.17229886632087604624@lazor>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com> <20250717-bindings-double-colon-v1-2-c04abc180fcd@fairphone.com> <175338519230.3513.17229886632087604624@lazor>
Subject: Re: [PATCH 2/3] dt-bindings: interconnect: qcom: Remove double colon from description
From: Stephen Boyd <sboyd@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
To: Abel Vesa <abel.vesa@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, David Wronek <david@mainlining.org>, Dmitry Baryshkov <lumag@kernel.org>, Georgi Djakov <djakov@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, Iskren Chernev <me@iskren.info>, Jens Reidel <adrian@travitia.xyz>, Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Manivannan Sadhasivam <mani@kernel.org>, Martin Botka <martin.botka@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Priya Kakitapalli <quic_skakitap@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, Rob Herring <robh@kernel.org>, Robert Marko <robert.markoo@sartura.h
 r>, Shawn Guo <shawn.guo@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>, krishna Lanka <quic_vamslank@quicinc.com>
Date: Thu, 24 Jul 2025 12:28:49 -0700
Message-ID: <175338532925.3513.4669145749917473070@lazor>
User-Agent: alot/0.11

Quoting Stephen Boyd (2025-07-24 12:26:32)
> Quoting Luca Weiss (2025-07-16 23:54:45)
> > No double colon is necessary in the description. Fix it for all bindings
> > so future bindings won't have the same copy-paste mistake.
> >=20
> > Reported-by: Rob Herring <robh@kernel.org>
> > Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kern=
el.org/
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
>=20
> Applied to clk-next

Err scratch that.


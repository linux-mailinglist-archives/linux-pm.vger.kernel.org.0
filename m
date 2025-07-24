Return-Path: <linux-pm+bounces-31398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EEB1119A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883E83A1875
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1F2ED150;
	Thu, 24 Jul 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpWyLrcX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BD20126A;
	Thu, 24 Jul 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385193; cv=none; b=Zr9eL1bLRP8WAKRzQYf4YF279CP/VeXVuLKhSSXtMkROydoIyDCBTlpYDjJquGArAOr8+CcMbkHQA5QEGMmrRk00hofBORzrJgBwjyYzvkGCvLk4N3c4wtItcTNOwhvcF49y3r9BHADtZSjpG/FK1KCrlGPTs/bx+J4wKlw2lEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385193; c=relaxed/simple;
	bh=wM177W+f7psGKsJckgdzDF1sJ70T+XnveODwtYBT434=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=T85wfbrXwsQHeWnHWhDEbIW+7fZTKdhMpjPKFYkRaPVEXuwLJN/ktlAIQMUghvZlhsDauB+ov3T2t3IsYIKkZkP6yz2IqQMi4LL+9vN4MIaCDAOnkRtgnMPGGjHhjfdx003JGgb1ZXMtC0Upj9B/nRTo2DpF/z3ME/oJhmO//Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpWyLrcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F2C4CEED;
	Thu, 24 Jul 2025 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385193;
	bh=wM177W+f7psGKsJckgdzDF1sJ70T+XnveODwtYBT434=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lpWyLrcXLKWa8P4brOU/kTsk0XNQ0GaK70gHEB4E/DCFKud8jhRl2kTbMo6YMna+N
	 vwOPOY/REm/l/h4S1Le7AXOQhE7evHEvzPH0/R2tgI7dsnqY21UaI/QWRDgh/vzBaC
	 cdzjehHjTqr3TmEQuoMaOWYsctzAwoTbknwsIruxgTJzix5C/v5TLg8jHh/1bKeCPr
	 1Z32rE4diQZW38p7eh7adqoqLIUwsC4t9pWC1RX7+ZKI7Pe83Mb3p0/TKTIERRRVJu
	 ka+J9tmUN+Ytn6YoHS1P/EywNurj3IcmhKNAPADTcY9fwnseBwCXWtzlx39s1fsTRY
	 SE7e1dtyHCmOQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250717-bindings-double-colon-v1-2-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com> <20250717-bindings-double-colon-v1-2-c04abc180fcd@fairphone.com>
Subject: Re: [PATCH 2/3] dt-bindings: interconnect: qcom: Remove double colon from description
From: Stephen Boyd <sboyd@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
To: Abel Vesa <abel.vesa@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, David Wronek <david@mainlining.org>, Dmitry Baryshkov <lumag@kernel.org>, Georgi Djakov <djakov@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, Iskren Chernev <me@iskren.info>, Jens Reidel <adrian@travitia.xyz>, Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Manivannan Sadhasivam <mani@kernel.org>, Martin Botka <martin.botka@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Priya Kakitapalli <quic_skakitap@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, Rob Herring <robh@kernel.org>, Robert Marko <robert.markoo@sartura.h
 r>, Shawn Guo <shawn.guo@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>, krishna Lanka <quic_vamslank@quicinc.com>
Date: Thu, 24 Jul 2025 12:26:32 -0700
Message-ID: <175338519230.3513.17229886632087604624@lazor>
User-Agent: alot/0.11

Quoting Luca Weiss (2025-07-16 23:54:45)
> No double colon is necessary in the description. Fix it for all bindings
> so future bindings won't have the same copy-paste mistake.
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel=
.org/
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Applied to clk-next


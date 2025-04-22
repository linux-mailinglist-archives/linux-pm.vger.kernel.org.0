Return-Path: <linux-pm+bounces-25868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A9A9631F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A8619E2CEA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC82580D0;
	Tue, 22 Apr 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChdFVkhz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4E239085;
	Tue, 22 Apr 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311418; cv=none; b=I8cA5HqzCOrt6qVY8Ib9m0ccMgVlp/axZix+oA3OZKNyRK63At25UjKpxhrXspKMqrTxYI7kJDe1mJBy1lPQklNYhsg6QAyBkCEosmkKgwvpSmW1YaPa69tuz+L7T0joZ3SaO/WPzzNsKltPauwez22+dUbMJRhpaPpUAw6kiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311418; c=relaxed/simple;
	bh=trUwxgkbYocqWQI6MfdxJtzi88omtDraXrFFZ8EFGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onVwZqjSMcHeIckO16C2RX9oeApmG8+UzmUkwZWVQJ+SaPEYW4WwvafS9nXg0cc6/TZwwYuZie9C6SJEg3cDm2dlbsAtaXJAoAMVS04THrM701IdmZpb14g6opaWUV1F0ApYAsca5GWifZbNOFR5hZ0LIJWmSA3DCtkTA+IsNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChdFVkhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA7C4CEE9;
	Tue, 22 Apr 2025 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745311417;
	bh=trUwxgkbYocqWQI6MfdxJtzi88omtDraXrFFZ8EFGnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChdFVkhzjsXHdkBGYH4gMHe7OCaIptwGjHtQ3BjfZtrrvBmdk91tVrY0tjAxc120c
	 B7NYiXVNUg6vHjy0Y5LpbI920NOG1XmK7QjkCdTPglkIDgHnDM4XjEBazVRdyHSe7T
	 zB3NvgKudujC6wvkmgZsdLHTE6YUJqDSHacYqX7uwsvV8Z2X0UOoUQxPS9oyDIb5bu
	 afpup07WhhdxQp86PDvOU/Ro4N6EQAJZFfTVzS3KsbuY91/xyY1OUgNwauevrYiRuy
	 d/buaizv/dU77jat3O8Z470nSCkHm1lixgik2Coa5rYdHy5i0DE01DFqsFzmYxtMUY
	 FjN/ZWIut0prw==
Date: Tue, 22 Apr 2025 10:43:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Maya Matuszczyk <maccraft123mc@gmail.com>, 
	Anthony Ruhier <aruhier@mailbox.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Message-ID: <20250422-beneficial-fractal-otter-ebd1d2@kuoka>
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
 <20250419-gpu-acd-v5-5-8dbab23569e0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250419-gpu-acd-v5-5-8dbab23569e0@quicinc.com>

On Sat, Apr 19, 2025 at 08:21:34PM GMT, Akhil P Oommen wrote:
> Add a new schema which extends opp-v2 to support a new vendor specific
> property required for Adreno GPUs found in Qualcomm's SoCs. The new
> property called "qcom,opp-acd-level" carries a u32 value recommended
> for each opp needs to be shared to GMU during runtime.
> 
> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 97 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



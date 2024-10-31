Return-Path: <linux-pm+bounces-16810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21C9B7669
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6541C21CBB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410D15665E;
	Thu, 31 Oct 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRm5ZSsb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C11547F5;
	Thu, 31 Oct 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363177; cv=none; b=D6yqybl8fUV2LdM1qvf373Vd7nWo9+tdSvvKHuEPpSHEk3ijoDYGI0IaRn/g5qwGEgs41I07SW4QMPZd8MnlVKK82IctlFTqaAPX7Rbmbpga/gN6Mt4HAyUVkVguZ1J3Q0CJIj2QIrVqvhiMrJ5S168+rYb9WG1Js2gvetNEYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363177; c=relaxed/simple;
	bh=UrDFFofF18WS6aKVThuARJiGWU2fBFDfhKgmv63OvlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0JWqX7iogF5eGec4fOkp2w5sHDpjHWqr9FWJDqjwuTv1nkHtjDO/l8KjE8h5oXRT6Wu7IKEWOX+XfxU8ai11hltASar7920xqPHZUmHGNumjOCGAIbLBX2xOV+l9k92Ct8aWM5jXOn7eveH/fom764tTBmhq6mOHSTOgTHO56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRm5ZSsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4FAC4CEC3;
	Thu, 31 Oct 2024 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363176;
	bh=UrDFFofF18WS6aKVThuARJiGWU2fBFDfhKgmv63OvlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRm5ZSsbMiy+R52CufgmwFaiIL26zVqRzODUeeJQuwQ7+VlmDlORnCAZlgTWZ7UER
	 2DVcDYgmUz4oglaPyBY8smV06XyX6VCir4S8IMn/8pYuUUT/2wyb79eQnCbNTUUXVS
	 cOIOb4+VwI/C1VO/xqAY2tPx5P5frNLO1m+AScrnRE6OGr+zIbIWrevTk7CBB6m8+y
	 BU691WBL7MFkPtHQPVo1GLQnOp5MIv9ysVDg5FB9V93HzWxzE/SqBDYTDBYpAIEjI5
	 +jQHikhGbutFrEhwSLd8hQyNPx5cgm1PqQ/N4hFgkNECBS6PebDRNQxHyfA/WKhxpF
	 G90g+9OHslgSA==
Date: Thu, 31 Oct 2024 09:26:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 03/15] dt-bindings: pinctrl: qcom,pmic-mpp: Document
 PM8937 compatible
Message-ID: <wko4zti5rmad73qv3yxpnawahugwym42z4oilfpdjdzvuys3eg@p4pdldp2ltfm>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-3-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-3-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:44AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document the Device Tree binding for PM8937 MPPs.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



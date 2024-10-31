Return-Path: <linux-pm+bounces-16809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A470B9B7663
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D521E1C21C61
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74EB155A4D;
	Thu, 31 Oct 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLrFgU8D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81C148832;
	Thu, 31 Oct 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363167; cv=none; b=SWOjUHv9CMsRKW83kP+C2bEFJytO1mHp6lEaUZJhV4YIXSCWHtdLGvGRpis6TMdSqP1x+Nk3tAV6AE9q3Vk3NXA9OHvvTjdMx9alf9gCIT1Naj8N/ULhYBUzWwgqAtTcsGerSWJoVRGJaWLq3Hqw3x4apy7vLiza439Wh2SzeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363167; c=relaxed/simple;
	bh=KWrb63gG4u+Go45YQM/D9fF7IRhKh98BdRQ/m+zDGL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeKHD6P53CW+H/APtBv6cgfajOGA7DVhsow4ydNfq86bFtCfD6jySa0/R313nNWeMaiIvtgcCcqbZJRxXvGkhd5XzlKk8ZHLKWno8xgQYZc0K3xuPH4dkXDZ5dUK0a1gqtHUBEhOK8JKqQ8HNjR/BD1YmuLi4jmjBaau2/qIONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLrFgU8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A672EC4CEC3;
	Thu, 31 Oct 2024 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363167;
	bh=KWrb63gG4u+Go45YQM/D9fF7IRhKh98BdRQ/m+zDGL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLrFgU8DvqtSS+vieYt2c9Ym86xZ2ctjyJv/00pBqDpb4RIlpk19kK49TmJSz0L7v
	 uyBCaqF5kmWbin1O6HjoaJQzkf/OXeO50CjQ54YxnWLq1LEs/5VruuCd5MqrAf2tF7
	 IwHk8YJowqELoP/CYc4AquiI/gH5PycSBkZNAngcBDZiMooGI4Yg+IF+e/YKaFA/yj
	 wFAghEoHL92IoBRwX02GHlqtmPl3FoSYBDgU8T8wgNN2rGErgfy/zRLMVpta8nQSuy
	 N+N3HsSk5V8xpUUkdQzpNLYuBCPb11Vi9J+xBafs0NzShRnpbU3noZQMDziwynQrP2
	 ky/AKtXa5YHpQ==
Date: Thu, 31 Oct 2024 09:26:03 +0100
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
Subject: Re: [PATCH v2 14/15] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Message-ID: <xpdjgx6lyu5fykeslbi6vmx22qzrrrzaac4hbmpllei7qqw37n@ue7jyfbtjrj7>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-14-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-14-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:55AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document Xiaomi Remi 5A (riva).
> Add qcom,msm8917 for msm-id, board-id allow-list.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



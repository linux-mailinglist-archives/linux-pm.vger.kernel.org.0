Return-Path: <linux-pm+bounces-16806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1B9B764D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD7AB21C7A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6C1547F5;
	Thu, 31 Oct 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFm95iyz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24F148832;
	Thu, 31 Oct 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362922; cv=none; b=qHiaWYPwn+pbWa1qc3GNNQnhKA2b5O1uwABQY2k3fjUcERLYBaaMglG9xDDmhA3PWaZArjptfDbvqvIUjJ9EllNePeLbycBwAke+N+Kq9m4pcmaN9xNvhfWB65+6Xcy4QGgBDu1zzn9I7Kd2z/2PNhTCSispoWJAmm9rp4J+JC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362922; c=relaxed/simple;
	bh=mit1UznUgyA0A1Mq6JGcwpWwK3gEYeZvE1Pj/iWL4wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0RKVJbiut1P8LOeoalvonMrEzyATsl2gKA7URVwTpnwfNmvtfuzWL/xXXppWwUw4BSetkwScEXhrmmgqBYsGO9KCrvLEi9mZtyyGgWT6C4KzFd9acRWHeaUUry0C/XyQwm/HVxR/GEw4yubdqPdu/zcKJGLwb/U9txC4OYmfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFm95iyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA00C4CEC3;
	Thu, 31 Oct 2024 08:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730362921;
	bh=mit1UznUgyA0A1Mq6JGcwpWwK3gEYeZvE1Pj/iWL4wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFm95iyzAlntui6pwjrXRyn+Gt8EvEmPBZbk3Um4lF5ZhJEleRISSnHEyWvlqa/LE
	 9IyBx1Npq3+JYA5itO5tZWMCpYnE1PIsrVRfmLIiSgjB+ku2tMMgj1JPT3NgL5KXFJ
	 IRodZ7Ffl6hBkJyvYBeReZBMBjmn1Z5k6m4Lcy3WoieVmzR3vF4DJlJ6XEk7jkEDno
	 op2vQN7WYikEysFSpg1XIUVH2m0qbFfexpn0bgdpHUSPHwch9MDKJknyDBhLUmNsWF
	 HZUYs8vLz/Re9bEI+VZWzpf6gkSucQhmtvb2XsKwvCIsPviGiP29fNAeeC9kmytckJ
	 YqOejJ/7g+Rag==
Date: Thu, 31 Oct 2024 09:21:57 +0100
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
Subject: Re: [PATCH v2 08/15] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8917
Message-ID: <ll74jcx67x26hgpvnwl7c2hzyqowme3ofwcc42fsg6od6wfj3q@vmoo4ufp7znv>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-8-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-8-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:49AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Document the qcom,msm8917-tcsr compatible.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



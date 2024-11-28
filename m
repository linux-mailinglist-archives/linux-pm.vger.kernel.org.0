Return-Path: <linux-pm+bounces-18191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FB9DB306
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03943166700
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21A146A62;
	Thu, 28 Nov 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNFKXpMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1817C7C;
	Thu, 28 Nov 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732777941; cv=none; b=rTvGLXV1rFJTJyWu+8Fem82FNNW8OacJgSDExCJdxu2LmkNEjWAKiZmXhD7WJ4uRXOTqI7cfe+KK7O/6JRA7BypT5baTPulpJ8Z1f5cSWTElbGOFcmpzqo1KLxIhLkb0xborB0cBoNK/0LPQ6Z2/5fugblqWnkAV8OOrmCq1FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732777941; c=relaxed/simple;
	bh=RXztPqWcga+lFf91NyCRDW4b0oQ6s7jySmyXx8o6G5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a15GJ4F+asPFUbrAP63tfW1lKMEWHj2u1yRuxTyULhgBonNruZ8lEvLWLUHyat7S1JvkvV+6Ish8+4EkImLjwCTeiCZlSZmreVj3cc0ksxf3KLsp5PRfQ7YZNTK8benJdpjVYww4zK5NUYYztKT7EdEg0ByErv8hzZv8VLK1shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNFKXpMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF01C4CECE;
	Thu, 28 Nov 2024 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732777940;
	bh=RXztPqWcga+lFf91NyCRDW4b0oQ6s7jySmyXx8o6G5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNFKXpMdIRcHSTu+UGqT6Mzpd1ARVvK1MtQnUHDa+kEvsfZbxkreJFEQEHt+Ze5fo
	 WF38+ZCYkPXpIDB2VM4ttbv7+cQ+78aAtzideMiY4acnLoeoyORO68IRaLu35+QoLE
	 QLPTKYrmr8IEVDnAzCM+8spJ7QLdhctrQ6+MUTfI0UlQLUiijhvYZme96KDZmJ4/hZ
	 dCP/N6hun2bpILdj9vizf0dO2EAiCbIAlh8BYJYTRJcPG2ZkC+OYHicpvTdBeDAHG1
	 QDtfYxWdeLuvcyVsGlAG+ipi9nAiw4zDfu5R6MrSkYV5XcO7A4GrMAEd3jzHz6WYSL
	 jmK7/Qm+WL2WQ==
Date: Thu, 28 Nov 2024 08:12:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] regulator: dt-bindings: qcom,qca6390-pmu:
 document WCN6750
Message-ID: <725gjpoubhbexpah5uch7rgsozgeb4mjc662idf7rmoe2rish5@uar366jby3qm>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
 <20241127115107.11549-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127115107.11549-3-quic_janathot@quicinc.com>

On Wed, Nov 27, 2024 at 05:21:07PM +0530, Janaki Ramaiah Thota wrote:
> Add description of the PMU node for the WCN6750 module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof



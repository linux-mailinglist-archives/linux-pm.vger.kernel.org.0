Return-Path: <linux-pm+bounces-28529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2DAD68E5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A30F3A39DF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79D1F5424;
	Thu, 12 Jun 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzEH+q9B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9B1EB1BF;
	Thu, 12 Jun 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713003; cv=none; b=q8Lqlw26coPtepbrq8fLlhUl5wpKnKZoNC1Iy2hVBEEAVIjK4ErNK2yAvXYVlCBjHSX4bMt22/nRWjXpjhXwrPTOKwvfr0p1nceYaVB4drh73M8TM93ipVZerE7PYrBkWx6wZH/Cxc0vB+49p0Bkmctg+XSQ5juspro/HtBb444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713003; c=relaxed/simple;
	bh=Gj4+PXLRdedYVtJ+mHJQKngvmnQjkLOcKbLWhmG04vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9U4YllAknC690iFXoucCYxYlYSCAknWuSBGv1OPBGWfylLWb7I6WZCvMDz7dSbNkhHGDQwW7qts2cFYLYJOreOqZW0W0Af1pck4BZSYbdTfvJIQD+7kKOEtQFB11yRjNK1fBR1EvWidaQnssNx0JDlQIr2i8CGLaP2zG+T1zTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzEH+q9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06702C4CEEE;
	Thu, 12 Jun 2025 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749713002;
	bh=Gj4+PXLRdedYVtJ+mHJQKngvmnQjkLOcKbLWhmG04vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzEH+q9B6rmlX8EftENmEjjru4gVWyE+Z+LdxtoxazZ/gctdHrBh6/fZhay/D/ZvP
	 MqFUTGmOqdKVRu47wFl4UcIbl065wST1FTx8s2DakcNxU5gBeil56mElRksF5R65uE
	 plmI5DN75+YCl/b0eFXNpHbkdzreI/AlhVxhqCnZ/mSvEnmqo2QkWncV/2/MKNCNi/
	 cZU/yjqOod/alfF9SVs/Dg67ZzjfoyLVqdAVLsy6N52vdjWvl/ph6Al2gosiNSi9b7
	 pxRdjVVy5oUM8SFKsFz0Fj4hzP9Z5ZL3DFY5AspktCNtozuWXdHqitokFfSEK9pEP+
	 SwVvCIMvM2feA==
Date: Thu, 12 Jun 2025 09:23:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
Message-ID: <20250612-accomplished-nimble-goshawk-49d069@kuoka>
References: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
 <20250612-ipq5018-tsens-v13-1-a210f3683240@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250612-ipq5018-tsens-v13-1-a210f3683240@outlook.com>

On Thu, Jun 12, 2025 at 10:46:13AM GMT, George Moussalem wrote:
> IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
> and, as such, must deviates from the standard v1 init routine in the
> driver as this version of tsens needs to be explicitly reset and enabled
> in the driver.
> 
> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
> 
> Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



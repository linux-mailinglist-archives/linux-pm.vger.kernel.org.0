Return-Path: <linux-pm+bounces-16058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B79A5CD7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 09:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B721C20441
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB41D175D;
	Mon, 21 Oct 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEwiuTsF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E31D1508;
	Mon, 21 Oct 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495468; cv=none; b=W3MjBgtqgGH9N/XhVNmHkOjWBtiUTO83gHJRraDQ+LEjIrMhgp7vsT6SZom7stccojiJyCD7gdU0eEzHaZ6j3eaKnmgVqjc2k55X5/NoY41IiuIcSmh3dV/MGSK4PNWxtiMPq5u2b+8A/V56RIxbbjDeoCktTs1cKpuLRkHkPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495468; c=relaxed/simple;
	bh=tPfgtyN7dgDomitHwrm54UhfVoCZDqQwHSKnK1GiHTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpDgC2MIr+iv3L29lNQU7xI1xqjdagOsj1wdoJMthCjr984faZeXLwwgTNZgNjd6yUAdFgjjl4uMChoiJ1uIsmyRguk+k8r/IatZZmysxKTWixQ2wqmHcVdn1/B5N/pfaKBEqw8PmP5QbH2oJ+1q4n6xF5mD56MJqVdQcYB1ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEwiuTsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD4BC4CEC3;
	Mon, 21 Oct 2024 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495468;
	bh=tPfgtyN7dgDomitHwrm54UhfVoCZDqQwHSKnK1GiHTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEwiuTsFVTBRfLIJusYanBXVQdv4p7HYZyLBKLL2ib08doOHsDFIjbjtK9+LlvDQQ
	 Z/9CGkfVkX3HL4bich4ORC4qgTSaqc5vLYtee7sVi+WEP6oQHSym85CNfAbl113evz
	 kxCr9RiXDbkK2BwH8bEgy0kmZTapSMZXatlh5BmezNoivtFGVuk+moF0ghNJdsv2t+
	 s+Xx/1jKHnad+MR7NsZ6ui1/G2nW9PT7lKCXaHCo6Cx5xN8PkcGdbjzpK2PjXtl2jT
	 vpMCnddvYrQCLZ1RGe1dQBneqLlxBSYI2qkK28rbXvPXN/oyvhyGqwyyz3YlOF3nAA
	 /e3ihWlHKpghA==
Date: Mon, 21 Oct 2024 09:24:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 1/6] regulator: dt-bindings: qcom,qca6390-pmu: add
 more properties for wcn6855
Message-ID: <wozfwlvmjhf2mvd5xxt33owbi44y3igi4gbsx3uqgjfzlgjk25@rsnkh35sheq6>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
 <20241018-sc8280xp-pwrseq-v6-1-8da8310d9564@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-1-8da8310d9564@linaro.org>

On Fri, Oct 18, 2024 at 02:49:11PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document two supplies that are used by this model and the optional
> xo-clk signal.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../devicetree/bindings/regulator/qcom,qca6390-pmu.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-16527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F99B20AD
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AFC1C20C27
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E5184520;
	Sun, 27 Oct 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZn8ed1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736F1DFE8;
	Sun, 27 Oct 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063246; cv=none; b=EMvV7r1ToTjnQIcgh626P1v44PSBxQFefb5xvGcTL6LFTSfHPrPhm7CpugC4E9rmUH6NHjVQ51OU5jOLO9yVN7vKoivsx0lDDqkZkfVVMPhVKCbj7huOvu/qsqmAPgoDugke5UH1dM0P4EqC1Qqf9n8L/7J5mOPHE8opCpePFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063246; c=relaxed/simple;
	bh=Vg7bc+N2WqnmGKQnX7h+4b+1CbkCilzWV2NEXN83oj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlqsxhXeRHNORVZ8SBUNlYCIrqBay/M1bvhrcWRLJGa7zW39ld9u1ny603ViMjWj18BpLuCgitKWVamqgNZq99ucZLiUbPJ1FghG3Sd9in/rXBMgNGoLz6nV7BvDPSjbl2XXgdN/CX4V5ImYNSEBVjBc6yMiRi+slxsYknHB5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZn8ed1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8686C4CEC3;
	Sun, 27 Oct 2024 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730063246;
	bh=Vg7bc+N2WqnmGKQnX7h+4b+1CbkCilzWV2NEXN83oj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZn8ed1LLwuxHHVKIiQYgIYTfqRjhcreqnwhY8ZM4oLBj7zYKErvANHzd+wmYYOve
	 uugnP0dYkAhpq0y35FBvMxM7mNMnW8dmoDQY/ME3Ft0fDG8QN+llk0XRyfYAU1oT8K
	 /x0bs/s1xhlWtGXZ/ZMpmLNvRNPQVD4Gux8gzYoqIhcTCZ9e/tqzx3kyt9MXmITBtS
	 o2C/cCMzt+p+VV5Xq9xkhTUA1VLiWQTnRhbQINGCKy0TX+oagLOXmztXuMUUCk84Pv
	 pl5QMFH66Sq16G+2fUx4wXsIkJYF+OJ307JiG91BAOc2Nn5c2uH3DbVCb7mXFyJqTb
	 9tgggXMzSA9Vw==
Date: Sun, 27 Oct 2024 22:07:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: add SAR2130P compatible
Message-ID: <thr77dlmwj5mm3444g35c5f4pgrdqi3o5gkhqrizomndug22oq@e34mltywe4zb>
References: <20241027-sar2130p-tsens-v1-1-8dee27fc02ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241027-sar2130p-tsens-v1-1-8dee27fc02ae@linaro.org>

On Sun, Oct 27, 2024 at 01:06:50AM +0300, Dmitry Baryshkov wrote:
> Document compatible for thermal sensors on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



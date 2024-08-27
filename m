Return-Path: <linux-pm+bounces-12946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D869960622
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DCCB239AF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722219DF81;
	Tue, 27 Aug 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0/g4DkF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F719AA46;
	Tue, 27 Aug 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751957; cv=none; b=sPpnd8S4E7Vsge/XyHP0yUPHqSRc4soOYPAYSe+o1mZYfF7rGrkuz7ePIXvSL92zPMXLil6VnVCwM2Gt9vJmohwjjtGP7PdOVnS55gcCf6qyw/txXJDRG8zSiCQa+CKAlkPoH8k8fngGmUXpytgxREF/FG5uW/mTeLdp5qQbe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751957; c=relaxed/simple;
	bh=pa1uUMzxapFwOzulx/0qiK3diOx9wGmg2r0PnQpb3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTcvKLgNda/+FnCnhiM+Zgp/OYeSE9p3CRTaCCrtsR1be2FieSCFSzymm4x2r8XS0TTJuPfGNBGLp4nJl0FFivVPz2rmf86pteWkw4aeLy0G/3zzMndDzur2Jg5CXAMskc6u1YrQoCWtuui4NhnjbnNUGYp+AUHveUHMzG2ofrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0/g4DkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C31CC8B7AE;
	Tue, 27 Aug 2024 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724751956;
	bh=pa1uUMzxapFwOzulx/0qiK3diOx9wGmg2r0PnQpb3Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0/g4DkFoNMeZQXr+c7nIt9HCMpHNwLaAeWhQHQpmpmWs6LKkloAc9FjNT7oOVWEp
	 wrFkD2+Ss1W1sQ9L8xTj3/4LywM59VuX5qIbBfP7YnRPoIyY8P6Cb5hPZgaOIft+GN
	 kLSXCVV6xFYYRGykeo334KMdH1XPcFmmo00aH7eoSp+fxvfP46NNp9LC/aaLsRO5jr
	 Uxb1OLzXHLwoehorA2mRV3eBWFiV+2xn+E2ur2DbybxBQ2TCIKk+eTqw82AzEiDs2g
	 J6KF2/XHf82qYk/HAuxkXQ69hLGDkr8O+okf2h4D3xV4RUVwe/ESgZgtsilVPLhj3E
	 PbtN5N4RgltWA==
Message-ID: <38f54537-7ed3-4f6d-acac-1704c004a349@kernel.org>
Date: Tue, 27 Aug 2024 11:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] pmdomain: qcom: cpr: Simplify with dev_err_probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
 <20240823-cleanup-h-guard-pm-domain-v1-5-8320722eaf39@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-5-8320722eaf39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.08.2024 2:51 PM, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make defer code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad


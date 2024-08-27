Return-Path: <linux-pm+bounces-12947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CC960628
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBED1C2032A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7191993BE;
	Tue, 27 Aug 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr/XzIUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EA1714B8;
	Tue, 27 Aug 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752057; cv=none; b=T8jxCCJe+QqhE9OzXt8CF+tA3hKHkheZn0ysYxmwEpfPoGyMgLUNzSt+EQSWy/7AwjL3pvPXbsuph+Cvcc5QlLXZm+Mk712KdjaNS6gw6OJF3NzQKL9cMwC+l7yhgs6nAGUZBLQbDpQ+xClmzMjGvBBbx348FyRWNWwlbuP4gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752057; c=relaxed/simple;
	bh=Lej6CAf6PPRt3VxOUgFXQ/Kh7FjIH2oWJQXtjqr3t1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6QQbhJDDbfEmnECx4dQs962LLHS/Q9LizZGCmM3GQhPbtApEZAd0wkXTRT+MtTHLXPOWIokDXgnGHSQCREofqkBbbMDLo94ku4uEmiqjDA4HPVQ0YPa4O52KMC5WZYnMyPgRRfjIV3VBW+jq8gq0bn/J1c2zveF0wTTT6Bq06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr/XzIUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE59EC8B7A0;
	Tue, 27 Aug 2024 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724752056;
	bh=Lej6CAf6PPRt3VxOUgFXQ/Kh7FjIH2oWJQXtjqr3t1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zr/XzIUsj5/ziXoYQv/3uU0SKUJrI/0HY2qErpDIQqPzJVs7Orag3qWxFWyBpFSEA
	 HG0WGwTigeSzFpMaFz5++5EmdO6rh6RZ+4GvxkLAqFtF+9Tv0FycmZIcqDhP8MweeB
	 Vftfy7pycegFwN4q3XAJUkjTg/RtEA1f1j3H2eyMCZJVfr6C8WDitEuq+hGTNFIvDI
	 7bgVoW/r/KI/5k+YEyoiuLq31M9CTLF1ufv/drLxyl1yN/StHrW4Py7a/zqAzhxyEf
	 GPoLRj/wx1u1bWSh0mzKPJ4svbMxAA7gPRHF5jJ73U9YnmTQ8BC7FmhjnkzR7iupvd
	 /AZ6RENkIRDdA==
Message-ID: <3a9914b6-521c-40da-a03a-685d7477fbb3@kernel.org>
Date: Tue, 27 Aug 2024 11:47:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] pmdomain: qcom: cpr: Simplify locking with guard()
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
 <20240823-cleanup-h-guard-pm-domain-v1-6-8320722eaf39@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-6-8320722eaf39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.08.2024 2:51 PM, Krzysztof Kozlowski wrote:
> Simplify error handling (less gotos) over locks with guard().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad


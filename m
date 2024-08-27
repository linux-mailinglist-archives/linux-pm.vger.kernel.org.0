Return-Path: <linux-pm+bounces-12949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A899960633
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE81C22880
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19A19D8AC;
	Tue, 27 Aug 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cygvi/Og"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909913B588;
	Tue, 27 Aug 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752159; cv=none; b=VylPdp15FKv96GcNgMDnOK9DOM9caZdE105Tm7+cOBoSqbUMLouHdFnrUnx2sCecDmKx808uNuEj8ySZ53dibwuo0KorQID0n0sOqwSjOn7NXUak3S4qEDSQvWBqMF/zJhC54AmQKU3Dv99JCTQjUjlfeoO7k2mcZBkSy6+Iy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752159; c=relaxed/simple;
	bh=i7NI4Nrkz5Xqzy0dJnBCstnJ32/Jo2lh/i45uj2UqIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBVxJSdumeU9Cng5zZCBTiw8OzhszUUYnCSHuLeA8146zyRbGIQ3LjysKHBdduoCubtOUs9M7sGdK8k1IVGypMV/Q5VAavjuV3SXX+cId3i9/n37gDgU6wUOmH0wODsWWmmVAwlen7jvbgo6Xk7fd8DsMKa/HlbkftsfrTRo0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cygvi/Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ECCC8B7A0;
	Tue, 27 Aug 2024 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724752159;
	bh=i7NI4Nrkz5Xqzy0dJnBCstnJ32/Jo2lh/i45uj2UqIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cygvi/OgZdHtqq0AMRAJRp78Rc4ZBdfMMPXYVfc8o4bdDtdC2wlSp9KusaMSwWGWT
	 YUYGidlt2nSYLzkiiFqRZX49f/pqvSGRFLs+xNURMmU205hRAUNcbGbsUmfpQp/xbD
	 9p/IBH+qQXYPC9qPQi3uA9yuKbklEjRxSBwSJurhGD9CFWOL8VHs4lNBMop/ZRlgZ+
	 /3zPeS82CE42Z8NsG7bRXLe9+d1hba5SJo7RGWtHrzIJM9NtmH/yFYtt9e2bEz85Ds
	 dtksnOSEuVayjjqJrXHM5pX68LrU5mPCyf8/RimDvJIawSHB20NrINI555SGgS5Q4M
	 J7mYfePXbXMkg==
Message-ID: <ca9e5cf0-2e6b-4584-ad2d-86e1ce638093@kernel.org>
Date: Tue, 27 Aug 2024 11:49:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] pmdomain: qcom: rpmpd: Simplify locking with
 guard()
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
 <20240823-cleanup-h-guard-pm-domain-v1-8-8320722eaf39@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-8-8320722eaf39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.08.2024 2:51 PM, Krzysztof Kozlowski wrote:
> Simplify error handling (less gotos) over locks with guard().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Thanks for taking care of this!

Konrad


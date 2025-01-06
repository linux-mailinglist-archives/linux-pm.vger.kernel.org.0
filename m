Return-Path: <linux-pm+bounces-19995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F299BA0319B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 21:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B2C1886F5A
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D91AAA09;
	Mon,  6 Jan 2025 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyJJEgkH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C41372;
	Mon,  6 Jan 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196725; cv=none; b=lkyuqWq1PFmhH59A4JZSBW9yxxXg56/bIF1bCQCQLi8LAFcWobGAASMo0Q3K5AhX6F6jUHUkj6S4WJHkfystkxqkUwhssEdjVd/wHxsl+Fc0aBrYyw4pAcmn86BtbHQL7J+3m2/Scua0zmo0DdGKbbOx6BoLVZccO0D5FvWdr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196725; c=relaxed/simple;
	bh=pkoTA3m4K1X1dlDuPOYVmh5S9A/up69OsUuJcxsBqHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnenumcDX9+qJjNFT7yUIBTQoL8Rprs3pra9I2D/gC5kEpyqlUVWkaa03DfH6FX73gdrGcjQ7YCA6XJrWNzuySxt0uiXSiBjiU/nHy7UNdVkumg7TsmaQEMODo2SPKxUSKAJLiQ8zpU6I0lU89SoBJJ//2zsUFHso8qABEB46Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyJJEgkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A3C4CED2;
	Mon,  6 Jan 2025 20:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736196724;
	bh=pkoTA3m4K1X1dlDuPOYVmh5S9A/up69OsUuJcxsBqHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyJJEgkH69zsFc0M3nZjbn4atDhSp6dbxWwLCHRzPcOXT5Z0FZN1NqS+YolQU0Y10
	 JQeCJM/2NAnBvcTYICSgCld1bBlgoxWrrrJs6KK6cxRgebvm5GZPr9Y0ykXRS5C3Xp
	 KHxw+JeReuqBkg1NreDwGzYLVLe58ylX1Hu5cAA33tDmLxaKLz1/Mcx+R/I+UIKIW7
	 NyIwxOIANbaRUkZnJ4fjivlv3OLQqX+eS215tMZ3QWD7sadaprTX5w9LDgXFFK94hQ
	 R0/4i3/h9kHCbFvRASHmbUK2zL029o9pWgrH2IDNMrTfOrhw5puQSzkdmk/B9ixUQw
	 hfBKBUSGNalow==
Date: Mon, 6 Jan 2025 14:52:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document ipq6018
 temperature sensor
Message-ID: <173619670386.940648.7452245327494202129.robh@kernel.org>
References: <20240716133803.82907-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716133803.82907-1-rayyan.ansari@linaro.org>


On Tue, 16 Jul 2024 14:38:02 +0100, Rayyan Ansari wrote:
> Document the ipq6018 temperature sensor, which is used in ipq6018.dtsi
> and is compatible with the ipq8074 temperature sensor.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Looks like this slipped thru the cracks. Applied, thanks!



Return-Path: <linux-pm+bounces-9082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6E90719A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DAFB25D88
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBB143C63;
	Thu, 13 Jun 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWNBZiOK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59814386B;
	Thu, 13 Jun 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282297; cv=none; b=s9lase2b28BwhYL1vdEjNS2HyEPzosEB869vRhWtyuPkAYAdKXwuBQibqk0QKPoXuqiHzvw73FMNM1sCrV+sO9jV9rggh2vFNyRhy0qI6asf4DS5jfiRRLE74xoNGI3axnoNDxiQfAW6HhAqHRgbYiluwtc1KUEUisl63W5vXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282297; c=relaxed/simple;
	bh=+Ps/m5LPCrr12cKf+1TsG+NGfRkskSxaIu7J2ih4u9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMTlg8P+4+IN08D2dOJtkDQrDOKst6VCFpEMEzUrYsRaADz6COMqEQ1YaRZogljMge6TNBphe05XAekH9bLz+PrB/pJkhHcdXyJGjsKvnKCAnnUo73LMmmcOdNbTg+aJY6TlO2tHwkdM2YUN7V8f9Aj5DtjzDlRAzo/IHFuJrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWNBZiOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED15C4AF1A;
	Thu, 13 Jun 2024 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718282296;
	bh=+Ps/m5LPCrr12cKf+1TsG+NGfRkskSxaIu7J2ih4u9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dWNBZiOK0WNhGJx5cvEsKkOoqN3c89QhYzBrfgIaR8sqDH6md4bbGOMuXhxszIYcD
	 yG3tnrBxi0Eat5n7E3yCGm/gqH2yVXKAVbFfSh6v021Yt4k5wJFsd45XqYbWX2U4Fr
	 Pgt4r5bvQnojgSpjHvd09IFfRA8hZUPpB7jgfyJwPen1Wpzm5FpY+9Tz8rxsxaMywD
	 9vHUeTXA6gMGerIiV+NSXUshO2uAmz8rH+nbrek8yYKZhbkk4qs5R0/0ZpU1EDlLOy
	 RNIg8DXGeD4nK/zFj255Oxt7DrIK41x1415r46zWv3bQVDKC1HpOE9dHP7d8sql8QD
	 Y3MtnY2fENwCw==
Message-ID: <e0a5690a-2c88-4154-9bec-441d22197468@kernel.org>
Date: Thu, 13 Jun 2024 15:38:09 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] soc: mediatek: Add MediaTek DVFS Resource
 Collector (DVFSRC) driver
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com,
 Dawei Chien <dawei.chien@mediatek.com>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <20240610085735.147134-5-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240610085735.147134-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 11:57, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> Hardware module used to collect all the requests from both software and the
> various remote processors embedded into the SoC and decide about a minimum
> operating voltage and a minimum DRAM frequency to fulfill those requests in
> an effort to provide the best achievable performance per watt.
> 
> This hardware IP is capable of transparently performing direct register R/W
> on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> 
> This driver includes support for MT8183, MT8192 and MT8195.
> 
> Co-Developed-by: Dawei Chien <dawei.chien@mediatek.com>
> [Angelo: Partial refactoring and cleanups]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Georgi Djakov <djakov@kerenl.org>



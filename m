Return-Path: <linux-pm+bounces-36627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0CBFA382
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6ED3A52AF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3552ECE96;
	Wed, 22 Oct 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h113bMnY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0F2EC0BB;
	Wed, 22 Oct 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114533; cv=none; b=lMXHV2/SjClSTUB6LFjTvVh6nnGZOTINZBMzlIClYE7UJ0d0QFv8dq9CfpJzul9f58mUhxEncvqSofL1SXrP1mab+3iRCel2WjzKKdDL0l88wm1UI3KTZx25iCo1gf3cjV9LReAln0s2EmGsvzJYtEBC/sB9EBTv/omQsoJnv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114533; c=relaxed/simple;
	bh=Ljm2ULtaHnAICwY5sdTetLQkB743kUutmk8GF2iooEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Os33Mhw/WDIKrrIH0R+alryf/TcMSxaEHbqo3KW+vT2FuBUH2vZT5e8qUig4bpoBzYUSbkaDOaWrX4wLYz9lK3h+d9m0qxyp1FXD1qVLnS/Aa/q4SbW0vWag6rq9ohyXrtHCljhLgH7i5lTfQXGai8Li1U9qWOzei/mGc3Svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h113bMnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62BDC4CEE7;
	Wed, 22 Oct 2025 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761114533;
	bh=Ljm2ULtaHnAICwY5sdTetLQkB743kUutmk8GF2iooEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h113bMnY2l5y/tnVT3ynhN5CotZ6Q+5nOgPCFKU83/0Cc8U5vHIoF9RK3+d9hn908
	 6aQ2ggeu2H723AxMu7rDs6Psyc6+815khC6gxP6tSyGpTgp3WAYJ8d+OQPycMCNzms
	 +nT5Km8Vp9tirN2fbf20OH8EBzOAvQ/lQrPoOdmPHXbpOBMq2AonwScFfkzelA2bFt
	 iv8oTXzROTo2jdyQDVaHSffWxks71Fldjf5Nz6W11kHLMwzgQNP6NostPEScnZbCAC
	 slXk3xlsWhCL8+p7PaqU/7I4HJ+L9E7pCIyojIl0kQI10vMOFhOwPyED/gsJ8NGEqd
	 9IdXBHDa11Rsg==
Date: Wed, 22 Oct 2025 08:28:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, zhangqing@rock-chips.com, sugar.zhang@rock-chips.com, 
	huangtao@rock-chips.com
Subject: Re: [PATCH v4 1/2] dt-bindings: power: rockchip: Add support for
 RV1126B
Message-ID: <20251022-competent-nondescript-ocelot-fd605f@kuoka>
References: <20251017093834.331998-1-finley.xiao@rock-chips.com>
 <20251017093834.331998-2-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017093834.331998-2-finley.xiao@rock-chips.com>

On Fri, Oct 17, 2025 at 05:38:33PM +0800, Finley Xiao wrote:
> Add power domain IDs for RV1126B SoC.
> Add a new compatible because register fields have changed.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



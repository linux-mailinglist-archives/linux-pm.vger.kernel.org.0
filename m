Return-Path: <linux-pm+bounces-19360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACF9F433C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 07:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DA16732A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B214C5B3;
	Tue, 17 Dec 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5iO8C/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88B136A;
	Tue, 17 Dec 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415313; cv=none; b=eMraNLU1y9+ijHg6cFpnyQi+/wFZ75r4jPQgdKwVD0FsFUMspGwk+IS/sXHG1kxKb2Gr9UsS45PREhCDwxRt5LsLdUAtPB46wKNf4kALNJAZGnI85iXKGF+xGn15Q6h48kcoEH0qTeyDmHoufOJ/LIXqvDZVLIq1u2MrQd/rNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415313; c=relaxed/simple;
	bh=MQnRWevRgWT/JlpN36fyGwLKn3r7MNLcMMTBRQu2YQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDuOHQRbR5fyv7iFgQCoR7gdkkJU+3T1+P2USVNR0QknXmRQEZ4M5X47P7uSxwcOTPU1CN+S3us1DoTzLDaMxloc6H9v2RFTtpMEuf0qfYA0z+VD6T1HP6Cx/FV2K1fsugT4ubO2jLGiKcTXEMnhTWN6HUj4fgmVbCF5LI370iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5iO8C/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3174AC4CED3;
	Tue, 17 Dec 2024 06:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734415313;
	bh=MQnRWevRgWT/JlpN36fyGwLKn3r7MNLcMMTBRQu2YQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5iO8C/UuhniGjG0h7aUi4m9cu/4f33aLXIkr3YdZtV3rXyiPpHQxHYSGoeFDoAL4
	 fCLW1PBKHXIn6wwZ0dj4hZXpc2s4ToXDvbMugCnwll8wMaIhQveLO8Mpr5W+v5AdWt
	 0Sc4SZpbNql6q4Ez/a0AqSoOW1knPOv4beOfH/mFstcy+eXkSf2znqRPb2gnco99Rk
	 7TDt62Xh5umr2vB7LM8d2XcRfFugVwvuZZd2/LzVoSPFQYb7z5LTlag4TTjefejDoD
	 1EEn6P33ac7bVJHfmITQaD99iKsN/VOTYYKQfzATTjJ5MrP60iBV7e/rBUG/0Kzb2e
	 Q9lJhU5D9CuHw==
Date: Tue, 17 Dec 2024 07:01:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J
 board
Message-ID: <lkj2atlhann2t4b2oiztnlurr6zecmzllxstaf7vdnj2zy5x5d@pbzfqr6lsnhu>
References: <20241216214152.58387-1-shimrrashai@gmail.com>
 <20241216214152.58387-2-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216214152.58387-2-shimrrashai@gmail.com>

On Mon, Dec 16, 2024 at 03:41:51PM -0600, Shimrra Shai wrote:
> Document board compatible bindings.
> 
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-21158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB91A237DA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4126165F96
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844B1C07DD;
	Thu, 30 Jan 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj4NZCSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1041B86DC;
	Thu, 30 Jan 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279919; cv=none; b=D1vTanwZh/RTeykJm6JBh8NzQFFpWt0XRZn3vwiLeqVj3tF1FIFyY+ts1ZZrMP5o5FZr1JgyEfH1B4kYJKKGG2z7CLxjqiwP99Tq5iOcQ3On6B1URUrMGNUuAVIhu5PGbvqaPOBgYjAfekR6RgnlXX1yAZQLnb8W/dO1xlGoy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279919; c=relaxed/simple;
	bh=FD1DT8h4F86wuJYVhooiMYuxZz8NzchzLHbeU8uZCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh9JjawIBCW3K/+OETCJXlArmTXzEqMVhEj2bYUffN2DadwOjb1bjxp7JuUswStvwrChUTKi1C7xrZu7I9WEPVqsMRXx4AwyvrUgu6XGzpKlxU3pO5GbEOTxhAjvELm5vAZE4GgfziN71yzKbXEJwhP2p54od/wJo7hYDUx1+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj4NZCSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D7CC4CED2;
	Thu, 30 Jan 2025 23:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738279918;
	bh=FD1DT8h4F86wuJYVhooiMYuxZz8NzchzLHbeU8uZCZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cj4NZCSfSnfYYpdidLQRma6/5LiCAhXXUzjlXVCt9EwmfZHs6Xbz0wyRKHySlbKw+
	 cW8sD0FynkolXzPRAYWkK3yFnXTXd0MaA9UkgNnrqFQ+JQeJtMAHUsBzacESG+113W
	 0ELmi/tXuZoi7gqkl7pCdI7+VGnsvJLHxBzx3znyIKIiseP+xe1nXAeihQlwwHUm5q
	 gj5M7RK/ySWbblznVyN+8eLjdPDnHBaNOnOsgySJtv6Nnb/pl+SSOHU5m8WcM0BeJd
	 smy1mVCxS1uKFsU6LFy4mhKhRBNJU7vnWoMENxCxnBh4VC8LsZkUURD2xOsaFfP3Jg
	 6DMhOg5w8z4kg==
Date: Thu, 30 Jan 2025 17:31:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: krzk+dt@kernel.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, sre@kernel.org,
	nicolas.ferre@microchip.com, lee@kernel.org,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 01/16] dt-bindings: mfd: syscon: add
 microchip,sama7d65-ddr3phy
Message-ID: <173827991640.1868148.3213096504696184504.robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <01181325b16c78ac50b8bab3f178b14e8f417892.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01181325b16c78ac50b8bab3f178b14e8f417892.1738257860.git.Ryan.Wanner@microchip.com>


On Thu, 30 Jan 2025 10:33:41 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 DDR3phy compatible to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



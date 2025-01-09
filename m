Return-Path: <linux-pm+bounces-20165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF5A08350
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93257A2C70
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AB2063C9;
	Thu,  9 Jan 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VLMDRBo0"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60230205E37;
	Thu,  9 Jan 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736464517; cv=none; b=f7GzGceH8/+fqggKUsVuF+2SHk3M9xh7dTJ0N+XnutUS/8KaGqhhEO4wYM+TTV8RVxn9jyiHtyWedDK1ebFruTXY6g04KKXTgpSS0bzrDPwqrZ4RynUW3fjjOaAgVn1NoLZq/PVVaBgNqCiTsYmv5KW1Enp7YSh81XSiBmIHP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736464517; c=relaxed/simple;
	bh=HznCb0V66Eh/wgloVhCI/l+lkOgEx8kQIjfNELNCpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxNM5snw3i17WZrWENdMa1Gsr8RqYrmuoulXYg4yvC6hOK6wGc6b0EFuWQo/gIeWqVK89JiqbJteyWvYsnz5VQboFkUCaB5OzId4b8NQmmiHKABPnYzzrSUBxF60HSHEoM4W7qZBnJ0MUB8sXb7ru4XfqrR41/0sZmzDGopxASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VLMDRBo0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DMXLTKZv7aPQSaOukCeYXiGlmyqmXrYyjrj2l+DZP5Q=; b=VLMDRBo0Fhxksbi/ChrY9gaNRh
	o12d4T6RURl9lbQ51vCzjGjUq9nTsq4uAnKCKqM86LZS0Du0OHDSwH/h9jND8AwaCIEWJZcIIfTI6
	6Jauton0lBxcEHROkEGLVW1/Fm0RsdkiReO3f73GQzzaWeoM4FZQqHYDmrDy1rsE+siE+UjyOYxhS
	rBka+Yl1YXrd+yqdkOhTn+48LdB+ZrKhCw8RI/bmk7YK/4f5/IeRG686DrjaQO37o++1bXbxnyas9
	wq3nuWEQPyTRuUSb2jkGY3y+f0SkkLy9zyGRWW089m9VEywmqRPGrv9oP+zLHlraiwZNSL0+CTDrm
	+DOU59Kw==;
Received: from i5e860d05.versanet.de ([94.134.13.5] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tW1k9-0005wG-FP; Fri, 10 Jan 2025 00:15:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v4 0/2] arm64: dts: rockchip: Add Firefly ITX-3588J Board
Date: Fri, 10 Jan 2025 00:15:03 +0100
Message-ID: <173646444755.2945728.11659314833812280538.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241216214152.58387-1-shimrrashai@gmail.com>
References: <20241216214152.58387-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 16 Dec 2024 15:41:50 -0600, Shimrra Shai wrote:
> Draft 4 for the device trees for this board. I hope this one finally
> addresses all outstanding style and organization issues. Note that the
> technical functionality limitations from the preceding versions remain.
> 
> Changes since draft 3:
>  * Removed the rockchip-pca9555.h header and used the pin numbers directly
>    in the .dts.
>  * Removed the display-subsystem node in the .dts. No other board seems to
>    have one like the one that was there and it was causing warnings.
>  * Removed extraneous property "rk806_dvs1_pwrdn" on the PMIC subnode on
>    SPI2.
>  * Removed an extraneous property "rockchip,skip-scan-in-resume" on the
>    PCIe node pcie2x1l0.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
      commit: 8886252102bd774656d19423b7d85e1ddd78f9c0
[2/2] arm64: dts: rockchip: add DTs for Firefly ITX-3588J and its Core-3588J SoM
      commit: ebe82df46fba0f0fe45d7e03ddf5ca0f6e758a06

I've sorted some properties and dropped the status="okay" from the
fixed regulators added in the board dts.
status=okay is the default, so there is no need to add this to new
nodes.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


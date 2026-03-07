Return-Path: <linux-pm+bounces-43906-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JLxAbVBrGmqoAEAu9opvQ
	(envelope-from <linux-pm+bounces-43906-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:18:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF622C5A3
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D143013B5A
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A88346FC0;
	Sat,  7 Mar 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz5TYceL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5A1DE3B7;
	Sat,  7 Mar 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896690; cv=none; b=juZq0tnGnXzWHIgVqi3jb/ppYvhLwMjD7SZRa5Sq3MxFmlfn5kZ6p30n8PzYIhHMRkPt0cJImzNq6cwkIEZnFlb4kILor718EOxzIIyq3i3Ifd8dZYbdCroyO3J+t9YYvYMQ47TFNtIc0W5hRynA2KYniJtm676QGT0i8X5zbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896690; c=relaxed/simple;
	bh=jlypIP7aSTLT6zBopju+NVijnNmlfi4wioiJEX4k+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0Ek4XpWf//Y6D8DPmjyiJEXep/tDb03OnLWITKrpkCGtm1VIZT24iiAs96vVhxcNb8KVs5Kccp3ps4UOjSkX6o6ZGCZ/KNuG6L9joqSkOmFrRhiz3/eC0lLxaU7GdUHXhnChs1rf4ySMyZ7/9W0gXg8z1w/gck4S+jk37DKVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz5TYceL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF76C19422;
	Sat,  7 Mar 2026 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896689;
	bh=jlypIP7aSTLT6zBopju+NVijnNmlfi4wioiJEX4k+HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz5TYceLrLeUNaE5OZh18nZssVhCQuGG4Dl+4595UIdhQ/LOMOsk1nsYmOSunzRgY
	 n8FzOkMCIHLLgpdtcUbrvZy03fQx6hnuoG9WgJt4juGbwcLOA7ga5TYqOkMnT0FrYv
	 ZXxbOvfTG4SA9hn3+lIZHVlVfP/XB1pGSV/ybg9psQRWEDsuvatJRWztk4UtDBO+Nh
	 8osKYuub3v2RngY27loXxr7S6UPCFRFv92Qj2uazrDK3fp1dKWb1VpLBTf9KaoXy/g
	 xuESlWTh1oD4jNWLbZKU41y071oHnLtyojHLAUun5jIg1c7o7v0zaiAJQUQhKlIU7R
	 11ImNMRK7nT8w==
Date: Sat, 7 Mar 2026 16:18:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add shaping nodes for rk3576
Message-ID: <20260307-impartial-cat-of-efficiency-a742ff@quoll>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
 <1772782832-216867-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1772782832-216867-4-git-send-email-shawn.lin@rock-chips.com>
X-Rspamd-Queue-Id: 67CF622C5A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43906-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,27f05088:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:40:32PM +0800, Shawn Lin wrote:
>  						 <&cru PCLK_VOP_ROOT>;
>  					pm_qos = <&qos_vop_m0>,
>  						 <&qos_vop_m1ro>;
> +					pm_shaping = <&shaping_vop_m0>,
> +						     <&shaping_vop_m1ro>;
>  					#power-domain-cells = <1>;
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> @@ -1602,11 +1626,21 @@
>  			reg = <0x0 0x27f05000 0x0 0x20>;
>  		};
>  
> +		shaping_gpu: shaping@27f05088 {
> +			compatible = "rockchip,rk3576-shaping", "syscon";

NAK, undocumented ABI.

And basic checkpatch would tell you that.

Also, shaping block is not a syscon. Please read what the syscon is.

Best regards,
Krzysztof



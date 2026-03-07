Return-Path: <linux-pm+bounces-43905-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPy1J3hBrGmqoAEAu9opvQ
	(envelope-from <linux-pm+bounces-43905-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:17:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBD22C59A
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C04B300B47B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3A39E6C5;
	Sat,  7 Mar 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Civrm1ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D82F690F;
	Sat,  7 Mar 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896623; cv=none; b=HxjGyZmd8mfxuKtdGSTrcRG+iSCOlubAckXF8KcwOHSKDaapJZNe6tyM4LWHi6cWHE32QtU6yUHz8wgPD0JRf3Ig7cGxTz1vPyCVrOn6GJXlwQIPnn9a2uj/qXwSioJCgYf1BFyNWXDbPn6zBpZ6D8hCVTbo5qvdPOJrejJs85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896623; c=relaxed/simple;
	bh=0UnT+075J08xFSw5ayjMg4ookTNNmPK5kNEOX3Bba1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+WzFtzRpiHngF1DrVlrRKWFTZgmtgEiBgAkksfCTMgXfkbJTOt6ccVuj3dKlf3jVe0z7dRL1QM8wbb+DhbxTi7/0WURAcnVm1BEODyTP1J6LaJ05PE6GZj+6vUonQCT/ZpKCTD20pZ5NDwju87waVwFB11AwO0UYuOCfOchnjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Civrm1ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8610EC19422;
	Sat,  7 Mar 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896623;
	bh=0UnT+075J08xFSw5ayjMg4ookTNNmPK5kNEOX3Bba1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Civrm1ki07KOZoF+DAaXctutesxEyo26q81HghJOpSHL2BKdvpIlmBfwuQpFamBd2
	 yVrpUj9M6xD/KZT/su4uRMbymopzKXjr01YdoygFIcLEVWCRGvmjeJRv+xiw1cmEVx
	 zzY0HWWE2rg6X5uajzbnItF7+h/WggLROWibSbf+8kB0PD6oQF8XBxmn83eR7feYZt
	 TbkN3ovSQofGYZfM+5CkuNhiwCFl9yt7rcKNHibSnY1YD2X1e4/XJw0I/WEoTix/uf
	 FrGDBBR/agAFHMIECAfby95z4fIMu95zT1hxiHvzTD7ClyvXjBi7PLuGB7SsiBpon7
	 +ZyCGYDlUCbdg==
Date: Sat, 7 Mar 2026 16:17:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: rockchip: Add pm_shaping support
Message-ID: <20260307-original-shrewd-mouflon-1eb07b@quoll>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
 <1772782832-216867-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1772782832-216867-2-git-send-email-shawn.lin@rock-chips.com>
X-Rspamd-Queue-Id: 8CDBD22C59A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43905-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:40:30PM +0800, Shawn Lin wrote:
> pm_shaping is introduced for some platforms to throttle the outstanding
> burst requests of each IP to prevent bus monopolization. Add a discription
> of it.

Isn't that interconnects?

Also which platforms? We don't add it for your downstream code. Why
there is no property restriction per variant in the binding?


> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/power/rockchip,power-controller.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index b41db57..4af6c30 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -147,6 +147,14 @@ $defs:
>            A number of phandles to qos blocks which need to be saved and restored
>            while power domain switches state.
>  
> +      pm_shaping:

Read DTS coding style. Build your code with W=2 so you will see here
warnings.

Also, read writing bindings or any docs for beginners. Missing prefix.


> +        $ref: /schemas/types.yaml#/definitions/phandle-array

so phandle? Or array? Decide...

> +        items:
> +          maxItems: 1

So how many items?

> +        description: |

Drop |

> +          A number of phandles to shaping blocks which need to be saved and restored
> +          while power domain switches state.

Wrap code according to Linux coding style.

Best regards,
Krzysztof



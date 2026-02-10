Return-Path: <linux-pm+bounces-42417-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDRZLuT5imlBPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42417-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:27:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E7118DC3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4688A30467D2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D57340A79;
	Tue, 10 Feb 2026 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAYyTY28"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2833F8B7;
	Tue, 10 Feb 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715556; cv=none; b=jsI35NbRVW0AtYYQAIzkyO3lpbpKMaX4bfhlZ+5k/Xyf6Sac/NBIsY/i25zLs0z/dFLHfE8pRfo//fObsvlY6bvazddzbmLVleNMoxykbvybXtAU9HmjA4Jy0Cn8nXorXeEDbpocRZ/3O3F487HUivUfnwq8xFvZfDTIfHGA/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715556; c=relaxed/simple;
	bh=nTpbF/LC8upmEXEac7kpyDh1IWGjV1DXuBQN7lJPICI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBU3mPZqReYdAldQAoiRWrrO0al2RpKf+WHfeebMyysPDksMq+/Q/xvW56EdoTqHxneP273TGAPuyPsjxd8drfyDeVuujGT170iXRuVy6SDY2sSHS8oDxEwdO6Z0u5mW4TiRvTQOVtC3NAkSHXfnRWW3y4630bXNzicIQOyxvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAYyTY28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601AFC19423;
	Tue, 10 Feb 2026 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715555;
	bh=nTpbF/LC8upmEXEac7kpyDh1IWGjV1DXuBQN7lJPICI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAYyTY287oX9lNxxZj7fmMhQJctEfjLm6b56+GD8mKgm/BlDrmN1p3OSwEX0kYl3u
	 HCfBy1Hoe0OQYA+O9Qkzpiv2K3BYlC8q3Z9fzTt9tbGNcJmem4ERsR8+dzQ7p6nE6+
	 8KWfi8XquljzZY6grvengKwF1M8nZ14RoecfaftGZ7YlUKvVaYGMAy9X9g/uuN53UE
	 yUUeLZghn1yeAhMXneC6pgFZX8TBJg3tGDhz/XBpeWQH50gmiZPuU45mn5KiOTwFTx
	 abQz9r4Wht3i/fKbUVv/qY0b6rYu+n9mO5hOuYvY/VfD5ynhHICARwUsq2R6XmCklr
	 yqcYQEjUDFFLw==
Date: Tue, 10 Feb 2026 10:25:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC
 DockRAM
Message-ID: <20260210-hidden-swinging-galago-fdcfa3@quoll>
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209104407.116426-2-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42417-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 449E7118DC3
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:43:59PM +0200, Svyatoslav Ryhel wrote:
> Documenting an I2C device used in conjunction with the EC on ASUS
> Transformers. The main function of DockRAM (the name used by downstream
> ASUS sources) is to provide power-related functions, such as battery and
> charger communication. The device is exposed as an individual entity
> because multiple embedded controllers can utilize the same DockRAM
> instance.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
> new file mode 100644
> index 000000000000..0cfde619ba01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml

Not a misc device. Find appropriate place, e.g. for EC or docking or
laptop devices or power-related.

> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Asus Transformer EC DockRAM
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  Dedicated i2c device used to provide power related functions of the
> +  embedded controller used in ASUS Transformer device family.
> +
> +properties:
> +  compatible:
> +    const: asus,dockram

Way too generic compatible. You are not documenting here all ASUS
laptops/devices dockram. For example this implies dockram is also on
ASUS Vivobook... or on any other asus device.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +

Device looks weirdly empty. Probably you have it only to instantiate I2C
handle, so what you really wanted is i2c-parent. This is not a real
device.

Best regards,
Krzysztof



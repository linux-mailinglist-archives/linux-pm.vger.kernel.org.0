Return-Path: <linux-pm+bounces-21625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D408A2E3B4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B379F7A1D43
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6306188915;
	Mon, 10 Feb 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eitg9pUg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258871581E1;
	Mon, 10 Feb 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165781; cv=none; b=n9NSl/0dPmpHC5CWwxZoZPy4tLHauWCyftJEUWMqNBE0VPmdv6o8a8zJ8z1blflz4j0soP2+44VpiubRl8+36uh2LUMAjMnjhFQrn1nR9nS7DeCXzranT250aIITDYxLDJ6gccyyx9QQnYzvBhBpG0ryIb8HZ4Jbo9nV7wFfgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165781; c=relaxed/simple;
	bh=urDld4RY+cYIO+TvMh385/JIv91I5yTnE2Iw1QXKAzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njI6LuGqAze8HWHj15Uog4OeXNm8yqtw3z74+YzbmFYLyW6OKU5nrZve1N7MqJI+mzRWgfhsUP7myY86p0jSPi+bnQlnou63LSo2brjP31LDZ3qp2ca3jw5JBev13PSMpbu5rhziKbuAp9wwK8D+aYph89iGmNdIKpgmYWWJh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eitg9pUg; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be6fdeee35so703358785a.1;
        Sun, 09 Feb 2025 21:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739165779; x=1739770579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ifdBl3NrYJonu6r4KpHBlucrHJcYm6tgOGSrXK8TmU=;
        b=eitg9pUgvMrN1N+pjl7xK+3Lh5xx7V3wmmt2meaUGjcXJ+bKhF7mTPfoZFgpHLqNjd
         u1S02OzT0s5z9Cvp+I727IsJf1EJC05xsDTWOTOPYFEq/TXt3kgvXJ3+E2pugOtBntsu
         ujDqezLxtCTUxcuvNm9DlhFp+w5w0ugn9xCcrZGpfZcb+GfZ6IrtnPNuSsAu25iUs6Vq
         cTLYxG4eUfnUb8nHnIfvyZSZeodbIanVthFTrcafQolMan1g6dupd3rV1PNDf+UStDFD
         YGES3GwPVFcM35TzfbXgFB3fJGuYIuBQy/sJHrbG5O61bRwF355pQOUmJQ2sacGb2zDu
         7iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739165779; x=1739770579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ifdBl3NrYJonu6r4KpHBlucrHJcYm6tgOGSrXK8TmU=;
        b=jw1dyRqF58v/F+toKvLWZxL4uqnP7GmyLbNTGZ/egCyMgEndn2bOBMRA2dQZceAO6C
         y7KyzKqfy5CxVTR3nhaBMQsn21F9/wPwtJEEhk1KUpFCg0zkay39cpFrWtOUsIcrbBpW
         ephjkdog4HeYI4pD+GM903pmIJRPx4cEXO8LtfOmJFSYieFuo1RCoawNcY8+7hDErgaM
         u2dFe05CbyDfK0i2kCP7/WLnmfqvB+0fkG/vSlq0f4c4lh1L/YI6YaGS+4x98oJnnWut
         dVG6DlpZAgJ3d6PHNI4mfhjbzQyxZjOWc5h5G5vcoBrf2PdGhmHJqDD+ZT3AY4z22pzv
         ydUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJYoO6/UeZ2up2Gc90uedClhBwHpsxUym3XseWVqmuX4X/ujLbq0IAgqXKGsfKz2qi1JRayl1oBKdm@vger.kernel.org, AJvYcCXCvQ2W793Z6BfX584OYdpyR8T8pGT08SbujnFq+BmAY1eaRKSAJMcmEmyawec0cP4WRivP2Qjg+CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmPMYOsmwpJ+eCpMs6YleurYz0GvtnB1UBL5U4hZTeTyuWOla
	KpWeuwqzogtOCkz7tkwuuGknzs5ixPLEWlrc8Ngx/UZhA7Dm8vQ5
X-Gm-Gg: ASbGncvhOYUrEoV9YK3Se0dsoAe3NK6yqQwouKZXmt/PDvwIX4iBnBoPUIHVCvN5MpX
	DgN/JZrULCYWr68/WwUzOYUZIPisyWbAat7I1OyO0M1SdKzBUccISZ+u3iMUEMJ1dl7oAmKt6zS
	nkhdqvBgr55Bsp6BtjAHcNSdViTxwrAC1YQaImVs6ylDAIHE0OaWI63eiAe0Jal6SnJIWuw6SdY
	R4eHGlkm6Q3nrsTN18XKChDpnqhRPZPp1sHfPQpWuxlLUX20KJ+tKq7j2lG+qsY0ec=
X-Google-Smtp-Source: AGHT+IEWqO2pMAus1b90+jEl0xBixTJRuApL2Dml4vzHcusAiiCC0HuddoHfUyCUVXV1B1ACw5vOWg==
X-Received: by 2002:a05:620a:2893:b0:7af:c60b:5acf with SMTP id af79cd13be357-7c047ba6b65mr1800335285a.10.1739165778925;
        Sun, 09 Feb 2025 21:36:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041e9f4basm484915585a.67.2025.02.09.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:36:18 -0800 (PST)
Date: Mon, 10 Feb 2025 13:36:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: reset: sophgo: Add CV18xx reset
 controller
Message-ID: <dlvmfdkxws6daxteiukdmce5rjr5vpcfey4tcpodq7d32rbj76@ikhlepkb26k7>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <20250209220646.1090868-8-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220646.1090868-8-alexander.sverdlin@gmail.com>

On Sun, Feb 09, 2025 at 11:06:32PM +0100, Alexander Sverdlin wrote:
> Add DT bindings for CV18xx reset controller. The power/reboot driver is
> going to use only 4 bits from two different MMIO regions which can be
> potentially used by other subsystems/drivers, therefore the resources
> are not being claimed directly by the device/driver, but via syscons
> instead.
> 
> Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/reset/sophgo,cv1800-reset.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
> new file mode 100644
> index 000000000000..4f058f99df5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/sophgo,cv1800-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cvitek CV18xx/Sophgo SG2000 Reset Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800-reset

Please use cv1800b, not cv1800. And this is a reboot device
not reset device. Refer other bindings to write yours.

Regards,
Inochi


Return-Path: <linux-pm+bounces-18519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F09E3501
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAA428289B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54018C907;
	Wed,  4 Dec 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvwGu+w9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2031FA4;
	Wed,  4 Dec 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299821; cv=none; b=t3B0mGYw5QCYzy30a22K3hez+xKCN9B/6Sq5SZRfcsH4SxDlHKJFw5m2NIJQ0xVopFC7M2iKKTOsLEz07+hs9QTnziLHz57ZjF06euEJv5IhaxkHC0j+HT1fYUFl8Dav67rk/L3eBybpSfo4K/ZiOepa507p+O2xP7FU15I2HVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299821; c=relaxed/simple;
	bh=WUawS9XNP8c3d2doKds4JvReeI2uvWaigDw2I6FJsCA=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB9gYud1HBeFiSjEP7uVLPWPALo5utoBPJTL9P2gwJRQhkURHlX3rxgkKXNnPbSOX1//YHIjJKs+V0jhGttDzgRkpEyDi073nQHra9VNQ2Do1GBkqw3kOxRkA3gc8n527t9/f5bJaY3ynim43rhN2HkRQc1K5f1P9R9ARdXI24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvwGu+w9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2320247f8f.2;
        Wed, 04 Dec 2024 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733299817; x=1733904617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ9eVjs+6mWlP9P3iqs25nJjg2fN1NzBMTr4VrGDn+M=;
        b=ZvwGu+w97RhJzu1tZ42tev8kvbF3g8gPu+SKZy4qZ91o6zT5MGAbTatZ1DNcs86kLk
         iWB8ZRV8yiCzlVjAT31r5dJDiEj2F94Bd36wGzrmkX9x4jO9JyjhQEBxov/PhJgM65eB
         Y34cJ5NuIh++C2XHU9RpGtMUsieOetWWVUS1dYwCVJKRJPPGahwk/WHarHVSqMjXN6Y3
         NngI8FIMDfqa0BDPK+ETzr0iQ6Y2vfwcGBWuTvVz7LPFLN54aYC4yDopo+cSdV9wAdH/
         G363ARtr/az/Ad7rogqkGhBxPq6hct6d5iqFnoZatuh6gXo9T5ooL9axAErwDGQGAS02
         X7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299817; x=1733904617;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ9eVjs+6mWlP9P3iqs25nJjg2fN1NzBMTr4VrGDn+M=;
        b=O1NleDtBR1kRvClBWaSy+8KMSATmxqJiDexCDheOcG5GTK8Cp4mIdhR85Of5tI9rzS
         xXC43QeaYKjWcvrLoO3G9xs/JmgLQuwRruDim9JdUneXZgUroSL5DdidOPO/WGtPh/+y
         afuZtJHvcrRdoTd1ONtgt+Xtm+3SkfU0nP9cB/2YBmGVGc8dUqSC6M1qm767S7cwf55q
         eVEC4SFg+cDHLHn8PcJGCvm9WdmMqEk9CgfhdsGnUwwtGQhTwOC7aZU0jxT8gDAiUTmG
         Omvd4aSrgbhwi94OflCwqMIPVHBIbif0pBko3unZCEsKCg9SiXIfy/BlJDUniMxGBd5g
         YneQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMxJ7M+XMMfRr2r19jieeBYGqZtsjVNEGAypuiG9mQhn/JvFyigaygcqT+NwTbwAjcLQz8rBfAAM36piSz@vger.kernel.org, AJvYcCUkgAGy8KWHAoqBM9CxMy2G8AqbMoDOt5oJoSiGe2MbXzwPiKQ9ot87aNKKJpt5uBZGQMsAXRsEsCI=@vger.kernel.org, AJvYcCUnPAwr4L9UQMcbMhXR6eO7BIlnH/zEbvl/hRCf01z1l7maOQXox9AoSUc8ky2fiFq405MuVHLJEKjH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vWEFqpdzmQDnEGn8b+Vd3f+nP9c1cv5+TGgnXZL2fa89CVYm
	KVFM/3PAKzOps/FPhlZp3D5oMvSwUlTnWMggioh4P9WqnBOJuaz9
X-Gm-Gg: ASbGncv2wkTywhPf898v4C6imGa85O9/Ho9gs6ncW0UN9xmpsJqSu8rMdv/RGgaVbwX
	AuKzTTsQZKLNx5Qwxr2KGQgFA2UW59k2KK+IQDKX0fkDFpVcVocRE+NJ60uskaO6LdGHlYKabN9
	I4cR/YYYrDeQAqGmlq+eNYbp8BwFgDI0NyqEYOPIlM2SFWMad+vO9f4fDYe5zIvMScge/ypr9xa
	QpQyFLogrhPfOsIeUetOOIt/BIM1k1C2KyjpU0uzWxX/cFkd8JGbD7AoDewnzNX5FJ2KICOm7x4
	EdxIvw==
X-Google-Smtp-Source: AGHT+IGBBdWdqXBu+yYRALH5lOzPQr7jM9OP9wfUJ4oAbtRRm/dgtKRMHATPNJWIY35eUMPcJapYPg==
X-Received: by 2002:a5d:47cc:0:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-38607ae5ee6mr2579229f8f.35.1733299816899;
        Wed, 04 Dec 2024 00:10:16 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b66ecsm15381865e9.39.2024.12.04.00.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:10:16 -0800 (PST)
Message-ID: <67500e68.050a0220.2f3736.2ccb@mx.google.com>
X-Google-Original-Message-ID: <Z1AOZQK-WAFKYiqj@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 09:10:13 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
References: <20241114211958.32137-1-ansuelsmth@gmail.com>
 <20241114211958.32137-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114211958.32137-2-ansuelsmth@gmail.com>

On Thu, Nov 14, 2024 at 10:19:19PM +0100, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor. This provide support for
> reading the CPU or SoC Package sensor and to setup trip points for hot
> and critical condition. An interrupt is fired to react on this and
> doesn't require passive poll to read the temperature.
> 
> The thermal regs provide a way to read the ADC value from an external
> register placed in the Chip SCU regs. Monitor will read this value and
> fire an interrupt if the trip condition configured is reached.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v4:
> - Handle offset and slope in priv driver
> Changes v3:
> - Handle thermal_zone_device moved in different header
> - Enable interrupt after thermal register
> - Use new way to provide slope and offset
> Changes v2:
> - Add missing Makefile and Kconfig entry (somehow not included in v1)
> - Sort include header
> - Add missing bitfield.h
> 
>  drivers/thermal/Kconfig          |   9 +
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/airoha_thermal.c | 480 +++++++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/thermal/airoha_thermal.c
> 

Hi Daniel,

sorry if I get annoying just to not lose track of this on my side,
I dropped the sysfs change and now it's handled in priv... Should be ok
now?

-- 
	Ansuel


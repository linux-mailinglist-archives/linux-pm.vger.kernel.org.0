Return-Path: <linux-pm+bounces-27083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B8EAB5985
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33B3863767
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D7245008;
	Tue, 13 May 2025 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJRoMkvT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E981CEE90
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152933; cv=none; b=Py5J6nGT9oaEImgGixmAEUjGgIElmzI22m8jfSHlObYtKtvIfOi0F9+hCBQa1MDLXyRAfioXBv1w3wjnGWocZ+ryw8nKOtxzgS6r4t2kCzqVnm7p16fezp3CoKZBAOLaupgr/ePAf1KjGBId8HUkpCWkLEj0tJxMxd0W/KKJRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152933; c=relaxed/simple;
	bh=ah8bSLd4n3ODXUTmfJPUlD1MUWxxPKMMuTRnrZTBgGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj4tCUtHbWeqcASQ87diIRVYUk4dqBuE358quh+IBqshgxsrAxU0B+Ezbqhnd5ni/FzmNTfEQ4CpPBvbtRtT/4t457YNbRpyizJCJARrQTikAkoEfyir5eqvMDUWIGGPSyZoKImjScMQuhIltFtyUEd+idUUMDtiTxLZG6wqsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJRoMkvT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-440685d6afcso64661385e9.0
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747152930; x=1747757730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23030sfZlYo4XXUwpy8Xijq/xitTfF3FnawkIR2T3C4=;
        b=HJRoMkvTtQHjsElk2TAMtlFlJNdjPGTCz4iQrGnuJpk1/s3NOnVI1PWY+gnrsHtd8Z
         K1uC/5R59GHINynvDzJm+f7ZGrPkocFjCVUHOaTB224XpVLDmqcnVeXC2P/j1AANfqkZ
         DoIfVobpsz9EwGOgDDehFRuukgiQgUEBaqPOH/XPrMX/ANapTgkr4gS6nGr8HyblXaAn
         G+CpqspSsywpgQM3KkYjw+motAh5ADrMajz9lthoMkP0dEHOFvpSOfr0CkeVvepevtP8
         +d2Gp2ht4jIEnrhR7RddERPBn54OfN8V3I1bKQRqyC3PEjZkFeJ5iLhY7PkXlPDCgZPR
         AGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747152930; x=1747757730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23030sfZlYo4XXUwpy8Xijq/xitTfF3FnawkIR2T3C4=;
        b=vfPgtvrP10ZbwEKpN4NFxFCr7YI6v8mGhpf1RUzDDouuB7NYBuoFEJ5BRdrHYRihmB
         kWeV9yVNj42aFrTDBOi1J1bTPEhxkTVfKk5+CSGqpdiWc6ju9+e3gOJs0vRBYt0pIkLx
         rAdoKhSZRStlYSW0bOQUfhDCkgIwYyG2jhBDA2tlUnyOGRNgec50vFoOeIFDR2RgabUH
         JuF78IjKRkbNtZu0AoGXrwvCrO3yLtJYGDkuR1igFhhtjv0WcjdqNEkTiKsH/GrJLkT1
         7WtlLYfV0l63YRIr5JMqp+x9Qq4vW1aWA+YpvOO4JD+/qG4m4gfHjr3HrqH0I/keiUdB
         2+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX3f14PLA5VFSEFkT6lR8U57tuTfGW33P2Q6X/5PJB/21XjyxWKTEehIuF8+n8ipIl32DT8yqL1Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9COtyphpB7w4d0B6kaWbjTw81+HmcSWi3bCuE0+0IS95XlzFF
	sKlZJ16TiJ0SbyxXZ9cqKe7VF5bkuPvP1u9wnn+aYzf6RgEbuhQu0vsilu0xojo=
X-Gm-Gg: ASbGncvnABqnTfem+YgwtljoxWI0haBnlVh85DjVtooo+jZOa8ntC4Iz++3m4MEZYs3
	xNlfDEfyaqbLLMVpawEPPspyO3YMYbAqn8k6g+5aSjOBC5YyaVXn0HD3gEI4QGauOdt5AZi/eVb
	fNWPJ/V7Rh5Be6ujKneyBfRO2N/Br92nwb1jUqR63KGU5L7AgVP+eAWMio60RN70skZn3K8nwnh
	n9bGgE4zukc6H1YTXMpcpg4mJ+pN4FaP0E/LcAY8AyxOuOXPtBw6YCjUXQ9zengwV65Cvefks5n
	oAkiCArYxiCfv1We2KDYExPYFbiBuqICuF2Y7UMiGx8h37zQpJ0mLuwFakgwrZTgXI/wYXO2YRP
	rcqp0LlAB9970dQ==
X-Google-Smtp-Source: AGHT+IE517qaNT/l4Wh33p0Dm3gFH8OKngeQCf2Udv2lzkZQNwRj+tloE1Jj35HueH2x5ewGA4LEHA==
X-Received: by 2002:a05:600c:37cd:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-442d6ddf676mr135234745e9.32.1747152929962;
        Tue, 13 May 2025 09:15:29 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6858566sm171835295e9.32.2025.05.13.09.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 09:15:29 -0700 (PDT)
Date: Tue, 13 May 2025 18:15:27 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
Message-ID: <aCNwHzqD0wC4yMUN@mai.linaro.org>
References: <20250511185003.3754495-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250511185003.3754495-1-ansuelsmth@gmail.com>

On Sun, May 11, 2025 at 08:49:54PM +0200, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor and monitor. This is a
> simple sensor for the CPU or SoC Package that provide thermal sensor and
> trip point for hot low and critical condition to fire interrupt and
> react on the abnormal state.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied, thanks!

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


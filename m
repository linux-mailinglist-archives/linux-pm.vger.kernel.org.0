Return-Path: <linux-pm+bounces-28150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C9ACF007
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3900E171587
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE822A813;
	Thu,  5 Jun 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnXXfc6W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302A221FC9
	for <linux-pm@vger.kernel.org>; Thu,  5 Jun 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129054; cv=none; b=HmvGnVXs2ngkxI+dpljstLgk5KMV+ychBEzYUtNicH6cAnFD3dnoKjHwYfU5Ss9av9nK+Ye/C41nwyxUkRUIPXBtSC+dcJjphokkyNcY1+JvTADE8CaT3OluU+Yo3DJiKF9LdbjpuTV7hT4Vj7QfP466B/tsJwqIZa4VeJ1OVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129054; c=relaxed/simple;
	bh=lNhfQTAqbTsru8r+Bj0ZAPYYt9rhG4GCErgMWfLnbw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFVAQPw68KXelxMcfpuISb0pTbPircbglAtV/VWaV3V2G3SGaKkr+JFld99846b/WivbVO658SUOFYMzlwmWtDp1EONGxEq5vHdX6jiQ46nvA/zz2u1cHfNIt9aRybkZKBbOXDR7zE5dY4Y+v2rQKUzb2nC+XsIVFDrehCNNQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnXXfc6W; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-407aaace4daso472380b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2025 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749129050; x=1749733850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lNhfQTAqbTsru8r+Bj0ZAPYYt9rhG4GCErgMWfLnbw0=;
        b=tnXXfc6WHX25aRQ/3/Im2CpCyx9Sv3BhxkTLY0xQSl+ZnPHbpkIXeBA1AoZurvjoeg
         r7ZoYd/typs0TcrycejMQI3NaY8JIfjVKN+tZ6Jxc+oOURrHLocAMAmY/setSyLoKgRf
         bkwj4MXvlFtmgqZsZHPEZO0HZP2wrvEoyXEXOzfQ+bmrsEsYQeasNaZVK8BayPE5Rzlv
         jUtBLx4d5h1RRGr80K1d8gCqZqnJKfaiP6RgiTUzz6nTJqxmEYONZCctakbt6+0PhX82
         7GeLSuVSw70qa8AcyrrQ9nirCg6XOkNmxtOqrEv5bSMZi+bLQbsM4rX1ds+iOwdrrpI2
         Y4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749129050; x=1749733850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNhfQTAqbTsru8r+Bj0ZAPYYt9rhG4GCErgMWfLnbw0=;
        b=iWHD7rRfIS98yEFf2+2DhIsJvhpq2e61rLGO2+/XDGrAQXdESOnUSf/ljzYbMT2aMF
         S4a5ZybUou/fUlE/we7/FHciTmKLlv5CoP02Hoy5qdyr7dODa26HLxte2TTBNtufvu93
         Ea3ctuBCAzdDhn+vXhU5HndS/sVU1JUM6TifVRIVeVGCV4blKr71tHxE3ScqH7wNW1C4
         RgfQEfNwnDg4sjXmS31hp/eoXf7M0RAtV9tsBHi9eoxEQLk+r38Uf+fp8ZnnceUJ9bMt
         +uEjDrrMMIpB+LsDMJ4GiOpWFA+rdKjKvwW9RbNLDUhpxNpz86ODV+Jb4rhipYd6shRn
         5Qhw==
X-Forwarded-Encrypted: i=1; AJvYcCVqx7DMLyUjCCqqtMwAx+pkOVWYWZv8suuFQoEcSVgXjfyF7pZF1bWGZGZc8ce6F2aheEpIeGQ+Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5Pk1+vA3tHb2i7xUvISJWuWuDIYFuX1lJqLIBcWQ0VwFIFYZ
	eE72uCB6fhXQRCN7Oj6tQSgTrDKlVJYQPiTtxAiFTUYR8LSMZI5rOYvYEZ/OwnQ7QBSkeBN3xIm
	5JepHbqiTDd88iTUcXQ9mr/tBjz6DbwshfeEXWxb6RA==
X-Gm-Gg: ASbGncuvJhoJGs/ilpQjbHcp9dfFOGv4wYMVVOXAdo4gQwaHJXE0h+EeCcomspNaH9q
	F+QrN4Ws3LM5deppWc+8ESlfjokrR25/AeqMw67aWM3SK5Ya3v5TnfpoMACDDDup399iky0R+A7
	rXK3CX9XscNu65A99npIGDVTwI9FD1inkA+eer7HvZOhuniQ==
X-Google-Smtp-Source: AGHT+IGvvIIAi7Jeo7wCUNfCk7jSkX+GkLuOK4ORo6xtJdT9aBnzQchoGj+e4GjQ+z6dMP38d8jOt2O6RhX124Z/rG0=
X-Received: by 2002:a05:6808:80b4:b0:406:d4d2:ac06 with SMTP id
 5614622812f47-408f0ebf570mr5092773b6e.9.1749129050369; Thu, 05 Jun 2025
 06:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be> <20250523-b4-gs101_max77759_fg-v4-4-b49904e35a34@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-4-b49904e35a34@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 5 Jun 2025 14:10:38 +0100
X-Gm-Features: AX0GCFudWa3xhzs7XGXYYVHqIxskkw2POUeo_WNLoTByWb5TUaRlQJJrMo-9pQw
Message-ID: <CADrjBPq67xtfWNY7GZAa3uJeGs4Svt940hW_X2Xxx3Pb7ZY6uw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: defconfig: enable Maxim max1720x driver
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 23 May 2025 at 13:52, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> Enable the Maxim MAX1720x as it is used by the gs101-oriole
> (Google Pixel 6) board.
>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>


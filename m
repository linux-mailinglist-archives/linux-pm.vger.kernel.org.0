Return-Path: <linux-pm+bounces-21624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55EA2E3AC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5CA3A3CC1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB11581E1;
	Mon, 10 Feb 2025 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOmw5Tat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94F168DA;
	Mon, 10 Feb 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165617; cv=none; b=ciiQRPfcwvXmal60HCyIpu+fqXDax6JNP9HXtuSdmyadZcwPI1WpGkgRxJBb7RcdmMe2WxFvZwI2J+zDkcu2EMx3/o7VikWMReVNih4E4AUfM/RSjnXBSIWMw1iaMAAxe+ipsFfv7We+csmiVDuF99hmW7/TT46QrdsECXQW+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165617; c=relaxed/simple;
	bh=BwJR/EZwNEsC8VKwj5lIILIBNa8OeA5xqpRWM56IWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4BuvySLDCeroYMaPVY9MafoQQYEEC5feQo9RGlnyi57qrQgumXvi2Ce+Butlynupv6wDAAaqtEAK6O03vCJmFOJIVzcROotCXKbMILSnEMyJYFE31b9pZbgHu//i183ACjme2aIvnaURrv/vPUOL0e0tjOp6a03IrEMwGgdTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOmw5Tat; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e451fdcae2so14966326d6.1;
        Sun, 09 Feb 2025 21:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739165615; x=1739770415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcxcTXxA+rFMlTOa3pgLfmdjd6Gb7RSOSP8Ix0+TbY4=;
        b=MOmw5TataGH8nzOAY6hfWSNfH2YimPiuGrim29C/ALqv/mpz88eqNcRurKaaIL90Kf
         jGMhQO3SNghi4XO/VfnuqWvM9gWzsNh+Zaxhapoxpq07rRleeFnKY9SxIuSGGK9ZsRwo
         ht5EPbY5nRY64jQoRS577+650vPJOoxrURKVxv1bqHwGJQAri+8j8yZjcubj313DCB+v
         1+mwzJ7kWJdSTSQHYPTTfuGRjhQh9FGqpOX36PXQ0EPMBNTN4fUHcXMda677cSQwLHni
         aPl5br/E8W1MHzRVPX5MDkrVK4leBcU1BuN/8J5p/6RoD6oe35DnDFRW5YHzP2FvP4Dr
         awsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739165615; x=1739770415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcxcTXxA+rFMlTOa3pgLfmdjd6Gb7RSOSP8Ix0+TbY4=;
        b=tvGCFEpmi1W5CBxdQdK1u4uWRbZu9WasHMbBYrHvG+Ia6U8YU6cSDc/dUWbIre5Sig
         HMSHF6KLxJ7hWLRq7q2KbVaG+wXUPmWbSco7/aCk0Ryv+lvkuALE9OQS5T9+N4mkH+e7
         RfB7dA/sEfz+UhFRQIssbUDC2D0gytvNHyHu9Aa30t/HjLRPWkXFP/F10cvz67rxFGab
         vX17cQC1eA6fyTpQcAJDdIg0EJUb2XynEgz+s0kRWojRYZN3WY5Os0ligTcoHo4sNpkp
         YRHIr+PiKiZyTy00Vf1Gfax2Qg9bal/tiy+yCQRNnls1fBfMLhP3XMdOdqF2NUDnP336
         dKAw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjnYU/b0+zKriKredUiprIOLd43nwa/v1RNO2YOaQ100LiqT5v3smbH2Wb4GWrvPrwTthWq3yNfw=@vger.kernel.org, AJvYcCXOXxrvLGHE/RnBJp3itP3j7GSrmXuJ1oeamrpwpazxug0T0dRnbOlAwkXc1TRckQydQeE2GyqcNNEM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx379K+Wm6Z3KbfKzyDVcV1uMdnegEdnBhwufMQ/ZhKcw9SrB2Z
	1a9BjZlbn3+kp9BEpxiaLtoZUL7uxtZDAPvVELSKzH9MGrrAhd0F
X-Gm-Gg: ASbGncv/5plCpq7LUU13zbBvgXkaGy7CWX9Xxrms0Mtn0UHfZ6Wy28F/mjul4GUFKFl
	dPp6iO3yqU4Z3G6uk7+LOhUp5PVkPgpUsRPDdMZwcL1ZNGVguJ5d4TQjCATL2JOmQYLM5L1Jnng
	yKfA3UEP32VOlVzX5tJ0MLl1BWWGN6SBz4wgsXdFblGV+5aXfBob3ncxsxkpEWHtf0vbpEABjpO
	0Zp6Z6SWXb38ExUfaNzqaCE9Xpfv/XYIS+fXz5pl11bukPf5k1nudJC409bW2txzOE=
X-Google-Smtp-Source: AGHT+IHOrT53o+O66ja4z7uaRdoPjEYG77YMak440BC7vH/+FiPz/BQZLFVDeZD1BTKSAYp8R+3oaQ==
X-Received: by 2002:a05:6214:194d:b0:6d8:a258:68bb with SMTP id 6a1803df08f44-6e4455d8759mr131696556d6.6.1739165614939;
        Sun, 09 Feb 2025 21:33:34 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e448819f8asm32926166d6.121.2025.02.09.21.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:33:34 -0800 (PST)
Date: Mon, 10 Feb 2025 13:33:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	Haylen Chu <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
Message-ID: <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>

> It would probably make sense that the whole series would go into SOC tree,
> even though technically nothing prevents the reboot/reset driver to come
> in PM/reset tree. If everything would come together, `reboot` command would
> work out of the box.
> 
> [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> 

This reboot implentment across the RTC and 8051 domain, which is
still a big problem to be upstreamed. This should be designed 
carefully and needs further discussion. Adding these two syscon
compatiable may be not a good idea and cause some problem. I invite
Yixun to this talk and he may give some useful suggestions.

At last, I prefer this goes to an separate patch series, and
implement with rtc device.

Regards,
Inochi


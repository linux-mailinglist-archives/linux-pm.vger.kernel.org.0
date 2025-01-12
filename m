Return-Path: <linux-pm+bounces-20285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69297A0A9CA
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54198166F3E
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18B1B6CF9;
	Sun, 12 Jan 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER51TUJp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2613191F6C;
	Sun, 12 Jan 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689454; cv=none; b=pTSUZvWXKlIrd4Swk+fnWE5da7K6mNfCYFmHeDEfSJ5tkBGBA/pJ4ReKL0wuYyQu88/BI9JdGHnd5KdOQhnw1yAB8qWGscmQxfMrijw4pG994tREdxw+tiWDuCyniw7qxwYfvWLUVeMAhmpQFmd8vN3TyVwONqnYJBxI5/fyYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689454; c=relaxed/simple;
	bh=/rMLW05jq4cUDUm1thCPJqxqvpmxmRyRSu/ZYqYrerU=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl+fjfroAq0pnHr+tIBypUywSpVICwHvIIv8GUr6JRX+p++GQFAsZ9yXmoSRETKN9UJCPnsOn3TklwV/VYB3OLxqxLm75vCWl4gaYSFGKwgnM4SH16QcMPqEZqzsqEL8JX1bdet9mSja59c54uy/6Rzmk5MnHQV1PltwXMZdAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER51TUJp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso6310652a12.0;
        Sun, 12 Jan 2025 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736689451; x=1737294251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EPgX5NsNbtvZ/N2NUTg4lI1LcSTBn2a3Mrtrofd3QVY=;
        b=ER51TUJpCqsv/I/6Tl9WrUMV7TdFS8PEyEvz8c5Qolkb6EcoZGfQm2+pVbMajBL+gB
         h5zgF/zijw9WmS6K/Cia4IOW8pYZxgoYlPJ6dGV1zeAeunE+0vxig0I9p90kfbJw/Cuj
         nTgQlCDIS5FrcO8Dv/TwpOfh3HERYd3lYGy/vmSNM2GhigPOFejlM8QQtYggpsiZM/Z2
         2ZVW8m2iFssaDTQ7gI0lEacNpoap8MaX7qEpnHC13m1NSWUD2owWvAJEvPVh+x5DtEVI
         jA3CEvAJ6ZKXNX5WM0Yy0+hvsWmgZlnesvVhrYXNoDaa67mSx/ztfgWQnRTbm3+n16JJ
         Y1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689451; x=1737294251;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPgX5NsNbtvZ/N2NUTg4lI1LcSTBn2a3Mrtrofd3QVY=;
        b=RUFCxD7VwawNZ2aTGmSXM6iuP45d8sWJJ51jkvtLN425J9jLdkQ/9eNyuiOeY1gMB/
         W7fP5QpdMCnLvg2zrmaCvwFdT0xc2uQId4SCQs07MzasIHujLYUn/m7sZmdiOAN9llHU
         Ig1CJPUQe43Q5zVHekKpwkCtknDdsv1XFzfHp9Kytslop2dOsBw2+prOeBT4+IiSdnSX
         PQP0FxGg8uq0DZRKpjl7CTfMXrI7DKR2salaUfRS0x2g4W4nMZVh52PjrUo6xzT3NscN
         BYDqpRto5m1BpfRZbIOIJBzkB9PYaBss/fy41uNtur7mzczyHgwu97pqDc5OMfk4REmg
         AAfw==
X-Forwarded-Encrypted: i=1; AJvYcCU0x+EIpe53dn+v7rXgaeycwo61hTURc+UwagBWwmgZjfyLt7x/Z8z1N7OhgMModjvHRJyX5Nfwl2wZxwl3@vger.kernel.org, AJvYcCXlv7c3ydwgpiAjm0qeh02wxOqM2TrHk4XHlYPZEOde2nmzBy4HwDnb9eS5NoPW6RWcSAjcJ10NHirn@vger.kernel.org, AJvYcCXuXa9/3INpEDQ60kbsdtTGnuFLtHqw/EfdXNy48+3JJYGHlc4VrinlePdC4D5lP+LIxUQpz/ergvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXCsDjNYH22vBAlogjT356jkyOE4GCnoZJbVFE7mGOS5Nvc6r
	UoJI0xmq3xnrLZFXMLeJeZ68uJc9RvxGrNimLR5E4NE6KAGgg18F
X-Gm-Gg: ASbGncuFdEBvD3up438olt2ZSUIoAF8SWcVu02ZZQMlUbYRRiqYXqqqZWycbNMws4Gt
	n21yC+rsuHQirvbG9uRO9J12UMVLdaQmD0g2MfXJJQU+81JvroxiUHaDw/L8gOA9VLOLEqSR9t0
	R9d9FfXNd6WgkHWVtwYrArCqyeBtFjlAKtiUvXyQcROdgpA/UGkRhhSa2dF0RHsKfd4NbBp99XF
	M9YJjFiAy2BaTikuiECK4zd0RL5RT4WKnXmnM0kVtKqMqs5t81Rg0N3tA==
X-Google-Smtp-Source: AGHT+IHcM7d6rqd8ThEuy8RduLXWP8Hm1lawoW8DILwbk0y864WVSg6CxWXiD3njvv5YX+O+CXe9vQ==
X-Received: by 2002:a05:6402:2345:b0:5d0:7a0b:b45f with SMTP id 4fb4d7f45d1cf-5d98620928emr12656825a12.10.1736689450829;
        Sun, 12 Jan 2025 05:44:10 -0800 (PST)
Received: from Ansuel-XPS. ([109.52.222.172])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4400sm3741062a12.52.2025.01.12.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:44:09 -0800 (PST)
Message-ID: <6783c729.500a0220.2cbf1.ef5e@mx.google.com>
X-Google-Original-Message-ID: <Z4PHJUenJpr5e2Y4@Ansuel-XPS.>
Date: Sun, 12 Jan 2025 14:44:05 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [RESEND PATCH v4 2/2] thermal: Add support for Airoha EN7581
 thermal sensor
References: <20241218073016.2200-1-ansuelsmth@gmail.com>
 <20241218073016.2200-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218073016.2200-2-ansuelsmth@gmail.com>

On Wed, Dec 18, 2024 at 08:29:57AM +0100, Christian Marangi wrote:
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

Any news for this?



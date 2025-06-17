Return-Path: <linux-pm+bounces-28927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2BADDEAC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 00:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61347189C191
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A929550C;
	Tue, 17 Jun 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGXaYPTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73132951CA;
	Tue, 17 Jun 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198991; cv=none; b=eUGyfteRsPhPN7L1hTQQu/qEcN5X0fqEyH4XgdVLeSXCOdGv6Q0Xk3Gqdyt54DM3/eMzU+4aAM8ZSW96LEhVUlXeYLpPc0Pke4hdq0UqTr99yjl95zHPWOgiZ7embnZB+gTkViqNIsajy7VM6uoc+gewRahw1IewANc8/9zGlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198991; c=relaxed/simple;
	bh=kz2nXruoOT+8n1Te4FqDwPlaM62tv+vpn008cqwOM8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZQRIVh3frLu+B/nE0KvDl6eGx691fNxUb/kwmCzA1f0lhHpaqqNa/kDu2PsXPykv0GD1LEbrmnnynW+5UorL7VTHJI7d3surNg+ZpFEEKIKRPobj5nezh6KkN9SQtNUdn6DJNG3LrPkD0XLQFrNdmvEKbUoA2+vhk/ctE0zIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGXaYPTm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748cd3c8829so1049214b3a.2;
        Tue, 17 Jun 2025 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750198989; x=1750803789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba9cyjWK9a5gtS/G1pUFwvKLF+g6GdyoidJ+9RnzRZo=;
        b=OGXaYPTmdJvyEow3zqrrsrVzhmbmHbGsYQQ5vWhUzu6AEw3u79UDM29UUwi6zDSNiv
         MmoheKqpMh0phV9314nlJfe+/uC+Df4Jk72VwmoTftBMk2Syi0+P5ENJNF6MtzN4lPZH
         MCx5HKmC6ICMbLsv6QrOTAFGhwxmOer8gCVwa7iHaUdDVhgP8JlwxwRoEZxXXD8FKGfG
         nuoogAEmSHT6SshXekLw3GgkfIZSTLxejJDnqgoAxxidMlaoWQBHkXRz3EUKyKOGgn4z
         7X7VjUNVjVYPoe+lAyqKghjNmCzTKFP1bXh4W7B0d6t1TkNEpLg9KfykTHjsuyiENj/g
         pf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198989; x=1750803789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba9cyjWK9a5gtS/G1pUFwvKLF+g6GdyoidJ+9RnzRZo=;
        b=pikFatr1NQpqv4pZdId7S2mStHV8mnf8mrnIcr8QE2imAOy54z97Awgm4O4ctHJf21
         +1z8PSFnUI9v2QmwBU4Ermpwnhv2ulUsmt3+d720d/0EMEonT00kGT7XxXB+zkZlUg3G
         mSOuVxBfq65izcJvMKzWhzrynFSK/WTquutTAsonRaXCxy0aANI740gO2mEL6SAih8yT
         iRM4X767Se8nYbXqxIJBAmNy63OmOd1Zab4lHlCRBHqN00jxITPU+AJk5+P9/U5vJEft
         PxbLkpOFN898UItK2DhbkPPQvzWkrmmVZmHdbi+JdDRdSUkVPeS1ByaA9j/Jts1psw1W
         OncA==
X-Forwarded-Encrypted: i=1; AJvYcCUIiW1OfGgOxLvkawAJzX5Ue1osWUQy1v9PdtobpiexN8SVKKbB+0b0k3/yVEH8VvfMvwFv9hQo0Ntt@vger.kernel.org, AJvYcCUO2D4JPpbBpoFs/RKMljo+G95RcIHxUAZLCD05opcVLTL53869jCOs2DuYucXMRtmriLdY8tItpJfpY1/X@vger.kernel.org, AJvYcCXpkmKOVDzbbsivUVWJPwWox47uLBFhP0q3v65J+BjQ8yaL4AxQUg+eTTJAUldLCRcR5lrW1fZMUiI=@vger.kernel.org, AJvYcCXzCC+HH1qGL83iE7AQtvoTbOADh/u87t2I+pYiiml+zMs7WpMIDsfysU4nw0sJQE2oXOGXI+ge5t1OrQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiGDt9p22yoVEOf6vKkuNBtrERZAWWfpYpvnnGA1Hyx1aSAop
	RCZW2QpbSkWVNnZyo01k5SfuoH1jpva6Yl/wQnRxLCKe9frnnFFXqeXP
X-Gm-Gg: ASbGncv7ikYOjkK2/x4RcM24nZ+qN1+mICEKZ0DAytkVyyi65EdflFcnkBekf4vxwoJ
	mR9p6j2FYS+kdP1SuV15NKRcKaFkxnpkMvmToRJSQYK7EnlAQAk2poiC3QN/GeoZJzpxiiTZVju
	c4kBdtccCFjJ+eXb3/AY0Tz/2lJBqU1n0Ei287AzlcWWqigTg9cOBHmc2fidqIcFicDbLSbiQWf
	6K2XE53eSeDEoRlsYxg7qbjrMPH+d4pSl6J8TNwp10pNDr7LBylX4YXXMOD93ilFlrXMj614MZx
	c8IPQn+reIewBzfNAnPUY28JPWa9zYebarm2XnaxqfasFJ5Jv5QgZPYZmIj/d0E=
X-Google-Smtp-Source: AGHT+IE6oCWcEIA9hAHCoer2+7IQhN18TAtn+EtjnVuvExVsZnZ1yzO0ig6GCb71zYvYy290rTKOoQ==
X-Received: by 2002:a05:6a00:1787:b0:748:1bac:aff9 with SMTP id d2e1a72fcca58-7489cfc7ed0mr20839980b3a.18.1750198988866;
        Tue, 17 Jun 2025 15:23:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4cd9:8b8e:24cd:5a36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b0bfasm9434791b3a.122.2025.06.17.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 15:23:08 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:23:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 4/6] input: pf1550: add onkey support
Message-ID: <5eehb37ccuoafc6x2axbgesr3mweeepoco46ih2hs2ncekch4v@ku25pypnlads>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-4-0e393b0f45d7@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-pf1550-v7-4-0e393b0f45d7@savoirfairelinux.com>

On Thu, Jun 12, 2025 at 10:55:46AM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add support for the onkey of the pf1550 PMIC.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you for making the changes.

-- 
Dmitry


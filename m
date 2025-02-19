Return-Path: <linux-pm+bounces-22406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E509A3BAC8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B63A3A1CC0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C71C175A;
	Wed, 19 Feb 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUATjFqP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2E1B4F21;
	Wed, 19 Feb 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958211; cv=none; b=k5Mnr82cAcD2T9JE8ZWmnL92DC2oHMYm4nKUeYcGUQGc0NqSxeIUeHVO4jZOWDW4qMw5JtT8GMtXvFc0t3Q23ZacvcVfTbw2pZnPDAmy24iXskp/vtkfaE2zWggYqjvYmu1GXUO0yqi8AkXmE93NjiUnoc8csjPkSgtKxuCQGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958211; c=relaxed/simple;
	bh=JbQfZE+vLsay+m41W/xExMvsph46lPBJtYHfkRyAxdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh3pcf5buM7CrvEftLPQQIWHoNlkEAXBnIGBWGsKd6/VdIHHHKREpLBApm4YHP31BTEKX6+Ke1FzVFXH60CEdgGUFUzGQ2FzYpuAjOZo4GMKx5kCO1vfzNKBVv8PdTiFLIYBbrtCQMjljkt544F4Q08Ie+pqyWVLRSCd1flz8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUATjFqP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4419a47887so4845296276.0;
        Wed, 19 Feb 2025 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739958209; x=1740563009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbQfZE+vLsay+m41W/xExMvsph46lPBJtYHfkRyAxdw=;
        b=CUATjFqPhA43PvcqgI8KA79AiKj96IUELf7ndyZJWe+gD/y7uQ1vsQCexotvMEoopZ
         OF4d9jXLaTFtsBwRpGrDH5TLieLmg/zW8foM4+MP26kn+nYhHbk5fkWacDoTYWwv+Nwl
         wvHkWlefOY0mUGh6mg0QGFSYL/AxRCUvom8BblVQ19o3PzmI3SluDqlpPN4l/Pa0nuFz
         YOdg/PTbyst2Qf+wEzjfI6EA1ACCRDi2Ruvg1DpLqmtlSXF7sJOArkLkFmRjmhjC7yeI
         6eZU4zZlv/MFoTYhvFsIPhgfM1XXBLCcOFRvbieVt3JV8SLSA/k/UztDmHeXl88rBMBx
         DNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958209; x=1740563009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbQfZE+vLsay+m41W/xExMvsph46lPBJtYHfkRyAxdw=;
        b=sUkWwhjJRwzvZQ2ZfLy8A5kVbRWFBNmB43YKPONkJb8fqJLWIqMjwNptQvJiO2NlSu
         1A/YzCbgxYFlLMED//e1t6xM9fK4RMCSRUHS2nX56TseC6Tm+q5B+LGh61KyJS4i7D22
         apI5KMKDF5jXhmUvwArM/8dJITdAT+ZObxwBedikfBR/SBAolZLfdW92Vlv7X+HbBLBV
         Q8y+u0k6DA7gu7B04pUtBf5K6E9tRgKZq2NIJ036WcvGt3kXVdR6a+/dm/5JBsABVQuK
         hh7Jmr+7m5rvoQlxzZTGAgUQ9/dvVLQTniDDvdBDgYhhF8ABmIr50QcCfIXn8wm1Ro+l
         Nqpg==
X-Forwarded-Encrypted: i=1; AJvYcCV2a+luLmQg1Q3eqd3mZkke27Y8mDAapoQnCuIY7bCGAzwK4z0yd/CvJekgSa7x90t525UwZWgalLY=@vger.kernel.org, AJvYcCWn6tNUsb7DZAacG3x8ZpSZqDwRHLAEdZxthzyN5RgunaGnlPWkOzS9OKKgs9WECp7njSewSeg2jti1@vger.kernel.org, AJvYcCX0LSE9h3t8z08jCC03K8BVl3aJnQD33tN38BA7sMhgSlkfIURNdsQtnB5/X8XeKYY69Swp7oYLX2zjLCU=@vger.kernel.org, AJvYcCX5ei3+qQBOyd5gen1IHX6sll7fg6wEs6f/s0K07n8rjuKzTHp2nqKfcddp7sDBjiygrFeY14dTlGwqXEpG@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0gQ4qPVrIM0E763ZfDVXFlpS6A2yOWe9gkvGoMpdUcx8TTCQ
	p4Bjziryxs7qYNsJ2vm741S2DfW6U1SfO//+9sYqbISCbJqVXPvXAMNI9+jIqLTBDAfjwdrh2LN
	UwfM9ZsB647+dSlI5tlPZAs+8OCc=
X-Gm-Gg: ASbGncudIUXCQyq+r9E5NHMkC6NlRbQkg5gRh2fy84H2Pc9NmKOi9jp8kWmCezGvbeL
	PAEfwmM8iz2HS8sAzNhxlOIAR46t1TBopStrsmTqoMRhSm9n6LMjQWI72ykn10W7lOQOWqEYeLg
	==
X-Google-Smtp-Source: AGHT+IF4fhS5ToYgiyprNptli3rl/YWe/Sr8AbYoBe7Xa+PURKeBJb7TRkFTdB3HeJfB6d1BuGRjs+ziA08+lfNk/74=
X-Received: by 2002:a05:6902:1509:b0:e5b:1453:d2e4 with SMTP id
 3f1490d57ef6-e5e0a09dcb1mr2433065276.11.1739958208906; Wed, 19 Feb 2025
 01:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com> <20250219-isp-v1-1-6d3e89b67c31@gmail.com>
 <400d64ed-670a-4297-b43b-cdf4e8599c7b@kernel.org>
In-Reply-To: <400d64ed-670a-4297-b43b-cdf4e8599c7b@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 19 Feb 2025 10:43:17 +0100
X-Gm-Features: AWEUYZngFT_TlGtzAp7eDIc5jUmixD2xinxUmQy_lSABzD_u61AwBZNq6Cj2sCI
Message-ID: <CAMT+MTSb2gdkfCZE3i+0ah8AgE_G8mH2MFTms=QgFwd-nbA8Ag@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: apple,pmgr-pwrstate: Add
 force-{disable,reset} properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 10:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 19/02/2025 10:26, Sasha Finkelstein via B4 Relay wrote:
> > From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> >
> > Add properties to set disable/reset bits when powering down
> > certain domains
>
>
> Please explain why and what problem are you solving. This looks too
> close to SW policy or really arbitrary choice. Background would be useful.

The ISP block has some weird requirements where some of it's power domains
will not power down correctly without using the "force disable" or "force reset"
pmgr feature. Basically a hardware quirk.


Return-Path: <linux-pm+bounces-22743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E352A40D71
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236863BE978
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243DE202C21;
	Sun, 23 Feb 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="belt4/y7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DB1F8EEC;
	Sun, 23 Feb 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300524; cv=none; b=p0DuWToslmvx95Yc4GZEEWVLbOuT3Warkj7n2Cu+DZnAL0XvJ37Vnv/R58WwE53NHuzdxmwYbkFvAVOIIDfrTrVuTiy07+nohHaQLDlxPWpd0Pwvok98FwtFkX1QMVf6NKsnPs6EPSoQkdn5u94fPRtkz2fI3I/GsGQZZJVttE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300524; c=relaxed/simple;
	bh=2Uh0N6lbwnpYOuoTtrElbf/WhtpOMy65yWBJHigR/YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXex8T63rxKzcDhYfipxJdfXdMEbMO/NVlCDzKTFv1xsZSg8IQGTTn5nx+VZufyhCP6uU8jY0iDZbVF576lfRz50h0/zukcxCLuhkIEYnGWIUqKwMPCu0+adfKpiMtGtamT8zF+99zfjvpt9iDmB9xBY1dTg0stFKsDWc5k0dPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=belt4/y7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so2465515276.3;
        Sun, 23 Feb 2025 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740300521; x=1740905321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRNAVvYYeCRwQ3a1xM+1m/wJzn5pqIvsuHf0zaTzy2U=;
        b=belt4/y7wmusp5l3dhR4DTtFXnCkYIwKk61V5qAaemidX7kUA9TRCte+IY2oagp1o0
         s4PbACOrjg6gRguMXxZZGBxNkDrpAEFHJYbf0v+HJzcfcjbXTX5b3D8cZt/w7bES+feh
         jE7jZKewTZu+IdR4zy94W2ib4jFFr7AWSwKnYw0CnJ6IDpG8p8Lwm9nG6lDD5jDJJKry
         z+ukIKeh9GNhZ5zlQQ5z6j46CefCcB9goilmFQ2u4rYx4OKZbdneeI8zRT/N5t/BBSsh
         T25lZSX+fADCLUDyOkqkZ1IVxpHgxM4gnUk2cFPaW2gnNv5+wnlc7QKgAgebLuMvu/U8
         WMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300521; x=1740905321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRNAVvYYeCRwQ3a1xM+1m/wJzn5pqIvsuHf0zaTzy2U=;
        b=rIYRJLDEsIS8MY/SI0+vryd9oCAbBrLXUm1w8ckkUwWGohgINfrsI3ofjPB4+rGcnp
         byEIN7Lk76/6zddYCNVSSi7crKyUB3R5m2RlyDlHY0JJAi583B56AMG6v9yZdGnbd9/r
         l9/3Tk+gUZj4RbJ/BIGkT2K4H96CYC9C2A8stS5GfLJN5xft8A9Xsk0EqpGfMFlUIUIy
         Jot/E/lTx2yOkcHbrxcWXJElU+XazV16JLyQog2XlyRulm6Su5Rjgp9WKDt6ArfuIXZL
         t3xfzRBTRHesYxmG2boB284Apm0VWyZeY6XGtstrIqCZpDNx7hA1WIt18Isnu+VKdepD
         fJUw==
X-Forwarded-Encrypted: i=1; AJvYcCV4GHATYW9WVFrIzgLQ6Fp3n60oiIuzEo210J3w6dnMjwnvG61aXssQyKLg/zRZmoet0QxaBfR7ig+t@vger.kernel.org, AJvYcCVV97x62r9VbpN3pe9zot2JfsxSpiawhudQYmLXs/ZbsgZCfKeIi4uGoi0v95dmsS4yhXxf/Gtsqx8=@vger.kernel.org, AJvYcCViv7zGnUL8mnHvH7AbAgEN4PdIYrdfFmvmecdir/+wfNl2ZWALkHIkK6YHz5Z6zscJ4bI3cOtFHuhA8Y8=@vger.kernel.org, AJvYcCXrtNmeV99rijaVwzBLJiL7xSBxhsLnv9DswV7nuBnN+6tz0GA2+pVwQw2zhBm4OsW6vhOzJVQBQuvDwn+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwDc+EDtCfRHxGuxp1JlUHHplajH+dVchD5FbZaSI3Yys7me6TU
	I62RkfDEw/wwXSZ0TolmcZIRf1HlHl30/XLaSip71MPk2HsGkABc+GB2plJ1vVGrBFwrchsL+/1
	rW/6XlUWGtcP8vIU0JOyNKCxymU4=
X-Gm-Gg: ASbGncvm+Fz39XzYOWyrdo4QiXZlKoQBsAOYlZZg2hwzQ2GSUFRpMVPac5XqfHJF2OZ
	GoxI2DFRD5k0GpknFashOTDfB+yCUthG3I927dBkRh6DtZQGuz5osFlrGk0QRoi/IfIbGit81Cn
	kppQ/rh6N+
X-Google-Smtp-Source: AGHT+IHb12XReeyoJDdKwjTiybo5Sj6fWeU+stjIr25RfUjMsbR/05GXSFVxnSxTw+cp3RjuECFwksFzSO61LWq7Pjs=
X-Received: by 2002:a05:6902:200b:b0:e5e:1389:cb40 with SMTP id
 3f1490d57ef6-e5e245e7139mr6807165276.13.1740300521431; Sun, 23 Feb 2025
 00:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com> <20250219-isp-v1-4-6d3e89b67c31@gmail.com>
 <20250219113422.GA26386@robin.jannau.net>
In-Reply-To: <20250219113422.GA26386@robin.jannau.net>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Sun, 23 Feb 2025 09:48:30 +0100
X-Gm-Features: AWEUYZlT7UA0f04bSLad26HmgfbyXA2dYAU1yBLaWwGCtq5yfIfuPEY4zNm_Co4
Message-ID: <CAMT+MTR4yPzC-NBLT6uLhveHFDWpwwn=hUzU6=WDc73+UVEMwQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] media: apple: Add Apple ISP driver
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, imx@lists.linux.dev, Eileen Yoon <eyn@gmx.com>, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 12:34, Janne Grunau <j@jannau.net> wrote:
> > +     while (maps < end) {
> > +             maps++;
> > +             maps = of_translate_dma_region(dev->of_node, maps, &heap_base,
> > +                                            &heap_size);
> > +     }
>
> The hand-rolled reserved memory parsing looks like it can be replaced
> with of_iommu_get_resv_region();

I have looked into it, and `of_iommu_get_resv_region` does the wrong
thing. We fill out `reg`, and it grabs that instead of `iommu-addresses`.


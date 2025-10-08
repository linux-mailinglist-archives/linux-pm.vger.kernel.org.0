Return-Path: <linux-pm+bounces-35817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFA5BC541F
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8693A8F23
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB43286408;
	Wed,  8 Oct 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKNGTE95"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9D2586C5
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931283; cv=none; b=tGDUjpi5UX5f0kzT4HZM8QElsCFdH2s/PjzFjEFFI5x2itgAMD9Dwc24gkRYvw3UHzfy4U02Vz1bMZ1/VOpU8FUGpd/wqOPLc15U32XG178SVyB4SNAzFicnzi2yWc8SZqZdTMhByvz5ctwWjwuD2/VwgIsh6Un/gXAEePOyddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931283; c=relaxed/simple;
	bh=TArvezDZEQsjMhaHWIisKml+GzJyRldlLSrXhgHIPb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHi7OFViTaOTJVIZAGyQR2A8E7d31SHacxPxB5tEBPjdc7wwPlhFsxUYeAv0GR6oW8UPdEDlurMj3kot+uIArdXCutOGGLU0v+tobzN5jH08motLk6hWwXPOg5IbJbmYGxknZB3iZVgh4w4p+IdCaCFWzhWD5B5lUEw+ihAsz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKNGTE95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB74C4CEFF
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931282;
	bh=TArvezDZEQsjMhaHWIisKml+GzJyRldlLSrXhgHIPb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kKNGTE95vAq1vaS/BL4oTKjY7jbEX3OEkX/j3GX6GyjVInt6acx2gObwo4cCcpnIF
	 WolI4vA5wQz11Le2ZOOqMEK+hRz0YSoLv1MXmLB48is8C1NGDFqNBxZ5oyJsPR2o4u
	 C0tMc8MMfXjVDaHJLzwf+xhJtTcwnJe8n8RYcsddZz4Six9cTwSb1s9GV+kbcyGyDC
	 iEGQTBxm8YoVRSZoWad05bOEnpqGC1w3mq7yRqdmA9whATdICvCUdj5xDOn2zWbYjn
	 ++CFPA3ur+y9eM8LOeBH2hE+XsoBZWqBbeP54dLveXIyzJwWxArRJLTI9TqJ5IJ+/H
	 k5AoWzLznZ0Rw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43f802f8515so3627985b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 06:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwPf7nLpTh+H9+WwWpmouu9m5AkZcBJdU26PuT2mftHLltzvGV04l8t5HYjzucB51w0kV1b0Jtug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQHaMKil20Mlkr2aUBYa/kvJwjYRGcfGBEH3WKtAglHLDETDK
	HmVSSips1Ficv+T0EARoAXrXOP74598OwIyve7GN672+2DIIOkZG/CmZhsp8Ivrk8mkL3vHScaw
	B+dvZJddLUkSUuHOBlMjAznmnpA/WHLw=
X-Google-Smtp-Source: AGHT+IFz5cBg4+T4rL9tuywKBs8c6cm4c/NRWXhnpM1O5tcd8mh0O2hidOMfjxbofOc9Tqa4RWlPyoGWgmjOias/7z0=
X-Received: by 2002:a05:6808:188b:b0:43d:2197:c1e5 with SMTP id
 5614622812f47-4417b1ac054mr1841940b6e.0.1759931282013; Wed, 08 Oct 2025
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911> <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
 <20251008130234.mw6k4k7fupxma2t5@lcpd911> <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
In-Reply-To: <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Oct 2025 15:47:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-f2dzKJZDZ_fxrDL+JYcF3JxjargBVT3RVcXhVVywjw@mail.gmail.com>
X-Gm-Features: AS18NWDzg6y_ln0VOA3LER6CVKTWcaEQ6TVX12yT9jm_4CrN9aS2IFrcY9Saj2Q
Message-ID: <CAJZ5v0g-f2dzKJZDZ_fxrDL+JYcF3JxjargBVT3RVcXhVVywjw@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:10=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/08 18:32), Dhruva Gole wrote:
> > What I meant really was to consider another path instead of a mod param=
,
> > something like a /sys/kernel/
>
> Modules' params are exposed to sysfs and are writeable.

Some of them aren't writable, but this particular one is.


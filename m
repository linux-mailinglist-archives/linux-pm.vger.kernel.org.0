Return-Path: <linux-pm+bounces-15353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85129995323
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316BD1F26AA4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285B61E0B8B;
	Tue,  8 Oct 2024 15:17:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA841E0081;
	Tue,  8 Oct 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400665; cv=none; b=ODaVMZKW3k2y3ZZfGfQZRO3M1Gnke5EAwE1Xint1YYcZHxuvldIxOro0hvSwSOdLg2Qc5d/fJBVLKcVgxux9h0+DIlSB3rq2ZsO6il5eE/f/fcURzogG9cbF//fL8TkCsqISJjl3mrWcXeaWsPX9raaDDIU0Kn+qVJdng0/l15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400665; c=relaxed/simple;
	bh=CNfpff1IU0uef2UsgIC+OwyYHv3DbTsFpmqGCXVkFqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWubqpknR6/UBM7W1g8BwuRpK6QnPh103lbSf9YpvniGWVzEwpO27VjphMUOXUH3wAKKyiv4lVlsQqeAIvPGMxtazYXjJPZ++9bJEAUNGmNZoDZ1KwWU+Yj/PsCQiLiRjFx0/bgqbZegbXdboF2Lo1Baolp9ZPCnKWHnVr4FuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e214c3d045so43716007b3.0;
        Tue, 08 Oct 2024 08:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400661; x=1729005461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+Bc4GjkC6icbPY7vgYqwmn4fwzMIGosWjslnYJ1NAQ=;
        b=Z6xGjxTDEJzFedHYkSqOcKIWXV2PaSwQpmGLa6yEW8uPLKVCUHlOzhezdlhi7O3V6X
         5FXRYXMG6ijW+vmIpKlccCsOG1yQ+fShl2dxM06GQ0uy/NxYy1k4NUvKED3QRVmxlvs2
         bkHXCTZQ0sDDJkgpBKtUgoewl3oi0wG2lkIGmOiM5ZoNohoB7GaWBpbXFjG+QFopXid5
         6swb5Wo24OCGA3ihZpNHdRtLigJaVaswXReTjvujdIlsBp4ym7IIWl36NBtWFA/IGsGp
         bnJAJvS1aWDQq5POqeTgM9WilmFAy8kZfh8PQQUCi2NkI7VxspqkO1us6A47RudxqJOX
         MbJA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLXi+dhaDWnK9/SIp9SIVi9NCkqg+HxcQFdLwYny/3l9Iz9frdAN1Hqq8LZ9a99Y+pJDAdaSirlo7@vger.kernel.org, AJvYcCUh90DKFh9xMHuT6+MVct0BFBv5ZB61yhOXIRVEeJOe2bEXzr12O2RnhTV7vYNZH9I29T5X6y8+VuZigFG6@vger.kernel.org, AJvYcCWdWXLWHU4klCZJYkbRmorAqI9FJ8BHhF5Wl0doSCWNSiX3QIE3Sk2oaPo92ncZ6y+v79gYmSAUeVi010XECidwCeg=@vger.kernel.org, AJvYcCWhy1feBVoYLOCLl6pqOncP7O/GyTn6pc4c6kYfHO+TxKozOvpeayW7sUqyy6lQSewA8RSAJBzp7NtR@vger.kernel.org, AJvYcCWn4PovJ+Z4oijeH0Cwyrj67A7N4SVqPoPj5GZJvXEmumO3g/ZmRFGFSwfDrA8QAJUDR7DZ62sXwdM=@vger.kernel.org, AJvYcCXlXOIYh0ImVkOZBBVWSxH2/pMyDsLX1POtJnwYZw1WvxqI4iGuEk+aEUbgJtS4rm+rjJPaF7Zx/iJA@vger.kernel.org
X-Gm-Message-State: AOJu0YzPShSvIUlKxT2+qRiF2qx5JaCXDIvya4HyqTcYNbRU1PE7qUlE
	Hc5L32QPx+8mG04A5jXZ5SkGbx27VuRD+5ZDgctrKpQo4HvYXbdr9nrASCDY
X-Google-Smtp-Source: AGHT+IFncmSsH7yrnX/eyOpZR+QLjBuLgW6DnB8bMCb9jvZlTVCdf602XDBtn1f3VXEZNiffiStKUw==
X-Received: by 2002:a05:690c:101:b0:6b1:735c:a2fc with SMTP id 00721157ae682-6e2c72466ccmr126208907b3.27.1728400661563;
        Tue, 08 Oct 2024 08:17:41 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9387dc3sm14494807b3.64.2024.10.08.08.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:17:41 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so5074391276.3;
        Tue, 08 Oct 2024 08:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7GSiNio/ld7dQg8K8yJBGLbf2eXhSO3V3+dc4Q1FNG4/cZ/jbpYfL2MUfShv9nTj1GV8CFPjIq1c=@vger.kernel.org, AJvYcCW7mCpM5CjDt1xbdbpCN+cslxVVGLdnqD8GrkgyyGIgEJp+vcLypMCBXi5sg9GS5ZXfPBRtC0tAIlU3@vger.kernel.org, AJvYcCWFOeX0vVKK6hYlf3JXHTOtl/YpeBGt0jSrS+kcwmqxFTjfAc6kB05c71RDMYxqn3sX5ockQolusk6g@vger.kernel.org, AJvYcCWvIuqaz7VJqcBv8FOCxFm4S3EqB6fi2sR+WdjAT+HR7y08iLR2AYpkmPdNZ2vgtSZ9S6NdCI2XJ/tqUgnFDd0z5As=@vger.kernel.org, AJvYcCX4PUIJPck43NL/U+hzfnG4ltm7x2/sUkEb1OMvCdvcvH69XQcw/19T+iphya3EMEouI4BcIhHTtQvM@vger.kernel.org, AJvYcCXjFW63+pHVQpBg0byFrFm+4MG9ztMxhbEQk/5NCUqvH4ve22tDTgnHptXfl4t0B12026uzPhBQQh9SRFj7@vger.kernel.org
X-Received: by 2002:a05:690c:fc4:b0:6e3:1a7b:9c9b with SMTP id
 00721157ae682-6e31a7b9d75mr9665837b3.3.1728400660642; Tue, 08 Oct 2024
 08:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-17-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-17-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 17:17:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqnSGnqUE1qOHBSxh15kOJwssx=sa0gSxRLzGyoFoGCw@mail.gmail.com>
Message-ID: <CAMuHMdWqnSGnqUE1qOHBSxh15kOJwssx=sa0gSxRLzGyoFoGCw@mail.gmail.com>
Subject: Re: [PATCH 16/16] arm64: defconfig: Enable RZ/G3S SYSC reset driver
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	ulf.hansson@linaro.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable RZ/G3S SYSC reset driver. This exports the control to 2 signals
> (one for USB, one for PCI).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


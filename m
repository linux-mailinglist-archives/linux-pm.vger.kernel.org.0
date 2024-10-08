Return-Path: <linux-pm+bounces-15349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91299952B0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908051F23607
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC91E0088;
	Tue,  8 Oct 2024 14:59:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C941D12EB;
	Tue,  8 Oct 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399578; cv=none; b=ThBzpbeSjzJ55jQwW0teqoBG3KPJg4RjVHjnaVEfnYGqmT7NuQdPgj1OSUVeIdfGSNZe6TiMacnwb5wIRnwhq6weEecOO1a5i4IJN3b2MT4N+6qnPuQait10VZIi3TJCGj2eXsRu7zisLDgRjHUD9tD3B38onijjc4KgUQgJtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399578; c=relaxed/simple;
	bh=vgZnys5A4HpdI3IN6Ctrcx/iMaW42IKlhOD94Zk9B1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjqsAkjSNl8D6lLxNFsGOapOxbIf2DHQ4T8Ro4yp2mTVFkLGmIBQXjkc7qVcyOkKbQi0HGQ6AxbeyJ/Ub+VbJfkymVoNUK45Eo2viaDw+zPEPGc2F7IRdBf9NBMXe/asH9/yq+YO8H+Ebi1VKR4WpE3RyYNb6U6JJ1Me8s8YJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e1f48e7c18so44458627b3.3;
        Tue, 08 Oct 2024 07:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399575; x=1729004375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf/tTPgyirdsDQap3WHfhe2ZsTNuvcfvkppSqZSZQ/o=;
        b=fzDeVKJ0DRdX6MqjPs9B3CzPbKt94qz7aDI1syaq2hNSw0/VppVImM7VgC4kgfs7Kj
         N20dksupSnWlx7oL6X4qfvSluae5wc0gDIRKBb0UbHOd59RuNnrP6DWLfqh1f67xPQIY
         i1qGr6QzrZs5iTTcgO/VcZN6fSTKsaDgQizVpsVnzflCDsb6gLsgMNKpQPyyRSmfByTY
         eaD1GQ5t12CiqdLt+3VOZgFVzPVMET+D/6dan52ak9rVhD88E/MpgLQKD+3zOKO3BMyF
         BQ7kG0IOlN+4cxltLvG4L7qnVmt5x/bh/mIF+SikfO0pdv0ND6dhV7IJKoqycTfEa0VD
         7E3A==
X-Forwarded-Encrypted: i=1; AJvYcCULtkPT8XgiGDYzSmndyRJIvGPemfcFK5HAm6+/+sW4HrLwgMDedBkNm6ZbhKzuvgLD0gGnAMZPA+LATB+20NzZyDQ=@vger.kernel.org, AJvYcCUznssPkV+S82+fQhQFLm/2pguEPxYkNpdlNw9vIWc23S8oeYv/vGDdVCvZ6p2/P1v+ItTzK2MYkIJoKsd0@vger.kernel.org, AJvYcCVI7JweVgZFG08pEEi6WdhZRT3WsjWHoq1cWGiPBbiyQSRp5xHruKa8scBJ8Ux2mjQglanhpFALYXm9@vger.kernel.org, AJvYcCVZLJaHhfRroxnDSYpTF7y9h/EqZ+fqWOvQVQ/AtNPuOiLDGiaVUzleRmr5+Req3kkQvO7yLsQxM1AT@vger.kernel.org, AJvYcCWxuO29wQSyQ6XjM+rgehPrmAAUfUiX9z+/bofoirJdOZFSqy5+12/q9KMJXjlnOsvdwgK0obYChXw=@vger.kernel.org, AJvYcCXDjjFpvQG69PwmIl14pjcqNyZaxoLgK2vt4KspnjgbVmKQ2rb5/zj/SBTRC7a4i+7Hv/+Kecq0i6gl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEx8HYCzYsI2bmNhfgaxns3DReqSAVuWBINMfc0z/q/bUCDUS
	lTpKoUf33BN/VVEmOmGbjDx1+1cKpvB8dfk67FZSNed3g39rxFqoR/QE3D4b
X-Google-Smtp-Source: AGHT+IEVmF4lG+GNaNac4x2s6hCFvWHvy3JHBC+ksZCKjedB4V4hFk60DqMviwXCbvPo7W2ug6h+9Q==
X-Received: by 2002:a05:690c:4e81:b0:6db:c69d:e30d with SMTP id 00721157ae682-6e2c7289742mr77866587b3.20.1728399575491;
        Tue, 08 Oct 2024 07:59:35 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e314814d56sm1952547b3.126.2024.10.08.07.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:59:32 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e22f10cc11so41138297b3.1;
        Tue, 08 Oct 2024 07:59:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH2ZuA1gPO8bRC9/1bR/w2l1smlqvPNaPKCjIolIwYMVE3sojUicug2IV5Xpudal2FPpL44wVrSq0+@vger.kernel.org, AJvYcCW1gBNePz+DGq3lJsC0krCIbFDxzkMDsdZcMiupU7litq2CEWydugdWe0389CWSDPsYXs11Gk9daVQS@vger.kernel.org, AJvYcCWVeTJXxI0m1oFdsaS21n+3Rw/Q1ggE3yDC6Nexi5o9Oa5GCwxYk58SQefh9Bh6LJohzGMivdpuhbE=@vger.kernel.org, AJvYcCWutj2VP1Na4hYOY748qivmginPhCYNcCWYd1sBe4YAEKlSeC2NcvxtkAbRaN5HRPB+uPJ8uuigWqlMneGLJVwfU/g=@vger.kernel.org, AJvYcCXT7b/DSNJMA7QgOPRlcBuDgWBGizZQ4JWNIJ5Ti40V45Uyfi3M5p1K9qhctAyVKtNd4ApqbsBF7GnjSD9d@vger.kernel.org, AJvYcCXzQh1iyo13HqPRf8BVSo4kF/jvu1GkvBqCwOS2YQeImAY6bwQViJqKC/VrvoWt2Y53EZ6nMnU3Qtdp@vger.kernel.org
X-Received: by 2002:a05:690c:6782:b0:6dd:d28f:9e02 with SMTP id
 00721157ae682-6e2c7280d3cmr123565017b3.18.1728399572309; Tue, 08 Oct 2024
 07:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-13-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-13-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:59:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvjhsbgPngts7ZgzSSviepkMpDtXKZtBd9ZX53yBv5aw@mail.gmail.com>
Message-ID: <CAMuHMdWvjhsbgPngts7ZgzSSviepkMpDtXKZtBd9ZX53yBv5aw@mail.gmail.com>
Subject: Re: [PATCH 12/16] phy: renesas: rcar-gen3-usb2: Add support for the
 RZ/G3S SoC
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
> Add support for the Renesas RZ/G3S SoC. The support is similar with the
> rest of RZ/G2 devices with the except that the RZ/G3S needs bus
> initialization due to hardware limitation.
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


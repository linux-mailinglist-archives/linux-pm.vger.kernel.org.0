Return-Path: <linux-pm+bounces-15350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD0995307
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370FCB26A20
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF91E0B8F;
	Tue,  8 Oct 2024 14:59:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B221E048F;
	Tue,  8 Oct 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399599; cv=none; b=Nv2IZkQ2YyviZNeaSGL4mULX15GaS0+9Ayp6bGzcsXR0IYcNOTkO3+Eam2+2HWo/+Fp9NM6sujyyFppt/NGEYA5V1NSyxRDhKOBx1z53c66BSe48aMInrwXLlJd+RaVughFleZ35OuMO/Rx/1LNSZM3Y7ByiM36yQBS3tI+FF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399599; c=relaxed/simple;
	bh=03Wada/oBCoMHe1h2WlwhE24CGG42Xtcb07KIVcC6Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBBO2PorDJu0nnfJ9NAjbKvj7rZLbq2X7WTrrVNLOujF037T2GrHkTOURHsR8JckSqLCL7FC7N5lsjX1lqreUjhN5vXTnDTDJy73qpixXC2oyJE0d9NkI7YqSD5Gk4jERKjiDxfYXolE8+CKahDoymKB+X+ccfzz8qoyDr6g8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e129c01b04so46166407b3.1;
        Tue, 08 Oct 2024 07:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399597; x=1729004397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7/JtpY+bt/evZG6gbvtnJhFDNvtidvn9InpMlG3Frw=;
        b=NIcM9GTtXC6CI27pQ5nkqmUiHgXVsLSBjpyTt58zIBYoQO2t717nlHgDyeXQ7JVz9f
         uW5B3zD/AYE8ZUSj33hNdIXvjxmUmJcubXKW5WV1pfXji/2lwSUz9dscR1wMlP9z/bdu
         8cSzFAaD4sYBg4pf3OwN2nuLGG/nQUhce4Ra1Xjq0TlP4AZiacnOu8hEE3HGFO0P2cRE
         pNZFe+S93WYh1skW5yhPM8TDjZasvt/+8zJ0IWBGPTdeQVy38BlzqrZa2+w+EqduzzjN
         YobdmZLXaNV53kUQXep5YuTuelmTGxn3KfKhWyEJnVaO67CyLZsAw14uXRJF54ZaaVUc
         H5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUWKgpfOCz31avTg6tN9e2G3kEyTVhOJWcB8syxXzcYz0oIIi0riNNBPvrTmgCArqiLMnoDmj9AFo7F6e/n@vger.kernel.org, AJvYcCV0KwkFlsrSXyZ9HOLIpUHXHlY/S0CquIXU7rTForqSLAuwDG4nOFp5dTCMpxKYEblQ63ZUWVPCiLA=@vger.kernel.org, AJvYcCVrvv2Sj1nBv7O1KflsboxqR5P7AYkxqu1NNO4Rta5zLU931cOQLkz/iPn+QyzKBQlxl4Qqqdq9w2PG@vger.kernel.org, AJvYcCW/e4K7wYFQT9cIolGe3KCU5CelBdlTYAdsPD6WmVF77+kPFRN1PLPiS6FLvG7vss6Z6t6xRZ6cWxXn@vger.kernel.org, AJvYcCXF4K3iPDzm9jz9WeexzI2aFDb/4V7NOw7/ctf4qQDXvkUwrL4xkkPCjHKOedxzuvlk4CQL1OTuxvWO@vger.kernel.org, AJvYcCXl1fC7YzgShx4Xfg1VEYeky7k0ToP3u8yP9WdUKM850tksyTNQNqPLmQD9vpT4RSBO6ko2pmwAsShk6t97vdapyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleLwy8G8P0jZfJ51EI1IvT5RMsTRs9BqsioziJipik3DC8IFY
	Tx3xtksReWc5EN8puq0icASS2jCH6OtFZ8vGY5B4f/c2alATr2KbJdCLui6h
X-Google-Smtp-Source: AGHT+IFpse4Nu0dg3a1D8DV6ecUXX8HCEUD4LV33TFDt0bq7DEiqruZ2OiLbJ8RJOQomgy3xikUpEQ==
X-Received: by 2002:a05:690c:2c86:b0:6db:3b2f:a18a with SMTP id 00721157ae682-6e2c702942bmr93059557b3.11.1728399596927;
        Tue, 08 Oct 2024 07:59:56 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926d8absm14507707b3.21.2024.10.08.07.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:59:55 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e4244413so29600737b3.3;
        Tue, 08 Oct 2024 07:59:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBCkkOBwI4bNav1ZrWMANHfvQt4sy48hMmOY9zmbcChfK324OAdlfwFkbMVuTux6vtEsnzNo4Q8UTy+dvQkQ2xTY8=@vger.kernel.org, AJvYcCV8uSu18vVgBv4gs/+8ZyfsaIg119sNWgEtmotMcS6pB2MAr1TGryH4YNuAtiIhKnyk0l0eaKWYz0hv@vger.kernel.org, AJvYcCW1dkg/YCDj8xPPtVBHJdd6eJWZwKd0y8RQNBjgyz6D1RHDSnvQpLvqNuGth75u/Hx/jLgiRPE/o4g=@vger.kernel.org, AJvYcCXQjRr1/nJ8c215cn3U5uqRX7UeWD66IF+zLY14sdzKVyHmqzex7nZ6UUDAxp3jTNmyDvavWwwfdIZcfsY4@vger.kernel.org, AJvYcCXSR82MHVroRpMi6J7x2ZpWgCUTf3x+tAH+QW+jzbt1iaMlbDyO3me2ii+rn1uvrkp7vkFpPwJ0ZvHs@vger.kernel.org, AJvYcCXV0ZlqUFGOS66INGZTBLLqR24X04HGojSxfOzAjkg3u5+K4j21HmkK+r5D3P4IXnurb70VSkuqsPQo@vger.kernel.org
X-Received: by 2002:a05:690c:101:b0:6e3:122b:8d86 with SMTP id
 00721157ae682-6e3122b8dd5mr20338607b3.44.1728399595196; Tue, 08 Oct 2024
 07:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-14-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-14-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:59:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBDQ4WrJEwfRPcAv3SEVB+d+pVdgnkq2y39aO-5tgGew@mail.gmail.com>
Message-ID: <CAMuHMdVBDQ4WrJEwfRPcAv3SEVB+d+pVdgnkq2y39aO-5tgGew@mail.gmail.com>
Subject: Re: [PATCH 13/16] arm64: dts: renesas: Add #reset-cells to system
 controller node
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
> System controller on RZ/G3S can act as a reset controller. Add #reset-cel=
ls
> for it.
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


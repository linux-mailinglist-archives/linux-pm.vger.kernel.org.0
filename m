Return-Path: <linux-pm+bounces-15348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BCE9952A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D721F26798
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BA1E04AC;
	Tue,  8 Oct 2024 14:58:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0B1E048F;
	Tue,  8 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399535; cv=none; b=IUuF2dJhRH5Wqui5lgz/6JmJtJW9p8V9OX7pJfscB9nX2juEverrA8aVVoLCz9FHnSjvInW4iN8Bww6bVbT5DzMtbR8NtYOxD7d/cCutedE04xZSSpHRDXjyN1G976RVOiQKpIs+Hwjoulu+Dy2laAxwwaLOrXuFBd8LBBIS3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399535; c=relaxed/simple;
	bh=zrWGygvQBUL7a2EN6+LnCQGkKYNWAs3HpdTwqR5/d70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmoJ+n+YngQUJBsq2d91mR5XNZlpGhbUjGW4upQ2D1yL+MJA6ECuNsSB93/9ZJr0WLJ3QbIqdD5KDodo3oOccuSqNOndq/QvpKL5fp6Gjd9KAMvXViXmdu9Z0gcT4/cW8jodBkNoew0nSebRMMzzQ5Vmq3QBn9gSb4IX25iB3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbc5db8a31so42417467b3.1;
        Tue, 08 Oct 2024 07:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399532; x=1729004332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxaihGwbTtAV9yGq87IxyRn8GIrOBfrfil37CC7c/NQ=;
        b=hhGxLQt0R1cxaBQaqjxTFHT3cDxZpSYvtzEQNlQWEjjCp5C/hKMYWZq09qPQ4VOz1d
         mg/Bn7IjROfhuAmBK8+AiomP8+CBRXHQkEU+hMvfC3GFJEiShaEZzwM3ovRGrrXRvbLY
         YichVJWSqYMM1rvSfbxUB1Q3QLlzScKKYh21GgRLbvmOfWeblMiF+krEuk7U7KLBT6An
         J5DvnoIdnDcRa3rpEPsvbszaWyE4m+lCIWQd9uJBYisHZHRitoyPoRiq1N4PjUtY26zL
         8P6U4q4VAJtXmyvNWYVnPO3KebFXNoS5ygeoKtPyv7u6XhCpCvDY4Qpdc9SevneKFpgC
         5oKw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ccvIe/GXNB5NaRh58XhXZdHGLwP27k6uQhBEtnRrCO39CHaULEdHUVCK4MOt618f+gy0NmVkotpc@vger.kernel.org, AJvYcCUYRYWOFbaV/OIX5AhGNyAIsFZxBXvW3+Nyde5VykztBB1B0JAB2AXTZgyZLhIX5/CsJHZRtmHPGuXd@vger.kernel.org, AJvYcCVntCnSVHzETvFLjeuyFaZMksxl7ZqbG1eZmp+AVrobnslobqIaxzaXtGmkHPe6nLen/JbS5eCi7NBm@vger.kernel.org, AJvYcCW2N+FwI5Us6xyU0DIrO30+w3PSDS8ShFoY5Hi4amNcla5PQ0RM+1eMVed+eo/UDAakNKwtKb+k5N8=@vger.kernel.org, AJvYcCWXRAN0iWQn+AVg4X06eTM8FX1dXqft+CNV6fkL/PsCFlto5aVxiLjqY3Zyr1N/BfwewFOEmpYBz+MOctsX@vger.kernel.org, AJvYcCXQOqGYGriZsaM3JlSMT3aLdNlqs0FuNtBCwg0F2uK/PW7uMklLinf+xMwvf1toVUFhr9xGBaLcJQYpd8CKcKsGaWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXuJh/ZO44G8tS1lZd7e16g8rj/lvbayctsO0NI8ycQx7QC8C
	tup09y1FnFtrV0rFfB+3UAZ4+302SbjYx8r07At9/TglAp4z2B+TZ8g3BWLw
X-Google-Smtp-Source: AGHT+IFWIt/u7wkiU0jOcdn4ibdsrZQxSY97tAAH+g+0nqX4I9GXtpSP7Th3hjduesev7xoDBYkfHA==
X-Received: by 2002:a05:690c:4806:b0:6d4:72b7:177e with SMTP id 00721157ae682-6e30de96dfbmr29771297b3.5.1728399532566;
        Tue, 08 Oct 2024 07:58:52 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d4260sm14679987b3.84.2024.10.08.07.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:58:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e314136467so6424957b3.0;
        Tue, 08 Oct 2024 07:58:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSEb/35OzjQf+2wFf3za8UtVJNNGVpRrxgsmUaFnAw7929ZUmSYEN9RoNyEWmSZjaXq6hwy+AVlC5/Vmrpr1LtAQQ=@vger.kernel.org, AJvYcCUg/blnHTiuA4nV0oA1cx/oe4I/qeNWsD6AqS2LQq8j0xuHHi1zYN614v1j9A7pJIzLBP04RaQG0Dg=@vger.kernel.org, AJvYcCVajalgFzRe0sjs/AFRoPnZjxuO2BmMhDWtQfi0nbPf18NUpFi0jiAUsojc8bZWrRr6GPuEXqbwsgx5@vger.kernel.org, AJvYcCVd+fvHbaGL47jtcwF/yGYXS3M7d2nn6RqInaSyzzxfZMk0GATeqvL+nG8yrhsXn/hI90U1ntdczOcI@vger.kernel.org, AJvYcCVnqwbkzAdGRV6ETOA31NvIrGUwa2Awn9mlSsi60yc0QmyZukpnlbixp9XrUiNBuJSNl/4gW+MlgKM8@vger.kernel.org, AJvYcCW4Wv85p/nUH2qRpxeA8PLtKfsmcR942eSWAMo/vzdBkntk5aXJbTZotuKrzzLp8JKS5YsEm4OsKT+WcYgk@vger.kernel.org
X-Received: by 2002:a05:690c:a88:b0:664:74cd:5548 with SMTP id
 00721157ae682-6e30de97175mr30204477b3.1.1728399529367; Tue, 08 Oct 2024
 07:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-12-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:58:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTxeE1SRKrUatjZ7VE=4JHs_OrFZJ85VsdVanewc1-Tw@mail.gmail.com>
Message-ID: <CAMuHMdWTxeE1SRKrUatjZ7VE=4JHs_OrFZJ85VsdVanewc1-Tw@mail.gmail.com>
Subject: Re: [PATCH 11/16] dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S
 phy bindings
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document the RZ/G3S PHY bindings. The RZ/G3S USB PHY is almost identical
> with the RZ/G2L USB PHY. The difference is that there is a hardware
> limitation on the max burst size used when the BUS master interface
> issues a transfer request for RZ/G3S that is configured though PHY
> registers.
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


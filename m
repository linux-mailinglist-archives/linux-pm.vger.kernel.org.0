Return-Path: <linux-pm+bounces-15338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E21A994F87
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364AB28631A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391D1E04A3;
	Tue,  8 Oct 2024 13:25:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778D18C333;
	Tue,  8 Oct 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393942; cv=none; b=SGcy/pcwocfY6OJ1God1V9nfj+SUYfjytPGkuDmk8HEQrGh9mB4pB0WUrt8SmzGDWpJu/cpXyUzYidkaIjX9Dsi7G/o0zAh0RW/wKdnM6dyIPVRCGKpynPEE23Ixqq9l+J1NJW4UKXrMke4ujHzLeDQWWcdsN4ZilZemN8xQTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393942; c=relaxed/simple;
	bh=jIPXc0s49GXJD3Fk1pEhomcMlbPTHXFr9HosdN5ZLrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW6R0H6mj8Bsyt5uueeMGvFXpCd7CeyglE0DMeXgRMWUVf+/izNoCaSAv3KTtOYLm+57AmhMIcQ5kfWI1KdFG9S1fRBhPA20xRUAqSLzofYLhlaJLym/5eXFRlVamxDaFB72p+SDp79zgZ2BtBt4tqzdoRqsOfZGMfJo1e02lpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e424ab49so23048077b3.3;
        Tue, 08 Oct 2024 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393937; x=1728998737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eTUczWLqVNXasZJjw/6MkuEU30oFDIHMIf/C0sqcKE=;
        b=JUQ4GTT6HrJvmrTa05KK/6Re7nCOzJAcFutSLYI4HpDTD4IwoCPG3Zk7oVHHAEpvBk
         5M7NPz6NW1MEQfWBmjDkl/h9v2n+Bm/xWkfex6mCj83dX19Vgq2vPgKY+F5iP3MIlj1D
         rk9ORJ1yV3L2QNPaobAbr1lzgpazXktS+yTOvVLGn01sTrkUTjzaR+u5xRGIb2IFZa7X
         8sqRx0pHVWaBKFGLAQRC32hRBiAVo2lvUUeicZDXHwA7XWw2Gmjfgi6FaewzoH1LGHbL
         AdSARM9jOQxZPUhgO3b5eKLp5FCK3rOv0tZdr3qFKksvFlgTe+EZi8Z4H+613PXc/Ngh
         fC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCULw+kKZKoLgXzQiaqO+0eCwCfQStkZCDuTOd+sbv7IMfgCO0w63KCcvxVPG7kne+AZ2bshbvrmujOqvQbUTkaXp0U=@vger.kernel.org, AJvYcCUQCE7xWgVUHoezz/OlbGdDxdeIm33Pu/DSXKtuFI7GQ3XfGhQ3zC+m14YhjHWfftsOIYuDY3zlOkjk@vger.kernel.org, AJvYcCVaV0aJJssTbhoAq67Qr4s3e4Yb/Z0w+f5wm9gOVNRvqgbpQrnrcgCzQ/ykVdS237jR6jy28JZ8gii7@vger.kernel.org, AJvYcCWhnBGmQm7n4+iJLX285Z+qzI0ltuiJpyJZHff8qryQgbFHpyFS4K1jOCjF5MsCQKbNJAmsBAMfX7g=@vger.kernel.org, AJvYcCWr0DZqb+UiFzyK241dP91mJF4Q35Laq0YWE4k9e6S6JlS3/6qNcCR5F32AuIrmqz7skm1I5zlSApQiRO9V@vger.kernel.org, AJvYcCX5RrQ6rfIjfzk/k7e3t3Vdh72ewCoPiQOfNLJtEQwu0qsHH0X9Ek1cDURuipNOzgdQVh0mXeZf9mjP@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJVBkvfLI8ymDam1ZVJB2qIsnTgwZ8iBUDMz0KC+AVIvJb5Ty
	0aZd1o3Zk54YFg3V7gTGkqxDUGtU4TI918ozxsCGWJ5h7gjdP72mnj8nYOM/
X-Google-Smtp-Source: AGHT+IEEBjIipgqa+07AuaD3+ns2D4X26JxK2+5zN8T7JGXjgQqTN6m+Yp4FRBV3KVowffIH4XBOcA==
X-Received: by 2002:a05:690c:2fc9:b0:6e3:e1f:2434 with SMTP id 00721157ae682-6e30e1f272bmr21566837b3.12.1728393937366;
        Tue, 08 Oct 2024 06:25:37 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e2d0bsm14285267b3.112.2024.10.08.06.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:25:35 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2d2447181so30052097b3.1;
        Tue, 08 Oct 2024 06:25:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlmJPvoxGfFdf0fy6+IcuV867nIa4h3HWgiRca1w5ndoicX4rU50WfAP1pW2iJMP5sM1RqAZfeeemUruLS@vger.kernel.org, AJvYcCUzs2QAYZ0Sx7d8hsLIdnCeFLwLSfIuK174Vdgb0ih2UKqrJBD7Awd8fuNMF5Hrs92plbgJkw2sLEa8@vger.kernel.org, AJvYcCVkBjxFrJrb/K7E8TOPBuNykn43/UiBGvMnVKzFaoT4oBCth6siNlFW7ZDMiVIdmGuEXe2qwyzDm/7L@vger.kernel.org, AJvYcCXR6XBEwA3LiELVDuD4sSMBrLlL9qFXjPIQZkhn14QRf9mN37qPM1bR5XHGfnvnQRlOjVqooG7u7FFO@vger.kernel.org, AJvYcCXhTyoGjFnvn+9xaj8pJq+EiF8oGSdWd2XYHCDbDEe+L7PzAKBLPiwQXF7z3a1pQn1OezKX2Af866UJqxbsvZTbZkU=@vger.kernel.org, AJvYcCXty+ZmMFlbBz6MsIYD9clavA6dzI5irrZLTyElYQ6teFZW5HEMqHWm1m1VABtfcvTF3UbgiJ1wtW8=@vger.kernel.org
X-Received: by 2002:a05:690c:2e0d:b0:6db:db7b:891c with SMTP id
 00721157ae682-6e2c6ff8368mr89381207b3.14.1728393933660; Tue, 08 Oct 2024
 06:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 15:25:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+OoOghaRdSgxY0cA7eeE1+N+CUetQXx1Rnt9d0wyd9g@mail.gmail.com>
Message-ID: <CAMuHMdW+OoOghaRdSgxY0cA7eeE1+N+CUetQXx1Rnt9d0wyd9g@mail.gmail.com>
Subject: Re: [PATCH 03/16] dt-bindings: reset: renesas,r9a08g045-sysc: Add
 reset IDs for RZ/G3S SYSC reset
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
> Add reset IDs for the Renesas RZ/G3S SYSC reset controller driver.
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


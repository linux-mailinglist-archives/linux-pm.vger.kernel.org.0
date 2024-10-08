Return-Path: <linux-pm+bounces-15345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A999524E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52C11C20912
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23D1E0082;
	Tue,  8 Oct 2024 14:48:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EB1DFE3E;
	Tue,  8 Oct 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398885; cv=none; b=BGvRNAqlXiUF1vaxoOp5tdzlivk/g9wOmrU+6I+DGUZ3wj8+tCcupR3JL0Fjcvv3xzbnJnOenFTtwKt/BAWJ/vF4bs5d0BXEpJARDO1ZG7b5Och1zabU9sHdgAdKA6A29ifO7VqWKVPY9S3Jx2rax3MW+BfvdggputsgeBMJ45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398885; c=relaxed/simple;
	bh=GSgOlDnXv10tYJqnb0gX9QrBQrt7riajws/mcdK/+i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7USbcyEQvtasLiVTXNVfpNxJ43aTm7edF80+iYXztSP8d0jcI6RNF9PNqWSJoTS5prmdMf2kxbHMahK963a/yk4YSaVA47LoKfWlcPLZV6tL32hMEL5Hmj18bc2BI54m7SUNajYYlXx0KYy5b+EeU6ib3euhfmbcwY37RecP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e30ee6788dso9865027b3.2;
        Tue, 08 Oct 2024 07:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398881; x=1729003681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13A9KYVntAG0o1ZVX0Og5yF6VCHjDAzxxd3dckxxILc=;
        b=WLBU2bcKkBgE4KTnrzaNl3ccG9rXeg/pNyF8g3XdfStJ9X9l2njxoRpOAiUskSuIfm
         oLf2OAsto/hyisnsBp1qrgrEOvaGvsjLvYYPSX/S7spi8yS5mTmbSbhPGqZVLtd0apwp
         umfbzUZKbqda8hjXT1vud1kJdHSbtzTr7h87c0MkUlhxayxI/gM1PjCq54FAvXJd/GvO
         5y3OcR9lfrI4HXvBYUsMjuKk5TeahDwmD1o/22wds0JP/lEq3fZCMr6+kJzzHQn+kbHs
         1f1vU1ccnMQcgnElGLmH/a7kwN8ILdhnNl+jux/ZjXaWR7DAACt/92aS+4B/q6sfCui0
         pFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlpaRFZ+5sfE+xC5k/3cydklkiDKQ6ZmqWulrFnghEITRvQn2FvbVg1k3JrjMqRrzdaa/qpHJ13ta@vger.kernel.org, AJvYcCUWzFdNdtjonrf+TSVnOXyZv0MJoGiiknIeOMIbcONWVvLw2Siqhcr4F8w7nS2grhY+CMjpRP+Mi4fgHzzfpMA2Nbo=@vger.kernel.org, AJvYcCVbaEXw/hGinhzzfPbXNhvilU124q2sdjkmX4rbTdjvj7z3K8ENBDTplQCDKe2N0KGp7Beu6+9lOBg=@vger.kernel.org, AJvYcCVeNcH1RuGxWMRS/WT1+czYYpDXY1RhCiQ4Zmd+qYcUNvEXq8bliZaX+MATEmnHK0dfYhY7HU+nO4l0@vger.kernel.org, AJvYcCVga18CWMQZMulDPvX7H2QCrL4ZrnOJDMsH/ZH+roIGBU9cFWXGDl0c8uMXiB9lOUgbJQeDsgFfmgc4FHea@vger.kernel.org, AJvYcCWyJzpQ3ijPJDc9coABPg1lzJYA1mZ4QRc6Q3ulQMR32RQbRlGX6E/GJ4u8CBBVhWx0ZjNfb4jW6f9w@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Z1BTnDu0YNKM7GGRe7X/743gCV/OfSYqUvQsdxAob2vML1DO
	yyFSrCoFzWCiAse1MiQguR9mIRId5o0sXaZOpxKYaDl66vSb28bVfUgZDjIN
X-Google-Smtp-Source: AGHT+IFXaGrlRYsK3jiAf8oDKfhtXnEa4WzyOBFSuSF31GjqrGovPqZY3nBR8bRkDUjpvoqimPqpnQ==
X-Received: by 2002:a05:690c:dcc:b0:6e2:636:d9ee with SMTP id 00721157ae682-6e2c724118emr140366097b3.9.1728398881641;
        Tue, 08 Oct 2024 07:48:01 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f55csm14574507b3.47.2024.10.08.07.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:48:00 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e20a8141c7so48095517b3.0;
        Tue, 08 Oct 2024 07:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9+Hvk9W12wzrPq7E5hWrZJE/DsNWHHshy8nWBVgH1iLOWoyvHDicSdgjRGq6EuHuL8uzfQHxRcfGE@vger.kernel.org, AJvYcCVFiFwAk8UGuxCbxt1uuni5tR5iavtBJNp5DxmwIfcPtWVkEOoymrK3c5E/g2pSd7mFFqK3P6UOOMqr8oiX40uKJ3Q=@vger.kernel.org, AJvYcCVlvBa/KOQsjBDaGQBRzS3sR1iNwi8cetOFQzWUDq/ElkDapylRqDIi8HFEVlRMhij2z8uNcleZwoqS@vger.kernel.org, AJvYcCWBzf104/fCkO845nh22oMNHndXMLR+HW7XtebFefy2L0xPj/rt9cWH8Dx4Q/dHnYotv/sE5P3MlKM=@vger.kernel.org, AJvYcCWULLLxQoyQQMRJ8UKyTLqo1bDFglMUtiOxC7ILtQnozxq24Chu3HUZhkfAaKN/rpCfJACaLaCnuWhh@vger.kernel.org, AJvYcCXaJ+eFZ3FMxmjMl8atPCYWn0djTgAVFuumvmSI0/heoCfSaNDOKyHaWR5Me9UO/7rJ+LQRgsRNvYdjBr0P@vger.kernel.org
X-Received: by 2002:a05:690c:4c8c:b0:6e3:18be:48f7 with SMTP id
 00721157ae682-6e318be4f52mr11579967b3.44.1728398878489; Tue, 08 Oct 2024
 07:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:47:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD86=6_tD2dQAz5i0TUcCgF5w69h9JFQqoEMXPkM77yA@mail.gmail.com>
Message-ID: <CAMuHMdXD86=6_tD2dQAz5i0TUcCgF5w69h9JFQqoEMXPkM77yA@mail.gmail.com>
Subject: Re: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
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
> Add support for RZ/G3S SoC. It needs its own compatible as it uses 2
> reset signals and it cannot work w/o both of them. To be able to
> fully validate this on DT schema, too, the RZ/G3S uses it's own compatibl=
e

its

> w/o a fallback (as if the fallback will be used the RZ/G3S will not work
> anyway).
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


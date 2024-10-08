Return-Path: <linux-pm+bounces-15351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586D9952D2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29BE2834F0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A291E0DBF;
	Tue,  8 Oct 2024 15:00:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EC1DFDB5;
	Tue,  8 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399625; cv=none; b=TCCFwu6k++hUR5kyy1OVua9ngSsHDSb+aMFHOOvc6DEPF3ANmgUzIsRIzBEnLL+nX8hyKxFsPMpcvxH7eg0WGLN+iR2tB/l3KxDQNBsDoTmyxl3np01UgoJ02AkDeV5WW4mtKHgWcC9uF0YKVIC1NavK7nNPxl3vEhbz5ev6IJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399625; c=relaxed/simple;
	bh=W7i+H0RcJIFPlTHVFH3mJM5dJssilkJ03Q80Fm2nJ5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Agob8LDkL4awRsXiJhjvi9VsleQwAvQctYnZjNlSesQSOS521SqqDObwcRQEJApJENkKwSiKbfytbeuCSKm0ywbF18IjkQvFi24V00oGRsJuF7PJeHB+Vwi18GHlJCPLruDreJta4NxB1bdzPHFhszhLKManvyN3KPp9uo1tlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e262e36df27so5585945276.0;
        Tue, 08 Oct 2024 08:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399623; x=1729004423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OI1CwFU8hmoHKJ3/axx7rOH5GOO3B9FuoN2F0R19HA=;
        b=dY6aCAaKHuw9LksElSAGNhOdRulntyE3nZuhdjbqxZbYb7Q2embSH1Iw4B0I9/grSS
         8vRKohG2FxO8pAzmpbcUtfwf4gpZS9dy/Nt5hIvSTRJ6tnslJJiQlVcsBVp/054IkExq
         qLiL4rIWLvDtceLGmuO+7HQp9m6o7i10hqj5SF/wfbmLvav0z6Gv+TBZ9FW8QtisKjL5
         waEE0lb2cxSeT+tCS5K+FbMO76rNEbZqjCaJ1SaI7NQrthu0jKJ9UnXOSJfQq/4tZRdt
         Wf8XlkWXM000ibJClu7VD54SPxEnFfPy0RQvvhs/avfP9yk8GD2lRFq2vLXlsryD1PZS
         lrSw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xSXpf/VKKuu9jq1mALdKdk6G5kUV1LNHp/yNEY8LGIr5+jV68MN9cy22bUL9S3L18K5rXLukZsKcKZOecQI23v4=@vger.kernel.org, AJvYcCUDfiiJOlNLX+QYS8lrLkyFnKIDzWNZ5fBSywF85thFdbdr0y/hbTuL6sTjxce/uVpNyV96MTyYqqFF@vger.kernel.org, AJvYcCUvCX78bT+J43IFIyWB+6DzfA1kHbx9mBp9oBAITfA6PYpZaOpMSGpDpuwwZloGYFpHQGJzyvpDhWqP@vger.kernel.org, AJvYcCV7d+Gn3ZD5NNXpdqx9DxEiJFhiUwfhbH4rqquxcTVulYGYM6RsBVA3Fcg3yGNbCtowct3zoDHQSAIeQxP7@vger.kernel.org, AJvYcCWUW8ADs1FOBGDOBGfPB9E52ihw23lLvp0mITCI+AxEoxsf3AkFKMNq4MOCHN/ZJV4Igi0l0myRUHSR@vger.kernel.org, AJvYcCX2lFJg+/EJwoC5oPvafP1mkuAK0hfsCHMtnOk+2aPCQjZYIzAhpv/af15dK1Z+B1JoRhCjL4z4wzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KxZ52OJppxxVb3RRG8Z4+ydKpHRsc3B8dcIeV/fjioSUI2Mi
	RHi90ivfc1Kuy3glBaDxALMVHWb/UaVzMJvV3ex7Fhygxb273CPXO1stNL7M
X-Google-Smtp-Source: AGHT+IG3yZwkaugLO6BIewBXlko9XYjspFGSdim6+S/k9A2hUOMxdUIX5cbyTQx5cET6l9kNC6HE5Q==
X-Received: by 2002:a05:6902:d46:b0:e1c:e9fe:f4a6 with SMTP id 3f1490d57ef6-e28ea7b4b38mr2548990276.18.1728399622501;
        Tue, 08 Oct 2024 08:00:22 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28f9e7a6dasm31762276.34.2024.10.08.08.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:00:21 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e23aa29408so61287297b3.0;
        Tue, 08 Oct 2024 08:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB7v7pqC1KGZAs109OouJMo9128vE0fKiOowB2nzxWq4VHJouOpd/DEm3QgwxE6b6oldkn537LhKoN@vger.kernel.org, AJvYcCWA+1QbFcCHPCXlrZ782Df64VpYHDnOKaVLAzViC8V8EI6YKRFoYPx/TNMFqqIvr1iHouWCcUh1DHNxJWJ2glat/1E=@vger.kernel.org, AJvYcCWGmc1/eegRBpgSxXB/sXCYtsN33VmNQSILeB3BzG9KrhqrDkjYYHcy1rl0k4CmmxfBUoDR9KLOdquluMSy@vger.kernel.org, AJvYcCWmPByIP8/i/MAb0dy1l1Lcj/B6XElKNa2AkWpaKUsVP1rbAhQwkWr6q8Zfq9BetX5u35pyEdDi7nk=@vger.kernel.org, AJvYcCX+mWCx1vmSU/7C6vtZC1Xb1xmiSd87FAx8Zka/uABEQTUTFHpC0bjn55m3iMNbdS8vD/8PY0pliL8z@vger.kernel.org, AJvYcCXrFvd5g/Jyp7EIGpUN67YRojO5J8xR9a4lpDmYjLy7ZWYBwD9DJEtcWzwLRImYtjPyxjZRHU2OEppD@vger.kernel.org
X-Received: by 2002:a05:690c:3406:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6e31d76c62fmr3976347b3.13.1728399621233; Tue, 08 Oct 2024
 08:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-15-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-15-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 17:00:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=3rFDFo9KA2KZxKJMw6sms_DOPiioRFqr5eH8_Av-Wg@mail.gmail.com>
Message-ID: <CAMuHMdV=3rFDFo9KA2KZxKJMw6sms_DOPiioRFqr5eH8_Av-Wg@mail.gmail.com>
Subject: Re: [PATCH 14/16] arm64: dts: renesas: r9a08g045: Add USB support
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
> Add USB nodes for the Renesas RZ/G3S SoC. This consists of PHY reset,
> host and device support.
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


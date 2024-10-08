Return-Path: <linux-pm+bounces-15343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A872E995235
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC55E1C254E4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827481DFE0C;
	Tue,  8 Oct 2024 14:46:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E71DF755;
	Tue,  8 Oct 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398795; cv=none; b=J92tGnHQdSSUm1Pf3hHqNU8QevpQCyA/l4O6+SJc3qIiHFYeolhLDWGQh3/Kw4dn/MwyZZ/MOPxK0ZSfKqhVuV24wAA29/rMnKp5doZFh8PWm++yIgArij/7gJEHLNncOlFvjr2LcBXv0B3RhBUBKXxU71qWlupD/UJNgyP+gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398795; c=relaxed/simple;
	bh=+YHYRfvrLz+RiZCTwLN1AsCVFXqMRucWwDPVG+8cAnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiBH2BwG9EWM48VOG/2ktxc0w17+qyOhwxVbOicKiOmJ5yGpoldWGHI4/ul1kWTAWQhiSB73pyGYviYEOHOlxAQQQMuu95irn34rOrTmYv4941pBulYbwNlw6AW6dEwwvq4XLykimWcOJKtEotpXYPZCsEexvAbUfvhDKbDWt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28ee55190aso659225276.0;
        Tue, 08 Oct 2024 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398792; x=1729003592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWmvaZP2QPicvk7Uow1+SNZ9QzFB05BEabMFglqaI/E=;
        b=N0JLm64uArOvn5KhDW2+DhOGgLvazgBoF6syjxOAfmQpRz2OuDcwY6dmd0rtu366NT
         Q4DICL/FmiMNJQPEVNTgm0b7GzUuAp6kAQ4Yv8ru11jvq4UMBnmAMO2C24SdrzfbZnH3
         fnNnHt3Uddj2TVqBMn2/23keWpE1ewAMw4tcShVEPXf7bLsZWROk7zEF+lAr0hPzKe2l
         Zku0NYv2qh8pUOnemCv38Uulq9qS4GfoVGkSMlySWxAvFQaMSns6kGolIQjGjQrxG7dk
         ftmYKs/mFtxLTqJ5CPNJU8g5ph6tMax4puPUJhNbhfKS90MUp5OeYWHKZyrv4qs+Yxxq
         Gw7A==
X-Forwarded-Encrypted: i=1; AJvYcCUzRZ1WXs/IGJgoxGKmXXBmsaZzGwUEyMgmDi407LsABqDKhXVvViJjoLCDGjNyc9upfv0XhKmwUivkzsnf@vger.kernel.org, AJvYcCVCnxOqsAmMJTHN2nhuuhKBN/yQ3drnzUjzPcl2eqBMGZDaG5JhZ6k0I75ZrTLJQaYxjih/QGUN3Y9k@vger.kernel.org, AJvYcCVdw5DXxSu6wu5qjteH2zWDvaDBzhCXrmmgFFqeFxhFO+7nBa9BeGXlZAEJqomRhg+7Y/eAvWrhOPgb@vger.kernel.org, AJvYcCVr3BYgOkg6ntvZN2V7A8X9jqMt7M79BqWCwmXbbdwt3nkNwTX1MxAYWNmKmTef3jMs7Pv9teI0gaw=@vger.kernel.org, AJvYcCW/PFpo9x2GoDCxq6HthQtCbm33CrWSssZeyuMRfKQuORA5tl0d8vFL5BEBL25hMVySkyUTkN/o3LlbL0kyAxLElNo=@vger.kernel.org, AJvYcCWLLXClqkbSVi+W+MfgVAXY3A/kXA2ovXRbFeVJtTjTrANuLeo/A3I3RlF3WF4n8mjj5MQhZ1McTTLx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaqh7SqLGZA/+vCMv3A2fWjh9mjeIWf364Qbf/Hkiu0H4+KNME
	T9cJa6vB5k7/PIcw9mOngSgdTlX8mGaeciwBl0hB3Vn4PxDbYlj2DalBC7TK
X-Google-Smtp-Source: AGHT+IGLiihXBfD8aRWSsX1cqUnfQEuRpP2b5rtAk0YMgquG23cJHnDszfgYZ5GG0EoO7DWRDTGU5A==
X-Received: by 2002:a05:6902:114c:b0:e1d:33f1:cb91 with SMTP id 3f1490d57ef6-e289392adf6mr9695269276.39.1728398792210;
        Tue, 08 Oct 2024 07:46:32 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a593b134sm1282547276.3.2024.10.08.07.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:46:30 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2e424ab49so24037337b3.3;
        Tue, 08 Oct 2024 07:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/v0/RyQF2hJiRs2DStS5WLe4bnbsguoEcvt/urryOGDsfInJ9K1HINPKSotfAgapqsd2ZsKv4lBb3SOPO@vger.kernel.org, AJvYcCUhCSASmIs85EZ6II0fC7b1G3rGthCR1pGWz7FUBi9cQn9sD3euamOOnIcdSznBMrfKyn4UruEIXaM=@vger.kernel.org, AJvYcCUiWXic9OUcO6JhPfdFhABr7pNSYBqQaZ6aRUxAceKadxx6BgelYq7ILegNyQdF2Gtl8sR/fHVfvIJi@vger.kernel.org, AJvYcCUnUGFhRQGXdZgJaJsMT3f1eX4s7wpZ3tNtUjeIWnFYNgJj2TjOgNfmK6d+wTOpkQhhrtJHlLS1P3cC@vger.kernel.org, AJvYcCUzHHcnL3Qtg+UKmZDTQRVIGkZWs8j1mBc1ffnMwGgt8J8/Bt1fO7yMDJgxaA+rzFb99oxUO63Saaxg@vger.kernel.org, AJvYcCVYuSqUq39Ei6NBbWX/kI5Vus/PPbol8ptpcfp9YUMl332j7rbgQTAYTjVP6fagZBrHBghP4zDTBEDznTTSVDTjepg=@vger.kernel.org
X-Received: by 2002:a05:690c:5889:b0:6e3:10e7:b418 with SMTP id
 00721157ae682-6e310e7bd0amr12032047b3.46.1728398790349; Tue, 08 Oct 2024
 07:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:46:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAX66bRKApsN3kLpp6Cezjx7AjgDt_q2_Lt6Qg3BaQfQ@mail.gmail.com>
Message-ID: <CAMuHMdWAX66bRKApsN3kLpp6Cezjx7AjgDt_q2_Lt6Qg3BaQfQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl:
 Document RZ/G3S SoC
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

Hi Claudiu,

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document the Renesas RZ/G3S USB PHY Control IP. This is similar with the
> one found on the RZ/G2L SoC the exception being that the SYSC USB specifi=
c
> signal need to be configured before accessing the USB area. This is
> done though a reset signal.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
> +++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
> @@ -15,12 +15,15 @@ description:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
> -          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
> -          - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
> -      - const: renesas,rzg2l-usbphy-ctrl
> +    oneOf:
> +      - const: renesas,r9a08g045-usbphy-ctrl # RZ/G3S
> +

Unneeded blank line.

> +      - items:
> +          - enum:
> +              - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
> +              - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
> +              - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
> +          - const: renesas,rzg2l-usbphy-ctrl

Nit: usually these are sorted by part number, so the RZ/G3S section
should be last.

For the contents:
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


Return-Path: <linux-pm+bounces-15346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5899526B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C50B1C25607
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C21DACBE;
	Tue,  8 Oct 2024 14:51:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B601E008A;
	Tue,  8 Oct 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399115; cv=none; b=PScWq7rPbJnW/WYRNcG991wLBxQNeJwx5+Mgn1o3y3gX1fDodhyQXPIQa84nZmu7tU5xBhFCqP268ELSLtuoPuw20RvCPvYZSXhsC1bH9VdyOCzHV7+nb+k5uhqSsujMmnaBVP/csXfXU+4AIvgSu3faLtm7aCBYWosDDId4Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399115; c=relaxed/simple;
	bh=jm+z9KCPI7wrTyNKF9MSZ+w+52JgfCvFUp9CLB7xotE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOMAO/3jMD224bKxVCnNfR+T1VsHLHsnYvir6kvx0QMtaUl9mD8sG/NA4JTYR4KXgdqPCAtL65W1LOOr8HBl3ShVl3PBXXaqxnHn7Na4Dr/3DMB+oAp+QjIoQPIGjsAhNCm04QEgkyBFfKmxleIVlWkkHrAYp4mPTw2ZPtfp1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e508bd28so22550877b3.2;
        Tue, 08 Oct 2024 07:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399112; x=1729003912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiAdTqgkCeMAY5igeCqnTzclkAkkQ30H915zKiiXQ2s=;
        b=deLSIaBE6iVekgR/gY58S6t35HYLc1OjmrQw+hNyX9E89DF6NDKX2v1FfQJBGJUEcQ
         ri0WJI1B1pK99IJTYRKTWcMcRG4yxZQgdaTOGm7ghJwgXew5AYf1c7A5+u8sIAbAjVpi
         qhDiDZEItytrD4n595WwzjmRKg6pJR8zrBcDQDu6KyEoIF2QD/hfyiB1zo+nlj2kiLjf
         luqPc8EAbc9qGReeRHO8TXh1fJbj1PPmQKHzhnpdM1pF2RrSjOYQ3sri8wbNLzJlbyja
         AKeJO9dYZvZgPIKX7N3nN8PYLcZMby8y8Wn2OEaHj3W6y8dWhYcBbJW7DyurBDxtdsfk
         QuXA==
X-Forwarded-Encrypted: i=1; AJvYcCVA+K9e2WWbF8JZfgUDBB/UgnVfsdCKVWDx6vQ3oMehnyomMIgPFnpFwUrv1XbbIPRzExeVqihZ5Ho=@vger.kernel.org, AJvYcCVCtX5QBgh+ifu8OHALoDCWvj6MVw3mj/7ww8MLeMmpu4oO2/BUAQYLNoIXOwBiRjpZStK0RWt0tDDZ@vger.kernel.org, AJvYcCVXyFWCv23qWC9Y4FLeL6Y1VkXPHzfTaiiZNSm1q6dEeL/ILI9VbeCGBNHeeLUIX/UfqT8b+rT4nkUVTjgg@vger.kernel.org, AJvYcCWJr3ngbgG3kiJw1UkaRnjOc9rML0xzvAgAHJO5/QbECaWQypzt/MpwEUvCTMyqdwXt9motOPkhFEPq@vger.kernel.org, AJvYcCWif+0QHhtOPPpAB5ad38j+hc6mIXtw+01KUv0NbkhY235OFLLZArKfmCa1JFa7JWTN/Z/5ugomVwe6PheWsoSgTm0=@vger.kernel.org, AJvYcCX1FloHxGks4cbAbpxxrFPAZeYPQuU2UCHcxte24DaHZYDnpLxOW5QNAjxTHQngTS6O5FL6gHfuWwX/@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpkHmVSrcb+3QAWaAOiTxM10p5mRwf6XCsWwmRl7m9qno7gCE
	Pha7IZvJ70AVXRAQuYjQDYi+Zw1Oju2D8GeKDRrfwax8v1gtSdYL4JR+xQBJ
X-Google-Smtp-Source: AGHT+IH8zAzhol++0FR866n1PtVpAZlxqymCVQSr+NiUYlaD97TM2WsQA44YQkv3YkrfNy5e/ljmTQ==
X-Received: by 2002:a05:690c:d91:b0:6e2:3f8c:8fe2 with SMTP id 00721157ae682-6e2c6fc77a8mr146012617b3.4.1728399111940;
        Tue, 08 Oct 2024 07:51:51 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e97d6sm14428387b3.132.2024.10.08.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:51:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e508bd28so22550267b3.2;
        Tue, 08 Oct 2024 07:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzDWSCntH4Ewa0ess0UuIQKEVn82XuM1oG6TvDJpYqJoacqGAuUGCP0AdyFY+gWZS21lhReKVCM51PpmD+wy9aZNg=@vger.kernel.org, AJvYcCV5VnvJ4ky52hTz3cF2TNT9HWug+Q9Hn8b2m/ssHGcnOHG/IdXuGjEGSngQ0bsq6VjZkIHp3JW8Iu4J@vger.kernel.org, AJvYcCV6K9LaiT5ql63tin6XIi22Zx1wcE+ai+ruYgNCeiWImUMcwJX2sCNquL01z96u/d4PGLhASu4Gcb3n0TIw@vger.kernel.org, AJvYcCVx4VRZJPAQlHq8ZH8vV4YGRtSE6fc28mf3TpA3mGEqrmTkf/bTeMttIRyz1/K2AvxzHy+7ds8X9ZY3@vger.kernel.org, AJvYcCWo8BxxDhMRNHVJ4oy3yYYcRT+8iMJzboHkyXfeExzB9KUV73lgtb8npZsGMgTqdCjyfqrmumG8oP2P@vger.kernel.org, AJvYcCXO6Kee6DmQkPFjbMzGPObhB+odcLqauFKcFE3gkED/yylCTMibTUNCI3GCRcESs6rl5eZuqMatDKE=@vger.kernel.org
X-Received: by 2002:a05:690c:2f05:b0:6db:db51:1a6f with SMTP id
 00721157ae682-6e2c703c243mr96576937b3.26.1728399109490; Tue, 08 Oct 2024
 07:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-10-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:51:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5asr8ppnfxKT2zXq-9ScK1zZUJ9Fw1fZZeU22jbTuWw@mail.gmail.com>
Message-ID: <CAMuHMdW5asr8ppnfxKT2zXq-9ScK1zZUJ9Fw1fZZeU22jbTuWw@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
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
> The USBHS IP block on RZ/G3S SoC is identitcal to the one found on the
> RZ/G2L device. Document the RZ/G3S USBHS IP block.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> @@ -26,6 +26,7 @@ properties:
>                - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
>                - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
>                - renesas,usbhs-r9a07g054 # RZ/V2L
> +              - renesas,usbhs-r9a08g045 # RZ/G3S
>            - const: renesas,rzg2l-usbhs
>
>        - items:

So we do have new users of the HS-USB block!
If you do have a need for renesas,enable-gpios, it may be a good idea
to proceed as per the discussion in "[PATCH 1/2] dt-bindings: usb:
renesas,usbhs: Deprecate renesas,enable-gpio"
(https://lore.kernel.org/all/20241002213652.GA1330004-robh@kernel.org/).

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


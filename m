Return-Path: <linux-pm+bounces-20796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51092A18F6D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AE165774
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80821127A;
	Wed, 22 Jan 2025 10:12:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E281A8419;
	Wed, 22 Jan 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540765; cv=none; b=S8kFIEzyNpi7alxXBzvjG/BsLjk6CF6uo9mBoI5wPQFhKFQgR4oA211t6L1KWsWDxXVaVQ6yv8yfT4sItSMcEW3OCGuLlNXvM2Z0pnznEdRbK7zb7H6Vm9q71TJuT+T2iWAqCdHF86nVa6mMFn0Yx2CHyDFAOle3HOy7Ik+PAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540765; c=relaxed/simple;
	bh=9u/+N1+qoNp5jbIi+sNll5CoJD7MHDOXvXMQ90h3bzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaCjn5Mcygj1Fhd345TCoQgkEYA3vExGAsvCBbTUkOTzEfMywxwnj4L/BTXCUxIP9mj+kAhTne+ca66CauT+fFHCw4eyqMFs2TbKLuiRVLwjaB3m+I9vpflsPX0t5nIRCdOcZiqnlff3K+3IeLYhHSVWUQqz5znPOErSLQRmCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afe70b41a8so1877008137.3;
        Wed, 22 Jan 2025 02:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540761; x=1738145561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FjAh7Ei78ytRX43ARrF1IGLCoNkOCTH/fahyOjt2Co=;
        b=pQKul9lNUwFjASO3StnA1AmCQ5b/d0/j4bJGPl9htUHQo1npxXsxjTTzayRkftsdmG
         xFynnS40NEEGTpYAuAu/UPHnEqW9yjZ+tm9R1ggU5ZWuUB5be3d9/B7p9raUW2OJEkMO
         PsVcUkJVVRcSz+dNv0qKT3K/tpeMQ61D0BTI9VxIeaUm0FWcBsex/DsIBsIZV3X1bRBf
         qrcfWkj2kbYLhDHgk3haCtunzN3aVmLMRHLdBtlyO4QzZlABzLE0xAVnnF8i3f3tL/Bk
         tOKvIsYEvTEdGdIGEzf1rsbFU2OdFB587HrdCri1hx9aMQp0c127eQ8OsohDNpGraLCF
         whuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUz/TbR0UwNg8EqPA/7Qf/n9GVAdlCELco6t6LjFM1kXQL7Gk5BWaITgv1oL4sGNjpchPr+ohvqGs=@vger.kernel.org, AJvYcCUgg4zzsCAMKm3dh25LWJSPO7ceBUUWvcv6dpiImIMDCkMejdV0kz+n7tpPtwnHnqNnu6L4dy/ZUoJZgjr3@vger.kernel.org, AJvYcCV4pnBIYDFZAeV9+yyQbkKqPQSNYCNiy0aYkn9DtYRGPMifYzqXvctYnNE/XaHuF/0USchEgzXff8Mu@vger.kernel.org, AJvYcCWXJU4AO0v0LX4zWRflNS3LZjVpeccDrf2r3ieuSuFYvoZOdUsJGFIoIbHike4LIghYo9HzvGEcyweGxQljaZxXnAE=@vger.kernel.org, AJvYcCXmdEEiLEyXbjjX8yt64+xxeYBERKvA57D6sYBrLebmSlJVWn73wz81SrrY2eLidaQzXIGWXRZubIx9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gRpye1q4I/kRToeDKMi3o6AnXWpgFU0WW62tyED6jHWyoXFl
	NrE4VIwxXVyPKUT7Udz5VUK2jaoY5njKfZzxlGFmCGPnGnAPfjnUE97wh3qQ
X-Gm-Gg: ASbGncshfs4I8kMF15VjFB69QNPhGZYQ3ai12uZVaEpo0YqrNgBXbV+3vCTffvcJ34g
	tpfIA3ut0/u/6+ndn1chfB0JeBBp/PwckM/1Li+/BPBjPLZn147rH83hHyEYVKNBAnXpdPn97KI
	7R1Mtdz8CsmC4dXtGXj+K92kFBLBj2iOof/s0A0+5FDkCb01bTFBHIuX5rAH+NCaEZBkj0i8rhc
	r1kCR+kp2yYEkn4K9j+0xfNo5Emg28xIXxuzFJrNreJGilsPZUEte+sNUehD+bfKwlIe4d5y/IQ
	HxAPSOQ0uLAZubqYOLvOQZxBXTWmsZQ2
X-Google-Smtp-Source: AGHT+IFpPcDjNxOxeyrHztEUN+y6gD1EP7coZlsspPsu5ucUBMOGJwKnQuMk2TBcGnFTD5tsj3RV+w==
X-Received: by 2002:a05:6102:162c:b0:4b2:48cc:74f3 with SMTP id ada2fe7eead31-4b690bdc67emr16350885137.12.1737540760936;
        Wed, 22 Jan 2025 02:12:40 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642cc7f49bsm2830788241.27.2025.01.22.02.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:12:40 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8641c7574a5so1704639241.1;
        Wed, 22 Jan 2025 02:12:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2CCDbU5vTVMjISpuG+qbj/BApW1XcHRjkVGsfMNc+5ayRcIkQvyofD88dCbOmGppouE91pRemnSkP@vger.kernel.org, AJvYcCUqUJauD/j1GbpZPuLJa/b6xKbPBVwmmuF7xlRm2a9yvAnhpiz3dbSG4rHY9Ginq/RCujK6LQOLfIN+0YkFLiOUobE=@vger.kernel.org, AJvYcCV4x86sD1hGtjsddx9FfhxWI1NnnorZO++nh85qt2vHUtBpPlcYfhTf1dTyVN4vYvkspW8KUqP0oXE=@vger.kernel.org, AJvYcCVIo1wpIKWuufNBot5WOnuxBT31ZAX8Ce4VnZxvBIVU6bGLLHFNeNE6kjsHJohg4vvkApsvPs4kqZw+xxMS@vger.kernel.org, AJvYcCW7Exg5V0f6o/SJhLiN7rd74CbFl0uu/eT0tdWpbSe5ysFBHyesbpV0g/fcUqicvez716fJH5GfcNP/@vger.kernel.org
X-Received: by 2002:a05:6102:3f03:b0:4b2:5ce4:2b4f with SMTP id
 ada2fe7eead31-4b690b5d82dmr18149923137.2.1737540760048; Wed, 22 Jan 2025
 02:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com> <20250103163805.1775705-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103163805.1775705-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Jan 2025 11:12:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUrU=wEORsTYA01nJKGDYyfGcbYUQ0PVbztWK89wAh6og@mail.gmail.com>
X-Gm-Features: AWEUYZnWOoKJ3RBtL6Pi7s9iVWaQT9ZdiOxnl5ZN6Xov2Ob1CcY6b31swX2Vhsk
Message-ID: <CAMuHMdUrU=wEORsTYA01nJKGDYyfGcbYUQ0PVbztWK89wAh6og@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC includes a Thermal Sensor Unit (TSU) block designe=
d
> to measure the junction temperature. The temperature is measured using
> the RZ/G3S ADC, with a dedicated ADC channel directly connected to the TS=
U.
> Add documentation for it.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

LGTM from the hardware-description point of view, do
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


Return-Path: <linux-pm+bounces-20798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF0A18FC4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9391C16785E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED671F76BB;
	Wed, 22 Jan 2025 10:31:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33E4502A;
	Wed, 22 Jan 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541913; cv=none; b=S2JhXQAPwXR6dEJGrL+wKuNG3AmBLLfd4RHSFbyO88jjQ5e0aYEsaQ95PF9yx0YlPkaaZTKWgd3dVdqMHQrMEZEd7uImyCPVoRmPynUKq144wKIcANPAvzjtJqo/+wl/Mk+abfjXVcIwUBTGElL4EkYmHIctiPD7PkjdRJ3WSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541913; c=relaxed/simple;
	bh=i0DMT725/bL95FWGOgzXfBKT8fFWUr6Puot+GgT6Teo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXBVSv7126cvWg3wFjQAwpP3UuML79KEatogmUKJSlPFE3fcPRN4RFdZptTwbEsV3Vyj2XMldVXzOC9QeRrZ4QhfIuWYIwPwCp7cBO5hOge9X1QP4nZUsWf86fnETNW/fj77XHq4/M9slY2vFPwjICYVBIdW1GQN3AyGVhAhEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51878cf85a7so1853603e0c.0;
        Wed, 22 Jan 2025 02:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541908; x=1738146708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+C2qs16toBww0G96C9iejd+wL2WWrrpbqoVaIml4Wg=;
        b=K7tZD4G/gx3+ytJ9btkJNCCtAP26bM9gkg9PGIKoNP5iQZsct34KpKZ6UxBzs3KqfZ
         Km4iR1VKHAOlJuS5RFf1miqXLkNvaTp7Ee9yVAEhhJ9SF9Tjuj/7D8bMhpu2crbr6t3i
         +nmR7dtwp/9XGiirMDRGMKtPWBaTS1501MvvXoyf7j462whJjWPimjQecWJOUHRPZsRj
         QGDoNJhZ2GVm4gkIy8fRJrFbLawS6lE917Y6mN8X2v9S0n/MWlSG4mFbCfCms7SEjP8Y
         3ZztfSvql6AyVzisa0bBewXqofQ1Y62PtF0tQs8Cm5VYDCXTr9SlbsXX+1noo9qUUCqr
         NLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUUzpLOMUUF4X1uND/SDiOk0BpvAJy2Y8SkTCgTo33kwOBbrZ9LP7pfC43eVG1aNEQojC4g7gc2KZPB@vger.kernel.org, AJvYcCWKPVtVCMlWKoEKxoWIG5EZnfUeF44WWGP5eg/mr6BkvTXKr23PdMoITizt3jO9MqL5AmmWdEaBr6g=@vger.kernel.org, AJvYcCWun82XN+yTbWMUPSzwGbce1s0ff94sTpWfQbPNtAWhCRHTZOrMSy8/MR7XoqxlJJSdcsfByDhbXrF6MwoT@vger.kernel.org, AJvYcCWzzrluvlMNYq4KGO770sVMvDAn5MtfCjUNorlKNAm3/+UlfEq8mkE00bGol7deMC0wAuygAv9/h2qt3tDB7B/IL0w=@vger.kernel.org, AJvYcCXJGLo5r1qsgK2ecXaHKjJYfW7ymVgytwevN+1VhOtjLmc0VT4kxjDNSPvvyGYYTPQRFubQHdFyqZkm@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6bh3EQSRlyfDaD9urvqe+piaiAT9HRRXpquuhl/Wl6kqaOzx
	/unslenDXbJBzT47pDqcoe3Y7UVu8kIFk7CdyVYmgClmKzQa6MgVErFinOxV
X-Gm-Gg: ASbGncugGTIQtg5T/2/vFZh5nH6Dv95+M7oYnaP+EQQbu1pJV3LOhUnAsxKEceU1EJZ
	rq9QHhixOJ51qW9VEhHENQDEFqfjth0SeZqarWf5vz2fiV660RwA9P2EE/qFw4MMY5M8+jrvDGy
	ev5WPfEjvmFJmDzsxowwGvdrTs6pfmsrd1zuiV085LJxSLyBi2QxegS6BtsCAWPpPs7A1OxyKNO
	EiKH5kIZwtQ5oGR4apycC0TSzFRZ9WvWHG+Gt+qyRYcvlljkIe/r8t6xNvkHJ4AfQ0AWjzQBzmO
	TuWRFtrbN1DiMxo4tU6GKYC3yE7dXnFo
X-Google-Smtp-Source: AGHT+IHidOOnDS3V5RkgoOmC/tXk48uczYJhm/AC4Jb1pnXZ3rywyvg3s5F7u2PnyjEannqIRamIAQ==
X-Received: by 2002:a05:6122:2202:b0:518:97c2:f21a with SMTP id 71dfb90a1353d-51d5b2c274amr14389960e0c.6.1737541908471;
        Wed, 22 Jan 2025 02:31:48 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf56bd59csm2117047e0c.38.2025.01.22.02.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:31:48 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afe99e5229so1645144137.3;
        Wed, 22 Jan 2025 02:31:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPK2JQgurWAJqtpRCwAhcssPBI/LRPtcppUhbOotqPK85K18Q8MuW/CWBXN0SpBnOnlDvpkkNfqk6AzzPT@vger.kernel.org, AJvYcCUTnYTM6iG57Afi7jV+u9p/Xbz9+uS4ZsIU/kGBldR0IdTXm5VhIGosNB688FRLQoVjA1cK8Ce+I9Zz@vger.kernel.org, AJvYcCXMlgTcdJbT5XgCdq/TIa/zD36a8ak2ZVLZ5W8Zlj0J1vPrjRWqUlxEpF1kYCR8q7IaDAxnp0vZG75TJMDT+T+1xIo=@vger.kernel.org, AJvYcCXm6cw8fhG2V7DY8KBXIuHhSOScHcDMwPNGC3LQ72ivO4Y2QKBsWY9ildfMFkYGuWwKIJ1Z8THXqjTc@vger.kernel.org, AJvYcCXygPIq3vpwu1+/Y9HJqUyY56EAjs6aURC2PMcMyXlQT1MUIKqsp6ha68Ni1K309MCOz/amHHEHLu4=@vger.kernel.org
X-Received: by 2002:a05:6102:418e:b0:4b2:4877:30bd with SMTP id
 ada2fe7eead31-4b690bfba7cmr16163436137.12.1737541907620; Wed, 22 Jan 2025
 02:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com> <20250103163805.1775705-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103163805.1775705-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Jan 2025 11:31:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOGQjnqk-M4FkCjnA0n3C1FR9-yZpRPN_X3yeMr4+fZQ@mail.gmail.com>
X-Gm-Features: AWEUYZkALm3737BqRxgqu-0dwJrFaMLAXr8UCLs5074DCuQFISbzFyekc8oFgvw
Message-ID: <CAMuHMdXOGQjnqk-M4FkCjnA0n3C1FR9-yZpRPN_X3yeMr4+fZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: r9a08g045: Add TSU node
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

Hi Claudiu,

On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI=
.
> The temperature reported by the TSU can only be read through channel 8 of
> the ADC. Therefore, enable the ADC by default.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Queueing in renesas-devel is postponed, pending acceptance of the DT
bindings by the thermal (and iio?) maintainers.

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


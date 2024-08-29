Return-Path: <linux-pm+bounces-13164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAF9644DC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329ACB25075
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819391B5818;
	Thu, 29 Aug 2024 12:35:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98A1B531E;
	Thu, 29 Aug 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934920; cv=none; b=A560xqqgHaHIud2KrrTCKlvsaTa8eY/kA+g2YkxLo5FCS4htpI9RpNtbdRGFkVVgkzFHX7Ab0Y3cueGAgl/Wpk8BZT1Sz5jTaUg6yF4IepvZ8IOmf3Wf6E+NjQwEsWAI/O20faciqbAr194oCQz6QC+pzDdRMAjVf2MiQyhNwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934920; c=relaxed/simple;
	bh=vGBKFDpY/2JZ7XatxShXTPt4YW1ZJUjOUZm4m0b9ue8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQlzi269Ag+1cSIyws1ptJXHBg80H+VKpjw6GkIHbPLw9Yvh3DZrYKfbDhP5lqrhMbLKAYvnLoekDKkgkmb6vyNDvyIdQyt5UmFnyoWksLA51R69U+VpINR9ryWTqPwe5MABRBYjKF/cbuxyBA4hcXkUQUI8g5EnCJjPKsVdcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c130ffa0adso6339977b3.3;
        Thu, 29 Aug 2024 05:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934915; x=1725539715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14V/EDucvcd+1DCus2mW3U6ZJ9nuoR181aW3vtTOiJw=;
        b=UKKJvlVKNdESUsphIxmP2CYj6RpltrG1UMiezGilmMEWC+vMPgyIBjuOEHb83A0YJj
         FxitSk4goLMc3JjfQNJ0AdsbGzrLxLDPc18Qa2kKyJr1K6zoFdamD+p8SiF7/uhNxFGe
         XfBnlR7t8XsFYFmZVMuQ8x0kQ08wkuTfpI6k3Eqs69jMQALpHva2m5y5DIjr0FnlGN4b
         e3aNRSN1hd1jHB0hSgB7vfMNBBSa3Yt+L7xSmeJpeGKELxXFyGyPODTtsSn88Ns5sn/1
         2iOuHZKdkM7770nlAWTKyvoX87l8UWmuoQHpQwSdcYY1caIJu5gmI50/fTeirVjrXXBd
         CKaw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0NaQcbpLjrNuh9+zG6dw7YnBjGQUmOkwSnM5Mh8xqHLaxb/riJT/+HqvZwA89VtuhNN+QZwYooM=@vger.kernel.org, AJvYcCVcHzHUA+n3ttI91mRttWC5Py4d7cd+9NWQSkf9rkA5Pimp7hTZyA1jkAPXxKhnzwYy98fQVH+Og+2Uxt0o@vger.kernel.org, AJvYcCWKf/otsz4IGKbnCP8bDlrXkeXhXNzXJEbJIJYx50LEe5TWDnD9eleyj7ByGRT1XZ5wARNMC3xWwVwp@vger.kernel.org, AJvYcCWy0sypPuLxI19662Obso9QRLRoAxqzfqzj8Q0YWgbfrMpsFJNv7pbs9dvuv1KmP7TIotYZ9ZJo/+ly@vger.kernel.org, AJvYcCXM1qAQM+qHBLHljL79NRd9p4yf3yEXFknPspEDQXnubASqcw0mF7g7MEZagAqWIxYJOss5qWSkt41J@vger.kernel.org, AJvYcCXogCRiQ00d6VPIgPE8DTQJUJpbJAsI5TDTsMrcm7DBSX6AT1htPWoNXOjGbRFkg4D3wg7aZ56hZ/WluSJIe31eVSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/L9eqtiST5a1GwTs74NpPRB5RScgr0EO+PvMPkgRathl2XzZ
	sjJ/wOIcaorAE161UA3Cgu40LHqga8QpTZ0KtsyPE6Iy4VpbrTZc5Pa8CtWo
X-Google-Smtp-Source: AGHT+IERzRtchaBopoGY4O+dwP13M32hvM5ouD8tZiGGaaILo9FWDYiCfoYRKJBp9V9B3U1GZV8TKw==
X-Received: by 2002:a05:690c:4a06:b0:66a:d93b:3047 with SMTP id 00721157ae682-6d2769e32fdmr30944877b3.25.1724934914591;
        Thu, 29 Aug 2024 05:35:14 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d438e169sm2200147b3.61.2024.08.29.05.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:35:14 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ca1d6f549eso7250127b3.0;
        Thu, 29 Aug 2024 05:35:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYfn/xwPmzKIMcAxHfsaCe1adeutv+BALeQ24Awz6WSNAhxiyZNSVSSSRJ9YY8fSzuu4epjoEZ7tA=@vger.kernel.org, AJvYcCUZOTG4NELOkZvLYJowl8k8+MPKcQSN285OEY9NrKpsY/UsBAuQwHTzgHxVM5kVDyOl22xXnugD8GEu@vger.kernel.org, AJvYcCWG8WpccfFVRyICzDYrKIJGDl95cibF5z29Qc7Iq058rPBG49GJCYq4eqhiJdSDcoSTD2jFdggpt68p@vger.kernel.org, AJvYcCWNPe/CSHv2NT1gbKt/E7nA/eJL/q3WbZaZCrnhsT8T4Ue2T978nlOVXnZBC8oEdY23GqUg35CbC5wRYv1iIYPzdgY=@vger.kernel.org, AJvYcCX1bxYNRxkW/Z77N9eNj4L0V8q8d2wpte9SKW/sMkx7ive8oLo/ZiqjwLjKRLYoty3E3cKKRUXbPezV@vger.kernel.org, AJvYcCX8gjc6Fv1debg1B9BI8bQ2c00ClN5g/jQdO9UOwkjNP6PArnWu80TusOwyCe9zJXNjLRIlYqsb+wyHoN/M@vger.kernel.org
X-Received: by 2002:a05:690c:fc4:b0:62f:4149:7604 with SMTP id
 00721157ae682-6d275e33545mr31207767b3.4.1724934912929; Thu, 29 Aug 2024
 05:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Aug 2024 14:35:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUV04PO2Rak9fLxWNFSEoqVp+gAKj36NcHhEKhqqRRL=Q@mail.gmail.com>
Message-ID: <CAMuHMdUV04PO2Rak9fLxWNFSEoqVp+gAKj36NcHhEKhqqRRL=Q@mail.gmail.com>
Subject: Re: [PATCH 01/16] clk: renesas: r9a08g045: Add clocks, resets and
 power domains for USB
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
> Add clocks, resets and power domains for USB modules available on the
> Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.12.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


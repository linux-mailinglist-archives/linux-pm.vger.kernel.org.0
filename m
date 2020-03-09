Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2817DC47
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgCIJVi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 9 Mar 2020 05:21:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36723 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIJVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 05:21:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id t24so9472333oij.3;
        Mon, 09 Mar 2020 02:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cW5QRu/WQLX7HG/+uT7JbwnBxTD9IJb8uwxzlsc003A=;
        b=BANk64tp4JYSPTJpon2r3Pr2USpsXoXwYHs+9jbEsLJRyWyia6KUG+b4bUy7fR4HJD
         ruDuUi7hAHz1p55cutg/SejjhSAcbuwWeGAo2DyJJTPkNBVwqBvrYldxMr8LVTG/pIGT
         5Gmt0OQpz6uqwbSXpPn1g3+WlXumI+kbvKyFv2q9cpA7Z4xeAHLGLtQ9MdZdLEU8nA50
         GsL4m7de7zhczX80GQsikUj7Oe6jLrWefsWcuhZLUW0CtlBNiDZ5qYnxUoiMiojSK03j
         GUPp5MChy3IHXR++BEUOfCMGZ83xmq6Nlcf+ExhecO6sHqqRB42OksNRcKqs8TVHQXt5
         EUHA==
X-Gm-Message-State: ANhLgQ3vFTCW448xz13sVU9MF4EeyX+E4C4ZgmNzTPOQVGu6gBsgpE4k
        FvdGkj43RomTmR0ve4TGL2v/Wg+CqrMDDhv4WLU=
X-Google-Smtp-Source: ADFU+vtbOXPyRFXaIDFk8cCnkW2knsMp8Sqc7CbW2cu0aR3vXAMSmqmgZ8onL4mKFmGV/6odqwEBcjQBfTTlYHMNcO0=
X-Received: by 2002:aca:5ed4:: with SMTP id s203mr6496923oib.102.1583745697858;
 Mon, 09 Mar 2020 02:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200306110025.24747-1-geert+renesas@glider.be> <20200308163543.GD2975348@oden.dyn.berto.se>
In-Reply-To: <20200308163543.GD2975348@oden.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Mar 2020 10:21:25 +0100
Message-ID: <CAMuHMdWprMpoyQuDFCs+R4NJR87FVnufQNqxmJGTiJXK_v5C6Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77961: Add thermal nodes
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Sun, Mar 8, 2020 at 5:35 PM Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2020-03-06 12:00:25 +0100, Geert Uytterhoeven wrote:
> > Add a device node for the Thermal Sensor/Chip Internal Voltage Monitor
> > in the R-Car M3-W+ (R8A77961) SoC, and describe the thermal zones.
> >
> > According to the R-Car Gen3 Hardware Manual Errata for Revision 2.00 of
> > Jan 31, 2020, the thermal parameters for R-Car M3-W+ are the same as for
> > R-Car M3-W.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi

> > @@ -785,6 +799,7 @@
> >                       status = "disabled";
> >               };
> >
> > +
>
> This don't looks like it's needed :-) With this fixed,
>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks, queued in renesas-devel for v5.7, with the above fixed.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B58EB798
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfJaSz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:55:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJaSz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:55:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so6980529wme.2;
        Thu, 31 Oct 2019 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEZ2MGdwSvgyihy3BgAVtU7EXgoX4IyUpv+yaDE4EcM=;
        b=ZYtnp5VtI2P7IqkhTg1B8qmX/LGKFnyoyP1OI02dcs9Y9z49dyvvKdcCH9EFsu7iyJ
         t3/OP80zD06K5ZwZsq3mCVndr+GGQO6XZ+W2cyUIPfufhkG7kSrg8Mp7cfm2aDfxLUgV
         eu11mNVUZvgFNT+OXFwpttyldXIHuSXsgwyUzXzLiEAZj5GUUmmBi7xHjroJUTFmlxXp
         7qra1V80Vh6JiZ2mfcX/uIaSdLZJ7w/AN54R2pbz3oBnrULe1IxtgUwIpFIIrkVsqFw5
         cbpacAfI5X7UrSZxxYKVBLQNgtp6ojnq1PgdlRoTMg4cI/bS+xYJaB0eEiO5W/GRwdOf
         /sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEZ2MGdwSvgyihy3BgAVtU7EXgoX4IyUpv+yaDE4EcM=;
        b=tGfSqBmJEv5vaelaaPmluVSZ6oC0d3HEMpVPh45bQ5eZTAzo7Wwfw7k2o3kwksG0jf
         yTlgcfXQxoJNHdGo4okbtsilU4nDglUDGj8CtkO9QV+me08iWYOE1iofQ9mfdhfBoVtq
         9DyjiJoKbvbF3zaBZ5dboXSs3CQYBH2xFHU994HIG5w5mngjbiCci2P1xXM7hrzeoEl+
         K1SavmSqXUpLzIucBkgJEGiICbjaDmPblc5MDRyv1myiVu+MQuDa2DOLmUHdMH+cSc0t
         cBjClePFDnM6CH7C8wmtz87VYBI5RTt2RtJ/aoGIYfexjRqj8iw09B6K9JzdlmqVLAU4
         Ns0g==
X-Gm-Message-State: APjAAAXlKbnNx3B7QYk3PC5+w7qT9U6HFzkeSAzMlU0uwtwIIH2zq3Xc
        CUUe7q6xHK+GOTLOwZC0itsv3dZ3Ga90w9Ht+/M=
X-Google-Smtp-Source: APXvYqzQvRT21L0PVgbV5c5C9W19QRhbCaQ8fQ/tMOUZwJgzzYQuw10WGZvoatXernuYn4EhUroIbjQ5XFwa10cGKYc=
X-Received: by 2002:a1c:480a:: with SMTP id v10mr6775812wma.138.1572548154853;
 Thu, 31 Oct 2019 11:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191031181359.282617-1-megous@megous.com>
In-Reply-To: <20191031181359.282617-1-megous@megous.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 31 Oct 2019 19:55:43 +0100
Message-ID: <CAJiuCcdZqpoXKuupk_w3F1npZgCHDgb=+Fdd1ukKA22K2PJ6Ww@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] cpufreq: sun50i: Fix CPU speed bin detection
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ondrej,

On Thu, 31 Oct 2019 at 19:14, Ondrej Jirman <megous@megous.com> wrote:
>
> I have failures to boot on Orange Pi 3, because this driver determined
> that my SoC is from the normal bin, but my SoC only works reliably with
> the OPP values for the slowest bin.
>
> Looking at BSP code, I found that efuse values have following meanings
> on H6:
>
> - 0b000 invalid (interpreted in vendor's BSP as normal bin)
> - 0b001 slowest bin
> - 0b011 normal bin
> - 0b111 fastest bin

Maybe have some defines will be more readable no ?
https://megous.com/git/linux/tree/drivers/soc/sunxi/sunxi-sid.c?h=3Dh6-4.9-=
bsp#n213

#define SUN50I_NVEM_INVALID_CPU_OPP (0b000)
#define SUN50I_NVEM_LOW_CPU_OPP (0b001)
#define SUN50I_NVEM_NORMAL_CPU_OPP (0b011)
#define SUN50I_NVEM_HIGH_CPU_OPP (0b111)

Regards,
Cl=C3=A9ment

>
> Let's play it safe and interpret 0 as the slowest bin, but fix detection
> of other bins to match vendor code.
>
> Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver"=
)
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>
> See https://megous.com/git/linux/tree/drivers/soc/sunxi/sunxi-sid.c?h=3Dh=
6-4.9-bsp#n484
> and https://megous.com/git/linux/tree/drivers/cpufreq/sunxi-cpufreq.c?h=
=3Dh6-4.9-bsp#n428
> (1 is substracted from soc_bin number here!)
>
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index df35ef3ef567..41dad03e245c 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -71,9 +71,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>         efuse_value =3D (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
>         switch (efuse_value) {
>         case 0b0001:
> -               *versions =3D 1;
> +               *versions =3D 0;
>                 break;
>         case 0b0011:
> +               *versions =3D 1;
> +               break;
> +       case 0b0111:
>                 *versions =3D 2;
>                 break;
>         default:
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20191031181359.282617-1-megous%40megous.com.

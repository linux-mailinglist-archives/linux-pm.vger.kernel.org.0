Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB519D6AD
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgDCM1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 08:27:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39707 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCM1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 08:27:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id u9so4781160vsp.6
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo2EZUNeB9SsWLhfGdO4NXUFfi3h/ZgSDOZGnGz/M8M=;
        b=AWTYy8y4zaClO/E3QrKZnMlUQae7ZWH/UnD3yozTj2BZivUYWSNVsWc8JkBuB+NIwf
         AcFYWWGWuvb5i0nj0fsftLGlbHooXGodA2QURbiI2wVxmFMdYgWV40LlgLU7RkFFbYH0
         BBfpXYmdxE1q8oIPu2qSSY2PCA4Hg8AC7+NjwcFXnZ+uzmT1GFk0+qJsuqaZ/VLfWvDP
         LtxO+i/cfEYCZJ0Dc291wQomb4Dr/uxJut004AZ4gePqeNQlV0MNbRWIlTi98WZwK0Nh
         S0XOkLvPsAPN0fdRxmYIW22+eTeJ2K4lq75U2VFpcDlB5KBDN9/cg/dvLyc7F52R4M7E
         sasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wo2EZUNeB9SsWLhfGdO4NXUFfi3h/ZgSDOZGnGz/M8M=;
        b=KLl5QATEGREsmUsie/v56hBqN31swUySTLAk6ShMbW4o0cc3CsjdqcM3bIWuVumkp8
         ZmcOIe9eGk7zQuFHyQBP8roTOiIsag64OmMQizNqpR3qOvbvQsw9wS/LmtbKlYbm5DCq
         OTlbdYoL5NMEZiMpQMjApP+eeQ/frXWSpQTxtSJqX3v6ZbJXMXLZiP/UUQL/oFFqFuBa
         Y2MzxJYZdXZ52KfZtyKWcJuLDroReKFaYUuRihr0PE4eYpUxjD+VJsuz98x5dxDH3eLn
         6kP1OM0ihbHQHPZ25nE+d35KHE169eVWI/N/Ak282K1db3qqLc7IfFHZK/k8KJ0Zp1M5
         LHTg==
X-Gm-Message-State: AGi0PuY6RSFL2+XPolPRSkcUgeP73exxvelIrTjtQP3r95sWwOf1nMVj
        xPYLPM5g3BT6UvnnLmWrm8ojZalGwOhHWIyXlMjRug==
X-Google-Smtp-Source: APiQypK3zlebDaHIYf3xJ0SdPkARdWrQq4THbXVO5Hj6xfMPT8VmYGqXxqVDetDL0Cu8CSgCsMIkNhk2Qk2txrZ2Wlo=
X-Received: by 2002:a67:870f:: with SMTP id j15mr5889031vsd.95.1585916825114;
 Fri, 03 Apr 2020 05:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 3 Apr 2020 17:56:53 +0530
Message-ID: <CAHLCerPVuZrNiSh45w4TF6jKmZ+aD5aBZCcCK87i4Txdfh_Z2g@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: thermal: imx8mm-thermal: Add support
 for i.MX8MP
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

On Mon, Mar 23, 2020 at 6:05 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add thermal binding doc for Freescale's i.MX8MP Thermal Monitoring Unit.
>

I realise this got merged already, but please send a patch converting
this binding to yaml at some point.

Regards,
Amit

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> index d09ae82..3629d3c 100644
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> @@ -1,10 +1,10 @@
>  * Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
>
>  Required properties:
> -- compatible : Must be "fsl,imx8mm-tmu".
> +- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
>  - reg : Address range of TMU registers.
>  - clocks : TMU's clock source.
> -- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
> +- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
>
>  Example:
>  tmu: tmu@30260000 {
> --
> 2.7.4
>

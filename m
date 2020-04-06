Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2219FDF8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFTTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 15:19:03 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45729 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTTC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 15:19:02 -0400
Received: by mail-ua1-f66.google.com with SMTP id 9so358545uav.12
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjAfYfpfwR/Uhuxu4iW+Imv0nmFvljHi7SshWdYw2xM=;
        b=IhTkbg/YrdV9CWgF4LU1QM5yNI9PoTaAT/lHfXx7ntA1TFAbRqF07o4m4oVedDzL09
         RRdK3/5Jb+Ep18uOnJkJGm74pLTDz0AcFcX3dGrKDhjpWT87aCFU/cJBnZgJAMzYQKX6
         U1OGTTEbogXxeCfMhfLykTt6nJeDmulQWt1m7CYKeu/QKsl0F/xbYK77Abf2jh2TwXb1
         eedchPfzMERpZVeSRlEA1jTVZGgA0d/o7yzMaxBo1TJfqOzcmzbmS5BkrOuoUBYLFvlQ
         bAa865MDmFZAXeIgNhXIJwdnZ0/x/z9HYK4hEiSBwJVpF45lVJZoe3kTwNpLNRNzOkq9
         0hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjAfYfpfwR/Uhuxu4iW+Imv0nmFvljHi7SshWdYw2xM=;
        b=NgldMwNsrHI5O9DZYrKWvx22YF7WsZ/DYS6e7h/huP4BOuFd1m5jzkuIxCzqYwyE3W
         zQoBmuU6X4WKukrd56V60OD21s3n7nVn2fsrgnjRbN9aLfNcfJJ84PlHiOhKpbU+bCll
         gAAaYAzhPVQWm7t+aRWRznaByLVgVwu/R/ru3l8rVjl3BVKe+L6iHbqW0DYOMiJnhQ2z
         FyNIJsS5sZgbJogapLtV8q/LgwE5+yeDeg5QtU2YTZcopXAilLdiueNmqrqiA+Lh0H1R
         BY1fqDYCVKqBDESYDyNlm4Q/rPGJxmg05lDeU/Mx8eSYxC++FJpa0mJxKKgjiuGmLCsF
         LPYA==
X-Gm-Message-State: AGi0PuY1mARaGW7ftELcS9DUL/xtBZ/GLP9Gdpvqj2zcGnrRp0LD9v9J
        kl+Bd//yksmNj7o0w5o2SG34eNAGSozbibKpcSD91Q==
X-Google-Smtp-Source: APiQypLHaO/009rtrIIFj+TOpL4Oald+Q5Coyb4NlVmf9tNta8n6ctHnGaUajSTwxn4kl/rUSiWPoeWQfNaKQ7MNrOA=
X-Received: by 2002:ab0:654c:: with SMTP id x12mr963381uap.48.1586200741414;
 Mon, 06 Apr 2020 12:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200331075356.19171-1-j-keerthy@ti.com> <20200331075356.19171-5-j-keerthy@ti.com>
In-Reply-To: <20200331075356.19171-5-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 00:48:49 +0530
Message-ID: <CAHLCerOyo0D=A14wmRGZqSSAmDj0X1AF1Ht1zV0ODDZcW0YqFg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: am6: Add VTM node
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, t-kristo@ti.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Keerthy,

Should the subject refer to am65x instead of am6 since your dtsi file
is called k3-am65-wakeup.dtsi?

Regards,
Amit

On Tue, Mar 31, 2020 at 1:24 PM Keerthy <j-keerthy@ti.com> wrote:
>
> VTM stands for voltage and thermal management. Add the vtm node and
> the associated thermal zones on the SoC.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f4227e2743f2..54a133fa1bf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -89,4 +89,15 @@
>                 clocks = <&k3_clks 59 0>;
>                 clock-names = "gpio";
>         };
> +
> +       wkup_vtm0: thermal@42050000 {
> +               compatible = "ti,am654-vtm";
> +               reg = <0x42050000 0x25c>;
> +               power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       thermal_zones: thermal-zones {
> +               #include "k3-am654-industrial-thermal.dtsi"
> +       };
>  };
> --
> 2.17.1
>

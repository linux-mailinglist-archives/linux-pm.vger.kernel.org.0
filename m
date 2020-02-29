Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6631747FF
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgB2Q3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 11:29:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52380 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgB2Q3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Feb 2020 11:29:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so6767190wmc.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Feb 2020 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/nhS7fRXWHjddQ2mW6qgUCBhU766o/FgbNANhrsBC+c=;
        b=SIEnl2c4LTlz56TnuowihDkAwHNgn0iRVkJm3p3VjdUo+NAOW0iAVBgUQCS93z+qC0
         NT/o0F4dGyDIfEKjqkkST4MXWGElsz0Ms3ijH4V1bTcuhOe2N/ISC7T3Pw33rNt1yb6i
         GoLFZG5G0clR5UIczr7iKW2GGVbFANq8SyTJzqmqYAgJBEFmyOo0FEBRgbcFXLdiVt9Q
         UpniXAW9a39DtmI3q75R0yMYdeZHZEwOc8LSKN3YTICHjqoYUuBiPT1nralowAP0Tnnv
         u38Hk6QCZptvhO+2BwbnflrKwueq3HYZMib9xY/OO2HWHKK8aubquWy/I7h3o0bMu9Kk
         X00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/nhS7fRXWHjddQ2mW6qgUCBhU766o/FgbNANhrsBC+c=;
        b=XlYDiJDoH+u68B99/fMHea5e4b3F85HSoftJXSlV6CzTWqf52oo9HGVKIwyIhuqTS3
         92/BmryPzwSjvvNNdEWKTLUwJSY/4TzCv3BjNQBu9FAYarjvgOvP0S/fIL9xkCM3vGPc
         LKHgin11jAaT8yIDHuZcwSi2mZ47lUmc1tuoDrFuX9vazmZWfPaFUojxkUYbBgFXCCH6
         MWmKl2E60mx3CKEbDT/M+uVJE2odvM6BBjWvEKywszBnXNpwlGjZn8XdnrCCD630FUmJ
         Vve6BM1NYxJz2Hq+WMkipYStVhTr8tfqL9MAl6Dk9z7Kf9LWOK3IQ2jcbBPElFzs4S0E
         25wg==
X-Gm-Message-State: APjAAAWOFdXRK3o7wDwQ5Op+9TTu17A3qRQKLAX/Fl+yYvI4sRq1Ly2T
        qd6PVb4gGCDuynmlKX2dy/JiZA==
X-Google-Smtp-Source: APXvYqzfqcYtCrS+L+2YW0wCapvE4z22/nu0RMLPxck3ioY80N+w/B/BrxC//vE2fGmjFlcQRyFnqA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr10430395wmj.170.1582993741675;
        Sat, 29 Feb 2020 08:29:01 -0800 (PST)
Received: from localhost (229.3.136.88.rev.sfr.net. [88.136.3.229])
        by smtp.gmail.com with ESMTPSA id k7sm18113920wrq.12.2020.02.29.08.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 08:29:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <1582856099-105484-1-git-send-email-jianxin.pan@amlogic.com>
References: <1582856099-105484-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Sat, 29 Feb 2020 17:28:59 +0100
Message-ID: <7h5zfpbbn8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Missing ';' in the end of secure-monitor example node.
>
> Fixes: f50b4108ede1 ("dt-bindings: power: add Amlogic secure power domains bindings")

Thanks for the fix, but where did this commit ID come from?  I think
this is the right upstream commit:

Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")

Also, when you resend, can you cc soc@kernel.org.  The soc maintainers
are who queue my amlogic tree.  I will ack and they can submit to Linus
for v5.7 so Stephen doesn't have to carry his local linux-next fix
anymore.

Thanks,

Kevin

> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> index af32209..bc4e037 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -36,5 +36,5 @@ examples:
>              compatible = "amlogic,meson-a1-pwrc";
>              #power-domain-cells = <1>;
>          };
> -    }
> +    };
>  
> -- 
> 2.7.4

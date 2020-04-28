Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155C51BBCFC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD1MD3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgD1MD3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 08:03:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DBC03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 05:03:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so21195978ljl.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kurMV7kbW7+mvXw3ERlO20xeNNN/mjD6xvxfhwzC5zw=;
        b=IFenHsO7riD6AM4Ud3/L6sM9M0YjJLGiT+OwnArs5ZnlCD8F8G4YkkebHMMknSnyta
         KZASg9FUq4FH5SmsgxV85H4axxfeZqCiZhH3DZq5Qh+maIzlty8ARsgz2HWx4pBli9Se
         o9WAuYZgOBsPynXL9nPXT3zTJYzfQEQBEFUz8FzeXzzdzGYGHVzPpol90dFJO+eJRpzi
         uQ7407QrDoGrCg3hhrR7XGHAI7VT764J78dAGvV2+vVW40TtMGaDt6oDwxCzB/id/ywN
         bL+x9NBZBgYY60nBP3oWTBxm01KWzGmrBXf3kZ0rxPNGDL0FpU4wtdKJpAaJM3MOl2IZ
         0tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kurMV7kbW7+mvXw3ERlO20xeNNN/mjD6xvxfhwzC5zw=;
        b=TRQq8OiluOR4QELQVUTgW7g9DkCQVTTp4zGs9kbi8JQkz7i2kHg9Ba5+8DNOhX00/j
         7VvSDOXsxrBl9o4iPobvnh1T6nnpnD1JTSQcoLyIubPTzjl8xegtgnactbGZqhPJXdY8
         +yzomdBmVtRh3gMe/5zycy26AcoWI08US7ECkgtdeSv1T/bhTH/OCmhAdhHTgkGswT3i
         bFyceQCAF/MfXLiY0eJKU65xReFii6MLYkblzN6OBzIXzNdXNljrsG4MfTAfG2oqszMe
         Suqt5Xcr99WGI1NNKdIiJVrM1FI4zVjR1LGjMGbe3JjPHD9BgLmp2sMV3oyoIYjcZAE+
         5x0A==
X-Gm-Message-State: AGi0Pub7G8oN2XmnQTlaAtc+SyzZ838Gx5jyJVhRF11qjATmCVDExhsw
        K4wnB6CYR1iWuS0VFgQqReWnLg==
X-Google-Smtp-Source: APiQypJocUaXEVxf7Ffq/LFP34lav1VV9xTIbo8V3CIHsS7sk7IsDiiN1l9tkgFwkFtAW/7O2WxTqQ==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr17704265ljj.70.1588075406336;
        Tue, 28 Apr 2020 05:03:26 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id y9sm12495001ljm.11.2020.04.28.05.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:03:25 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:03:25 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add entry for Renesas R-Car thermal
 drivers
Message-ID: <20200428120325.GB1372619@oden.dyn.berto.se>
References: <20200305012721.425330-1-niklas.soderlund@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305012721.425330-1-niklas.soderlund@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Soft ping on this patch. I'm unsure who to pester about this patch being 
picked up, should it go thru the thermal or Renesas tree?

On 2020-03-05 02:27:21 +0100, Niklas Söderlund wrote:
> From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Add an entry to make myself a maintainer of the Renesas R-Car thermal
> drivers.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6158a143a13e075c..2514551ac932b817 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14205,6 +14205,15 @@ F:	Documentation/devicetree/bindings/i2c/renesas,iic.txt
>  F:	drivers/i2c/busses/i2c-rcar.c
>  F:	drivers/i2c/busses/i2c-sh_mobile.c
>  
> +RENESAS R-CAR THERMAL DRIVERS
> +M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
> +L:	linux-renesas-soc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> +F:	Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +F:	drivers/thermal/rcar_gen3_thermal.c
> +F:	drivers/thermal/rcar_thermal.c
> +
>  RENESAS RIIC DRIVER
>  M:	Chris Brandt <chris.brandt@renesas.com>
>  S:	Supported
> -- 
> 2.25.1
> 

-- 
Regards,
Niklas Söderlund

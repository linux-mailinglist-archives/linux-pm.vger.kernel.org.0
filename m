Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15843267A29
	for <lists+linux-pm@lfdr.de>; Sat, 12 Sep 2020 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgILLxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Sep 2020 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgILLxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2020 07:53:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A090C061757
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 04:53:00 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so8545876lff.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IpDA5lrqpoe9BhHzHEKcDdzah7WCXhPLSe4uwf4HayU=;
        b=0TDzUIrd5WeoitfvoSTyJ+emMF5/BacQv11/txWOChQQeYZCc+kKRuMW0Y6rcvM99j
         fAwP8fmEN+7ZiwDrs35uA7tsDkd6ap+GhjJWSs8NY8him2c1KOBsCrS2fGcdgnb4JN/C
         QQErpArSKOjmVycQK+6tnooH/0gpRHR2FDYOmYAnzy4We/sOvVJPSNM2Tx9qtUv6Dite
         TVA5DEEMMMlwoJGF83MCw+klch89BlMDGWrfOKMqmgxJILdOh/H3upJUpsql/aL+5mxn
         FDhponLQKKlCnI2UR4umJKLTAXCduZ0ewdzK58C9X+1EagPhl1uOOnJnnQfSPd4A4t6h
         q7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IpDA5lrqpoe9BhHzHEKcDdzah7WCXhPLSe4uwf4HayU=;
        b=PEXtK5F+H8OAs0aVPQKFUjAe2S47NBE7Xq9B7ev46gdEfJouxKPChQs/EobcgCqTVe
         u/bumlFcxezXVAszXOtieC0K0LLFRACmRp+x5P8/oEuwAaOf0Km3vryU+dWPJgd5NCBa
         VxG3j7DKMfNAPK4q+QLdD8zek1NoG0EU1RmFh/zPwgRGN7uPhO/jOGWzjK6pDAEe+9GN
         ckm23XU9a3YUTqkrDcjReXw6S/X7qSdQ8LnctBV+jveTpsVfuqoHk2uBV+L5uDTeGtw8
         mD2q2j87cYi8cEqAfjWu/QN19N4ws+b1QjeryAnLnOdlqfTNoggXzoXmSs9xrDTuY4mk
         NqSg==
X-Gm-Message-State: AOAM5316cA4MkK3PCjQWQT2lZFtAJbw8lz5L5U7qxcUch8zkgz3deB9k
        84cCIbh5UGJvN8l1R3TM35XWpA==
X-Google-Smtp-Source: ABdhPJwe/ic7w29H4PUhdB4LYAjG6LKQFEfW/u5HIb4rpcMPyN7QGCJkD6Fh0qXTQkaw0ph3r8243Q==
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr1439042lfq.230.1599911579231;
        Sat, 12 Sep 2020 04:52:59 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id w4sm1404951ljm.50.2020.09.12.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:52:58 -0700 (PDT)
Date:   Sat, 12 Sep 2020 13:52:58 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] thermal: Kconfig: Update description for
 RCAR_GEN3_THERMAL config
Message-ID: <20200912115258.GC674140@oden.dyn.berto.se>
References: <20200911100148.19673-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911100148.19673-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-09-11 11:01:48 +0100, Lad Prabhakar wrote:
> rcar_gen3_thermal driver is also used on Renesas RZ/G2 SoC's, update the
> same to reflect the description for RCAR_GEN3_THERMAL config.

Same comment about the commit message as for the VIN and CSI2 series 
with same commit message. With that fixed,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  drivers/thermal/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b668224f906d..7edc8dc6bbab 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -346,13 +346,13 @@ config RCAR_THERMAL
>  	  thermal framework.
>  
>  config RCAR_GEN3_THERMAL
> -	tristate "Renesas R-Car Gen3 thermal driver"
> +	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	depends on OF
>  	help
> -	  Enable this to plug the R-Car Gen3 thermal sensor driver into the Linux
> -	  thermal framework.
> +	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
> +	  the Linux thermal framework.
>  
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund

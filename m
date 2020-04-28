Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB241BB501
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD1EPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 00:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgD1EPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 00:15:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239BC03C1A9
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 21:15:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so7825769plk.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 21:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fb3EFsD2bZpljctpIMaRg7cg/sbgMTBtFSzZZIOBqzw=;
        b=eCyi1KQ3lLoj8jPxo2jyoo7NdvnJH7nnPkJ1Jset9stBRdLpSEU7kxDiN7XoQbC2n5
         76d+P+/c8AOhBdAhuDhKNrp7FSqN2KYvsOfnkEBXBUJzSCNfH+T6pEUQbOsbuO5kUaDU
         EGEWQSkmsxbNwrbWzgbSjKg9KuOUnAtxNuyrcsK8PknrRSv6euVUd6NrtskGcig3Bh3D
         bZqxyhNQYoU3KvxdlWGeNJeN/2K7WdjfwrayDGnCJ+TsX6M66ob0c4fq8QYC0g9vlbib
         V4eeqbhjtculExwj3ZZ9a6MgP/z0HLynANqmHcxqKJpP0DxQczO3Pf1W8wCusE0kM2dB
         eOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fb3EFsD2bZpljctpIMaRg7cg/sbgMTBtFSzZZIOBqzw=;
        b=bARSQzy7Nang9Ts8UUx/XumMRkucWErKSQ/4T8xgZvUk4gxxiHnh55XyLqOuyf73ef
         k+XK/71ysnttxmqOJhC9sGSjaJgKNrpsGseBmgESrsneH59o5w+5sXgLkio+MD3U44r3
         fY7cEonAzUofVAnTBCOgnRKmbwU2q/E3da24fU5fgpqbxAWyTzi5WzHbk+CmNQ8wv2J8
         HK1TYoxBhsoVYFBZdcdaEfsYYl9YbK42mYB4zlTacsDjq3560VPcegC5s4ZMa3clc4TJ
         Pp+TdhvVq4OahMRiapn9cd1/UFbxBI3HCwOQ92i0PtkQDOdQRIcINO8znI4Ph19Vb36r
         TK0g==
X-Gm-Message-State: AGi0PuYJeqO5hUVyod2+jrFGursmAOEW8fEMGbMA5/jOGt2/cl8OtmvC
        KuFTTerYD+sE77zR0SFGuFIUzw==
X-Google-Smtp-Source: APiQypIZIqGkq8jg1GEKCshppipgTRGbqcy6ym6OtKkwWJ2Zpsd+pPaFRNwGK8ZQXD4A6aPYj+OHgg==
X-Received: by 2002:a17:90a:7a83:: with SMTP id q3mr2490951pjf.162.1588047315839;
        Mon, 27 Apr 2020 21:15:15 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id 28sm733064pjh.43.2020.04.27.21.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:15:15 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:45:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] cpufreq: dt: Add support for r8a7742
Message-ID: <20200428041510.ezypspd5givv6pv2@vireshk-i7>
References: <1587992010-7203-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587992010-7203-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-04-20, 13:53, Lad Prabhakar wrote:
> Add the compatible strings for supporting the generic cpufreq driver on
> the Renesas RZ/G1H (R8A7742) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index cb9db16..148aa66 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -53,6 +53,7 @@ static const struct of_device_id whitelist[] __initconst = {
>  	{ .compatible = "renesas,r7s72100", },
>  	{ .compatible = "renesas,r8a73a4", },
>  	{ .compatible = "renesas,r8a7740", },
> +	{ .compatible = "renesas,r8a7742", },
>  	{ .compatible = "renesas,r8a7743", },
>  	{ .compatible = "renesas,r8a7744", },
>  	{ .compatible = "renesas,r8a7745", },

Applied. Thanks.

-- 
viresh

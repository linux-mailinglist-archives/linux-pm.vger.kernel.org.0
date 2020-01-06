Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBE1316CD
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFR3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:29:13 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46372 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFR3N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:29:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so40082512qke.13;
        Mon, 06 Jan 2020 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxZmBvBguF1JcQOjsls5F30x6tlo9ctviEfiJvkYBfs=;
        b=J3cwtQO+u6RU4bfiCikVMB7Fvel/CoINo9oGSTbye/Gz0zWBDvkBkc6C6gmykLkmM6
         JolbSRBFZU94D5vJ3a5toJ/T7sHV+rsuSHvKkqRlFupT4yJ78XKiFP+5d5QfOTEzfH2Q
         MkJInwxDkUjsPhFCEGjgwGZMjHISfUCmKtiQlu7RtgRHoU7eaCP8JANW92zT2HAu5jam
         idoOXB+SzZwp9Kp7VAesfSmgtvlo9Aq1lpIStOwv8wTSiJLOLovH6gkMIXKoe21pGL/W
         4xDNsapUPCoyQIbUDU4+4Hxr/o06UlgyyjD4B2dHK/1JuupEDhrbGrTM00ppNuc02WII
         df/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxZmBvBguF1JcQOjsls5F30x6tlo9ctviEfiJvkYBfs=;
        b=M2UKvrANDFrlO9DRIEadjSs3dCTjhUADama8aMP0b5uhsZabHyEMFqjHeECFXr4ZRo
         bs9ickA39IN9r8K9IDctx9b4Wyv8PSJCaGb+0oJB4jg1YisGDYsibbpXXnnoFVxzy4UF
         WH/uOxOZWDlGwWsDoXhX1V6fsT2NrttPToE2SQWn0AScoGsQGA4mOiRGwADAh80snOK6
         l3YtPsWC/E5dr55r4IbuR39d7nioWzRdDmiLTLxZbHqRYVBvdUNJsBUesm9TelrxjPs9
         P7z7EbcbETaJX9L0+sgOMKmG/4D4U5TWwpHAEkoKFswNMH9sn8KDxS/BqZZbXd293CrH
         g2Aw==
X-Gm-Message-State: APjAAAUsve2vgayS2EDdkg+XADvaadphn2+4xFpj6x+zGR7xtgm7GcrV
        SkgafU9iFnC6lSJLaOvkyILkPPbWO4ymNephF0U=
X-Google-Smtp-Source: APXvYqzcdm+2thl8HHqrCf9rsaN4i4OXg2U/csojMViUWqozVnMmtx0KDP6ARuGZL/t+re1lAMRRufOeZ8f7BmmPlgs=
X-Received: by 2002:a05:620a:918:: with SMTP id v24mr84077158qkv.22.1578331752458;
 Mon, 06 Jan 2020 09:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20200106172254.20271-1-tiny.windzz@gmail.com>
In-Reply-To: <20200106172254.20271-1-tiny.windzz@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 6 Jan 2020 09:28:46 -0800
Message-ID: <CA+E=qVciDPXrHCGsHR7mjFuaGrv_K21ZAdWW28_fnSV3CvEDCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: sun8i: fix r40 ths number
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 6, 2020 at 9:23 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> According to the spec, r40 has 2 thermal sensors.
> Sensor0 located in the CPU, another in the GPU.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

You should also add "Fixes" tag here.

> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Tested-on: sun8i-r40-bananapi-m2-ultra
> ---
>  drivers/thermal/sun8i_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 23a5f4aa4be4..c5661d7c3e20 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -565,7 +565,7 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
>  };
>
>  static const struct ths_thermal_chip sun8i_r40_ths = {
> -       .sensor_num = 3,
> +       .sensor_num = 2,
>         .offset = 251086,
>         .scale = 1130,
>         .has_mod_clk = true,
> --
> 2.17.1
>

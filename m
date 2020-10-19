Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A76292A9C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgJSPmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 11:42:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34926 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSPmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 11:42:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id w141so400866oia.2;
        Mon, 19 Oct 2020 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXEochqhW0YkK393ZCrugBsw7tLHP+l1LR04jQHwvdc=;
        b=tp3v45WmqVMvmGXXX/E9c8Hugu8+YrGEDX6yFo2XVxVJ8mNPs+ZNyuYr0kdULrwETn
         Q1ZZlKFvupbxRa414Y9Q3SohnlnY/7+QDe6S5EN9tPcX5+PkAUTAf88ACDvLggAzGs+x
         8dP4DHnHy84wd26nzJMVztcmdwzpydVUItpnwNsSjy1kFF0797ZfsREIVTwJaWfITV0O
         X/Ech/Wo7QS6jZCC15Xd5RpEOwcwJuuhbfLZrLhyvYO/j4TE25NbSpIs08NrzaWrsqlS
         7AbCEFiSJT8a2cU2rgEm52uJWQOEY4hZr++Um+ts8pKAl2vnSUFnthqmDDIjITpmNWZP
         tobw==
X-Gm-Message-State: AOAM531MqD4T/Kmz+tFKlP483hPjhhXaHYnw1f83wZfYS9vJxisMO4+Y
        WHF4kv8GH1B4XDcBrlkZ75fJpStStuR5fdabTOcoF90R
X-Google-Smtp-Source: ABdhPJy3t/DLE7nMLkpfnS5dLvjK74mc81ZKGW7Knws0aAm3X4kZYGsmsX+rvX1ICF3Czt5lpvEL0Do34779XnJcCB0=
X-Received: by 2002:aca:5256:: with SMTP id g83mr241803oib.71.1603122140910;
 Mon, 19 Oct 2020 08:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <adc856179a9496f73be4036d80e6e6fa5c7ee591.1603033133.git.hubert.jasudowicz@gmail.com>
In-Reply-To: <adc856179a9496f73be4036d80e6e6fa5c7ee591.1603033133.git.hubert.jasudowicz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Oct 2020 17:42:10 +0200
Message-ID: <CAJZ5v0jkT5q1X_KiXuO0WE8epzYpy8q490vJN=J3m_V+H7qpuQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: Fix typo in Kconfig "Plance" -> "Plane"
To:     Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 18, 2020 at 5:21 PM Hubert Jasudowicz
<hubert.jasudowicz@gmail.com> wrote:
>
> Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
> ---
>  drivers/powercap/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index ebc4d4578339..bc228725346b 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -30,7 +30,7 @@ config INTEL_RAPL
>
>           In RAPL, the platform level settings are divided into domains for
>           fine grained control. These domains include processor package, DRAM
> -         controller, CPU core (Power Plance 0), graphics uncore (Power Plane
> +         controller, CPU core (Power Plane 0), graphics uncore (Power Plane
>           1), etc.
>
>  config IDLE_INJECT
>
> base-commit: 9d9af1007bc08971953ae915d88dc9bb21344b53
> --

Applied as 5.10-rc material, thanks!

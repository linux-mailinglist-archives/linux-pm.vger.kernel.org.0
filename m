Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1A181837
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgCKMii convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Mar 2020 08:38:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33339 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgCKMii (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 08:38:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id g15so1772771otr.0;
        Wed, 11 Mar 2020 05:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PFwZSaV+MlXsfLyxBAqwQR4ATwP9EzsMSPmdh8dfld4=;
        b=UTgxYeO6ZzDIarBCEQsvxjjSh5iKAdwOeknI4b2Hh+MZ2VC5YsYcfGbZWt2dqGLL50
         jpqepRWbCo6yocIltRzJgwJtorP8qedlgrfhk5pablI6YoeOuP4ctwu4R6OM4PNIybYz
         u8BBEAon87LurKHKYStodK1lf3krhyz3XJl0fXsenJyICOJLOHbj7djG/yUGezBhGYr7
         vjcYN+XBDu9rdUfL2+j6Q+chRO1ktq9bJSSUsJAmASX9eDnl/D3rCG/IEMgXg4+zNYBB
         rWRnNCjgc7B/JUmjHDBb8H+cZ1C0qeTp9oUti8oAdM9xc8afZwQM+YdpmwtV/VyP98z1
         tnJA==
X-Gm-Message-State: ANhLgQ0ldUuXT60FUQiNb+luQpJXQ4ASs4W65tMPUp2MqWsOohy8PhRa
        6Mj6sSflCHIHAspGtzSQdNZ8TUIG/o92te66RI+V6A==
X-Google-Smtp-Source: ADFU+vsOBgTtUjsf8m2QI79o6h8b6CX/b9iu0yBsTwezpIc1Z2sggQL81lH3135Vk3G3v3yyH76iYehJCCJ6tVddjCs=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr2056848otf.107.1583930317357;
 Wed, 11 Mar 2020 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se> <20200310170029.1648996-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200310170029.1648996-2-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Mar 2020 13:38:25 +0100
Message-ID: <CAMuHMdVioRFbLMS3jtQyMk9vOyOR6NM9RZY6z27v3ZCUGrymGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: rcar_thermal: Always update thermal zone on interrupt
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 10, 2020 at 6:02 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Since commit a1ade5653804b8eb ("thermal: rcar: check every
> rcar_thermal_update_temp() return value") the temperature is always read
> in rcar_thermal_get_current_temp() so comparing it before and after
> enabling interrupts have little effect. Remove the check and always
> update the thermal zone when we get an interrupt that the temperature
> have changed.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

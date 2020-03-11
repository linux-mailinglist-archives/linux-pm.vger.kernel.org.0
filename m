Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F4A18185A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgCKMnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Mar 2020 08:43:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37708 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgCKMnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 08:43:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so1766620otp.4;
        Wed, 11 Mar 2020 05:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+PxktQvp/cKLLI06CG/tjO/tti/oJs9yCRvWmABx9g=;
        b=ezQpV+XYc4m0MfRVscbdp4CXtbqrd1IZedJsp21poU7O7yHkJZk8BECIDd+WdZz4Gz
         sx0LnFvv6emCfX4DlhQfCC7byVblAYCUSvjYv1n6a6g9X1r3YTD/OR/gs2pAe9pM8rjf
         P9ZWeM7xFxIlqvctjXs6nkrKhIPQyuBwz8D8t8DA07NIV2+hyF4LxgGGX+7k3JxRgby3
         NXtQwm5QtG+IJlB4RiWRekgIoFxTeiVLA80NhYqAttOxFQE9tetAkpcc6JGrDYJP5Hq2
         hww1JQkokK0a1lreKWveU13x/7rPp0oSatK8MCW6OXJJj0CAQ9wtvmBQxg9QLGQmMHR1
         MUfw==
X-Gm-Message-State: ANhLgQ1pdbjjdP0rS1XPcSZECs4yt+k8nQMuZ5KFisoEHXxEBhBAp+PX
        9LuCptC76aeTzciOCkYJsXf+jmiU3sC7rsWwvnk=
X-Google-Smtp-Source: ADFU+vuqJfhqwRNB8Z5/QRBuP2mh71GRTOEd87T+7eEsVeg4AmP8mnevNxxKzOSqZCw/8TXflTgfSXhYuELg1cdWNRI=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr2203478otk.145.1583930630168;
 Wed, 11 Mar 2020 05:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se> <20200310170029.1648996-4-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200310170029.1648996-4-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Mar 2020 13:43:39 +0100
Message-ID: <CAMuHMdX+89romoUcHYJMbE0mvJvBQJd4TfnRpcdW60YbG1mRBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: rcar_thermal: Remove lock in rcar_thermal_get_current_temp()
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
> With the ctemp value returned instead of cached in the private data
> structure their is no need to take the lock when translating ctemp into
> a temperature.
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

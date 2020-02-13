Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFD15BAA8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgBMIRw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Feb 2020 03:17:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32792 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMIRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 03:17:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so4959383oig.0;
        Thu, 13 Feb 2020 00:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kDpW5UiSxTZzoXgT28VtxU1OsyGjrpDblWAoD8b6FRA=;
        b=F30hqoSF/JZ1BSvvDJCzG+t90WeDe1/A3YlH/IxJ6XEx1nXptEritVKtc9sTUIC3Ou
         ioIX9TA0jAtRMHMFj8nezsn9018ge16WK6ALFNgh89ZhLs0ot3ghs9GyUvgYlJ5XEs2j
         xKPnZM5KJItIctb5AltV/uwwZWvkTlUmSN9esgM5pxK97BG+gnNni7zaUV9FYLDChNu0
         /9XDHBfWU8ElU9LU2snHjy/ke+2Cs0EZpWhLKXKjAg4QO+bkZmAHRVyjGR68pLHmdPbk
         sryzY21zZ4hmjAKf9tXgc4dTe6aF007aB53vSXk+HL6xqusm6UWRIJgFgT5bxKAiLYeh
         WJTg==
X-Gm-Message-State: APjAAAVfbXyJ9ZglRYpNhIOxeHnvoBWBItqMgozWdaGARKdV6sG8PDX+
        E0ZKRZLa7jK+42k5vkqSE9k8HDgDmoUnYUXGcAXA2g==
X-Google-Smtp-Source: APXvYqzrTn2A3a/qjUY8mI909CgdtV8qNdDxJ4U9xnKfKVJgHNIH06YtllHkdYYQ8eOf3mxKPjOC3ckgoT/oak+l/To=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr2171181oif.54.1581581871990;
 Thu, 13 Feb 2020 00:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20200212224732.736785-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200212224732.736785-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Feb 2020 09:17:41 +0100
Message-ID: <CAMuHMdWM4A0353yZZLfHhtQEX_GBHz2NLcVAfJXSj-Kqbxz35g@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Remove unneeded curly brackets
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

On Wed, Feb 12, 2020 at 11:48 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> When devm_add_action() was turned into devm_add_action_or_reset() the
> curly brackets for the error case where kept but are not needed, remove
> them to match the style of the driver.
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

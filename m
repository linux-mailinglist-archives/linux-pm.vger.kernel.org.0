Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A311D4FC4
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgEOOAl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 15 May 2020 10:00:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40814 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOOAi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:00:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id d26so1943996otc.7;
        Fri, 15 May 2020 07:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z10GxnzzEnm3W99sc26qbUzvMLJG1vLuMtRnx8W2VWI=;
        b=B9ytcczn8TulhSRZ9dEfmq7u7GCCfU2IWgyOHGcxYeylXVWY6YGK6z+naxSRCfDJCv
         N+QVXaqxK19LoqJbwUQmfyYKdI8NZcd/jrmo3beKRBQFIZhcM9xgA6OsrF6qfRGEsCgo
         BXQO7s1jUSVH8J6EdkoRZUH6KX5VHgNQ5kTJRLKYylEYBtD7r8SgCcmmObgZMUHcPKgr
         QXCOLS29Wrikowj21CbOJqDeCiTnjLyIzC8U+nWfzNmZ8+Gda6EgLzTSqzuq5IAi+sHT
         Jph6TY2lHTaMT1xb5NSijKjXWYdH1iBHrQc/2QnPpsDHB4NNLrj1eN7BbwvSfff9Hv3+
         s1Zg==
X-Gm-Message-State: AOAM533Kei4N8tgkQMtjJfwQ6h8lwsPXctOaNs1AWNAXhVZH3zthNisT
        MRf/RHFhVhHVFJC+5GhuKoGCTn9h3JwKrzh+WkwvFg==
X-Google-Smtp-Source: ABdhPJw2WN/VZaNUGyMe3e6aC2ycl6Er4NktaPxKvCqKXEq/CBIB1EOlUPr/ZLXhPmY5FJch6c39R5asegbL8SKF4Dk=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr2200930otl.107.1589551236847;
 Fri, 15 May 2020 07:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200515135626.2554873-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200515135626.2554873-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 May 2020 16:00:25 +0200
Message-ID: <CAMuHMdUc6d-5=LXQHuP7cqi9KS26xEgVW-SF+m1sRZiieoF8kA@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Do not shadow thcode variable
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

Hi Niklas,

Thanks for your patch!

On Fri, May 15, 2020 at 3:56 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The function rcar_gen3_thermal_calc_coefs() takes an argument called
> 'thcode' which shadows the static global 'thcode' variable. This is not
> harmful but bad for readability and is harmful for planed changes to the

planned

> driver. The THCODE values should be read from hardware fuses if they are
> available and only fallback to the global 'thcode' variable if they are
> not fused.
>
> Rename the global 'thcode' variable to 'thcodes' to avoid shadowing the
> symbol in functions that takes it as an argument.

take

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

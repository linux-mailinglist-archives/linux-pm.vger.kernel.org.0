Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D693B17F7CF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCJMm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Mar 2020 08:42:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34347 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgCJMm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 08:42:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so12977268otl.1;
        Tue, 10 Mar 2020 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kfycomguv06VQCU+xSRo5ljDeRZeGd7uM5suR8zPJT8=;
        b=i+XxgS/PlrmkKuZBAndzdnu7WjguRudMZfGm7Oe9aDDtzVxqYfLnteMGWSntXov7ac
         heVds7mpSsh/IowBN6B3KdVQLHmw+uJ1RWaKwW4gtnK0KYUDcy3h/3ZEIWKscbmsom6D
         YIIPGuEs1jnoaMqLzhi3nfDT28mqjH2ATAVe1BY7S4dkoG/K2ur4SNkPsSV8jIcbAlfC
         nf97DYbgR4MGB2N/zdcBltPILRKilKs60j3CvKfJTgt/f5UEXEAYUg+8NyIw9mzT/fHv
         EbmZjdud/Rh0f684hUZ+k20aBiVhv9fP+DkR8WJn1dtCpG7+MKEchST/ss/xUVTRvPDf
         8HJA==
X-Gm-Message-State: ANhLgQ2c8jzTcAcg6fP2hp0ZjgWO+qjkmNcnHVnwDTfNeCYRLRmd/ReG
        aLinOzeTTgeLuzgdrBowNdYGLOKJs/HiHzggrUPCQQ==
X-Google-Smtp-Source: ADFU+vvnhcQldBJ6bvtbZYYKQIcMnPQ0S+l+Ks1r53JQMhSecZyEzzMbVF/D0uzBc67W/q6oUZpf/0athU/jbcs6Who=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr7133754otf.107.1583844146329;
 Tue, 10 Mar 2020 05:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200310114709.1483860-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200310114709.1483860-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Mar 2020 13:42:15 +0100
Message-ID: <CAMuHMdUkF52DvL8YbnoBLetO7gMMyTxsB-yL2R3dhDHBLdeizg@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Handle probe error gracefully
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

On Tue, Mar 10, 2020 at 12:47 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> If the common register memory resource is not available the driver needs
> to fail gracefully to disable PM. Instead of returning the error
> directly store it in ret and use the already existing error path.
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

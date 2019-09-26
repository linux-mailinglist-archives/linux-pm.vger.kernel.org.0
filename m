Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322C9BF4D6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfIZONo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 10:13:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39060 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIZONo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 10:13:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so2118614otr.6;
        Thu, 26 Sep 2019 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Km/DrCvqj3aLLhSzWvVTMmBfoUwqSRo+fhy2SA+9qs=;
        b=SJ20/UCxGOlv8y2209C9O1pRUHINy8aDu3tj6erdrIXwrFZoJoSO785GZEhYyl2RaF
         kS0VbQog/3MsV1Ft3b45ay6YCEVD6c+7a+ihsRONvGSEwjuUU32Xx2I9qhQC1IvrKmNd
         itezseaUyv8smcKbV2z3AhHqdi4ehz2jSpuofWbuIv3z8takvJPiSIC0tejYiiD8C9Ig
         PTzxDQb/C2jJg0zxv9pkCl8VJRAenCHBs175E66Qu16dqjUrtlwOHoG9b4nPz5wRvdPu
         WhcofX9ZBQnhv2RKUeQ6NrS+zQ8x0E0M6twu1+DR9Kaxt7GvM7Z5E+btaT2AK2wAfKRU
         psLQ==
X-Gm-Message-State: APjAAAVvb/ax/CJXZcaBF4EfxnduW6VfNq7IBCF8Z5huwoFXEuCACbuU
        Cw69engqt82MbeHdEXhWcHrqtxK0wRR2IoGLaWk=
X-Google-Smtp-Source: APXvYqyuPdFkzssH11CNKWxc102E5366BJ8UKuIevYWNRo+6m0I1HlKrJALSxJYWFknGfUOIai3RT5Re3nxkIU6xXg4=
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr2842636otj.297.1569507222389;
 Thu, 26 Sep 2019 07:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <1569248746-56718-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569248746-56718-1-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 16:13:31 +0200
Message-ID: <CAMuHMdUBGuoWD0RZ9OOsaYUxnUb3H3Q_xFJnT3P4fG6V7eiXLg@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Add r8a774b1 support
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 4:26 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Add r8a774b1 specific compatible string.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C01964FD
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 11:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgC1KUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 06:20:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46562 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1KUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 06:20:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id cf14so14561483edb.13;
        Sat, 28 Mar 2020 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fe7vSqTovofs2pbqQ9vBZGE4ICdZzytA51ufbrvug5A=;
        b=gZzoGR9pE2WwhIDeENQCW/x6kpV7USjpLVpyp0uH7+Fq6u4Pr6VyHGy5MxT65P1Jpw
         2IwFjZAWystaYH29GKa4oevh37fKQClAFd/6sCfi35W9/6H9b2st92hznyzG7txJxifb
         /rOL5DyfJHFcQ1DEf9C9BCL3MHhibBA+GsdlWkc2rtg4LaQNcOoG8QB05tzrj49/0eEl
         TNgbeY007ZskTRpSiblMaihBN7H0uViDxG4hyT5N99Ih65I26eZdiIXjHM30n+J5tKLq
         f17zIR90Cyfv7UAgzMoz+/WEq+n+OILmc0z/EbKvXtKix0P6yR+vJ4s4g6k4anerM3wJ
         WYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fe7vSqTovofs2pbqQ9vBZGE4ICdZzytA51ufbrvug5A=;
        b=YbBDwKrV9IYBVKkaUDwkVgLXEAC0rPpyPGN0StswgKObohMDPESyVeM1YUQehIYWeF
         02ZgtsRuGMHrgo8EYRNNnERF9HQdHnGoR7/kjdtmd4jqGYim3FFyKYHkkbgjO0mBUXPN
         5r17yGLFBr1VARSuDr0CMK+abETqA5MJrSooZMqrO3L9cI/3Jdtf+L+HCMxlPbZ+NDLf
         jpmIMPzesGuU99m2f2Fh6GRZSWoiH2jl09bQamf9XUD5eC4ciGAQolNey58i/HQ5digO
         rpqx2IFvvvld5v9FbZC5hFV/rBijAgvdDqSwc8+szzPCMFxF0oAjfHessPCqYYPw5hVb
         jumw==
X-Gm-Message-State: ANhLgQ1/f4eG7oJxajsKqhc0b3umr1JeGbNGsKlkT6FVM8TaB5pzjoeP
        31MvcyIvwfI00tIT0/FcH4Psgxa+Hoxc62z0WnE=
X-Google-Smtp-Source: ADFU+vt+CGOstPPiyOkXccPeNwU+SbD3xZ1o9QkolQ8v/Gi9v/pdo4TjR6yY1eJHtp+rIWU3zHv5rAEhRHHb9xghbBI=
X-Received: by 2002:a05:6402:b14:: with SMTP id bm20mr2831787edb.365.1585390835491;
 Sat, 28 Mar 2020 03:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200319203427.2259891-1-martin.blumenstingl@googlemail.com>
 <20200319203427.2259891-3-martin.blumenstingl@googlemail.com>
 <CAKGbVbtKqdCEcawkjG=7TRd30df6GJ+gagV_JegntyqRpzC4cg@mail.gmail.com> <CAKGbVbvAvk0L5sGQmuqfxeL6AwtVnSsYyCp6YBYV6ZHKepWBXg@mail.gmail.com>
In-Reply-To: <CAKGbVbvAvk0L5sGQmuqfxeL6AwtVnSsYyCp6YBYV6ZHKepWBXg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Mar 2020 11:20:24 +0100
Message-ID: <CAFBinCDUhVaky6EUA7dOAhAZM9itbydQ+w=0P-1m2u0o0HUUeA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/lima: Add optional devfreq and cooling device support
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 28, 2020 at 9:40 AM Qiang Yu <yuq825@gmail.com> wrote:
>
> Applied to drm-misc-next.
thank you!

regarding patch #1 - can you apply this as well?
patch #1 just takes this midgard change [0] and ports it to utgard


Thank you!
Martin


[0] https://cgit.freedesktop.org/drm/drm-misc/commit/Documentation/devicetree/bindings/gpu?id=982c0500fd1a8012c31d3c9dd8de285129904656

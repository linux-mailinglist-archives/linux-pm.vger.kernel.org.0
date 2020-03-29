Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C760196C49
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgC2J50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 05:57:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgC2J50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 05:57:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so13568275wmk.1;
        Sun, 29 Mar 2020 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5/ybwGZw15O183cB6hxraMKImcCya/+VsT5AgJC+wk=;
        b=PlBBbPjoSfFFs7coNzHn9y18vAv7tg8/gEY0ie5YIkK13kmI6SbdzQoLrfMgSy8Rm5
         M6+sZHbgLbuUP3x7Yi4JOEBmBfnVda+LdwY0Bj/l8h0ZA7GwdUMMPV9FgLFKvYJaQfy9
         dD02x2Np6E67W8gO2RBaVF56KZAtqp1CEFtuUIbWKhYVCXseO4V7/kzmWJsWVWZ9RPT2
         MTCiMRujzIQ9JvGhJ3qoItKdllyaL5MnMUvQlC6O810X5BaS9f5mhH3x/grKuoDdvGDe
         vVpv82zY7bvOSu48mbqHv8jw67oBX8GWFwfg19KElJa2K4zU3TB3rSUoXgPMAwgFG8Mf
         gAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5/ybwGZw15O183cB6hxraMKImcCya/+VsT5AgJC+wk=;
        b=RjTPodOzR2L1LgbTkhVJsXChm5yVKwBDYjkSP/GbrfFU8seZpO4AOu0k0Fe2JIR9Fn
         elB3Fz1S8tBRZ1Hof+vetTypWGygPTO1hvkYyxULxIUyQQpVM9NhNSz16VbcLAlDkI5w
         G90Ga4lR6YWx+NlnNFXzORsGKXtmQCSFgleNF2Mpw8ZyUsx4q7crM443EvYSViKURiiQ
         iqarTFySWxOWHCDsLTaeXMgCUMX9H7xOpQiJGla7Ib6xZ4octAIvdy4X3/ABQoZojJZ3
         lQxC0p8dFf8Cdhb3TFGPiJeXhJ+G0oxwQJO/GCWTFpGoahTr0fKxoo8UfcLdWSd+5/t2
         Ucsw==
X-Gm-Message-State: ANhLgQ2co2mxzxvNFinH4jYjq6dLnlreWxlOjRf2aNeqf0XhUkds67/i
        MamJSnfAbbCGGSTZeF78RrZBYByeKS/x6BFJ6PI2tx6LzaNQwA==
X-Google-Smtp-Source: ADFU+vt/KWuDksi8mUndNDmzSr2QWqqKzTuw0aQvhAAxtapcUeVPe+tjCaP46IlOCkv0ET3XIlL1gz6wNhFoqGMdrKY=
X-Received: by 2002:a1c:1942:: with SMTP id 63mr4990909wmz.133.1585475844683;
 Sun, 29 Mar 2020 02:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200319203427.2259891-1-martin.blumenstingl@googlemail.com>
 <20200319203427.2259891-3-martin.blumenstingl@googlemail.com>
 <CAKGbVbtKqdCEcawkjG=7TRd30df6GJ+gagV_JegntyqRpzC4cg@mail.gmail.com>
 <CAKGbVbvAvk0L5sGQmuqfxeL6AwtVnSsYyCp6YBYV6ZHKepWBXg@mail.gmail.com> <CAFBinCDUhVaky6EUA7dOAhAZM9itbydQ+w=0P-1m2u0o0HUUeA@mail.gmail.com>
In-Reply-To: <CAFBinCDUhVaky6EUA7dOAhAZM9itbydQ+w=0P-1m2u0o0HUUeA@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 29 Mar 2020 17:57:13 +0800
Message-ID: <CAKGbVbsHXUhpaU34ovRPqc51LSavERUzMySx3hG7AqdO-oobHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/lima: Add optional devfreq and cooling device support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

I'm not the maintainer of patch 1 file, so please contact:
  - Rob Herring <robh@kernel.org>
  - Maxime Ripard <maxime.ripard@free-electrons.com>
  - Heiko Stuebner <heiko@sntech.de>
to review and apply patch 1.

Regards,
Qiang

On Sat, Mar 28, 2020 at 6:20 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Sat, Mar 28, 2020 at 9:40 AM Qiang Yu <yuq825@gmail.com> wrote:
> >
> > Applied to drm-misc-next.
> thank you!
>
> regarding patch #1 - can you apply this as well?
> patch #1 just takes this midgard change [0] and ports it to utgard
>
>
> Thank you!
> Martin
>
>
> [0] https://cgit.freedesktop.org/drm/drm-misc/commit/Documentation/devicetree/bindings/gpu?id=982c0500fd1a8012c31d3c9dd8de285129904656

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1959CA17
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiHVUfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHVUfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 16:35:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C911454CBC
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 13:35:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb36so23515884ejc.10
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kg3si/WqZ2UuGBgeFpee5ChSULBO+SUIk5ZvymvbTKI=;
        b=HIdP2i1AcaynwhPmy7b1DkZMhAXV/hh+1VoI2Ojp/UHcpa7E1+BZ7UE+hb260Uw0JK
         +ITfNjAdpzm+GhURNGNdHBfuXdPu1Y68bYDqdf+p7oazv0UgB5+SN/jzwovYQPZnHkXp
         85gT+RgQD+3G/YWWOk4hx1ZHKELEo92QzDAKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kg3si/WqZ2UuGBgeFpee5ChSULBO+SUIk5ZvymvbTKI=;
        b=KvkAoqs2ypAWfGeZ3HZ8ok59sIbwvhzOFszBSKRs7hUIRo9fhQIOVKo6zKEqoPH8gO
         GY1Uo4rrdD5xlxwEYkiJSVVuBnA1b8A54PrP8VS995BPIW5GTwPbHvuPMz/vhMLVdWVO
         dABSIL/R3dZ66FYZmpENf0UTISajGWymdReaQAjzlBguAYd8p7CZYeTMFlepxgxXV139
         kinafxxwDtfPyEUV1NM9GyQ+9MovROIF+q6hFFT+Tmi8Oh+0IxC1kZABmtOAHUXd6nyX
         co9D4X0ohMaMiYHgjxLWuhpYLp7GFwq1tmmz7PjEpn2JR4o23dJmz/LSgAwSoBFraWeK
         /AWA==
X-Gm-Message-State: ACgBeo2tZyz7Kxu33Rj9PXPBNKRpIXR1T2byeOgvdHDXwDN7CSE/q6T2
        yRfCzW9yOpWAvfIKnlPX+NKkvM3xK1nzoh8cAGI=
X-Google-Smtp-Source: AA6agR63EtN4yZR/e32bBY421i5ehgxq17Oo6FigvFcfV87XzXhZDWZ0Q9ryaFhGveTqY8NLgn0Qdg==
X-Received: by 2002:a17:907:7fa1:b0:73d:8326:cd5 with SMTP id qk33-20020a1709077fa100b0073d83260cd5mr3860853ejc.522.1661200513146;
        Mon, 22 Aug 2022 13:35:13 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7cb45000000b00445b822005dsm272202edt.6.2022.08.22.13.35.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:35:12 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so26812wmk.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 13:35:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4c06:b0:3a5:4eec:eb4b with SMTP id
 d6-20020a05600c4c0600b003a54eeceb4bmr59560wmp.151.1661200501419; Mon, 22 Aug
 2022 13:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com> <20220819221616.2107893-2-saravanak@google.com>
In-Reply-To: <20220819221616.2107893-2-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Aug 2022 13:34:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfrBAbO8pKmema_8nPFHTNc5nZE2X3RWpT8S53PiCkGQ@mail.gmail.com>
Message-ID: <CAD=FV=WfrBAbO8pKmema_8nPFHTNc5nZE2X3RWpT8S53PiCkGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Revert "driver core: Delete driver_deferred_probe_check_state()"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, iommu@lists.linux.dev,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Aug 19, 2022 at 3:16 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This reverts commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b.
>
> There are a few more issues to fix that have been reported in the thread
> for the original series [1]. We'll need to fix those before this will work.
> So, revert it for now.
>
> [1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
>
> Fixes: 9cbffc7a5956 ("driver core: Delete driver_deferred_probe_check_state()")
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/dd.c             | 30 ++++++++++++++++++++++++++++++
>  include/linux/device/driver.h |  1 +
>  2 files changed, 31 insertions(+)

Tested-by: Douglas Anderson <dianders@chromium.org>

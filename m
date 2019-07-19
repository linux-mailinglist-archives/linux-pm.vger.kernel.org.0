Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270086D7C3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 02:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSAay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 20:30:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37629 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSAay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 20:30:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so20468135lfh.4;
        Thu, 18 Jul 2019 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xho2od4dR/ejVEmeXeRJDJbW0RNQVIpYbWcGXZpI5jM=;
        b=PoHem9fIGg4wqnF8Um03wzb4+ec8lw19QRIsHE0kkWaoW0EwCYviUNXR1lrMMwA+Ba
         m3uvT53qQsn3wXhFqHcNCowE4x/i8TSecJudbdfi1Wyx1qqvJMtv4hyuN3B8S/oRd2WS
         sMubF8qEUvi0zbL0ZWlCL3JXEvnYcI/cwocdysQkE4UskPWCid48GlTDk4Gg89A1IUs+
         wH21K9oSmAwaYfCzNFexSrkeSujL2mfwUtvFhGOIqrzPS/8w4nPxJuGMcfiB5qh3kOYa
         GjAsX18ac0QjEmCEHQ67IxJRP9pivBgrB3cRUEA3/3WtM3j+gqfOe7qyYK03ERB1LxAJ
         Zg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xho2od4dR/ejVEmeXeRJDJbW0RNQVIpYbWcGXZpI5jM=;
        b=U9Jz1WWOhTa6z26TUwqtTi3A76AMITSQwlbp0McPyb65QFMrp/rDK7NbFw3bjt+98x
         GJIypHm0vPAdIkdtMsCSfY9dGloP8hsBXArtmSDar8OUq2viLNznZzyWzSs0ZEisYbTd
         kvALm2E4LuJWpYeKPBnvBh/dAEpqvf1lJuNrOnEEG4CWg+VDepZoUoiNeqJDYTqpmdAf
         6z9ZIAn0055znszEtsUjNPAlkyqC3wsJE7D8+O/R8/DWDa52TwPBgjOd+T8aAsOR2khe
         4ZzpwN5eSwzUuUucFNk6MUDRPB4ra1bjvHlawQDsztmz8qYpv4BRvvgwqIiobRicBuE5
         yZUA==
X-Gm-Message-State: APjAAAV4imHFtoOV9uqoC3zaBGoDSh3LhASKDgFiXFeg0CocAr8WvSwP
        m3kwPM1gGJqahJzahLR0d0E=
X-Google-Smtp-Source: APXvYqzj15bv7yXHFwe28D14xB3MBwm0/yF+lel2HERvYQjD0qd4+CP7nds3FkKe4Q4+F1R27WkkXg==
X-Received: by 2002:a19:2297:: with SMTP id i145mr22187789lfi.97.1563496251701;
        Thu, 18 Jul 2019 17:30:51 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id z30sm4726328lfj.63.2019.07.18.17.30.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:30:51 -0700 (PDT)
Date:   Fri, 19 Jul 2019 03:34:29 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 22/24] PM / devfreq: tegra30: Include appropriate
 header
Message-ID: <20190719033429.47985963@dimatab>
In-Reply-To: <2f317faf-8de0-2717-cda7-b15374039493@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223620epcas4p16538beeb317e2ed0cbecb64147f32b71@epcas4p1.samsung.com>
        <20190707223303.6755-23-digetx@gmail.com>
        <2f317faf-8de0-2717-cda7-b15374039493@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 18:58:50 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:33, Dmitry Osipenko wrote:
> > It's not very correct to include mod_devicetable.h for the OF device
> > drivers and of_device.h should be included instead.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > 8a674fad26be..19e872a64148 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -13,7 +13,7 @@
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> >  #include <linux/module.h>
> > -#include <linux/mod_devicetable.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/reset.h>
> >  =20
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>=20
> Is not there other unused header file anymore?
>=20

The rest looks good to me.

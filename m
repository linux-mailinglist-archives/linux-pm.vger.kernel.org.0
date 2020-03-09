Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BCA17E567
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCIRKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 13:10:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42043 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgCIRKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 13:10:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id f5so5095572pfk.9;
        Mon, 09 Mar 2020 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Al2h1TKzjElXxyKh+YkzrPKu9p09cB83uwPh3UYud7c=;
        b=NMZz5MsMd3OBckUoOvFxZ2Pg5drge6zfoiRvulGzqFKaFpXvhjE4hgjKmghazwuC5a
         O2gS54bNl4dSb29oUemufHlBmC6yOiwH/JI/JLOzr0QupydVU4ersjPgkpPTf1pTER0Y
         znH49FPr7b3NBlFPqcsOkhB3S5JPnszP7eNTa3NxdeWmBmF4lWUxH4nKmI6ivew7l9d8
         uZZoKOZhYWbaQZIwlkLtSoRadzCNMFDbfPZ4qxGxAvJrBLiQfWyPBJGEWCmRPEPmui83
         Br1tQKj8INp7mtLaSW1TC7zL6pJrbZ3eIibc3MDv56ojXUyegm/3wSKoDT6maLMEIBOy
         QxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Al2h1TKzjElXxyKh+YkzrPKu9p09cB83uwPh3UYud7c=;
        b=Ucq4KR+TWXePEzcZztY55vwRcuI8TjOc5h7fjH5dJ1bLPuifwu6b0lfqu+88tDJYA+
         Bnri/NgBKbYhhC/PRFlDWzk4qh4BFqkEQXr/N+D+RDfRiNGfl26Rt7ayCdYIu6LE3jyH
         s6Ap765lne7utQCHqaSn6IOeLPMIb3LU83zeCdmxAoOkfCjer1N9L8+4uy8kTgiBJwI/
         72PmySThIIZeYZS/3EyGK4WxvtTAwf/dduBGeRCghmwNs+9kah2G3Ua5JuobXOyXagl/
         Izxzd/MzwjJL4TudlKxZUzj6x8IE8aHMN6jn8//JEwDkDCAhldX0UjV2V9J4MynYFPR9
         pBJw==
X-Gm-Message-State: ANhLgQ2b9YdfszWqDRS08rUf2ITIkKsNHYPJv6z5rQ5xzhK21X0NwyHC
        S+skHHqrTF5OelkHSw6MJ78=
X-Google-Smtp-Source: ADFU+vu/DbFBxHbJjGxd44Yk9bSm6Ml6DSBR4TJ03Rv8TwQJtR44YraTRUbY1rO1eLTjxJshjpK3fQ==
X-Received: by 2002:a63:30c2:: with SMTP id w185mr17913850pgw.307.1583773814751;
        Mon, 09 Mar 2020 10:10:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m68sm147089pjb.0.2020.03.09.10.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:10:13 -0700 (PDT)
Date:   Mon, 9 Mar 2020 10:10:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        daniel.baluta@nxp.com, gregkh@linuxfoundation.org,
        linux@rempel-privat.de, tglx@linutronix.de,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, ronald@innovation.ch, krzk@kernel.org,
        robh@kernel.org, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Message-ID: <20200309171012.GA24802@roeck-us.net>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <20200309110609.GE3563@piout.net>
 <1ad38cdb-bf0d-1c19-b233-15a5857bd6fa@roeck-us.net>
 <20200309164705.GG3563@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309164705.GG3563@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 05:47:05PM +0100, Alexandre Belloni wrote:
> On 09/03/2020 06:27:06-0700, Guenter Roeck wrote:
> > On 3/9/20 4:06 AM, Alexandre Belloni wrote:
> > > On 09/03/2020 08:38:14+0800, Anson Huang wrote:
> > >> Add stubs for those i.MX SCU APIs to make those modules depending
> > >> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> > >>
> > >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > >> ---
> > >> Changes since V2:
> > >> 	- return error for stubs.
> > > 
> > > I'm not sure why you are sending v3 with the stubs as we determined that
> > > 2/7 is enough to compile all the drivers with COMPILE_TEST.
> > > 
> > > 
> > 2/7 alone is not sufficient. With only 2/7, one can explicitly configure
> > IMX_SCU=n, COMPILE_TEST=y, and get lots of compile failures. Granted,
> > one should not do that, but 0day does (I don't know if that is the result
> > of RANDCONFIG), and I am not looking forward having to deal with the
> > fallout.
> > 
> 
> How would that be possible if the drivers all depend on IMX_SCU?
> 
That dependency is being changed to IMX_SCU || COMPILE_TEST
as part of the series.

Guenter

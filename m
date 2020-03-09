Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7317E6BB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCIST3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 14:19:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCIST2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 14:19:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so5093953pgn.1;
        Mon, 09 Mar 2020 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUgRxVNWWI4/X6MpRA1miIl6BKxEX3f9Er1YPxkTvvw=;
        b=sNlPIoM2gt3GGdSuObomrqoffsAtxhxZft2ETl+N3lZ3JSsCVtomAdJeaNPkTfheFa
         dzxMu8ssE23gZE1OxWJNZ+9Hf25JLpasSBaBdGGq+lY4kZHw/HCniVudCE2Aaozjad7L
         A8AQC+hDjh+vOvWgARydrt917tpg7seq13OcylBlfc0LT86PMepy+F+tkYc9mzbybEOn
         S/jxBlUMHRG5Lu//z3iUZDoUrnAQtczHnWp8BBBzHs/avjK67sKc/0ROBmcZUg4IzzUx
         2O0ctvHZor8KZ5oNC0Uxta9UOSkSJaY7BP1zdgX3G/b5qyfWyeLiYL9t5K4YNuB60gSk
         vKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUgRxVNWWI4/X6MpRA1miIl6BKxEX3f9Er1YPxkTvvw=;
        b=sbSThMvcRuPzgi5//HM3Y1XVqmAMxwttBRIUMTHkbgQNHEZ2yd9BXBsy0LIcSr5tPZ
         w8/ln1HgYB5saCmtGge7Qfevf1f6g5QsisgWgifUsnP1MYq6M0x1nj4M6Dc3nvwIGW+o
         0v6K9+aHQUPjFo9iEULC93mG8lZm1TOsrNakOcvGswN5uWMm++KLCqlBTTg5SoYzxXbx
         KHmZ+L0aMUS/5q+2F69cdDGJ9RlUdayhUPra99wFGlscNw+3mLJ5965z/NYqxCxfiZuk
         +xG1u9Z+dxaQ1xWlJvj/jGc2zIa2qL2pOsCnCCjQxcEnt+FkQ/UScwRYy7hulZwnzkve
         riOw==
X-Gm-Message-State: ANhLgQ3WzHe1AF+iE2Gx53KOHRe+Du2E+6wRUpt5bQfErSPncHi4f8Yi
        RlZDGr0MBwaHUYkDXrZBlS0=
X-Google-Smtp-Source: ADFU+vuOgWAHVSJ7870Wsdc6jp9jt1VM/hwbVvbgrPsGlhP3zO4qktaIEgcY6kj2q1SiRmCkNaL7zA==
X-Received: by 2002:a63:6841:: with SMTP id d62mr16700934pgc.86.1583777967062;
        Mon, 09 Mar 2020 11:19:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c190sm1023630pga.35.2020.03.09.11.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 11:19:25 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:19:24 -0700
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
Message-ID: <20200309181924.GA27218@roeck-us.net>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <20200309110609.GE3563@piout.net>
 <1ad38cdb-bf0d-1c19-b233-15a5857bd6fa@roeck-us.net>
 <20200309164705.GG3563@piout.net>
 <20200309171012.GA24802@roeck-us.net>
 <20200309171556.GH3563@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309171556.GH3563@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 06:30:54PM +0100, Alexandre Belloni wrote:
> On 09/03/2020 10:10:12-0700, Guenter Roeck wrote:
> > On Mon, Mar 09, 2020 at 05:47:05PM +0100, Alexandre Belloni wrote:
> > > On 09/03/2020 06:27:06-0700, Guenter Roeck wrote:
> > > > On 3/9/20 4:06 AM, Alexandre Belloni wrote:
> > > > > On 09/03/2020 08:38:14+0800, Anson Huang wrote:
> > > > >> Add stubs for those i.MX SCU APIs to make those modules depending
> > > > >> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> > > > >>
> > > > >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > >> ---
> > > > >> Changes since V2:
> > > > >> 	- return error for stubs.
> > > > > 
> > > > > I'm not sure why you are sending v3 with the stubs as we determined that
> > > > > 2/7 is enough to compile all the drivers with COMPILE_TEST.
> > > > > 
> > > > > 
> > > > 2/7 alone is not sufficient. With only 2/7, one can explicitly configure
> > > > IMX_SCU=n, COMPILE_TEST=y, and get lots of compile failures. Granted,
> > > > one should not do that, but 0day does (I don't know if that is the result
> > > > of RANDCONFIG), and I am not looking forward having to deal with the
> > > > fallout.
> > > > 
> > > 
> > > How would that be possible if the drivers all depend on IMX_SCU?
> > > 
> > That dependency is being changed to IMX_SCU || COMPILE_TEST
> > as part of the series.
> > 
> 
> Yes, my point is that those patches should not be applied at all, only
> 2/7.

Ah, now I get it. Sorry, I missed that part. You are correct, that would
be sufficient, and I would very much prefer that approach.

Thanks,
Guenter

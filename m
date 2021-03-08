Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207A331288
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCHPvZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 10:51:25 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42543 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCHPvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 10:51:01 -0500
Received: by mail-lf1-f43.google.com with SMTP id v2so8728764lft.9;
        Mon, 08 Mar 2021 07:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=UrJzfLcCnxaOoFMAc3IPMH6xpm/uARcRnsEzoAN4jHA=;
        b=Dx0fTIdrXjLLrEGzfmiiXzJ+AHjtlJZbmq/jml6KCXdVXowmz2/o/9HzP58JrgjO7O
         7w5Tup7PrG4Rr2lGmMjnWekTcj3ncZ4Ok1kBkmShOvcl+FeLXZk5tfWjKYSmbe1xYXJo
         ISapw9SSIT60+ZwKVxxFEh3C8PUBuh6X9HmThYh+ePcPsKp4D8MREisX9xxPfoAGBvvf
         Jvy1a5EgjHDy9RU4Vzde6PHw6s5KjP0mvAskhHQ+b4yvVfWFJOLtXLqf1Ftqivlpci7I
         QdgA/Pq4UO9OANHMj+81W9bD9zASO668rErw9quiDKt6rw1d5VfobeU3+hD9BOJ+Jgnu
         nLyg==
X-Gm-Message-State: AOAM532EdjZxS9gpO43Ti97kLON6Abp1X3RyorvfbeOIojmxTXgrNhWm
        oPb/gwcVgn8gyY6RcK2txAw=
X-Google-Smtp-Source: ABdhPJxoyXnbpdM/D2fjc5EUGz/Z3ZrzCRGnl9KHOF6ceqpGX4pIJMnb4so3trDy9QAXWzp2l5kFzA==
X-Received: by 2002:a19:d61a:: with SMTP id n26mr14346288lfg.383.1615218660426;
        Mon, 08 Mar 2021 07:51:00 -0800 (PST)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id o11sm1388325lfu.157.2021.03.08.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:51:00 -0800 (PST)
Message-ID: <7ca68ba756672ab937550f6ffd2b07dbd1b021d1.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency
 unconditional
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Arnd Bergmann <arnd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210308152935.2263935-1-arnd@kernel.org>
References: <20210308152935.2263935-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 08 Mar 2021 17:50:54 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Arnd,

On Mon, 2021-03-08 at 16:29 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I assume there is no reason to actually build this driver without
> extcon
> support, so a hard dependency is the easiest fix. Alternatively the
> header file could be extended to provide additional inline stubs.

I am absolutely not insisting this but it would be better if there was
no hard dependency. I've tried couple of times to do changes to bunch
of drivers (added some devm-functionality or generic definitions or -
you name it) and I always end up at least compile-testing changes to
multiple drivers. I always repeat following:

1. Manually hack the Makefiles to compile changed drivers as modules

2. Try CONFIG_COMPLILE_TEST
 - unfortunately not too widely supported

3. Manually hack more to get drivers with 'hard dependencies' compiled
- occasionally ending up to commenting out the calls with dependencies.

So, if adding the stub is straightforward I'd vote for it.

But I guess you know this quite well so I am just giving my 10 cents -
decision can be yours :)

Best Regards
	Matti Vaittinen

--
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland
SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~

Simon says - in Latin please.
"non cogito me" dixit Rene Descarte, deinde evanescavit

(Thanks for the translation Simon)



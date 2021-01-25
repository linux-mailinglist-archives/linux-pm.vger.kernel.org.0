Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B637302A28
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 19:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbhAYS0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 13:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbhAYSZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 13:25:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F614C06174A
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 10:24:52 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q9so13113188qkn.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HnSvtHvi0XPNHM/mWiGJMhC+HTvDL2NKMxV7WptHfR4=;
        b=cXX3n5P62RS1OIbP0vOV8vm1mKp+DqGnf20BppLCxsEQe/SYzhopl9mI9sXGZ3RpNb
         9IE4juvewKXdZxUV6SlFbcPZa9Bdt8XtcTo8VzvugAALA54L0VPBXeJvKf7SxkfsLd/p
         uqR/4mxUc+RixF5vtmQjpM1Yq+A0tX81+QWtMm/eXFUfPgtyzPLtZohHPjZ6f9gVStGU
         OJqRjLDUNxSkznpxxW8i+N3h8O9aBbDkjl145iCfOrhwou5eSmQvvgNpdcikIFcgsT5L
         FasAp2DnvVnoDGE/7ZuxQn0hpSkxyVMxfdQJ766voKaE1dH6soi/JeH6+rikFoMNwnJj
         TvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HnSvtHvi0XPNHM/mWiGJMhC+HTvDL2NKMxV7WptHfR4=;
        b=qkcpEKbT0njM/Jlw0Rwndbr/NMWSyL9VlWUIy9+5YXMtoe7bXafQlXrTAJsqOTUmcq
         +GQhJV+fQO1I0AK/rf/xa4sERy0PBkXJVJp8KeBkh+Sb9eO6KThi3iqlG7zC8jltIJPN
         QGPC3qAycbeSAMUh+chtwPLavBSOunCPv9H1j96/ueH/pH9xsGPuU3mSyOo7IClRf03B
         HHX4sQhvlAiay6Uu2R1uAI9SRUXWSh8HdBT1cIQ51qS+HwNKygW4AaUet7Vd/HIw6xia
         YhpYG2/1YWtniLjg5/GUwhllXbdQGtJWutR54fKQKSpLoHAhDGgKbEtVTqE7yWAUbQoT
         YC2g==
X-Gm-Message-State: AOAM530/zXmz16w6e0iM7Yag4cJA31JFDZxmasuo4db7uMD00o8DQTfC
        ZkVhJ40wjQDjlEitx/Nh+LD8kVlQe1mtRoDM
X-Google-Smtp-Source: ABdhPJxJ8+We+9/uI1REscQW0vVnt3GvKzHfyM0Hy/lkgOEkOXaxGEVEHJok9twXTDAEAlsCtGc7QA==
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr2076301qkk.447.1611599091863;
        Mon, 25 Jan 2021 10:24:51 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id x15sm7400377qtr.72.2021.01.25.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:24:51 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:24:50 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] PM / clk: make PM clock layer compatible with clocks
 that must sleep
In-Reply-To: <CAJZ5v0hn=aUXS-cBG333YXiG2_SUhfkvzsJPYqmWRyDu1zc+VA@mail.gmail.com>
Message-ID: <82qo9ooo-32q0-2r4r-26q-o8482651qr91@onlyvoer.pbz>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com> <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com> <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
 <CA+G9fYsRVxWPW1nvSXMTLWfEadrdBDSH5hRPtoUYpfpqq8zRSw@mail.gmail.com> <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com> <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg> <CAJZ5v0iNtmXWr3uXzit5Er_j7G=LkGVyhdNAsjwpVWsDy8F7KQ@mail.gmail.com>
 <61p41n8-r88q-9npq-879o-s4r5856os9s1@onlyvoer.pbz> <CAJZ5v0hn=aUXS-cBG333YXiG2_SUhfkvzsJPYqmWRyDu1zc+VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 25 Jan 2021, Rafael J. Wysocki wrote:

> On Sun, Jan 24, 2021 at 12:07 AM Nicolas Pitre <npitre@baylibre.com> wrote:
> > A note on sparse:
> > According to https://lwn.net/Articles/109066/ there are things
> > that sparse can't cope with. In particular, pm_clk_op_lock() and
> > pm_clk_op_unlock() may or may not lock/unlock psd->lock depending on
> > some runtime condition. To work around that we tell sparse the lock
> > is always untaken for the purpose of static analisys.
> 
> It looks like sparse is still complaining:
> 
> https://lore.kernel.org/linux-acpi/600dc681.3mAl9WQXnragfNZk%25lkp@intel.com/

Would you happen to still have one of those randconfig configuration?

I'd like to know why sparse complains about 3 out of 93 configs.


Nicolas

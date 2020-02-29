Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26F817482C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgB2Qzt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 11:55:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40267 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Qzt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Feb 2020 11:55:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so7153215wrj.7
        for <linux-pm@vger.kernel.org>; Sat, 29 Feb 2020 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d/eDOfaq0VJ/SLOUD8o7N9AIT3f4AtWAyVbS0HbmA+Y=;
        b=ZDfEfSIbwFOP6KOSjbayNzj2YbEZkQX6Z41YrmSJXwXfIh4gcrTrC0ucxSb/UYemLq
         9j5cCBJkMzkTvxX433AP/ieV1mdL1BQJEccbZjHRV5QkQrVpE500qmNZgFUHIJ/wRWJO
         X6SQfLREWXeMkvz104rKMdxzDeIup0/o0ASv3tTmCBoWnqWrqyT5vrf9a21vuMGfldQt
         Ge9ByOggpCLLbHQ5ykfL+5aivVBTM0k8ro5eOMSpz7qA9F5MiWXKn5MY6N5W8crsCrDn
         pQDEBa+Fto/kFy+CaM2qOroDjpISsdzWG3vtB9T5Igz5ZbFx/lG5P6a66rKemJ0IFjd7
         gJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d/eDOfaq0VJ/SLOUD8o7N9AIT3f4AtWAyVbS0HbmA+Y=;
        b=ESHG/uK7cCqwM3zZwWCWkaPY5r8+owCRG+jOH0UndnzAfzFLtAVmaXocxpMOqQEAv6
         iy+NuoW14Q34yLSndnSWM/+X0Q7WLf9TMOcIuNhnT8rdq33RyeOBpybAFb9XKzy9hyAN
         EvsXSrqrkiNH+UycBXGQq/8q6y++9wJcMaY4YkehRDaJTIhD5hbpFesbFe354cjMmUTB
         3JD9tyxewe9/kywgGlIVYgUjM/RupleoqCbqpfOp/PehCbSarxpPbfCRa5BLqYklmY+G
         8QaZjRm+NgYSM99lefXPgWjIWLT/MDpx3YDczNLB1RXEfPibXIJyJmyDyfBezikEYXeF
         EzpA==
X-Gm-Message-State: APjAAAW0d4HNzVTuPCHbQ922QgZ8u0NxevLjJqfd1mrZy35hdb3okeiq
        zgSJl5C6+eRvJM7LulH4z+twdA==
X-Google-Smtp-Source: APXvYqwKHZ29xYaYamtjaiSWnMeUqe2YZDrHRDyBGKpmsUJX9UY0hoeQvKhbYqqayRN0+5Hv35ysoQ==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr10964595wro.22.1582995334791;
        Sat, 29 Feb 2020 08:55:34 -0800 (PST)
Received: from localhost (229.3.136.88.rev.sfr.net. [88.136.3.229])
        by smtp.gmail.com with ESMTPSA id d63sm6703261wmd.44.2020.02.29.08.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 08:55:34 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Carlo Caione <carlo@caione.org>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Jian Hu" <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH] soc: amlogic: fix compile failure with MESON_SECURE_PM_DOMAINS & !MESON_SM
In-Reply-To: <20200224101654.530f1837@canb.auug.org.au>
References: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com> <20200218080743.07e58c6e@canb.auug.org.au> <20200218092229.0448d266@canb.auug.org.au> <20200224101654.530f1837@canb.auug.org.au>
Date:   Sat, 29 Feb 2020 17:55:32 +0100
Message-ID: <7hzhd19vuj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> On Tue, 18 Feb 2020 09:22:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Tue, 18 Feb 2020 08:07:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >
>> > On Tue, 18 Feb 2020 00:12:13 +0800 Jianxin Pan <jianxin.pan@amlogic.com> wrote:  
>> > >
>> > > When MESON_SECURE_PM_DOMAINS & !MESON_SM, there will be compile failure:
>> > > .../meson-secure-pwrc.o: In function `meson_secure_pwrc_on':
>> > > .../meson-secure-pwrc.c:76: undefined reference to `meson_sm_call'
>> > > 
>> > > Fix this by adding depends on MESON_SM for MESON_SECURE_PM_DOMAINS.
>> > > 
>> > > Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains controller")
>> > > 
>> > > Reported-by: kbuild test robot <lkp@intel.com>
>> > > Reported-by: patchwork-bot+linux-amlogic<patchwork-bot+linux-amlogic@kernel.org>
>> > > Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
>> > > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> > > ---
>> > >  drivers/soc/amlogic/Kconfig | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)    
>> > 
>> > I will apply that patch to linux-next today.  
>> 
>> This fixes the build for me.
>> 
>> Tested-by: Stephen Rothwell<sfr@canb.auug.org.au>
>> 
>> Also, please keep the commit message tags together at the end of the
>> commit message i.e. remove the blank line after the Fixes: tag above.
>> (see "git interpret-trailers ")
>
> I am still applying this patch ...

I've fixed up the trailer whitespace an queued this up now, so should
show up in linux next shortly.

Kevin

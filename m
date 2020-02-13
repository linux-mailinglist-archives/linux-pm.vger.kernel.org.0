Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE38C15B5A6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 01:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgBMAGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 19:06:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45306 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBMAGx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 19:06:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so3947084qko.12
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDJUToEt64sYdPk/trsg/w/cAFjxyyVNajzKkjxTLpM=;
        b=nziJvcKqFRJii0hlM0b1yxzorRxDn2DultIEe1tCLiSjxuNnSO1bXttdnxOZZsgvLN
         8yK0bAvZ/Rokl9Vtpp8Ruigs+ZYZ+LIN4JdyBTjZe07DHYmsp0OCSfddvYVaCOsC8Uou
         0s+6PqARSelT27SF65WkbORzoubddvlDEXSAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDJUToEt64sYdPk/trsg/w/cAFjxyyVNajzKkjxTLpM=;
        b=WLZT/MpHU3Icc3lrHTk1SlwbmVhasfbdb5rXGRikVVLd70iBNjMSxzq29JwOQCF73N
         4iy46GpxC21YI0z515/Y2/RUew8AlVLhOjCGWCavod+GvI4iSPNX5Q6mAsGzRQzhsDZk
         wMJKdNj0wL7obWqtrhyX1dfYeVq6QwwIXfoI2VvgyGF8cC03QUmg04FD4jO19rRijTrb
         cL9s9xYYlRKdI5SoP7N/MSySulEZANoqT0cEd79WD6Ci9Ygqj0C8t2FNCANarsv3ekHp
         QoYMwz3NWEiE4G7UNsVkeKPxDn3YXJA6E8lW1gGMVpURKy16MM2BMF7POAAcn3zLYgWb
         XS4g==
X-Gm-Message-State: APjAAAWXLcNZyDOhZ8uFzmEM5Vi2ZMonDhuqZZC1tgZBlP9uZHpRhw4F
        Ob1P/Iu9JXCOr5WZy7v+BNbZlle7igWEidpYK6VkUQ==
X-Google-Smtp-Source: APXvYqysZTAX6q7Ru/YaQ5ufa8rnGlLHqhM7dXnZKo1GenZCZZPoChIMT6FeNZFkhvJpov1IoPaCYAR/CjsySzL1LFY=
X-Received: by 2002:ae9:ed88:: with SMTP id c130mr3326135qkg.299.1581552410838;
 Wed, 12 Feb 2020 16:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20200212075529.156756-1-drinkcat@chromium.org>
 <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7> <CANMq1KA1=LTtCD2ic7GcskX7izuEkAqUo1xxwwCXBeTLi0r5vg@mail.gmail.com>
 <20200212090356.x6aieuddym5zea5d@vireshk-i7>
In-Reply-To: <20200212090356.x6aieuddym5zea5d@vireshk-i7>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 13 Feb 2020 08:06:39 +0800
Message-ID: <CANMq1KCut88owb2r5_uHi-k57io0T_D9ag0rf==UAEsqoH07eQ@mail.gmail.com>
Subject: Re: [PATCH] PM / OPP: Add support for multiple regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 5:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-02-20, 16:57, Nicolas Boichat wrote:
> > I see... And you're right that it's probably best to change the
> > voltages in a specific order (I just ignored that problem ,-P). I do
> > wonder if there's something we could do in the core/DT to specify that
> > order (if it's a simple order?), it's not really ideal to have to copy
> > paste code around...
>
> I will suggest adding your own version (like TI) for now, if we later
> feel that there is too much duplicate code, we can look for an
> alternative. But as of now, there aren't a lot of platforms using
> multiple regulators anyway.

Will do. Thanks!

> --
> viresh

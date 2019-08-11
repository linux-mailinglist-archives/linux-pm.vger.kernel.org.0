Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81B9894AC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHKWVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 18:21:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40709 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKWVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 18:21:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so73024955lff.7
        for <linux-pm@vger.kernel.org>; Sun, 11 Aug 2019 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PKMnQITWwiXFSMsZSKMDb22TaOXVnDVmZW4//J3IWw=;
        b=F87DPDCxu7qIiZp3Iste/+lk9+QFN97gCAZMErm/aWY1IvruObafGHsGTw0CQyf2k4
         8gOeV67Q6Clph22ez5jP3zA7VXVGeEiKiLLfQw3VVc7vmOMJWqOQHmguB6fnIQHZb9EU
         8OH9pkSXbmZHWZzeM5pxDYzhyMSl6TycH7RAOo2dDDyWzE2aQGtaxt9itY7qPaYT8iLb
         V9cbjhVBzEl9ZcqSoZVtbRFtZ9gCagNIds8d6P9fWYqFtEUcyrQewT+daihzzX6/AF/9
         JPL8a5ze71GKaTXakXMixC83mi2I5SOFnzOafvhWAjwYGC57VU/zn5RWtOwhttjyeS9k
         o93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PKMnQITWwiXFSMsZSKMDb22TaOXVnDVmZW4//J3IWw=;
        b=sQBoquPjvdpqxeIGrSGz/TwUZv3qsTmcwJlgaspAZrPKcXTdgVgzQ88Nt8LubCUzLK
         9zzQct3E8+wqNMru0tNW+NoNhEgGC5msVE9RIEPSHwaq6QzbwnQuNdAPtiC1sWPxXzLK
         gwKQIFsxZPcAsprvStaYQe8VfibpqfhZ0WA1Mk4dy7SQLj7GSSXE7uKGy8MgZEDOn45L
         RzJQW+xE2YlSbAzty7EaQEFWyxMSOzuElnCsCTZihcDxtv2ko8d4v7xTj0qcAHXbKl0m
         Q+Kk6PcUsk0QE7zuzE7tinfa1r9SiYH0gFiwDvjgXD78htCuNdeNkgpl+Xfc8Scr+7X/
         ZYpA==
X-Gm-Message-State: APjAAAU4UO/9OsZzj+Sxh/2tA33z3UhMo3wsIQGyMsJLee/Omej6zxDx
        T18ZAw7khGG1/yEMGaEztV09gSAQYjQ9CFB/bGsDcA==
X-Google-Smtp-Source: APXvYqy6mTIfA60NE7kmS7s1BxZG3hi4Qgr/HAnUJW4KB8c+62S/9s0VLcQaLSRgmtQkP2qox9Vitw+vqHeZRJ6c4pk=
X-Received: by 2002:a19:e006:: with SMTP id x6mr17864493lfg.165.1565562102810;
 Sun, 11 Aug 2019 15:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org> <CACRpkdZcuqeUXVtwNJj8N+ncs6CVjmthdoe1cDj+M_imGLqisg@mail.gmail.com>
In-Reply-To: <CACRpkdZcuqeUXVtwNJj8N+ncs6CVjmthdoe1cDj+M_imGLqisg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Aug 2019 00:21:31 +0200
Message-ID: <CACRpkdbtk_hjwuEp+9-NuGDs6OficrJVWZ86ncmiH+NANay6CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 3, 2019 at 3:58 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jul 17, 2019 at 8:34 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > At some point there was an attempt to convert the DB8500
> > thermal sensor to device tree: a probe path was added
> > and the device tree was augmented for the Snowball board.
> > The switchover was never completed: instead the thermal
> > devices came from from the PRCMU MFD device and the probe
> > on the Snowball was confused as another set of configuration
> > appeared from the device tree.
> >
> > Move over to a device-tree only approach, as we fixed up
> > the device trees.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thermal folks: can you apply/look into this?
>
> If you're short on time, please just ACK it if it looks OK and
> I can send it through the ARM SoC tree.

Ping on this patch, I need to merge dependent code, so it'd
be great of it could be applied. Sorry for hammering, just a
bit desperate.

Yours,
Linus Walleij

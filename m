Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CBA5DA1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfIBVkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:40:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41176 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfIBVkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 17:40:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id h4so7860633oih.8;
        Mon, 02 Sep 2019 14:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXbN/yi7X93TMH+BXS2cXuMz8NVjciWZDxzvL0VB4L4=;
        b=CQHWj7I3oDdztaOrRovr8vQbgK97nQhG8cBbkqm3g12NKCGyMwVHk787moyLfyEKVY
         dUqDHuMf7X2JFUm/FBldZ0sebq/aa7HaZmnakUvx3fC23QgzNBybWsAOOv9HFe7GIRre
         Z5fP+PMWACgeGl2kXrOcFyR5WvyQxpwcBhFPjnQ9k8p4yqPR8ioU4TCOepfhIs9AEe0m
         s5ofc4JwxCnJsC6sExlmlv4sxiV+CfCb4GhVjYNl5hTreby9Qrzupwk64eYtLaelO5Uq
         27ORESW4YVHcNi+AkAUnoN9+OosXMw+WnNBfdDnK9E1xozLvML4Iscn9PPO4KBb2RovR
         nJ4Q==
X-Gm-Message-State: APjAAAXG/QITSfKmd1fiiXH1vc55zFAyI9GsN1bBd0w/LyXUOS2dNcBT
        hXzR7QyKXKP2D5XwpQzgdjUQnSslLZ9L0u5Gh+Y=
X-Google-Smtp-Source: APXvYqzqBjJPL/bu4gNX/O8T8mByKAZ/PuQesuWjrdVROv7VuQ/k9Mxe9LY3rQeHY/S5nzLTB61QqWBUIRarL3UkShg=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr8956207oib.110.1567460405306;
 Mon, 02 Sep 2019 14:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com> <20190901142304.GA20868@owl.dominikbrodowski.net>
In-Reply-To: <20190901142304.GA20868@owl.dominikbrodowski.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:39:54 +0200
Message-ID: <CAJZ5v0jgEtyEPh6qYKOkKzYtzixDbtN41m1sUS9tab1Em04AFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Documentation: add runtime_status ABI document
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 1, 2019 at 4:30 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Hi!
>
> On Sun, Sep 01, 2019 at 11:08:51PM +0900, Akinobu Mita wrote:
> > +What:                /sys/devices/.../power/runtime_status
> > +Date:                April 2010
> > +Contact:     Dominik Brodowski <linux@dominikbrodowski.net>
>
> Thanks for the patch! I am not sure, however, whether I am the right contact
> person here -- maybe Rafael J. Wysocki as PM maintainer?

Right, please follow the convention used for the other attributes
documented in this file.

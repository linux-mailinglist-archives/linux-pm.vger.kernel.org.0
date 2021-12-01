Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340F2465439
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhLARut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 12:50:49 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38427 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhLARur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 12:50:47 -0500
Received: by mail-ot1-f47.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso36327230ota.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 09:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4hP6IUEN212XufAWm335Ms/+849s7av17sQ+wPJ4r4=;
        b=ejxObpIYAlAyC7KDkH4AzRbrUu+rZmjBqxg5Clbvxb/N4NBF/UwTr+yQu+fiHDp/W6
         6QIol7ySWqCeEkkH9dloVmuSkZv0zXmj6WKqf13KiOaVBWDGClhtMNdb+lVRtX0TCNO7
         14CLQVvBfyHX1henqgwkEOsD6KRQOmV3QpVRokfaxkDJmFvST6AhhkAqgvnj+Yrm64/r
         TNmEqMSWn2bP5sUtqZKWyfuNulE8WbRBcJ0SgklMhvz7Tzup734WDf5Vh1p6sdxd3Zoi
         tcrHcTKo8EXHhINN5YLlZxmE/3JBDcrKgPqOoSEZt6ZOGtqt2JgzIcUYeK/B8MB3sydC
         Ukqw==
X-Gm-Message-State: AOAM5326QR0EPGzKIQs5JyO/l1xo4YCsa6mH1mv9gi0D02GvAoSFwv2u
        NNWwXPBNOZMq17boCWwI6KVJjGQ4J0KWIyd3aFQM5IxR
X-Google-Smtp-Source: ABdhPJzrQbOVWhQb9wehJnlqz2h6eddy0wrx4J8wYApB9IYqLYYYjB2L832emuxbJ+GPtlKixkKkRnsf41dSYgf9jTk=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr6952361otj.16.1638380845748;
 Wed, 01 Dec 2021 09:47:25 -0800 (PST)
MIME-Version: 1.0
References: <BF9F1078-8789-42F6-92B8-CFC4A0A7895C@getmailspring.com>
In-Reply-To: <BF9F1078-8789-42F6-92B8-CFC4A0A7895C@getmailspring.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 18:47:14 +0100
Message-ID: <CAJZ5v0gPCc++kkt-=zhmXWBnXcqtwm2OM1PgC2YeOhkkCjkYEg@mail.gmail.com>
Subject: Re: Thinkbook 13s-IWL issues
To:     Florian Dollinger <dollinger.florian@gmx.de>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 1, 2021 at 4:56 PM Florian Dollinger
<dollinger.florian@gmx.de> wrote:
>
> I am facing a rather weird issue on my Thinkbook 13s-IWL laptop. On an
> arbitrary basis the device is trying to reach the suspend mode, but
> after turning black the display it does not, as one would expect, turn
> off the keyboard lights and starts flashing the power button. Instead it
> reboots the system after a while. I am using the lastest UEFI version btw.
>
> Anyway, I was able to find out the following:
>
> * `pm-suspend` works flawlessly, I have tried a hundred times now and it
> never crashed
> * `systemctl suspend` instead, is crashing my system every once in a while
>
> I would like to dig deeper there but I thought both commands do the same thing?
> Looks like both are trying to reach the s2idle mode, right?

I would think so, but you may need to double check.

What's there in /sys/power/mem_sleep on that system?

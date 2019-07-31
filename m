Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5507D0CA
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfGaWSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 18:18:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51265 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGaWR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 18:17:59 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 930e658ccde014c4; Thu, 1 Aug 2019 00:17:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>, Tri Vo <trong@android.com>
Cc:     gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
Date:   Thu, 01 Aug 2019 00:17:57 +0200
Message-ID: <32598586.Mjd66ZhNnG@kreacher>
In-Reply-To: <5d420f45.1c69fb81.35877.3d86@mx.google.com>
References: <20190731215514.212215-1-trong@android.com> <5d420f45.1c69fb81.35877.3d86@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> Quoting Tri Vo (2019-07-31 14:55:14)
> > +/**
> > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > + * @ws: Wakeup source to be added in sysfs.
> > + */
> > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > +{
> > +       struct device *dev;
> > +       int id;
> > +
> > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);

So can anyone remind me why the IDA thing is needed here at all?

> > +       if (id < 0)
> > +               return id;
> > +       ws->id = id;
> > +
> > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > +                                       wakeup_source_groups, "ws%d",
> 
> I thought the name was going to still be 'wakeupN'?

So can't we prefix the wakeup source name with something like "wakeup:" or similar here?




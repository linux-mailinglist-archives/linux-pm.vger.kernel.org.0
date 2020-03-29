Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E934196DC4
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgC2N4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 09:56:46 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44548 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2N4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 09:56:45 -0400
Received: by mail-oi1-f171.google.com with SMTP id v134so13327309oie.11;
        Sun, 29 Mar 2020 06:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xc/YsL22+xvtRonmC6Bol59woO+qBjPIQufFfO9npSM=;
        b=bj4O/Z4/SlexbgiYzMTWApxSZRp7pLkurxSJ+5l7y9lZvxSBkaoTG7bHPL7i/5vc4t
         nAEqzPpTUgNMf8/7ZBgr7fwa2ynjA6+tEKatO1TxZ/HYidZQpGoXhYMMsVtRjt+mQEqg
         krnwKo6//SgFdhqo5ZvCTZ9PlOL5K+cT4SOOMCIW6prjMOI1cIlK7BpRlRatcSDjlC8j
         M4EI2qpFYTjUlCkXNrEOeTnr+iPQkCFHtaspDoMMwRyPHVBG8XtmI78TeGIB4AGZciq0
         nsOHmz+ijA7Sw7XhnnGZlO2zgInnPjqaId4rCrpRol3pY5OVfmK4YtllqUaXXVGvRcp5
         NzwA==
X-Gm-Message-State: ANhLgQ000O6rqJZk07rMoSki3Go0yPCec82bLLYnypfkEiBt5q+LDSxf
        Dgi2Y8XHrnAq4foAwWVAcJHWdSeCQhpddzlXuJk=
X-Google-Smtp-Source: ADFU+vuAPXvZuTFrPg0P26FMXoSrwWtTlPV65QUUwTX5E8ZDQPZw4waandbicfWWTX3OHlLtZAcfPi1cVmjZh5d9ts0=
X-Received: by 2002:aca:5155:: with SMTP id f82mr5003191oib.103.1585490203653;
 Sun, 29 Mar 2020 06:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <10243663.e30Z2V8kAt@kreacher> <Pine.LNX.4.44L0.2003281432130.9749-100000@netrider.rowland.org>
 <CAJZ5v0igUZnqFLcOhruDSNjv0HqCsy64tmYWyTX98xEc9cH14g@mail.gmail.com>
In-Reply-To: <CAJZ5v0igUZnqFLcOhruDSNjv0HqCsy64tmYWyTX98xEc9cH14g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 29 Mar 2020 15:56:32 +0200
Message-ID: <CAJZ5v0horQNK4EBnNyFAz1gCe=SKJ_f9-5yiMeP=Scq31gscQg@mail.gmail.com>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 29, 2020 at 11:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>

[cut]

> >
> > But if SMART_SUSPEND is set and the device is runtime-suspended, why
> > issue the ->suspend callback?
>
> The driver itself or the middle-layer may want to resume the device.
>
> Arguably, it may do that in ->prepare() too,

Not really.

The problem is that that device_prepare() is executed synchronously
for all devices, so if multiple devices needed to be resumed, the
latency would accumulate if that happened in device_prepare().

Cheers!

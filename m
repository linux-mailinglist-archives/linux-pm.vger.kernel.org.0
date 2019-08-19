Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0D94CF7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfHSSaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 14:30:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33257 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfHSSaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 14:30:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so2607572otl.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/VeAeKX1xTDl+s4tBgBAHJpn7eS0PK+CB1vnSZNpOE=;
        b=nzaLeW0lOmuy34oquCtsLKqtgPATh1wWb/oREDrGAPrZMOi7mLLlCqwJDwHzuQI1zQ
         nFQaknob2bqdEOyUP9e8S6auemmhPRtBmAsn1hYWWsgeyTnK/NTt3s+W80KuAGTbREo+
         HJZVKXhv2NdFL2epDgHBMma/rfIYstd8Soysr4+OiXVDyyxAAne/xrVRaR4wozSrIX0j
         LCDAMJexdqbJwN3F5eTUoEz2yCtV+r3nFFGEp/BRaVsoOfko4zwOgIoZfzjE92uNBKJ4
         Mw+eS9L/SV/u6xj2Osl+u5p+i4hHMK1U5rzO5+qAAupURpQtqupRLpUOlA+JSLKzViM9
         fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/VeAeKX1xTDl+s4tBgBAHJpn7eS0PK+CB1vnSZNpOE=;
        b=iXGlOC1d1YRk64+0qO6CXYR9Xw4HERoZiuY0RzV1Ju/2kPv5iGB9pqIVnoKgVJywBr
         suZ6iAxmlmHMA8cUYStdCcgJzwazlHAQgJD+BWW7uR2KoVEyHa/v2arkTHk5g6zxy2Fx
         g6t66PU19GBJMKdZF2O/mtu32DCLsL5E6A9hIXhb+giDU2VislCTElOefhFGFxk7KYiX
         II2bFS4KFaIPOtN25ipmSMYAjwk2Xo9PJ9TeSfYo0hxm13SWqcbbk4ChnJd0+8GNYSx1
         Yw7ZxhPUCgUzazc2bc8LjbCPaTmTQ6yRXbCWfLlji85mXYudD/on1fJ7JbJgbXlq0G50
         5n5g==
X-Gm-Message-State: APjAAAWret6iCTUBvNISX3Fae7k2bZbxGBomKCBJ0swcqaQNs5Xhwbrh
        Fc2YaSUfINDA8cKzWMTShxtkYGysK2ssqEZv6ES6Ew==
X-Google-Smtp-Source: APXvYqzSVE22VDiQu8uGHa8Q+AjRI72tU3whMdq4pqkn94MHCeMT3uvhcjwzyjipLlogSVD3xRNpahFaVw6maSbIuSo=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr18326897oth.159.1566239454336;
 Mon, 19 Aug 2019 11:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190819175457.231058-1-swboyd@chromium.org> <20190819175457.231058-2-swboyd@chromium.org>
In-Reply-To: <20190819175457.231058-2-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Mon, 19 Aug 2019 11:30:43 -0700
Message-ID: <CANA+-vBZF+KkB-ZWhjpRS=hwhk+6pM0mmUsj8gwxy0VcKjqG2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / wakeup: Register wakeup class kobj after
 device is added
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 19, 2019 at 10:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The device_set_wakeup_enable() function can be called on a device that
> hasn't been registered with device_add() yet. This allows the device to
> be in a state where wakeup is enabled for it but the device isn't
> published to userspace in sysfs yet.
>
> After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
> sysfs"), calling device_set_wakeup_enable() will fail for a device that
> hasn't been registered with the driver core via device_add(). This is
> because we try to create sysfs entries for the device and associate a
> wakeup class kobject with it before the device has been registered.
>
> Let's follow a similar approach that device_set_wakeup_capable() takes
> here and register the wakeup class either from
> device_set_wakeup_enable() when the device is already registered, or
> from dpm_sysfs_add() when the device is being registered with the driver
> core via device_add().
>
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tri Vo <trong@android.com>

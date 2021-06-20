Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2A3ADFE5
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFTTXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFTTXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 15:23:41 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259AC061574;
        Sun, 20 Jun 2021 12:21:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r16so5082434oiw.3;
        Sun, 20 Jun 2021 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t+9gD54K/vBtpR6t83LME8EKiJq/ObCRGqxLJarDo5g=;
        b=CWyivAcngKNrH3U3eHksqHxLbJPgTMiwfgFuy/1qyYUXV9gLqulIy8H7ixuvf5XgA0
         RfppBLa9BrDNS+SDhohyJq2xzbZOCtFgOdCAk2hDIXd09PCRXDB7GkGmJY+w0BIz/6FL
         vgca9EUHoZdkIGHemJ8xythN5kpLfyzZUXBwpm5hY4ONx6JLKN4r7SYWQp2A+1RKqrzP
         hail6ljc8/PlcGG94lWL8gydC7rb3cw2pc2p/PlZ4Frp3ryjObtGMV/xhZ4toHPTLTTa
         vic5Os9ksWLUWLWiBagNl6FTG6mVmDpgIj5G4uy8gTebCsRtUoCvm1e9KcPv+5mvLTEg
         3yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=t+9gD54K/vBtpR6t83LME8EKiJq/ObCRGqxLJarDo5g=;
        b=c7HCofQn+EWr8jAkhu+cwNQAVe2XgS997sTZxOiLFWX4yTp/puTIPv/qyyyTea8nZF
         LtLGlscvvzxZwdS0y5n4V/fAnZwhAqTh4loENyBhRK7Of39AmT5FphsCU9eeLVIftSof
         5auwNo2B2AINL+19cjgCdPtz5KkTC7o8mH3VjxdQSak+Id0fw/k/mArBZC6qKUssh8g6
         iwsdLEJ2kQKNNSRncI4/D+tNbM7z+kW89DxIfsQyQJwsuxMq2mtEU0vmyvl2521KPQmr
         Jh1NzKNBi8vuIVl123JQIOEgOIXorAxC/QPnb3Q+JgOHPzl1tCqFVsmhg5WSA5fuo9m8
         NEZg==
X-Gm-Message-State: AOAM531UQWPww31Aw0M2DETBA3rCMxekeml48eurI3j4ixMbyX+HQWsk
        u0t1BFflfs8VZPsgKUixnBw=
X-Google-Smtp-Source: ABdhPJzj7IylBq1/OsjmLoRHZP/tiT8k0YsWkvjZyoAnhYXSyFjNFhqpS+fNtuGO2c/snGqd5crSJA==
X-Received: by 2002:a05:6808:692:: with SMTP id k18mr21786992oig.148.1624216886804;
        Sun, 20 Jun 2021 12:21:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p25sm3126129ood.4.2021.06.20.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 12:21:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Jun 2021 12:21:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/2] hwmon: Support set_trips() of thermal device ops
Message-ID: <20210620192124.GA3853199@roeck-us.net>
References: <20210620161223.16844-1-digetx@gmail.com>
 <20210620161223.16844-2-digetx@gmail.com>
 <20210620172329.GA3850372@roeck-us.net>
 <1cb97f70-9fdd-e7d5-da73-dc5c42a53104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb97f70-9fdd-e7d5-da73-dc5c42a53104@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 20, 2021 at 08:38:27PM +0300, Dmitry Osipenko wrote:
> 20.06.2021 20:23, Guenter Roeck пишет:
> > On Sun, Jun 20, 2021 at 07:12:22PM +0300, Dmitry Osipenko wrote:
> >> Support set_trips() callback of thermal device ops. This allows HWMON
> >> device to operatively notify thermal core about temperature changes, which
> >> is very handy to have in a case where HWMON sensor is used by CPU thermal
> >> zone that performs passive cooling and emergency shutdown on overheat.
> >> Thermal core will be able to react faster to temperature changes.
> >>
> > 
> > Why would this require a driver callback, and why can it not be handled
> > in the hwmon core alone ? The hwmon core could register a set_trip function
> > if the chip (driver) supports setting low and high limits, and it could
> > call the appropriate driver functions when hwmon_thermal_set_trips()
> > is called.
> 
> I wasn't sure about what other hwmon drivers may need and want to do for
> programming of the trips, so decided to start with this variant. I'll
> prepare v2 since you're suggesting that the universal callback should
> work okay for all drivers, thanks.

It will require some checks during probe to make sure that writeable limits
exist, but that is still better than per-driver code. If for whatever
reason some platform expects a different set of registers (say,
critical limits instead of warning limits to attach to trip points),
or if some platform expects that limits are _not_ used as trip points,
that would not be driver but platform specific. You would not be able
to address that on driver level with a single callback either (after all,
lm90 compatible chips support up to three sets of limits).
That means you already made an implementation specific choice with your
code, by selecting one of those three sets of limits to act as trip
points, and by making trip point support mandatory for all lm90 compatible
chips. If we need to make that configurable, we'll need a better solution
than a single driver callback, and that solution may as well be generic
and driver independent.

Thanks,
Guenter

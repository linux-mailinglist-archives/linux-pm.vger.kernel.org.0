Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DB12328
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 22:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBUYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 16:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBUYd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 May 2019 16:24:33 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027E620C01;
        Thu,  2 May 2019 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556828672;
        bh=fPysuS9QGjjgbk9tLRamHIsNsWi799oVziR6RsQ3XTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B5FzbdvYNHyOzaACD9WnyFZMcLJAtiwUAT7VXwkycVlj1ywQdTL8YZQmE38MoGiZS
         eJl9nziJNk5N7ip2vO/yzjxNUdRPQz4y0Mii5QzP4X0RhwXQVDrY9oxBMciQcU9kKp
         w/z33u8QovQFpjrHmcUgbqjbLfH4vs1hkIiA4Cz4=
Received: by mail-qt1-f177.google.com with SMTP id p20so4205810qtc.9;
        Thu, 02 May 2019 13:24:31 -0700 (PDT)
X-Gm-Message-State: APjAAAVyNpqnmf8M/COWusVcDQJ9AHa/OCZ1CW0mAMwLMbr+K3FjjJSa
        KHdbRLyV8v1MFVcWO1g8TMq6Wo44q3cjFgn/0w==
X-Google-Smtp-Source: APXvYqx6C25RjdbTQS+SWLt4/8jx2DcPpy0kcWoZHeaatbwZmHH6mbkpB3Fk9JShMpb/mxi8G6d9PZk2zE2bZTukxKg=
X-Received: by 2002:a0c:9066:: with SMTP id o93mr4888171qvo.246.1556828671176;
 Thu, 02 May 2019 13:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
 <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
 <20190430223629.GA22317@bogus> <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
In-Reply-To: <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 May 2019 15:24:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJcm9Z6vYFHGyAZ+h3-kmSv6e=3NtO-fjJn3-QT0JoX+w@mail.gmail.com>
Message-ID: <CAL_JsqJcm9Z6vYFHGyAZ+h3-kmSv6e=3NtO-fjJn3-QT0JoX+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 3:52 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rob,
>
> On 5/1/19 12:36 AM, Rob Herring wrote:
> > On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
> >> Extend the documenation by events description with new 'event-data-type'
> >> field. Add example how the event might be defined in DT.
> >
> > Why do we need event types in DT? We don't do this for other h/w such as
> > ARM PMU.
> In ARM PMU all the events are hard-coded into the driver code i.e. in v7
> arch/arm/kernel/perf_event_v7.c
> and are seen from perf. They are different type and for different
> purpose. The Ecynos PPMU events are not seen in perf, they are
> for internal monitoring and must not be reset by other actors like perf.
> They are used by the 'bus drivers' to made some heuristics and tune the
> internal settings, like frequency.
>
> Chanwoo has written PPMU driver which relies on DT definition.
> The DT events are used by other DT devices by phandle.

How is that done? I don't see anything in the binding for that.

Rob

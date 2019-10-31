Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353C4EABF5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfJaI4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 04:56:05 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:32910 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfJaI4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 04:56:05 -0400
Received: by mail-il1-f193.google.com with SMTP id s6so4707342iln.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFfdHfuhP+nEEQfQbC0Ba4Z+OQ9QN7a/luiGoxHZNKI=;
        b=tvdh0va1KgpZTtjmMZNglpPZI03tvtnGrO5YO4cTV4BiVYA+11jNi3bTMfInJ1Up0a
         aoVUaXwQWYabwxtf4Ll8mfoLG2JyLcMYt0mam5/o6dAfujWHFAcY/46v7Oq6GsABGJ0M
         +Sds7J3eBBKmtI3m8OcMFpGgLP7p1VD1LZOFdfuKKY9IhTqlufbq0ZTaKFZ1OFbDTMeP
         wt5HuQunjysLqwvbwBOoStV1dcahtv0duyWC0YgjtTkXgEto0XoPkk72ntb5A93L/tE8
         itwFWMXuQOEeNIjk7rzz9dcNdf6oJotXCzlx94WWlSxwuvaLnbjM1f6Xg4BI8Xx9Mhky
         Kh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFfdHfuhP+nEEQfQbC0Ba4Z+OQ9QN7a/luiGoxHZNKI=;
        b=iCxLbxOdx/o5OEEn3UQ0ZGWa5VJP76AhNHw1mH3553R03V3Poigzgw/zg6eDh3nmNB
         Zu/3XI9DFl90GFIwwwQdilPoIT7jPCH70DlfqP0V2+xSXlwRsQgtWjBeoKHnc5ABw3uT
         KGbCvbDJypNMalFperO7tWLczyxaMtOqu/hPRDGZN4i5mpHkotTtzKbE5XpgXYUxPpsn
         Estr3Ol6EVVCY0SKIxJNNWfMtytsEBsbw/5Uc/fPMhThtzZ0ePHzoDqA6QON6pyrYzHk
         ABvnH4AbSmRkJn57UlGuQIUlPDNJbQXFbimR/dGboig/eFce8G7Sk0EQsVywpsbk+7CU
         jxuA==
X-Gm-Message-State: APjAAAU1fZ42pPX5PqgJrEKjbWjFQLEZXpXXiDSSitS2Kz4dXnSfG9sp
        Rfu3JFVeyRD9XwAxxJg9KzEw65qjYbjJiohYZEmrCA==
X-Google-Smtp-Source: APXvYqwfX3ZfmayVc1DkCMbcevGUQ3Zmtj89LujmSEYYk2OKKpmSKfIAH39CJHL+4amH5NwNeo9lS0jhOjQEwNOQDnM=
X-Received: by 2002:a92:af19:: with SMTP id n25mr5445478ili.138.1572512164205;
 Thu, 31 Oct 2019 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 31 Oct 2019 14:25:52 +0530
Message-ID: <CAKohpomW1CHrHZmXTmOAw9Oj2YauLPQmrL0Tw-j92qZ2YqK_Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Oct 2019 at 14:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.
>
> It it pointless to check if CONFIG_OF is set in the header file as
> this is always true if CONFIG_CPU_THERMAL is true. Remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/cpu_cooling.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

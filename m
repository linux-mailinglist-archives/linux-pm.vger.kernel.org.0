Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688972FE8B9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAUL0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbhAUL0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:26:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BAC0613C1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:25:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w18so1311594pfu.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aL4GPeleTKRCNW1fK6e7red/YB+a/GG2BxvUEBjR5W8=;
        b=uGsuauxP904q8sXK2v9yGjasS/3E0sveYxPOJmpLwGSi0oqBbCwrPmIPkOuJYT+MYu
         FYRI5PtnqyoNs940vWo4wo28MBZ+p0+AZYB9TpsTfbF0aA4zt6KH3GFB2lylaluC2tvw
         JYagpbIyXmtu0aLvHUJ9wsLY/8Zqc+LsAQUfvGnHrqT73WF09RgkemvFlkvlfkZHqi/V
         azpQ42z9E8mpTT9k8//Q4tGdsHr338AQ+ZV6xy0t9n20jacy/8beAPVsGQnMu4ThhlMm
         sdMrNlByVcszUPl3XxOsE5hy5v1ZBsNtDoIVMQBc7MndALFzFc8HQS/4I34evxiDFOgw
         nR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aL4GPeleTKRCNW1fK6e7red/YB+a/GG2BxvUEBjR5W8=;
        b=qoTycSM5CJRwWeDrOx8XWupaqOMe+vBPzC5IwQdzYocRUO+z+8nFak6ne7xvQPvjnh
         p9CgYgg846PFK2L1Aqv8sEZTNVA2Rk7zfyxI2msZvSsiJzqWGbMgmNN7wJyWBwE7yxJb
         ktV2L/J6oM7WiYLmm2JZO7EQmhwfK5gakdAJ0r8U6ELY6D7Y+6hOsIOkSsZii1q0dIzM
         SsT4Y6dhipzHYHPF3ftd/532lGNdsqs8jvRr/XtebourS81fxijc+kNEkxW823EgL4/1
         XpzGDwIwwL4a3bnjze2LTFGEKnjlsPY/MbGCFYcjVWENA52DaLPl44hAeNtR0Cfd985x
         D6Rw==
X-Gm-Message-State: AOAM5308jIX9ysRAKMi8fY63Y1Ow5Qwp38hxKk8noQUH4S85Y5buGpcF
        uoZd4uNvtSc3sBTgZgnQLZyHhQ==
X-Google-Smtp-Source: ABdhPJytWTErMkAfHV/6jgBPSRvh619jqHgv42YX3SLD7FLTMtKCDSBmc6FUIlFUK6j2ejD79Twvvw==
X-Received: by 2002:a63:e058:: with SMTP id n24mr1472541pgj.345.1611228339475;
        Thu, 21 Jan 2021 03:25:39 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a30sm5139273pfh.66.2021.01.21.03.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:25:38 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:55:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210121112536.pwdxikqtgpxmmizt@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
 <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
 <94f4ed8d-ab54-4180-87f7-4ddafb52074f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f4ed8d-ab54-4180-87f7-4ddafb52074f@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 17:50, Dmitry Osipenko wrote:
> If OPP API was meant to be thread-safe, then the
> dev_pm_opp_unregister_set_opp_helper() should unset the
> opp_table->set_opp_data under the lock since it races with
> dev_pm_opp_set_regulators().

Right, I will fix that.

> Secondly, functions like dev_pm_opp_set_rate() don't have any locks at all.

It was on purpose. It is expected that this routine specially will
only have a single caller and calls will be in sequence. This gets
called a lot and we wanted to make it as much efficient as possible.

> It should be better not to add "random" locks into the code because it
> only creates an illusion for an oblivious API user that OPP API cares
> about thread safety, IMO.
> 
> Making OPP API thread-safe will take some effort and a careful review of
> every lock will be needed.

I agree, we have kept some part out of the lock intentionally, but
every other thing which can happen in parallel is well protected.
There maybe bugs, which I am not aware of.

Another reason you see less locks is because of the way I have used
the kref thing here. That allows us to take locks for very small
section of code and not big routines.

-- 
viresh

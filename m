Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB71BE4C7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2RIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbgD2RI3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 13:08:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CBBC035494
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 10:08:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so3467354ljj.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F/GGX+E0c0+b/vD1LG0X0Imv+S43d6dDOK/FkPT3g8=;
        b=jNkYpc6S0ZAt1d7I3WBLADvu8AvAoumyVfy15MqXYeffwC+o4Cob9YDhPtMZ8QWvH+
         NIwdCDYO3Ztb8zQ3NlSssEXDT66TreFG8fQZFp2Sf/GUZvt3pdbYSGtLKGnxRX+tQTcQ
         zb1kabUEdqdEgPGAX3PG8+MATiYMctEl87v0wIV8vw6cs9cJg5IaVwlKG6Zfiv5akn75
         jDsY1e2YbK6YsNoc8BmOCB3Kw7UeY8zYQ1iUdKYUGLuug2TQemrSwaCGKE4Xe4nS9V9P
         WBX0kvYhtVFlazgSsG0wd6v0mt1vwy7k9/83/pCmG6nJkn1eoGUkQmSC02Cnl2AeuK8+
         nCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F/GGX+E0c0+b/vD1LG0X0Imv+S43d6dDOK/FkPT3g8=;
        b=RLeu/MkHL7tpCuU8HKczZCHG4v85JcmflMbzBg+/yWHcLzAnCQ+DrOOzaN4ZITO42B
         GFliJ+ayDUp/WtblmOuy3UFNmJE/gAvsEFq6rtbmzH4dljMDDc1vWVvr3oafByrrRjYv
         Pu2fhQ0+oqL8qF19jTv/yERkMNJkU5WDZF/xBrLHzSiXis/e7IQxRiMwafTQUC2d1eYE
         3eoXIJ1Sm+WSnGoC3aL962VgJiA/Ffs4P3jUN/ZPJdZlLVNsj/toPgbPvn/6r4mO9TXj
         ldeNsRxbu0kekg6ibRaCwi1CmltiS+THGkflKnjKyIiJenk+gjHFoAfBbiCktZiYyj9O
         PhMA==
X-Gm-Message-State: AGi0PuZb1hEUnGdB8janFcTQzJq8hW6OMZtSiWbepQDXbVF3Ld+UZWMC
        GBI5rCP3D+fQKCxoG92WeNmkNpt+ojNNPIvyRFInjg==
X-Google-Smtp-Source: APiQypI/p8hMCfeSVM1tpb+Hmphas9b6HroclmJaxP7F1hxtSeUvsqPKT++NGG1tH/H5GveF7lU55+kiTYZblxp87+I=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr20607906ljg.21.1588180106288;
 Wed, 29 Apr 2020 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200424114058.21199-1-benjamin.gaignard@st.com> <7657495.QyJl4BcWH5@kreacher>
In-Reply-To: <7657495.QyJl4BcWH5@kreacher>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Apr 2020 19:08:14 +0200
Message-ID: <CAKfTPtBNH8x=83RVQajgK859qQGjMTyvEdP4GioMONEZp9t-NA@mail.gmail.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, hugues.fruchet@st.com,
        mchehab@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020 at 17:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, April 24, 2020 1:40:55 PM CEST Benjamin Gaignard wrote:
> > When start streaming from the sensor the CPU load could remain very low
> > because almost all the capture pipeline is done in hardware (i.e. without
> > using the CPU) and let believe to cpufreq governor that it could use lower
> > frequencies. If the governor decides to use a too low frequency that
> > becomes a problem when we need to acknowledge the interrupt during the
> > blanking time.
> > The delay to ack the interrupt and perform all the other actions before
> > the next frame is very short and doesn't allow to the cpufreq governor to
> > provide the required burst of power. That led to drop the half of the frames.
> >
> > To avoid this problem, DCMI driver informs the cpufreq governors by adding
> > a cpufreq minimum load QoS resquest.
>
> This seems to be addressing a use case that can be addressed with the help of
> utilization clamps with less power overhead.

Can't freq_qos_update_request() be also used if you don't have cgroup
enabled on your system ?

>
> Thanks!
>
>
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96713B2C5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANTN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:13:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39059 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:13:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id e11so4756364pjt.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kh1Ge+Ojyq1Hkaf57+ksFQlpw/tvYEo5VWAEqDe26e0=;
        b=IoV0u8G3OE4qe/OlOUrmQtTvkn0Ck8iGTgGitUdy4pm3zeqyty3RtPcor2vp/ZM5UM
         bh3Y3Dm0Rl8FtYVdIGq1TmyzYHROP92D3Yb8/avJnDjSPv2yCHiRXrJt9rFiOnhFOgfx
         J1uuzsbaA6SZJOUNcD3OseGl4+stFJaViEmj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kh1Ge+Ojyq1Hkaf57+ksFQlpw/tvYEo5VWAEqDe26e0=;
        b=p9swh42wK/xf/TsE43EYoE3vKuSAL5sQkhGXuncAWiPwczjBDkpnQT5fP08Uwecver
         R6hmpdvs+taTjZqjqRTs/MO+0oBxoasw7rZARMDH8cUViSgPkztcpkfRW8qu1anj0j5V
         R7XY6htc0sEJk4b0LnVD+I3NkQh1IVKgSPZGz5tCAkzmcEzuz7u/Sza126Jruc7bjpQr
         W/yk2MjzTUjv/ypO6oRXs/E+wUuePlkrgkk+8L4CyaCbOm1AREOAUwCg5+eBhlHW45pT
         GDRK1nTPks4kSfm5EPujtUdUX8CInNlASOx5ZWd4U3WzYyt7wZEaCXjQKuHXTEUtck0d
         rDew==
X-Gm-Message-State: APjAAAUHKGBenA/YT+bO1zRqHseIcmErySGTSJ+v2Fw+qghGx4M2gUVR
        CSmLsI1Fs13rQ4gDrdM8FsmJrg==
X-Google-Smtp-Source: APXvYqwzRsJ2RVe43UkCslTgq8Oqb8xg0wTDZUJHvubtVap0H3WXcQ3V3xpS5d6YsDXJ15yBA5c0TQ==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr21515599plo.101.1579029235167;
        Tue, 14 Jan 2020 11:13:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id v4sm18628483pff.174.2020.01.14.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:13:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:13:53 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
Message-ID: <20200114191353.GL89495@google.com>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <CGME20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86@epcas1p3.samsung.com>
 <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
 <c793c2e5-dd0e-bff4-9769-26344afe914e@samsung.com>
 <VI1PR04MB702308C23513581F33EFE697EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 02:35:48AM +0900, Chanwoo Choi wrote:
> On Wed, Jan 15, 2020 at 1:08 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >
> > On 13.01.2020 09:24, Chanwoo Choi wrote:
> > > Hi,
> > >
> > > Any device driver except for devfreq_cooling.c might
> > > use dev_pm_opp_enable/disable interface.
> > > So, don't need to remove the devfreq->scaling_max_freq
> > > and devfreq->scaling_min_freq for supporting OPP interface.
> >
> > It seems that devfreq_cooling was the only upstream user of
> > dev_pm_opp_enable and the remaining callers of dev_pm_opp_disable are
> > probe-time checks.
> 
> OPP interface has still dev_pm_opp_enable and dev_pm_opp_disable
> function. As long as remains them, any device driver related to devfreq
> could call them at some time. The devfreq supports the OPP interface,
> not just for only devfreq_cooling.

I would like to remove the disabled OPP handling since no devfreq device
makes use of dev_pm_opp_enable/disable, but I fear you are right that
we have to keep it as long as the API is available.

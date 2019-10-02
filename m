Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C355C4A24
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJBJAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 05:00:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42084 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 05:00:44 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so55072224iod.9
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OMb6qYz7L39aWv7huGiD2tvBbT7Ji7GJd30UEGa+oU=;
        b=XAemzTfZ5XTN/w/nxCS7Stgtb84tkodIy5FcsHED/wIXFB68x1T84J/iRef3lIzVa4
         fnzEuGlZckmxDnTqZ+Mq/yOgQrL/lOSg3RiWSZjPsv+OzgBAMy2BjMLaZ9Y53O3ZFG82
         VGgyS/ChXqJQ9XqFmU1oaDphAfsJbO4SE/cFAH1gD+Z608Rzu8hr9fKMWwwSo/MtyPlT
         LgmT5DtzoM7getSdU5n1/TBljBlFye3lZO0BpJ6Gib74zZGiusnBPV3gGwaiU3Fcb4jx
         CrsAZKpUl7lBQPAzDizJpVsNJaBGcMGELRQlhWwEgPYgsP7X9wUGi8v4w/Ry7G6cQPXX
         L0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OMb6qYz7L39aWv7huGiD2tvBbT7Ji7GJd30UEGa+oU=;
        b=PeeMGY3p1hbiL7tb1YGkTFWB/DgiZKq+Ss7keCm2uMZkK5xjtQ6ZRk33R2Dg/i0B26
         PtL84Fhi8YI0aSLpScNgeoElliMIAVVWVHUvBxiW8o1Xwja8L4/4VAAZsc+qqh7+QvHR
         6zdW8+wPcDl3+ZWHMrPiqLP7VaTSC3bpGMTqPIAEUl8Viacd8P7iGMz7sykLmqMIqVAr
         0CuYY5VbtBqTCj8LhQOQSrf3t+DjApRajYJ2AdvpaCtcf82t7OkEr9HX9D/JztCj36Fj
         PrvJ+xJqYcJtbE+0a9liDj3CM4ye0DtDRjo7HVA5jaG4m/JD9Xui6UgYmWk/4i+n0QYc
         gSQQ==
X-Gm-Message-State: APjAAAXAlLX3RBjlhqa6r0C9G2B48ET4sy98yOTrw2aMzAnUpqzqPYfo
        Og3kmY1kdwTPIAhh0EP7EuxNd8KyrExnpBoKLdDeaA==
X-Google-Smtp-Source: APXvYqwEzjF0lbQ2ABgEhpFVDzqJdfpxcmC8WbxgaqLG7Ibv/dVo8qc6NFmWgAb3blXoWa15bzoJ2xyQyu2JM1jS9Iw=
X-Received: by 2002:a92:98d3:: with SMTP id a80mr2849757ill.167.1570006843856;
 Wed, 02 Oct 2019 02:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568224032.git.hns@goldelico.com> <20190916162816.GF52127@atomide.com>
 <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
In-Reply-To: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 2 Oct 2019 11:00:32 +0200
Message-ID: <CAKohpo=44UkJ3RBjtB8F3=1D9HzicULh303jF2uowiboa2328g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed
 binned / 720MHz grade bits
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        linux-omap <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Sep 2019 at 16:35, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Tony,
>
> > Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
> >
> > * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> >> CHANGES V3:
> >> * make omap36xx control the abb-ldo and properly switch mode
> >>  (suggested by Adam Ford <aford173@gmail.com>)
> >> * add a note about enabling the turbo-mode OPPs
> >
> > Looks good to me, when applying, please provide a
> > minimal immutable branch maybe against v5.3 or v5.4-rc1,
> > that I can also merge in if needed for the dts changes.
>
> Should I resend a v4 with your Acked-By added?

I will pick them up in a few days. I was waiting for rc1 to get released and
am on vacation right now. Tony already provided his Acks.

--
viresh

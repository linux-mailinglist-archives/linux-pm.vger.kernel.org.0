Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0C210FA6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbgGAPsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgGAPsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 11:48:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC0C08C5C1;
        Wed,  1 Jul 2020 08:48:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q15so22937968wmj.2;
        Wed, 01 Jul 2020 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMNtPXYGOcRO7tLq+pEY3fVgHa7bYP6mmW0sBsz4iyE=;
        b=fXFRvwbsCOJLj/fmIEHNT63bg9uryP3EE/7dDlwF8jxf9jCt5ybmb3ASo/yDalgM7E
         iwTdhfdu8M7QgWYlCs2nrUf6HK4eHW44JBNnVDASYA7aewFaeaptanrjcwcrhCY/qWFw
         xRs1dfvHXYXjViIlp4uGKM8SI52W8+umIvErhAL5ZtHkEXB4AUlZocgMiH4qP9ZODywZ
         kNOtatYRD/dQ7IQzjEtTzlN3B2yz+0KvtPA3dsPXdI7YG2a0DaXBlW1Z85iOuF4Ty8un
         GRt3oM8R1MVFoFAlXkQsdAsOUEssjZhG+cTHs37GefShIlCnPHklFfmLNBCbwM6TT/jO
         1pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMNtPXYGOcRO7tLq+pEY3fVgHa7bYP6mmW0sBsz4iyE=;
        b=qb9OSCvVVhfuQ5gsn+2fDYAgRvZ6r+/k2KkDjlm1A5YD+UkMp9a7sjH9tP8hji+DCS
         GIiKrmUlokjm0bIwTLNKBiMtJ1BUhcRRZH0F6SWxWTtd4uvYSBYll1pMmzJl9DNrvL99
         d4NJfhkhjGXXkScgNZDPK8xz7ZQEvIgJa5W9w9VoBVfkQqf6AxCoYITkSyxolZW6ykpV
         dMPA/YkIfhLWmlpwiMuZUid+h3bP6HU7/Z7r14Lsvf467EnJtlfkdHsawUo1Q4dquPBi
         KRofi00gSV1YlL2F/jHdgIDivrChkyi5zTjfMjP7o0lhLziqfR759C1Q7GVqPJq0l/5G
         tmQw==
X-Gm-Message-State: AOAM531mY/l8KlMoEwddea31O3mVmyhlvomJx6MpIomlViah5dLMzj8l
        7z8FrCuQBdcF9zxuN1TIEc8=
X-Google-Smtp-Source: ABdhPJwoHEVt0hAkrRlr66NPMNDPJFnAM6h3LAE5obWcBhZRQBZeNju+7ADF5dUGvnRQvhJTsy+gYw==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr23338033wmi.35.1593618485682;
        Wed, 01 Jul 2020 08:48:05 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id d63sm7988050wmc.22.2020.07.01.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 08:48:05 -0700 (PDT)
Date:   Wed, 1 Jul 2020 17:48:04 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
Message-ID: <20200701154804.f4amjgnqmprcfonw@macmini.local>
References: <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
 <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
 <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
 <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
 <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
 <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
 <691bc55c-5b04-b519-4575-6dce5ea9914c@samsung.com>
 <be215777-54fd-ed84-0709-1d276bc3fe90@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be215777-54fd-ed84-0709-1d276bc3fe90@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-29-12-52-10, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 6/29/20 2:43 AM, Chanwoo Choi wrote:
> > Hi,
> > 
> > Sorry for late reply because of my perfornal issue. I count not check the email.
> 
> I hope you are good now.
> 
> > 
> > On 6/26/20 8:22 PM, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > On 6/25/20 2:12 PM, Kamil Konieczny wrote:
> > > > On 25.06.2020 14:02, Lukasz Luba wrote:
> > > > > 
> > > > > 
> > > > > On 6/25/20 12:30 PM, Kamil Konieczny wrote:
> > > > > > Hi Lukasz,
> > > > > > 
> > > > > > On 25.06.2020 12:02, Lukasz Luba wrote:
> > > > > > > Hi Sylwester,
> > > > > > > 
> > > > > > > On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
> > > > > > > > Hi All,
> > > > > > > > 
> > > > > > > > On 24.06.2020 12:32, Lukasz Luba wrote:
> > > > > > > > > I had issues with devfreq governor which wasn't called by devfreq
> > > > > > > > > workqueue. The old DELAYED vs DEFERRED work discussions and my patches
> > > > > > > > > for it [1]. If the CPU which scheduled the next work went idle, the
> > > > > > > > > devfreq workqueue will not be kicked and devfreq governor won't check
> > > > > > > > > DMC status and will not decide to decrease the frequency based on low
> > > > > > > > > busy_time.
> > > > > > > > > The same applies for going up with the frequency. They both are
> > > > > > > > > done by the governor but the workqueue must be scheduled periodically.
> > > > > > > > 
> > > > > > > > As I have been working on resolving the video mixer IOMMU fault issue
> > > > > > > > described here: https://patchwork.kernel.org/patch/10861757
> > > > > > > > I did some investigation of the devfreq operation, mostly on Odroid U3.
> > > > > > > > 
> > > > > > > > My conclusions are similar to what Lukasz says above. I would like to add
> > > > > > > > that broken scheduling of the performance counters read and the devfreq
> > > > > > > > updates seems to have one more serious implication. In each call, which
> > > > > > > > normally should happen periodically with fixed interval we stop the counters,
> > > > > > > > read counter values and start the counters again. But if period between
> > > > > > > > calls becomes long enough to let any of the counters overflow, we will
> > > > > > > > get wrong performance measurement results. My observations are that
> > > > > > > > the workqueue job can be suspended for several seconds and conditions for
> > > > > > > > the counter overflow occur sooner or later, depending among others
> > > > > > > > on the CPUs load.
> > > > > > > > Wrong bus load measurement can lead to setting too low interconnect bus
> > > > > > > > clock frequency and then bad things happen in peripheral devices.
> > > > > > > > 
> > > > > > > > I agree the workqueue issue needs to be fixed. I have some WIP code to use
> > > > > > > > the performance counters overflow interrupts instead of SW polling and with
> > > > > > > > that the interconnect bus clock control seems to work much better.
> > > > > > > > 
> > > > > > > 
> > > > > > > Thank you for sharing your use case and investigation results. I think
> > > > > > > we are reaching a decent number of developers to maybe address this
> > > > > > > issue: 'workqueue issue needs to be fixed'.
> > > > > > > I have been facing this devfreq workqueue issue ~5 times in different
> > > > > > > platforms.
> > > > > > > 
> > > > > > > Regarding the 'performance counters overflow interrupts' there is one
> > > > > > > thing worth to keep in mind: variable utilization and frequency.
> > > > > > > For example, in order to make a conclusion in algorithm deciding that
> > > > > > > the device should increase or decrease the frequency, we fix the period
> > > > > > > of observation, i.e. to 500ms. That can cause the long delay if the
> > > > > > > utilization of the device suddenly drops. For example we set an
> > > > > > > overflow threshold to value i.e. 1000 and we know that at 1000MHz
> > > > > > > and full utilization (100%) the counter will reach that threshold
> > > > > > > after 500ms (which we want, because we don't want too many interrupts
> > > > > > > per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
> > > > > > > to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
> > > > > > > threshold after 50*500ms = 25s. It is impossible just for the counters
> > > > > > > to predict next utilization and adjust the threshold. [...]
> > > > > > 
> > > > > > irq triggers for underflow and overflow, so driver can adjust freq
> > > > > > 
> > > > > 
> > > > > Probably possible on some platforms, depends on how many PMU registers
> > > > > are available, what information can be can assign to them and type of
> > > > > interrupt. A lot of hassle and still - platform and device specific.
> > > > > Also, drivers should not adjust the freq, governors (different types
> > > > > of them with different settings that they can handle) should do it.
> > > > > 
> > > > > What the framework can do is to take this responsibility and provide
> > > > > generic way to monitor the devices (or stop if they are suspended).
> > > > > That should work nicely with the governors, which try to predict the
> > > > > next best frequency. From my experience the more fluctuating intervals
> > > > > the governors are called, the more odd decisions they make.
> > > > > That's why I think having a predictable interval i.e. 100ms is something
> > > > > desirable. Tuning the governors is easier in this case, statistics
> > > > > are easier to trace and interpret, solution is not to platform specific,
> > > > > etc.
> > > > > 
> > > > > Kamil do you have plans to refresh and push your next version of the
> > > > > workqueue solution?
> > > > 
> > > > I do not, as Bartek takes over my work,
> > > > +CC Bartek
> > > 
> > > Hi Lukasz,
> > > 
> > > As you remember in January Chanwoo has proposed another idea (to allow
> > > selecting workqueue type by devfreq device driver):
> > > 
> > > "I'm developing the RFC patch and then I'll send it as soon as possible."
> > > (https://lore.kernel.org/linux-pm/6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com/)
> > > 
> > > "After posting my suggestion, we can discuss it"
> > > (https://lore.kernel.org/linux-pm/f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com/)
> > > 
> > > so we have been waiting on the patch to be posted..
> > 
> > Sorry for this. I'll send it within few days.
> 
> 
> Feel free to add me on CC, I can review&test the patches if you like.

Please CC me too.

> 
> Stay safe and healthy.
> 
> Regards,
> Lukasz
> 
Cheers,
Willy

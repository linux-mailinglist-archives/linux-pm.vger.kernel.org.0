Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2F27EC53
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 17:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgI3PWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3PVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 11:21:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7525C061755;
        Wed, 30 Sep 2020 08:21:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so2261144wrx.7;
        Wed, 30 Sep 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=vMzDpUYgQzoXePZPyW6W3AFRaKDbmE0J4/++8kixplU=;
        b=osP4XICVpQVA9vOP/L8FrT4irUZlCITExDq6g5/Z+P/sDULNlw0KZz6MY37fyJbgNW
         0hcJNF3/eLBaZ8+LaDOZ7d1SpjqEkMsgv+chehcx6sHyoQFlTSKbm43a97PXs7/h2ms4
         FOfxKEwNiaEHHAmnxcB0XQ3WjYQontixk0IxjiZqrnI28gnwQCKefgI7TNOyjpOShPKB
         iJX+ssEX2eaNu/S8iqP6cxybmdBfgHkg6wsSYvowQTiMqbdoJPpf9duMcWNcqafIY6U/
         c639h2KUY9lIVVGSmC3lmUmrXTCq3zlo0GLpHjmUSVoiN9mZX6vrt2ULUeysBgXTyg05
         9oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=vMzDpUYgQzoXePZPyW6W3AFRaKDbmE0J4/++8kixplU=;
        b=FXI/sMMWcBngU78JIninmQOOjlzKgkfz8M28AIR9TsYOGBIys85BJ3oESqwjYRvA1I
         79yY7hi5p50wm51UbrxpygeLszP8oMzrR7VAOuUk1H3Ax6vDnmt1sw/gxsFykuBlmAXD
         kNoAx5KAm+xFHgH0e5dTcNUSE7bvJoq99Z3AbN+RkA6plohckAa/TFFfaOJDXGydZWK4
         jV/TTcATANwjTv2AXHRfWa0EMcBiPqIkNjiz1+VNxWPJjKQ7+v3squERrsvy/Oe24ei4
         GB0cBr9655pSRY2+qYYE7QHN7ZUkYh4JhlNUx05QNuVQJ+zOSQ3ooGBFstYhM0EmBH1T
         6h6w==
X-Gm-Message-State: AOAM531gdbtdd24Y7RGj+niEOk4O7jm58+cUs3J7pOSeSEju8zdtuENb
        ZqRI2XStgrIq2bR9X7F8ZbnUEs7kyrglzg==
X-Google-Smtp-Source: ABdhPJxmxtyYCrxfJtA9b6XsUqwRbQ84mbFaIc2beFn0TQxLDQBlddQI5kOBf6e0lHAsm07eTehXwQ==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr3667351wrc.193.1601479309173;
        Wed, 30 Sep 2020 08:21:49 -0700 (PDT)
Received: from AnsuelXPS (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id u12sm3584498wrt.81.2020.09.30.08.21.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 08:21:48 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Sudeep Holla'" <sudeep.holla@arm.com>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20200929162926.139-1-ansuelsmth@gmail.com> <20200930092954.GA7125@bogus> <006c01d69720$abd3f230$037bd690$@gmail.com> <20200930135733.GA7609@bogus>
In-Reply-To: <20200930135733.GA7609@bogus>
Subject: RE: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling driver
Date:   Wed, 30 Sep 2020 17:21:46 +0200
Message-ID: <001601d6973d$69fe96e0$3dfbc4a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQHRHCX89vsNM0cZY8BINv1SaJtjIwLCr4YDAd5WpiECF5AAyKlWexsw
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Wed, Sep 30, 2020 at 01:56:01PM +0200, ansuelsmth@gmail.com
> wrote:
> > > Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq
> > > scaling driver
> > >
> > > On Tue, Sep 29, 2020 at 06:29:24PM +0200, Ansuel Smith wrote:
> > > > Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't
> > actually
> > > > scale the Cache frequency when the CPU frequency is changed. This
> > > > devfreq driver register with the cpu notifier and scale the Cache
> > > > based on the max Freq across all core as the CPU cache is shared
> across
> > > > all of them. If provided this also scale the voltage of the
regulator
> > > > attached to the CPU cache. The scaling logic is based on the CPU
freq
> > > > and the 3 scaling interval are set by the device dts.
> > > >
> > >
> > > I have raised this concern before. I am worried this kind of
independent
> > > CPU and cache frequency controls make way for clkscrew kind of
> attacks.
> > > Why can't the clocks be made parent/child or secondary and
> automatically
> > > updated when CPU clocks are changed.
> > >
> >
> > I don't think I understand this fully. Anyway about the clkscrew attack,
> the
> > range are set on the dts so unless someone actually wants to have a
> > vulnerable system, the range can't be changes at runtime. The devfreq
> > governor is set to immutable and can't be changes AFAIK.
> >
> 
> I don't think that matters, we are talking about Secure/Non-secure
> boundary
> here. DT can be modified or simple a rogue devfreq module can do all the
> bad things.
> 

Well it's what is happening right now (cpu at max + l2 at low) and from my
test
the system is just slowed down. But you are right about the security
concerns.

> > About 'automatically updated when CPU changes', the cache is shared
> across 2
> > core and they scale independently. We can be in situation where one cpu
> is
> > at max and one at idle freq and the cache is set to idle. To fix this at
> > every change the clk should find the max value and I think this would
> make
> > all the clk scaling very slow.
> 
> This sounds like we are going back to coupled idle states kind of setup.
> Sorry we don't want those anymore.
> 
> > If you have any suggestion on how I can implement this better, I'm
> > more than happy to address them. For now, the lack of this kind of cache
> > scale, make the system really slow since by default the init of the cpu
and
> > cache clks put them at the lowest frequency and nobody changes that.
> > (we have cpufreq scaling support but the cache is never actually scaled)
> 
> As I mentioned, if this needs to be done in OSPM, then hide it in the
clock
> building right dependencies. Clk will even have refcount so that one idle
> CPU won't bring the cache down to idle frequency.
> 

What I really can't understand is how I can describe the CPU freq interval.
Since I can't use dts should I hardcode them? (cpu have more opp than the 
l2 cache, they are not mapped 1:1)

> --
> Regards,
> Sudeep


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585AF27E7FE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgI3L4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3L4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 07:56:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF6C061755;
        Wed, 30 Sep 2020 04:56:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so1444821wmm.2;
        Wed, 30 Sep 2020 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=/e6Hsi9CMtqzZnIKCBnu9x6TRjKgsku17Kje/SLQgxk=;
        b=nlytbkeZSQFvQ/dR3WEjx/pwtK7fPq36kiqhAaienevjAo7N39meQZ+oCzvJ8Hdk36
         zb3yDbtBqYI5xXInfZjty6fztpwTm6J+bcTL24prz4UefHiqknsBNMVSjWdMzb4ZB5fk
         49rbsC7fXQJp+G1RTlP3jQl5Xuzr8oEHF4dAe0RBLS9Ehp1S+NKLj1GXn/Cpf806KL4n
         LaDG2OlTUFxy5wEVrx6Ky9QyTkCLzujagGAUMOt5b8oQP9myED9WkJM+oJdvtpAUJZdo
         4CViUbJhF3GsbjNgLEjQ3r84syUAEAR4MA+YqC++ldHpa4TgCvNBUM5yo/eW7/UEAL3z
         97eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=/e6Hsi9CMtqzZnIKCBnu9x6TRjKgsku17Kje/SLQgxk=;
        b=txwL1jxCQAH1QELXZmlMoJJriykvjDHui912PEE1FGkxtevM6ki6yqXloxKEyji84w
         hFQGy4bMsv2uagOl7tb1wMrrVZSRXFbDRYf56UYDMA8BYaUgOy/dlZyWkwAOe+OgYCZx
         Kqn2r5RlEtTsUoHssQVv16LQW8hOEPLs8NW+fjee2Ebre+HDCLsgCzdNHDhJm1ibUDED
         DIGNVFwR6BUGTTAq/52udu1i9rxQAqkAomQ6amguNMWcldht8gVWCz6c2tSmz+VDGZ4G
         v/MnIWTy2fjhOz1sOKvDTRiq1Vgxo+17YjdOafoQ0slPpY2cNomjeyn27UbqsxEcM/JD
         Az+w==
X-Gm-Message-State: AOAM532YBRtfC40Gp/zNEOnKDy/mXROW1WKveMPkTVn5+uZrBwiGZ9ir
        /5s21jW97d7LNU5N0k2XubI7I4kt+JbjmA==
X-Google-Smtp-Source: ABdhPJzZbgSCxiYKhLE3ZvqSSKxPBlptlSX/RpWq51eO1owDHr5yHk+gVbqlEv3e9tLdz8/hoIu3aw==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr2740833wmb.155.1601466963922;
        Wed, 30 Sep 2020 04:56:03 -0700 (PDT)
Received: from AnsuelXPS (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id h4sm2996187wrm.54.2020.09.30.04.56.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 04:56:03 -0700 (PDT)
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
References: <20200929162926.139-1-ansuelsmth@gmail.com> <20200930092954.GA7125@bogus>
In-Reply-To: <20200930092954.GA7125@bogus>
Subject: RE: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling driver
Date:   Wed, 30 Sep 2020 13:56:01 +0200
Message-ID: <006c01d69720$abd3f230$037bd690$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQHRHCX89vsNM0cZY8BINv1SaJtjIwLCr4YDqXXwJVA=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq
> scaling driver
> 
> On Tue, Sep 29, 2020 at 06:29:24PM +0200, Ansuel Smith wrote:
> > Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't
actually
> > scale the Cache frequency when the CPU frequency is changed. This
> > devfreq driver register with the cpu notifier and scale the Cache
> > based on the max Freq across all core as the CPU cache is shared across
> > all of them. If provided this also scale the voltage of the regulator
> > attached to the CPU cache. The scaling logic is based on the CPU freq
> > and the 3 scaling interval are set by the device dts.
> >
> 
> I have raised this concern before. I am worried this kind of independent
> CPU and cache frequency controls make way for clkscrew kind of attacks.
> Why can't the clocks be made parent/child or secondary and automatically
> updated when CPU clocks are changed.
> 
> --
> Regards,
> Sudeep

I don't think I understand this fully. Anyway about the clkscrew attack, the
range are set on the dts so unless someone actually wants to have a
vulnerable
system, the range can't be changes at runtime. The devfreq governor is set
to
immutable and can't be changes AFAIK.

About 'automatically updated when CPU changes', the cache is shared across 2
core and they scale independently. We can be in situation where one cpu is
at
max and one at idle freq and the cache is set to idle. To fix this at every
change
the clk should find the max value and I think this would make all the clk
scaling
very slow. If you have any suggestion on how I can implement this better,
I'm
more than happy to address them. For now, the lack of this kind of cache
scale,
make the system really slow since by default the init of the cpu and cache
clks
put them at the lowest frequency and nobody changes that. (we have cpufreq
scaling support but the cache is never actually scaled)



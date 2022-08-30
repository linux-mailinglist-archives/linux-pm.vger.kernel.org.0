Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2E5A5B0B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 07:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiH3FXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3FXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 01:23:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316A7CB55
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:23:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so10748687pjg.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=wB8Td2/uiacFaPNAz4hB1j4lSbOXW1I+BZ1+JeaZT54=;
        b=EvQ+RefzFYuMMkHXDVVWyhE+WBRfONxOb/paNJ3OC6i8qXmkECw8nOCF21rq6Lm9i/
         Dr7nUtsBR7K6WjAh0gsgI0l/XmfbA+ObfhNnYr9WyyFlyu5vF1/TtKWXycxoaK2EazHo
         ywG3QRDgl4EHcoRKWucZy0Dl+qjPr8Z+v6d1ozrV7AlGyhNe1aLtHMXGzDZjenD2LnSK
         jJsQKnDb45sQTCGgQf0iYQbHlexwvb6nnr1AoI2GfrXt6S75O3SJ+O0QZidWbstr8QTo
         hfyF9lICOrfbTRzzW9r/3HwuD9yZZMH5MAhqrGTm1VmQ5kIxiTon4rxKZ0TTNiyMSxEE
         o8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wB8Td2/uiacFaPNAz4hB1j4lSbOXW1I+BZ1+JeaZT54=;
        b=IqGybA2Wka5pqwdaxI+6lYRuwdNVuAkRuC5Xx6UlaeJGkA8O9zy+jbK9ZyZ9nWl3Rk
         gWmqy3u9wO2xOrCfS7mCoEWyyGTM+FhMpnFb2ejZ0Q1ecqcVnOgy3dJVAPauKrZJLf6a
         mc+gZNvvb56mf0FWIOB5TFOivcE/3Q9Dp+msygE1XX/Qm7jhTdkDMddF5rre0Xz4kloX
         e0izCHlqUfNQVyida6iEMoZxkp/+f6go0DzDQRcN9B7q9eNnGO7fOZXk23hXKxVBNgx1
         cCBmIhMlBy1WdDLHzZNgkGOM/xsDEIK5q2KYC82261jWkN2JJ3u55plpUuGgdH99sran
         7XjQ==
X-Gm-Message-State: ACgBeo1zRW98IUdOiOT/lz53HMi/E7iJFQM7GSldiPEFk8/+T0Mh9r31
        MNBKiOjy2XbantzqRes10guNug==
X-Google-Smtp-Source: AA6agR4cFm79F/9BxmTt4kFH4SsSMqCk2+0LYdwGQ0UZZjq0yfjBEQpyfwK47jPqwdnhZ920hyrPQg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr22248257pjb.164.1661837019782;
        Mon, 29 Aug 2022 22:23:39 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 17-20020a630311000000b0042af14719f4sm671670pgd.51.2022.08.29.22.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:23:39 -0700 (PDT)
Date:   Tue, 30 Aug 2022 10:53:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        mka@chromium.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] opp: Expose voltage info in debugfs for OPPs w/out
 explicit regulators
Message-ID: <20220830052335.zmot3ojvlqkz32z4@vireshk-i7>
References: <20220826075655.1.I2e4958048f30c3b44a01e31519092f7d3c9204e4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826075655.1.I2e4958048f30c3b44a01e31519092f7d3c9204e4@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-22, 07:56, Douglas Anderson wrote:
> On some cpufreq drivers we know the voltage associated with each
> operating point but there is no explicit Linux "regulator" present. An
> example is "qcom-cpufreq-hw.c". There the voltage is managed
> automatically by the hardware but we still associate it with the OPP
> table so we can do energy calculations for EAS.
> 
> The OPP framework handles this in general. In _opp_allocate() it can
> be seen that we always allocate space for one supply even if
> "regulator_count" is 0.
> 
> Let's handle this properly in debugfs.
> 
> NOTE: as a side effect of this a whole bunch of OPPs in the system may
> get supply-related files exposed in debugfs that are mostly useless
> (they'll just contain 0). I'd expect this to be OK but it's moderately
> annoying. It seems better than trying to dynamically create debugfs
> directories when the voltages are non-zero or adding extra complexity
> in the code giving a hint to the OPP framework that voltages should be
> exposed.
> 
> After this patch, on a sc7180-trogdor class device I can see voltages
> for the CPU OPPs under /sys/kernel/debug/opp.

The OPP core already supports platforms which don't have a regulator
set for the CPU device, but the OPP table have an entry for microvolt.
This already works.

I looked at your DT and I understand why this isn't working for you.
The problem is that your DT doesn't have any of such values
(opp-microvolt) but the driver later calls dev_pm_opp_adjust_voltage()
to set voltage values.

IMO, this is wrong by design. This takes advantage of the fact that
the OPP core doesn't check if voltage has been previously set for the
device or not in dev_pm_opp_adjust_voltage() and it works by chance
currently.

I would suggest adding opp-microvolt property to the DT for this
platform, the values can be 0 with a comment mentioning that software
will fill them later, or if you know approximate values you can fill
them as well.

And then it will work just fine I hope.

-- 
viresh

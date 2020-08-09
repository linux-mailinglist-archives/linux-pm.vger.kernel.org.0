Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119EC23FBFC
	for <lists+linux-pm@lfdr.de>; Sun,  9 Aug 2020 02:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHIAkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Aug 2020 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHIAkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Aug 2020 20:40:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F06C061756;
        Sat,  8 Aug 2020 17:40:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so2989536pls.9;
        Sat, 08 Aug 2020 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoI02kIPv5v2lQrEFtWYTVFM7JZrBv3uT+arvbEzRC8=;
        b=O7w+q029hE2KX4W8MHGLpAX6jI7rJTMsRIVLfGKcz4IDDrum74DBgfi/oS6bOM0xOv
         5nt6w4rcu6Wv8mPvg0cJVFGaZgTIF6UYC0zVyKsTfebJHS6jn2Z19BpAzIaTevZfKhsv
         ldZLWj4PgusGw+dcJfro0TSwI4Zex4GOSFI9TxeiPs9LMq0ovRMyLqYwzN13jAXJg2v3
         qCauBZAaBriDfmqxtgbJnTT01UWwBOWMUALtWCW1gJ9kBu/MKIU89gCEHrlYjcFuXO5e
         gj4Ss5YHfrnq4NytbkeXvOHx3xOA+u1jIyCJkKSJNCEfiF1rDwZ0x+0/XU9SkIQfH038
         cJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoI02kIPv5v2lQrEFtWYTVFM7JZrBv3uT+arvbEzRC8=;
        b=H2gcUUqgcEfLCYf99sPX8rJl9Hwez12rgME2SoVEIlBlmN3CsIzhzkz9ETyEmkpfja
         dOKhD5e/J6Zkp3oUBDD0w09q19GBoT9NSP7EFs0ZcQ8Z+SbH8B+GvTLhs5fgs9gwAzEO
         YCzXGBSoiJ0OSMlz4BDyJswFzkhpFV4sKPpM0EwUaOGlV8fbMsVK7jnodKvmwN8PSDXM
         i7u97piagXNMP8MiuYEEEukJT5KPFOp5rid/BXFQ8QF7lA4v2CxuZj6pDT9Uxd/wLwVW
         avm6TtSc41sIyJd4eDo9iREF7mlU1PYvutDQTR3NwGKHualT5NHnDga15vAL4qgtIiH4
         SpdQ==
X-Gm-Message-State: AOAM531hVicW5DWJuUzIVRrZpv/mVRwtRFL/+0PSUnGXW3NYGilhKbsM
        akgULP/XTC3GWTgjSHulqQI=
X-Google-Smtp-Source: ABdhPJybEzbAts0RW8NMwyR4Aw7rMrZw1oGKzNLjQ+QABcupg38fRhfBMrvsw9hvY/vFeMXGqKtkPA==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr20792249pjn.119.1596933611431;
        Sat, 08 Aug 2020 17:40:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q2sm18909579pfc.40.2020.08.08.17.40.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Aug 2020 17:40:10 -0700 (PDT)
Date:   Sat, 8 Aug 2020 17:40:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mirq-linux@rere.qmqm.pl,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 3/3] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200809004009.GA96704@roeck-us.net>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-4-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594819885-31016-4-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 07:01:25PM +0530, Sumit Gupta wrote:
> Add support for CPU frequency scaling on Tegra194. The frequency
> of each core can be adjusted by writing a clock divisor value to
> a MSR on the core. The range of valid divisors is queried from
> the BPMP.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

If built as module:

ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!

Guenter

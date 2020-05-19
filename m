Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D41D8E3C
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 05:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgESDbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 23:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgESDbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 23:31:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AEFC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:31:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so753240pjd.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KO3Z9hueRakPgAx9Ac4Lw9qP6WW8KjlpYbXitB6bWSM=;
        b=OtsyfSQlKTEjylyOPRxpPGUcGz8k7uGMLR62alTvDkaoxXCQglR7nJ7rV7uW9KWv6E
         EKyqvWjzO8hmrqfjjZuUpn7FP+TPDdswox4M2rVwu/qA/jjwozjXmByWiEckY9soQXl6
         exuw2AKYBeQOH9hzuCbiWCpbPWtdvMicE7J58tyEw8wVSchfM1LX5/3cCXx+Rx6d9TKU
         tqegmblQ8zYMpY2qD7ykz9jFsYaxPPkc4bFHxAxlTs+WNO91nh4JvylaOgqUrrwqWa8m
         zsU9DHGJW33EEHIWjZXQenSVzF8qsLbRupskLRZjhB/e/txudaShaKvdh29+hYLW61FY
         jpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KO3Z9hueRakPgAx9Ac4Lw9qP6WW8KjlpYbXitB6bWSM=;
        b=YV9sQFCxan+4atHOTJ8ST+HkiSQwjEcoxQsar7KmI+Lh5+Jl64YbXAaNOZqN1Kz2c9
         6EieS59Uz8waqryaxN0KWle+8+crzxn9ZmzEUA5VgrQLhapJjlxPi2TciM1skqnAC2Zl
         h8+U3f+MGsuREMFBt9f85iOMwuLd7zbMt7sQ8kg++Y4Oi0a+PcXjMiAqTvIZXYK99Cew
         fjotib5SbQ6zhGQqzDMdoZcenpMdDwuTM52sRbCGTAAf0SrGXC1OH0Ad+BProNS5himU
         qK/FRGxanmjOMhj1aSLuhRa2rceaTHw/SKT0IwbdnssqXAHxSYg+EqY2AWCPT70liO9V
         5yqw==
X-Gm-Message-State: AOAM533nrH8F9IpkgVxqIgv5bHKKm1mtJJq1+cDUuvdlaDreuFS9r/jk
        57n1eoqvnG7ebn5LTvrAx3PfsA==
X-Google-Smtp-Source: ABdhPJx2exZggkmdCdR9LnIIv36HDIca/L6gu/8aoM/2VReOK6PBJlLaeDMuS91GY0To15weB0y3Vg==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr2756791pjs.17.1589859064517;
        Mon, 18 May 2020 20:31:04 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id n14sm785468pjh.45.2020.05.18.20.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:31:03 -0700 (PDT)
Date:   Tue, 19 May 2020 09:01:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
 <20200518184010.GF2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518184010.GF2165@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-05-20, 11:40, Bjorn Andersson wrote:
> It most certainly does.
> 
> With INTERCONNECT as a bool we can handle its absence with stub
> functions - like every other framework does. But as a tristate then
> every driver with a call to the interconnect api needs an entry in
> Kconfig to ensure the client driver must be a module if the interconnect
> framework is.

This patch has been pushed to linux-next a few days back.

-- 
viresh

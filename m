Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8825A4FF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 07:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBFXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 01:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIBFXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 01:23:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F683C061247
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 22:23:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w186so1947586pgb.8
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVhFJ3Y+hjMqVUpwLbS9tGUo0xITtak6uttEh+ZRoAE=;
        b=fCMQSPyR6dqJGAxuqwQ3iQwXVR9XO4k3BEgkYmAL5kNppciYkogCXaku4r8hyC64bt
         EZgv2mebMFjGNTKx160KdU6YvcouTOBGBmSc6F5OlDUF2Oq1Inqt/CgxEy9nvcrk6V+8
         aLwxx5q0gIWPmlB7Tggypgri2EfouqVjjRT0LsobAcllcgxhv6CBt4ITtwjl6EjTjj+S
         xtwaQGnH0XJrSHndj9J78HeG1wKqYpCNKKf+hCEZlS6LV+4vH2GF2GKFGM1Ne+jOJz0e
         vUNGObEpeMOZ3EwWchFNgj+56ykk4/Aekxm8ChJXEyhj/zZ2gHWiwEd4srfTqJIXVuvW
         38gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVhFJ3Y+hjMqVUpwLbS9tGUo0xITtak6uttEh+ZRoAE=;
        b=QX3L/I8uWd4oeB9OhWVVZSg5eXoPMklv+dhiE1VTCkLc5zY5QlcJkhQX78Tc1O4nRx
         1dM1WALgxekEJleNIdHMRcaCYd6VOMBZbS3HJg493Jv+8Qqm/eSjVjAqsJGSiiq+cwZE
         k0ZbYQNE6SEgJqQ86Z4RnMeFFbxPbJUa072bcJRVwODU0t+G4ywcyFz13PSUUTqGyGS/
         6skOMjHTeHFyrGxXBsYPPvg9HaW5oAzLwygqh4W8PwPlhTxPfs+4Jq4GepLDhsG8x7I2
         QuGsHjecSGP1I5qA7d/s0D0Z2myLZOjhf8jSOKAtM9EslVFXE3y2nchw+3uznQ1bfSkz
         ljRg==
X-Gm-Message-State: AOAM533A6HecZeoHlmD+mh+NaF03KxQIxwvc6N/B+4WzaIqq4K91RVqA
        SmbY3j5YgvqNG9IZuoFRrPzOwg==
X-Google-Smtp-Source: ABdhPJyVAj5bq2ZIy1KPMkq6FyhzjG9cOtRfI0Si6VHtWCcizDPw0evcn9d4QROXifoq9jqPssZ7jw==
X-Received: by 2002:a63:e741:: with SMTP id j1mr629326pgk.422.1599024194547;
        Tue, 01 Sep 2020 22:23:14 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id l24sm3848694pff.20.2020.09.01.22.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 22:23:13 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:53:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
Message-ID: <20200902052308.jvdbkyjuawfihea3@vireshk-i7>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
 <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
 <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
 <20200831110408.a6lwivim4w4jtkdc@vireshk-i7>
 <603071ec-6ae4-7e34-26e4-f64065b01ee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603071ec-6ae4-7e34-26e4-f64065b01ee0@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-20, 16:21, Dmitry Osipenko wrote:
> IIUC, there is no fixed formula for Tegra, at least I don't see it. For
> example, if you'll take a look at the 1300MHz OPP of Tegra30, then you
> could see that this freq has a lot of voltages each depending on
> specific combination of SPEEDO+PROCESS versions.

Right, it may not be worth it to clean this up :)

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D07604A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfGZIDf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 04:03:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42122 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 04:03:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so24495056plb.9
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V6zPBev9xQgiBqMyHVwiFqQKL5cx+sR2tLt2bKc/lVQ=;
        b=HynS/ASw3Ys3ZyhOwYmGKzl1m1kwEE7nhm8gNvbojrDBb+rqjQ9hmTAP92o9YJlhz0
         aj+aQeSIN6AmLljyuVNRQm9hKkmsP3BfsnY6Wg4fJ57DD5Nh5FLPsSydLc1zd1/vIgQo
         ZoLDbBxJWLgD7RMdTjZPu0VwaQITz47QSC5Uv9xnyTa8hqqJ+GzW+WM7ommW+BeSRik+
         H5hOMdwjoCoEFOI3NUWqYKYbzmFdcqlISmkJ1ff28H/CiE4DUUrxP9EEktKHnuutBIwf
         r26wI9R4XxfMoyPcU29ZUU29FLjWh7Lw5LO+TDJIXbHjcdsQB/w8yS1yjatI9gyD0fdt
         i8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V6zPBev9xQgiBqMyHVwiFqQKL5cx+sR2tLt2bKc/lVQ=;
        b=rxONdrU3kKoP6nca9rm9ES9Yc6EhLKgrfvdz4RfKCCxDg0UYIKE1vVZuq8U4xHQyTD
         9aUiixnKfvWytsMqBPR/1YdxRoSe2JHANteJOYbf3k5TTpy/6cEakMOaorMigPBefKXe
         IaWnG1kWUgmXQQURTQKW8L9hGP/+jvpRuI/NxZ6NYgpdaYDfwtTU0ogTCLGHPSbcsl3f
         YF+9WDONGqyJ3WgLy4WUBE1ghdBrMzV2hx7pzSWqJJtyTN0lq/+W0l48ZX3w1nPPIxUL
         UY4uTZecNUrop2b0FDiRo7lHnNJz+jbvy+oPrdcBExUonP4mDKh8pfz4GTY/dIyUoAs3
         t7uw==
X-Gm-Message-State: APjAAAXi20GTnTf+zlGIvpphULNE0c9uWySQ31ZxupCmOaXYxSJcuYyF
        cjzbVh+wq0hKcLaFAHw4qUPNAw==
X-Google-Smtp-Source: APXvYqwYoNk6LUyHsrgO48OvfBPvyGjR8jqkVPjQWqjKXtuBa5adbQy6aRQy3AbSY5sRUgiAxHwLFw==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr92070283plj.116.1564128214872;
        Fri, 26 Jul 2019 01:03:34 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id q22sm47092154pgh.49.2019.07.26.01.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:03:33 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:33:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] opp: Add dev_pm_opp_find_level_exact()
Message-ID: <20190726080331.qzvi737nj4oflghz@vireshk-i7>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-2-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-07-19, 12:41, Niklas Cassel wrote:
> When using performance states, there is usually not any opp-hz property
> specified, so the dev_pm_opp_find_freq_exact() function cannot be used.

Removed above two lines while applying.

> Since the performance states in the OPP table are unique, implement a
> dev_pm_opp_find_level_exact() in order to be able to fetch a specific OPP.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/opp/core.c     | 48 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 +++++++
>  2 files changed, 56 insertions(+)

-- 
viresh

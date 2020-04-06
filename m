Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9A19EF68
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 04:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFC6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 22:58:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFC6f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 22:58:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id a24so6850730pfc.8
        for <linux-pm@vger.kernel.org>; Sun, 05 Apr 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Snmazk82MB0/0cCIeeJxaxYr1fCvgV5xCLT8s21RwAs=;
        b=NqPNfIWgOWaM4sqrQjkJIXbp4kT3YO3B6wIsbdOFmc7pyXoGE+VpXs21oojmhTvtCm
         Y+y1dtXB9zv/cjK4hEKRyVCSiKUqpVhrhbMDH0nxoyKBSwhydSdWpqPFNrMbYEONwqRW
         aPZFVQ+NIt+dsDmxklpi93KoEIHkfhL69mX9exDgI3NQ7tsVfsbL/lQC2vH8WXGmiQ18
         tK1paQ3pARNq8QchfUQ0D4YtTSh6wI92NpK4P6clPK4hPofDCqwBhwYS+iMTL+iVNgCJ
         Eu0wi6WiU9hZSkSnbDcsayaICj10GcZoZ1P4m/kiIeeE+qqGEfWThwuD5BK6c41DsOE8
         33/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Snmazk82MB0/0cCIeeJxaxYr1fCvgV5xCLT8s21RwAs=;
        b=IHO14Ego1leIJ2yPFNxFakHciPpMA8WeeXhPIZdposvM1yAxn3tBK39uIn0k9E4YEB
         u72RDcarx82i6UzAW28wPOIYeLPDtbIUUG2JAXaemXmIXLo4gYzrTGz8tTg+nRCHwfiN
         Y2hwmijd5ov18lqSQx6ZDXw8OqnL8Lz2V2mDYf+5TAqKuy0cj8I6pGtViMvZbpO6pPdI
         yDfgC2Rzs8IlWCos0bJQDunZKIrWtLc9h1tmOVgXbBaosn/t4GcI02XBrD/zhpyqZ9US
         Sqyohhkys9xGxMLD8BSj+AbcPS6zxAoAOBB0BivzspxOdFwxHpyqM4unUy7nFKx6nQK2
         EaXA==
X-Gm-Message-State: AGi0Pua7iE0NahI5MhYzykvV6Dzq7LP+HJFJRNP7Gp2IKq97YLRqXLKz
        W7UFOwih37XBoY+Zc7gNliwh+g==
X-Google-Smtp-Source: APiQypJFIzF+3oECidi3FpRsgBdzk96yF/DdD8sX4fg1ZTuRL6fKY5vITqktCAnS0MAH0XqQp9KVDg==
X-Received: by 2002:a63:64c2:: with SMTP id y185mr19296513pgb.133.1586141914636;
        Sun, 05 Apr 2020 19:58:34 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id d3sm10450782pfq.126.2020.04.05.19.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2020 19:58:33 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:28:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-pm@vger.kernel.org, andy.tang@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] cpufreq: qoriq: convert to a platform driver
Message-ID: <20200406025832.7bbtfo52k3dz5pkj@vireshk-i7>
References: <20200403212114.15565-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403212114.15565-1-ykaukab@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-04-20, 23:21, Mian Yousaf Kaukab wrote:
> The driver has to be manually loaded if it is built as a module. It
> is neither exporting MODULE_DEVICE_TABLE nor MODULE_ALIAS. Moreover,
> no platform-device is created (and thus no uevent is sent) for the
> clockgen nodes it depends on.
> 
> Convert the module to a platform driver with its own alias. Moreover,
> drop whitelisted SOCs. Platform device will be created only for the
> compatible platforms.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 76 ++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 47 deletions(-)

For both patches,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

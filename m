Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818F2957B1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfHTGwG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 02:52:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTGwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 02:52:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so2627780pgv.13
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i+hjWtS0xkyvDgGGWpXI9f3HTBIBIzNWQxSwzV+WAZU=;
        b=cYo1TxsIHe55HfkUDfpuxqMKsCkz65t3qxzFpSCMzBJk9IHPU6ExXdG0U+pZ++k0Cg
         okumg/ggZRGSoSy+ZbRT2Ps+Vsd8pfSi9ZWMt7U45pvC2/IT5F77HNSodayPqBOv5cV3
         6BvYS+u5L1Ni1kfHcWYm55YuKtPGaDozX5PhAn6UwAz+et/tKA9mX+XcF97rO+aqzlFv
         Cj7eBpJAFNGxoVdXqvD1ru51HekIc1GzXm748F5UXczJzpAY8DX7FS9seLLnl3M7Vemk
         J/tgzz+zv1j2MA19K17lgp9lWTIBN8pXGNqo0OMStH+QfzpJsAdsLVajyNrgHd5/0M88
         zG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+hjWtS0xkyvDgGGWpXI9f3HTBIBIzNWQxSwzV+WAZU=;
        b=PlqaXZfkGJIuHDklsmdDKluudLQuUZo4HB+P/+M3FcpW9lFY6TzjkjbOpicfFT6q6f
         n0/UWQ5QfePJhf1ssIuVVuuYrngaCG7qLGcDopBaYBzeg6DwntBRLmnCwTw/XRa2O3+I
         P0ENUshZ00C4MXW+zX8mPA9iKGd15mXVBpJ9y6fwDlgDFrF/pjmHSPdqGHy0ayC2fsvc
         U841y6S4zDrdg5EpMuyZmyRlPK4LQk0LKtA5Is7zdwruZpICz1tw6iQ6yqR4859bopCn
         u5eUAOINK2CrmwoaVtXj0CXGKIBSNXYjSJ+kXmtsDXBSK2MzxhvMMJdE59CaT4DYzsr+
         PA2Q==
X-Gm-Message-State: APjAAAXnXWU5KcQzSbCwLUxFPXOyO0lAZ87FXqhciGAaPsS5XV6hOhFn
        b+A6tPWpqbW8O1VBHZbIkBe21w==
X-Google-Smtp-Source: APXvYqzwjCsRAS6cB5J0P5fcBJP7buAZ+aw80mguRxLU0GqLt/r9iSse1S8YKV4Qh+5TKFuU67r4Fw==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr28480771pfs.114.1566283925579;
        Mon, 19 Aug 2019 23:52:05 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id r4sm22922805pfl.127.2019.08.19.23.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 23:52:04 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:22:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Message-ID: <20190820065202.fet4ctxk4jku7ul2@vireshk-i7>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-08-19, 14:12, Leonard Crestez wrote:
> The "required-opps" property can be placed on any device and point to
> any OPP table according to bindings doc but this is not fully
> implemented. In practice it can only point from the opp table of a
> device to the opp table of a power domain.
> 
> As part of my investingating QOS mechanisms I implemented support for
> parsing "required-opps" into a DEV_PM_QOS_MIN_FREQUENCY
> dev_pm_qos_request. Since OPPs can be shared between devices this only
> works when OPP tables are unshared.
> 
> This would need to be called from a device probe function and any
> suspend/resume handling (which likely means disabling the QOS requests)
> would also be handled manually by each driver.
> 
> This is RFC mostly because I plan to use the "interconnect" framework
> for device requests instead. In theory this could be used if you don't
> care about implementing smart aggregation and just want to "set bus freq
> to high".
> 
> Devfreq support for dev_pm_qos is here: https://patchwork.kernel.org/patch/11078475/

Some work is going on in related field. Please have a look at this as well.

https://lore.kernel.org/lkml/20190724014222.110767-1-saravanak@google.com

-- 
viresh

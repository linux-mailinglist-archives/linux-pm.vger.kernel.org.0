Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C724D2A90A4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFHq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:46:58 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FBC0613D3
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 23:46:58 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t22so281428plr.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+nSJ1dUMKTzMHcRiv+jEKZyI0VMUKMfKAIHBsRy+j8=;
        b=kBcevyRxvEfAwJNzJ4iM3BV++zYAPL5sWPRSIK5NU22puWSvm4kOX9usvmv5flKF7G
         0AQJrbkeegxjhpfTlNF/3PQ5iNPf3rYBIXRI/dj7Il/ZVRRItGMRuEn4OVGN1nF7i0xT
         HNKxIUXgM2R41wISpT7dZPC0qrXlq47XQ/QxFcchZa4emmEn0a9Xq6+fCvUdcqTCR4gy
         erDEkRZn4u8vDyMY3fYdqXfcEiLzJOepohCQsh6E81qheA57/p640UAnKynkL11kd9HE
         r1N+pLoapNRO+mSlIZ819bDqVUPlIjJ9RMWPUuxUOj+vYgLkU9jJceu6XSyFeFytAzm3
         n8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+nSJ1dUMKTzMHcRiv+jEKZyI0VMUKMfKAIHBsRy+j8=;
        b=GO4DpKe30Ar5Eib7Qoq26C4El2nX6iRagdTtOaABGPl0BzJftULKQGQ5t0zWe1yMZa
         69gB7s0juZRU2vplGs0T+5hlWjicDLWcEGTsIOQ4k00Z9jzP26cGQedW/1Uk2siyv1sC
         X+5ymoLFZ5xuIfwmwQBgaS87FtdSXYleWm9+P/nQ/kL6F9Cr/SCMfTI9yDr+rOdvg10g
         hBf666KUza/b/fk3jzIsDxSpqaV88BSZHHSFrYb+RAsnA1XBSOeHpsBij4Q0ZW31WBnP
         uoVVBtzSfVoRG0mJxnykgjgSE9NDTMjedyg1WrMJi1T54PrBWn6UDmBJGUliFZWMRxlS
         1zAw==
X-Gm-Message-State: AOAM533d72DCi0GHb+Hi0ds8SDnWpxThb15GLpT1VVmXHxc45f1GfYkp
        MaP4Z0x+iRVCImxz1WGC/BI6qQ==
X-Google-Smtp-Source: ABdhPJxaHM2ScKefdHxO0aiQSp5dkZ3oSGeXt0F+XsARWIMNWVebQTp5RbmyQVuGD/3eDFyS0/QTMg==
X-Received: by 2002:a17:902:b7c4:b029:d6:855a:df2c with SMTP id v4-20020a170902b7c4b02900d6855adf2cmr728458plz.26.1604648817934;
        Thu, 05 Nov 2020 23:46:57 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id ck4sm1264075pjb.50.2020.11.05.23.46.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:46:57 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:16:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] devfreq: exynos: dev_pm_opp_put_*() accepts NULL
 argument
Message-ID: <20201106074655.dt6lfy5ozovpnghe@vireshk-i7>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
 <CGME20201106070533epcas1p480406659e38528d1263641612fcff8bb@epcas1p4.samsung.com>
 <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
 <a2f9dbba-1c07-8b60-fda5-737843be92e0@samsung.com>
 <4b13f82c-fa2a-939f-e26f-e8fc4d34d567@samsung.com>
 <5a9625bc-9e40-fb18-b111-9cd797943af3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9625bc-9e40-fb18-b111-9cd797943af3@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 16:48, Chanwoo Choi wrote:
> On 11/6/20 4:46 PM, Chanwoo Choi wrote:
> > It seems that this patch depends on first patch.
> > So, need to be merged to one git repository.
> > 
> > Instead of applying it to devfreq.git,
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > 
> 
> Also, need to add 'PM /' prefix to patch title 
> in order to keep the same format with already merged devfreq patches.
> - 'PM / devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument'

Done, thanks.

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D317DEA3F4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfJ3TSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 15:18:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46414 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJ3TSW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 15:18:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id q21so1408320plr.13
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OlkZ0fbcuhFnCC06vBucpby6j2rTDvW/LLqNAsLplQ=;
        b=L2CD3ce3d2ob0TvHZzIn6TzM2d4+RIlDTsEZL5nV9u8YgBB2f8vbP+XZjWtLXbFiiC
         +oMuwq2U7SWqrBMsyJtJdlzoG3ZuYzS3daVtslG/Vj2Vn70eYQ5t5MSaXSF8JC6XbQ/p
         IzOhi544QFjXbAhDSScXE5zO3SR8mcfLOMhGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OlkZ0fbcuhFnCC06vBucpby6j2rTDvW/LLqNAsLplQ=;
        b=HPTf5THz9dr8XfBlIzNgW2JYojpeFUCqToTxY9XTWZv1HNTdhv2gX2NcKSN6Md6iFI
         GCtv6yoR5RrLm9gJVfPMrBfGmcJEtJnIsmBLoTQHdsmeKV2zrzMBGW6f2ET346yWGbfA
         wCkBs/mSVpcuqiNyTRbSGlMQCdGuTtBt9RUi9sQIcNsB78Z7Js6khO8NfkIzT5UhE6wa
         NM8ny7vsXhut5vizP4z8OW707ntcLuf+GUTYtzJF/u8guw3jzZXdOYYL7tSYdzPR8ukJ
         dMO24oBLfdux6Wff/wi82TiRfF0vQ9DD8TqDQmsK/joNXcBEpibd4AmkOrEIidW+foEn
         utTw==
X-Gm-Message-State: APjAAAUZUw44mdaf+ssT2iPoZecqVFpIW5KiJE9zNEZ8hbXvyrCEURvE
        zs+1pvZr4stZDuGK1XcIKHu5Zg==
X-Google-Smtp-Source: APXvYqx4N2VLKcKkoi0hP0tFPhHeamd6/J7d2dmaS7igYbxnjmiCmAT3z1euOVcdNEw9NpujQQVijQ==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr1671958plf.239.1572463101315;
        Wed, 30 Oct 2019 12:18:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h9sm705436pfn.167.2019.10.30.12.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 12:18:20 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:18:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
Message-ID: <20191030191819.GB27773@google.com>
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 02:41:49AM +0200, Leonard Crestez wrote:
> Current values in scaling_min_freq and scaling_max freq can change on
> the fly due to event such as thermal monitoring. This behavior is
> confusing for userspace and because once an userspace limit is written
> to scaling_min/max_freq it is not possible to read it back.

Yes, this is indeed confusing.

> Introduce two new user_min/max_freq files which only contain the limits
> imposed by userspace, without any aggregation.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> This was motivated by these discussions:
> 
> * https://patchwork.kernel.org/patch/11078475/#22805379
> * https://patchwork.kernel.org/patch/11171817/#22917099
> 
> Those threads are about devfreq but same issue applies to cpufreq as
> well. Let me know if this solution seems reasonable?
> 
> An alternative would be to make scaling_min/max_freq always read back
> the configured value and introduce new effective_min/max_freq files for
> the aggregate values. That might break existing users (though I'm not
> familiar with any).

It seems there isn't really a perfect solution :(

This change creates a set of new, consistent attributes, but since we
can't make the current min/max attributes read-only userspace will keep
using them forever.

It's somewhat doubtful that userspace can do anything useful with the
current min/max values, since they might change just after being read.
Anything besides monitoring the limits (approximately) would be inherently
broken.

Having min/max return the configured value would be the expected behavior
(IMO), but obviously I also don't know for sure if there are userspace
components relying on the current behavior.

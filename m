Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234C5EB9A6
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfJaWX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 18:23:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33353 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbfJaWX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 18:23:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id c184so5490475pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SKGgL+l3I4cTUfYsDNCk4em6H5Eawid8b/zxLf81N/Y=;
        b=YlcnDl/IEI9bxcUtH3e4eha3zBNrSkXhqkORi8o+V/3u2NnNjtf5CfJ2Mjmcd0h3nG
         x/TMlweb3+p3ag0jh+1F+pr8BP9JyZzd9I7n1DHPc2/i8Tu7sgUAlgm2q3BJneuw+b5n
         tEi3E6y9SEAe/ZvKPyTIbf6Nkjl83BH7TgAYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKGgL+l3I4cTUfYsDNCk4em6H5Eawid8b/zxLf81N/Y=;
        b=Aoq2rkueE3AOyniADkGzmRjRj7bpDEIvkdbhraGJXxwU4VIB4Dbvsexi347w7imSFm
         4O6SSMpL7dCR1ZJIZVLWs5ucvZITiGIpPRWqv9EiN0o/MJk3/3wkSbFtmAdZ4YR960it
         adBU3dVNk+xgsuAcckQfQ+kJYlgwGxAdrRireUx6WkiDLC2rADoD1Qt37xaZ4KKSZk6x
         XWPeP1P51ywdBpnu88+ZmGlwmF8dfRqxjB36rDaL/qoTixdmPWq7ZdLMd2i+pYi9LKzD
         rHn8wsJ/cROjiuFd1avIRSpYBA0AATmUWx4NoQJmvHGR4pOBdN3ECSWnkaDYVF1ScAKL
         5H+g==
X-Gm-Message-State: APjAAAWIvpTuqFhmn8R75Vg8DlKM1MrQzOfY1P92/SaHM0jTH7oJ0u81
        Up9lvoE7hUxGcy+/yOuUT+lhig==
X-Google-Smtp-Source: APXvYqzigiCQ005SliDdxLkAbxe7L6nNy7Lo3E43CnhaZThQBDAgHYJdN7sSuJ7SmGCgR71ECNhp3g==
X-Received: by 2002:aa7:9482:: with SMTP id z2mr9193349pfk.98.1572560638740;
        Thu, 31 Oct 2019 15:23:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f13sm3915110pgs.83.2019.10.31.15.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 15:23:57 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:23:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
Message-ID: <20191031222356.GE27773@google.com>
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
 <3169109.BFaCN5124U@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3169109.BFaCN5124U@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 11:24:31AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 30, 2019 1:41:49 AM CET Leonard Crestez wrote:
> > Current values in scaling_min_freq and scaling_max freq can change on
> > the fly due to event such as thermal monitoring.
> 
> Which is intentional.
> 
> > This behavior is confusing for userspace and because once an userspace
> > limit is written to scaling_min/max_freq it is not possible to read it back.
> 
> That can be argued both ways.
> 
> It is also useful to know the effective constraints and arguably the ability
> to read back the values that you have written is mostly needed for debugging
> the code.

Agreed that reading the values back is probably mostly useful for debugging.

Reading the effective constraints is a debugging use case as well, userspace
can't make any decisions based on values which might be in constant flux.

IMO the current interface is completely counterintuitive, I really hope we
wouldn't implement it the same way if given a chance to do it again. If there
is use for reading the effective constraints it should be exposed as a separate
read-only attribute. Keep it simple (when possible).

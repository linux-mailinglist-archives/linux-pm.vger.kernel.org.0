Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2D24FBB5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHXKly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHXKlx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:41:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61FC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:41:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so8191692wrw.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t88Db9KnngUKJEjmA8Oo2eYSJH8tNiI0z6sghYExUJg=;
        b=F7QMYB/cYqJJZJzyXNpk+zdlNmd2UXLMyIlZqvzSJWgfYxLxfO5ZEz4HGNKsRLhy1y
         TXaGSY4X8pyMVkK9NUH2O6i2lGiO8mFT4C7oNqlAor+0i2BkLqAi3NtAp/JVLapxKfFH
         aMGxMKfRgTNI7fHCnQ7zxfzM1WKcTclBiNgzYF05DeKgXO2Ra4fPvOjvbxJ9YGhurXIt
         brG4xeyNsJfKrEP3NKytD4uzmFtOC+GctGDj7KYPFio0n9wm89s0BmCsqHZlPx9B7WMj
         6PGuk87bCep+bFGBV5yZ+8PPZN5FpOpAcw6KiAcHrTzrAYHIJzRacWXoxQ5iGuoRochn
         FWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t88Db9KnngUKJEjmA8Oo2eYSJH8tNiI0z6sghYExUJg=;
        b=V2yJvfPlRJaJJkutA+UmN7wHeoggf+pfERVd0lrCsESdRmidT+qAKmI46e912jqcjE
         hhKzmcpb+RvkXGHFVbOzpdsklXJcY4uSjSaHfHiXJjxbPpk8HMfUSme7XEzgy8biZRqw
         PHtp/jRrV5XvEhsFxXWWQK1ske1PZRq0WFTaoHYQ+i002gWK97Ejdix+pctg5vC+2WzT
         ezFggRi7bYNgXT4RRcrfqkMZ8h//XCrlw6BLoO7nhs+2aJhDu4DEgzj58mdgFSOCLCoS
         RWLEizl1oENBBLb7XvaAcJGrRGT+pUsHV3TDYuVYQeUKkohd08gd1rz1EjKG4y/QD2k2
         pVTg==
X-Gm-Message-State: AOAM530bDJziLcSkyEibD1ApccptUoY0zEwXHvDG+kWT5cHHF/D2jueI
        qV59num3WW5+zpIL0bK+MxbrrXDWc9ZlLw==
X-Google-Smtp-Source: ABdhPJw1u3S5KYjm4QpGvR+EJJv1xekZLgNOfO7uLdBbtKw1efODis2mhyplqbBM+TQ38VwQ7S5DEg==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr3770326wro.44.1598265711435;
        Mon, 24 Aug 2020 03:41:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id f17sm25070960wru.13.2020.08.24.03.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:41:50 -0700 (PDT)
Subject: Re: [PATCH] thermal: rcar_thermal: Add missing braces to conditional
 statement
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200819092716.3191-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dfd8b4d6-4df0-892d-12a1-63edd6757136@linaro.org>
Date:   Mon, 24 Aug 2020 12:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819092716.3191-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/08/2020 11:27, Geert Uytterhoeven wrote:
> According to Documentation/process/coding-style.rst, if one branch of a
> conditional statement needs braces, both branches should use braces.
> 
> Fixes: bbcf90c0646ac797 ("thermal: Explicitly enable non-changing thermal zone devices")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89991133CF3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAHIRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 03:17:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37891 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHIRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 03:17:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so1193250pgm.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 00:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wKcCES/d4/KeU/NbfZOHeDU0TekdBewHLd32C6AO1ck=;
        b=SEKtLl/2LU1rqULv4K0YiLjIIU6CfLWc6zgCHzvxXn6rxs3MloRGcaY+mmpntrk4bR
         qqWP66RHO1/y3UFLDjZ5vX9LWA6WSWYaNyehUzftiFo/A/vpzLr7FOczpYhalxh/g+ct
         a+Gfmtpi+1j4iZzOSb68bV8GqPo5Mpq4dFFwZdtm8i1akjAn93MM63gkF9aG74vL07jw
         efvISDgtx7WPN8FQ3PapBNdjNSHXuyU5JaLAe48son4QVaPPZ0sHRPrbm8SedF+oLoOE
         vkTH/LFqRemsKya0qnLlhZsrwR+UHjzxT+UA8MxOW9nVh6Qhd9DaGwjqEYzs6LeHwavn
         ZdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wKcCES/d4/KeU/NbfZOHeDU0TekdBewHLd32C6AO1ck=;
        b=McMMn6SGgkxCcrjTx4xz10uiRuGX59AxyBeiAZoFQAmbPL0+knodtLG18mHX+tci0A
         E8czn1VyJdrxI7pnyz+dFR+dI+K5oqAPVqQtvCimQeM3dqCozJoUp1JpVD5hING6YDz2
         ZLUyE/rAZEAHNWSwV0G4CzoOYaJ+1y63ecDGeR+XURwHVT/Mg6W3+ZKTvUq9YGXGyB+C
         GD3Bz+a5YOplmluqTF4XNMDIEV8KUJleYBwkay5hO8xArSidZ8QW+25DTsMhgHs0bx66
         FpZJCK9BUbkHAOLM0qQqto4RfL5PNJIKBPy64XZnr4zubZH8qHBhUKHQMnHP6OWy22qH
         Cz1w==
X-Gm-Message-State: APjAAAVaz7msTclVONvWk1pS+tDQ+n5m9ZVOHCygHe2pu+qghMO/PyZq
        9UbPCVhFSPVP9i8PX/p+bhhiPg==
X-Google-Smtp-Source: APXvYqzegCxJYokSIFLdFNcsQ5hduGvbek0AbObhZQnUPnuTQ7IwQ4pkC8mnHCuGhr5jfepvFOz3+w==
X-Received: by 2002:aa7:92c7:: with SMTP id k7mr3844330pfa.8.1578471464268;
        Wed, 08 Jan 2020 00:17:44 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id j38sm2414849pgj.27.2020.01.08.00.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:17:43 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:47:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200108073500.ir4nvvzlz6z7d22m@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> -	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count))

Okay, you can remove the WARN but we don't need a lot of diagnostics around it.
Just print a single error message and drop all other changes from the patch.

-- 
viresh

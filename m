Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02F56CCC1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGRK2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 06:28:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41815 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfGRK2T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 06:28:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so2352953pgg.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kuRFO9z4yov4IRc8BXZGZtgoW2sm4qmv8R5QdB8Q4oE=;
        b=racBSndMpYtdzbcSG0/qxxm7041D5sDhp8JLFwUcQYYgVCsz/U9b9NfKwD9xwhqcZ+
         +x6ugngMN7Qp8divmnKXWX/WXO+3zyX2dcwClLKvCWctXfzl69SiYvsNW1j7aLikDybA
         PSBGtOeZ6urZiRmM63boDH9Qfy28/cV9uOZrOc71vzxUBttQaXqQoA3Y3lVBHB2qV654
         fMBnRjg1ttSU5XLIs7/lef854Jv6NRo8U/UprQIB78suEyP6Jtet2M+VCMJsXceU3sVg
         PVh1M1luKc75Uvmmd+RDr1iiq/k2FHGO+6UDg/2FiJa7B/ZOkf5gI9pLg/zWes78p6Tu
         rRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuRFO9z4yov4IRc8BXZGZtgoW2sm4qmv8R5QdB8Q4oE=;
        b=B1apUNRoMxmu48P5zKaJVqs2TNGkR7ReY+fj+lagqcpaYzWiTbQbghP98CsvpZqOJE
         3i51zoa+xRs8mmUHimpFkVybLYPXa91rLOgS4Drj4Ahq1y6CjtSIjEC1LZz47mvavBOo
         2IJ+p+yU4KgxNtFE8dXHKvTLK+RRfDx1W2vylULxoh+CMbWdqsqEFuf6JFi315HnCGKR
         qRx3FAmyD93GxEUec4heg7WBOT4Bz1nXfOENN7Po0eZhGhIKtHvtpOMuHoNXQX6e9ztO
         5lnkC588p1TvTi6/EJmfl8amv7Dzv/TkOwiRujE6U5/ekdUW9hi88dwwHX0TfNuuw0Ho
         gUCg==
X-Gm-Message-State: APjAAAUhWeM8IS9ndj5XAj3IcWtm45Wh3c/4rxI3bIDKUUVZ6tmtxHg6
        r4GTXoKMRFe0hMAYYwk6MoBnMQ==
X-Google-Smtp-Source: APXvYqxpCWaaZ26yIUZ3BfOE5EjZRaF+ffkGAi6TWuWMToHVg1AhBY8k18zcid9aC4/eOIN8bDLJPw==
X-Received: by 2002:a63:6904:: with SMTP id e4mr19287348pgc.321.1563445698832;
        Thu, 18 Jul 2019 03:28:18 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id s20sm30217742pfe.169.2019.07.18.03.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 03:28:17 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:58:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     rjw@rjwysocki.net, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dsmythies@telus.net
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't set next_freq to
 UINT_MAX"
Message-ID: <20190718102815.utl3hanfc7fpf2i6@vireshk-i7>
References: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 23:26, Doug Smythies wrote:
> This reverts commit ecd2884291261e3fddbc7651ee11a20d596bb514.
> 
> The commit caused a regression whereby reducing the maximum
> CPU clock frequency is ineffective while busy, and the CPU
> clock remains unchanged. Once the system has experienced
> some idle time, the new limit is implemented.

Can you explain why this patch caused that issue ? I am sorry but I couldn't
understand it from your email. How are we trying to reduce the frequency? Is
clk_set_rate() getting called with that finally and not working ?

> A consequence is that any thermal throttling monitoring
> and control based on max freq limits fail to respond
> in a timely manor, if at all, to a thermal temperature
> trip on a busy system.

-- 
viresh

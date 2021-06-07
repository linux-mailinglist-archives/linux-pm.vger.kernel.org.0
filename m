Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44939D43D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 07:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhFGFFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 01:05:01 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:56041 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhFGFFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 01:05:01 -0400
Received: by mail-pj1-f48.google.com with SMTP id k7so9054540pjf.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Jun 2021 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7hFLRPZep3NhEyjBLx39SpIzdx7gsFvbPRRE9zh5io=;
        b=CsMz1zMDhuepyLr4s0wKs31UKt1jXAbPOKpRfj/F+CYqxo+M/RYnTEr+6ixW1s8TCA
         JyTBeJQWbdePJSmxQ9x0oqz7+EK0IxXwg/eJZRY5mFGcvBuedNDk8SkVLWJnTM7XcF66
         b+AONi5OyI/QkURdQbzKkFuew81h9t9//Y2RVtu+rakvdeyIt1ZRCapGpUUY9XwBnCQf
         OKDSoja6PywHfgwp+T19+BPT3HyCXXB6rRkT0iSOEKw9iTexuPpPkuk2HhQOpurpEzjZ
         YE5Lcb6F2keQM03Tke9WDMo7uhxcgmyQnDOJ0GBNorNgn0L+z7vYsYmz9Y3pGYgnXPOV
         0Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7hFLRPZep3NhEyjBLx39SpIzdx7gsFvbPRRE9zh5io=;
        b=ZBNzRX0sk5idNaMzw9Fur8agfLrdXJ3Tg3FLp/h7+nQ2giWH01yaL/FylYdInw/iGg
         ndiomyteoN8gbcxVrZyeA2vToA+TMZPN1igkcKBCAUGmIgLd/LNYe1zC7OcFBISpCiPk
         WkxqTrm3KdTYjOd51Moh5g6kHzAV/wzpB3DhbKKoPwK1eB5YwZuoOSEdOgBdU36lIiuW
         yKgyIQEHErkhMNCNufrOQFlDRvyGC4V4+f2PrLNBMDaUOT/ugdcqaGorBol1+IVYoX2b
         A0JECdFpJYSOndMXSXMeyO7No5ubCZX9jdtOfjEQWCEOw6nFVkjvlUwnikYbU/vczSZz
         +XgQ==
X-Gm-Message-State: AOAM532uDNs6wDMk8LSx8V6uNFSNiggsETtUh0QBQvEHUIqp66/Gmxfp
        UQjopbWfwZtBQJDhgnsdmLvBQw==
X-Google-Smtp-Source: ABdhPJx4ojsPmZ8mVRSzHGxkj8fmrzRsWI9rz4lA5f3FU6vskFg1L80Fn8Dd+gSXkSCHxIQAEzcvUw==
X-Received: by 2002:a17:902:ed0c:b029:104:8397:3376 with SMTP id b12-20020a170902ed0cb029010483973376mr16162350pld.60.1623042130532;
        Sun, 06 Jun 2021 22:02:10 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id s11sm2894169pjz.42.2021.06.06.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 22:02:10 -0700 (PDT)
Date:   Mon, 7 Jun 2021 10:32:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210607050208.3annn3dtmfrfxpzo@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-06-21, 12:05, Vincent Donnefort wrote:
> Some SoCs such as the sd855 have OPPs within the same policy whose cost is
> higher than others with a higher frequency. Those OPPs are inefficients and
> it might be interesting for a governor to not use them.
> 
> Adding a flag, CPUFREQ_INEFFICIENT_FREQ, to mark such OPPs into the
> frequency table, as well as a new cpufreq_frequency_table member
> "efficient". This new member will allow a governor to quickly resolve an
> inefficient frequency to an efficient one.
> 
> Efficient OPPs point to themselves. Governors must also ensure that the
> efficiency resolution does not break the policy maximum.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

I was thinking about a different approach when I suggested it.

- The cpufreq table instead of an index, will have "efficient" as bool.

- EM will set an OPP as efficient or inefficient, based on the OPP
  table, there will be a flag for this in the OPP table.

- The cpufreq table is then created from OPP table and this
  information is automatically retrieved.

-- 
viresh

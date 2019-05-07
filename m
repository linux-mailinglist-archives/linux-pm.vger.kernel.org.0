Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD315D3C
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 08:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEGGOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 02:14:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfEGGOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 02:14:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so7735137pgl.7
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dXkJPjzOGIuMY/FTGFoOTw4dClnk/7+YCAfAz1pX+HA=;
        b=iOu7+LYsdHfoxjaxHg9y6RVdjO+e+paH/cHN4CJlm4R1Ch1EDwfSiSoNC1D6LwZKDQ
         Lb+eX9sKZovTb5AcqpCTmXxmN12vXxkxKrazBg8ddb1wrR9TnLaChDjL9cyi4yY9Ljjy
         X2aF9myy73XzCeDH02zTH99z4nvEbDzgZaYR1ru91ljXQBqP7H7YMHAUxsdAaCVBedrc
         viN+1X2hV2iCsRmK8wRI8EVJt4kEGDkBX+4UhPm58AC4SX+KDizuCuo4GrFEP/wGkMJx
         BUQwhF1HwgYTumuO1qIZkeJQ4NAVJx63GixN3CaHUc9g4HiPklAuTDOPbDL/l6Cb6ulL
         MLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dXkJPjzOGIuMY/FTGFoOTw4dClnk/7+YCAfAz1pX+HA=;
        b=gixFkXiiR1V5ilTudEhR12uP3uk/KxNGl8wEeFwmE7HrU0SwgSiaN0+EQR+Z/Dp81g
         V3zkuqT12tZxleB0M0JiADuWCxmej0otYJPPBf15vvzYHAMgvi6B9KNbDEQVHyI4wNTp
         ADshyxXVdd1QjPNR3Q5JwuzEbpRxPb1aimIa99FyyL0+oJU2NjCXao/zX6+/eYg7BWi3
         RQATrRoSOuEnxTMWsRi7ygrzTaOLGpexA+h1EFgYcV0AQ7nSp4Ev+D/cIr5F8idZeCsR
         lF31K+RO6vwsUhjhPIIVbZrKQQdjB9VWhtxHu+jY9bB2s07VqwKTC4pDGZl/G/VKDvXV
         fttQ==
X-Gm-Message-State: APjAAAU7lclF7Fd1Dopll8nbOOoHBGCr70dPmKvoGDQO9skP10lta/Cw
        /E7XUVY86QXtisQBbIZ9qslIpw==
X-Google-Smtp-Source: APXvYqy8kOz2tJmBHkzr83G9as6tP7+g7D2rbTXUZE7TajzAQ2RDLeAQEoWLvtheuQB7JwyzoniUuA==
X-Received: by 2002:a63:6ac3:: with SMTP id f186mr37192260pgc.326.1557209684974;
        Mon, 06 May 2019 23:14:44 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id 2sm3418726pgc.49.2019.05.06.23.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 23:14:43 -0700 (PDT)
Date:   Tue, 7 May 2019 11:44:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Message-ID: <20190507061442.jfcv764or3v3zk7o@vireshk-i7>
References: <20190505080736.27970-1-ping.bai@nxp.com>
 <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
 <20190507060702.ub4zjsurylldj2mm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507060702.ub4zjsurylldj2mm@pengutronix.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-05-19, 08:07, Uwe Kleine-König wrote:
> Just to add my color of the bikeshed, I have (among others):
> 
> [alias]
> 	oneq = show -s --pretty='format:%h (\"%s\")'
> 
> in my ~/.gitconfig and can do:
> 
> $ git oneq ddb64c5db3c
> ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")
> 
> which is a bit shorter than Viresh's suggestion.
> 
> (Originally I had "one" without the quotes which I learned (IIRC) from
> the git mailing list. Instead of deviating from this I added 'q' for
> "quotes" to match the usual convention in kernel land.)

I didn't tell that I also use some bash style aliases :)

$ alias glf
alias glf='git log --pretty=fixes'

and so all I do is:

glf ddb64c5db3c

Thanks Uwe.

-- 
viresh

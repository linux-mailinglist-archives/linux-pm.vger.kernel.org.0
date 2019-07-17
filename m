Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8636B4CC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 05:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGQDCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 23:02:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42633 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGQDCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 23:02:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so10068935pff.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRX9TlAeUtyXQ5rQBl4frqjOwkqHx09X+c4ROvlgZ74=;
        b=Xpr7jSjR/IEv0BXRNnCER6aPr/CInT7jFn/4GjHwo98RjlqW2Y2qf0J5dG2WyZ+7el
         dslAWSvGzSpR3TGqTbhS+6aSlFLxvf/26RfWZfayQ/4xFwL5726B3JB61hNfoJweUIsv
         tz5R3G/NbYJ5E5E6ijoP850+4jdKVAe/xEb1Jw9wBYUJN4KfAOpYAzQtjqkFdnMHRded
         lUG+2qKUGmMG1fas9JShxaaqlNbJp1Zk+Q8g5e8KQe2mGiFIoFyaiqW3coT/pdM8BaQc
         yHfD6AEeYPPCUWECtO9zox2U33Rsj2EVAgX9c7WhFtGiYOVJvvqCRYie6CTOeEdvIvvw
         OzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRX9TlAeUtyXQ5rQBl4frqjOwkqHx09X+c4ROvlgZ74=;
        b=L3XYmv6+9sfebHFB4DWaF0i4s9ywf3AGkSKBQeS7Olc914roF0eZ2BOnlHPK4iRDpj
         8J5J/RG/FKIobNbi+Ly/yHzvMIlVQhf7XBluxY0S8gYcZUszJ/2m6n4+hMymerWQsGyR
         TVhpER5yz4lhq3iIDVVnI5hnG7RKgA+zy0C5QJjAErCj2RFTa+BoXg2ON22qB5uwmZ/4
         DhZr1162QLQRRM6wXl69uM28NboQ2Rlb7cPMausDait4r7iLnm/UrpXTMT0SBRW5QStQ
         doGoJRJOmAlUC9VKpeLpFQ78adWQwDSt9CNI4NgGCanRhhy7zE9zEmjS+Wp2ObHMZHIS
         3b/g==
X-Gm-Message-State: APjAAAVYj3AjWQsf6rS8JKxgIwAJjT5j7XcT6RDU6DQkyATwSa4/7cut
        p+VDfFy4UpxeXiCMchMZOuB9Bg==
X-Google-Smtp-Source: APXvYqwqqqHTOl9WI+4Q6WMPGE4ns8EQLwo8Gpn5YY3/i4zhWjU57zokH9ytJ9mERR3gLD2KJjT7aw==
X-Received: by 2002:a17:90a:71ca:: with SMTP id m10mr41370885pjs.27.1563332550525;
        Tue, 16 Jul 2019 20:02:30 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id y22sm19984787pgj.38.2019.07.16.20.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 20:02:29 -0700 (PDT)
Date:   Wed, 17 Jul 2019 08:32:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] video: sa1100fb: Remove cpufreq policy notifier
Message-ID: <20190717030227.pxqgq7strhzqyvfq@vireshk-i7>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
 <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
 <CGME20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8@eucas1p2.samsung.com>
 <8b0f9adf-8462-eeba-afd1-52201f4e7f47@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0f9adf-8462-eeba-afd1-52201f4e7f47@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-07-19, 14:25, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Viresh,
> 
> Please always Cc: me on fbdev patches.

That happened because I used patter-depth=1 in my script for finding
maintainers from get_maintainers. Sorry about that. I have incremented
that by one now.

-- 
viresh

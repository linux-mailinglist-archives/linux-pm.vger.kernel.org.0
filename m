Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A816323CD79
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgHEReN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgHERdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 13:33:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E17C06179E;
        Wed,  5 Aug 2020 10:33:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so1288056pgl.10;
        Wed, 05 Aug 2020 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ubC/V5WUzoZj5xfHrYdi+jL75ehDvyw9uS6rHF+Jq8U=;
        b=O/GHeGm/gQtbGK1llGngflGpM9k6g4L5179tZ8xre02/XuGvGMRFHUAsC6AXqIh3lN
         lWrz38BERBpyJUHI4TBNvyZadqoPsBKXhNDzGhAiA3CRKyYK6Kci0sUEvRD+kUW8fkFf
         v+ochFEQzfRkpRJmVj+OCCMjL313jypzYHQjt8rTuvov8DMPYexlXfxATyTvI8dvShCY
         UUjtojLaQiVDwXokabVt5tKckoG51WXOGIuH6yhGiRXH+xRK1NlLGgVqDZ+6zoU0F7yg
         BRFMf3BTuwrQrymB1Fkm7PLVGrksZUGir2siyZYXQTtKfOygYakI0e63P5vZPBZWbumQ
         GNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ubC/V5WUzoZj5xfHrYdi+jL75ehDvyw9uS6rHF+Jq8U=;
        b=cuaqYK4puvEWhN5QUEX5GKShZmWo9TR8fqBpipfccHI+h3j8BF6ra7plQlV2ycuVCV
         7CiXZOYvUxmafYduvGTt2v/m0rH46gv75oj17kjW1YIhTuXm7daR5wUcEehMYEq+MUhP
         lEqwiyrl0dShKbysxjN5zjJXtLvIArRERpd1uiv4FFUtIjrA2+F3eCshaN+cxqUzmvDF
         ToJoRRm94k68h+4jrtOJNSsYxDxPzGDggXABsJcuWNQSmU767q8FVGAjvSRw1LIMXHhl
         AdTO5nuB4aGvUluHdIZ3FUjge3122qyMAqRFYvd0UPiF2WD/DaZdE8LXc1nmGz88uyXF
         t8WA==
X-Gm-Message-State: AOAM533Rgma0wiKw+6wBxX3voqe7VfGlAxjZ9ayt9ZGIs9EGydQaa8qy
        zsdHoGAk99w7JbLiE9Nvhsc=
X-Google-Smtp-Source: ABdhPJyE+3mIJw7JiYtikhouQKcIpFH/TIV61KDAmqsI8WELrTzl/wETy8tPvwFa1sbu+JKrAcXM1w==
X-Received: by 2002:a62:1782:: with SMTP id 124mr4246256pfx.204.1596648789558;
        Wed, 05 Aug 2020 10:33:09 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mj6sm3777559pjb.15.2020.08.05.10.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:33:08 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
 <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
 <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
 <20200805160312.GC4818@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4962aa3c-2b56-5232-c5d7-286ca1363446@gmail.com>
Date:   Wed, 5 Aug 2020 10:33:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805160312.GC4818@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/5/2020 9:03 AM, Sudeep Holla wrote:
> On Wed, Aug 05, 2020 at 06:34:36PM +0530, Viresh Kumar wrote:
>> On 05-08-20, 12:04, Lukasz Luba wrote:
>>> I know that Viresh is going to develop patches and improve these
>>> cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
>>> I will leave it him.
>>
>> I am only going to look at cpufreq's view of stats independently from
>> the firmware.
>>
> 
> +1, I agree with that. Kernel must avoid any logic to aggregate or
> interpret the data in a generic way. The userspace tools can manage that
> especially if this tend to be platform specific.

We can probably standardize on how to expose the firmware maintained
statistics such that these tools do not have to widely vary from
platform to platform, right?
-- 
Florian

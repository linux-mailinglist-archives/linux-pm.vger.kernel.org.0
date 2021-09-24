Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20064179EF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhIXRlw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbhIXRlu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 13:41:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651BC061613
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 10:40:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so29617381wrc.11
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXBiZ3lMd+Z19YrZpfewJmi1/8g+N72a9+ebtf2jcDg=;
        b=LvrnJcFSd9hDrLwHldZaicIeKrQtvXXEBr6QeH67LPmIeIAN4+hK/2DBybrTKrfDPJ
         KzuV7SSlASa8CPpbNbU2fAnkjCsfTtvebmIHhiwqWnyHHGh3s8mrSeCC66G93zLtp8N3
         T3u6SHf69JN2ciSx6CqIrWEoCq6IxqDszPrBY0Houqij28xPRiOxKpmMhFFcali13URz
         Woa7UuAIjwvL1S/OHuvzd5Q8oNk5t44jurI7oTepjMAkQpCYv6Qw5b4NPB4TISbPNuA+
         ZdTrcchShfRKivD/8IA9dAEjGoh/F/++8YDfA0SUmIKLWhKyuAys5wMZ3WfmWrKnP8dM
         3QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXBiZ3lMd+Z19YrZpfewJmi1/8g+N72a9+ebtf2jcDg=;
        b=uvJU3B86r9IRn6Kq4zywe8AwJeBb6frewxG9S9WHxYVHDrOAZHlE6OlQyCxP+peQYR
         DdnrbqfpE4YVbiQE/vucUuTgXydGf3xSKlFB4w4FvOk+i5zVb6ap3fFd4JGH+tJe+k2g
         CDoQIvKRrlMwFizxXTIecsLYHP6Fef2XgILp0FN9WugO3M/BRheJxOXd+LbBjFs1pjrm
         fE5HaL1UwRIx3dnW5Q3/rNmbh9dYKI7QDfkpaQX4sYKH5X051gvsS2nRZTAT3mj2Nfjq
         WRpaaWDNRILOgqXD4j4ZyRajr9CgPmBRbmbfdE+TqE3g5LtoIF5VaHxDqDLAu/Q9MN8E
         nt4Q==
X-Gm-Message-State: AOAM530n4LUvDcLb+ljPeGu9HcFaL9WRRjzXS60DP74NUyc4VzLfw7n1
        buSg1fBuxRqmQXusYlVO9zDo3Q==
X-Google-Smtp-Source: ABdhPJwvJ9hZyMAnm4LbVQbSMEuvCTVUCudQxClPjacvYBdlFGLm1xL/c8EyrseEits29Blc6bjYEA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3408702wmf.154.1632505214618;
        Fri, 24 Sep 2021 10:40:14 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:fc07:a338:ccc1:8b6? ([2a01:e34:ed2f:f020:fc07:a338:ccc1:8b6])
        by smtp.googlemail.com with ESMTPSA id z13sm9956503wrs.90.2021.09.24.10.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:40:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] thermal: int340x: do not set a wrong tcc offset on
 resume
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Antoine Tenart <atenart@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <20210909085613.5577-1-atenart@kernel.org>
 <20210909085613.5577-2-atenart@kernel.org>
 <46d6d30201e11422f57bd79691133dc0491bd4c5.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <03ba2e41-6ae6-d4ee-ace5-055ac40c1128@linaro.org>
Date:   Fri, 24 Sep 2021 19:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <46d6d30201e11422f57bd79691133dc0491bd4c5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/09/2021 18:27, Srinivas Pandruvada wrote:
> Hi Daniel,
> 
> This patch is important. Can we send for 5.15 rc release?
> 
> I see the previous version of this patch is applied to linux-next.
> But this series is better as it splits into two patches. The first one
> can be easily backported and will fix the problem. The second one is an
> improvement.

Yes, it is in the pipe.

I've applied the patch 1/2 to the fixes branch and the patch 2/2 will
land in the next branch as soon as the next -rc is released with the fix
and merged to the next branch.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

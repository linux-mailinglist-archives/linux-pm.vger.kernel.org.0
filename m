Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B77462FA5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhK3JdJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 04:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhK3JdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 04:33:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D510C061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 01:29:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a18so42971463wrn.6
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 01:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=felncm1mZvr7zHi58upE9nlqocAVIX85FXINzUJHutc=;
        b=peF/Q3t+jU7+66L7aIjXgQKez3slgg6ejeSkmnTsgfFXIDQHPystltw+vw1xGaTgtZ
         uzgOiD6kqv4dmXisOnNDWPTHWD73dKb51iYt6ciFckQEs75XWaXilkZYk8OkkYlJ+8v/
         BQ7KfU+PjssUenDe8sMJ9BMf3lBBsCdm+ayPfzXtDgLsY0+selgl/9qc1st2y1WV63Bm
         7tWaNOakWezHwlsSoZYRH84No0kNnDuXqrsyJce8zlk//qh8wkWBx+/0DDBGPnU0rr5a
         qZmEuiF53bqJ57LHQFEKnLE5EsYETRsM+JCoyTQLlJa8kLgDXyggDDiCVgbXoMKTqaLk
         T4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=felncm1mZvr7zHi58upE9nlqocAVIX85FXINzUJHutc=;
        b=iriCPc/th5zERPEE1zs3//oXI9y4FOjWz7fx14HmoyV4/x9mPG7cNHvO1XOBo75Kkp
         xSjaWyRAY2WghKFFqZjI8Ga22NMat9VoZ4mHyVOFlyWuok6q2FuHW/4LIJ/AXu2u9Zux
         YUPmIF6oTvLS3TPVQeDqUe1tA5NpJjNa4GOxonZWAiG+Wys+sFbr8ysszaWtLxRol6Jj
         EMWBvR32QNYqdnf5P0K3HUUjIEG5wHmqEcoiE0uoIxaUVhEpkutqTCv58Ph3jaQ9OSMR
         uNvX7p226heQ6UQtXZqGD5nMK8zXMi6NaPwN7WZEM91d44pTVf5SQl/vXFgBZjeIYHoc
         InVQ==
X-Gm-Message-State: AOAM532Bks+PH3TTmoybdNb1GpaTlyOnVayOQsCe/llfU40eKFjJGzTM
        WotVlDnPCTa+bV73XZxAxp+Ozg==
X-Google-Smtp-Source: ABdhPJzdiFz+5CZ4OQ0z1EP7aGFuMzQ2lbjLZk1z+q3SiGtYY12xMl+QVZchUrsQWGDeKbUSf9Hv7A==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr40618505wrd.300.1638264588653;
        Tue, 30 Nov 2021 01:29:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id q24sm1714601wmj.21.2021.11.30.01.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 01:29:47 -0800 (PST)
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b51c9b2a-40d2-6575-7746-3059eec53519@linaro.org>
Date:   Tue, 30 Nov 2021 10:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/11/2021 02:33, Ricardo Neri wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Add a new netlink event to notify change in CPU capabilities in terms of
> performance and efficiency.
> 
> Firmware may change CPU capabilities as a result of thermal events in the
> system or to account for changes in the TDP (thermal design power) level.
> 
> This notification type will allow user space to avoid running workloads
> on certain CPUs or proactively adjust power limits to avoid future events.
> 

[ ... ]

> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]	= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERF]	= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFF]	= { .type = NLA_U32 },
>  };

AFAIU, 0 <= perf < 256 and 0 <= eff < 256, right?

Is the following true?

	0 <= perf + eff < 256



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

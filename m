Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19C9340367
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCRKdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCRKdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:33:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A8C06174A;
        Thu, 18 Mar 2021 03:33:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m17so3738798lfg.0;
        Thu, 18 Mar 2021 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/pZ+kezBF2UIJIIaXW6PgYWm9Md+5QNCYNLeHlex5s4=;
        b=YrlTZbNx21OZWFoqPTG0Ww4LflBxA3ggLRD8xBun8L2ZEpfYyRqPejl2U9MZai+X//
         AdZMb6yNP3dntqiZ840DkeaqZRdwTckMkDOYVZkh7j0wUp8Z6+TN2v3pGzcSDWmMdJnM
         kPWLx+3g3vtDLY70mG4JBHco0khNHkoG9O6Fx+AX9PXnLI8rzpjb2WmxmFKepoDFOFpG
         YkrOnljWH3+u/oXCfugynJBNUeWG9EyRgllxKTgqQM8stY6H0aXT1iM72X/4jJczKRKW
         pagQk4UTF46F5WJJ5ZBGWLei3GRmPKgNearDWvIxs8uEaHYbpDQs1NmYooMpzk8whq+6
         Lv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pZ+kezBF2UIJIIaXW6PgYWm9Md+5QNCYNLeHlex5s4=;
        b=RyctUJ5x6Kam8w+j2oQ6Y3t83tU4/OQvpXiULPV7/3hizsbta9YOvKlwOOvhglwIL3
         8O3+gTr5Rve4bHU7FKeMkEQNmEJbQT+7Ycm1nmak4PJ1CkHyqRIwOb0uROfkI1Yr5Gsw
         ujA735pFPQD2xXQCGmZDhLj2hi9SojFSjL1TRv/rvD/Qqk/+0JvasJ7zBcEVX7uScI89
         uvoOMUMus4YZBrrbfHf9IxmC4DNoAuyVd8Do5/ABGuYDycc0W8bGvfsXdenYjbOUvdNW
         0bETaCMpxSzwwXKbQfdV4sqX039vzHlc74CypSPxZXVPxRD5q+WgSwKNCBGcq+9yqRTx
         iA9w==
X-Gm-Message-State: AOAM533XavWXMCvnngcSvMs5ZGN7xtcwbg9AhVw3/sYne8EafaIVWSAI
        QBdtxz59nyCK6Lo02ldNGwI=
X-Google-Smtp-Source: ABdhPJyxMOynpXNQj3F5yIeEViZsBGK9MToVwqbacPUTlVyIe1ljh+G35/ctl0fCbVv1zVnkmo9+cA==
X-Received: by 2002:ac2:5feb:: with SMTP id s11mr4810902lfg.558.1616063619505;
        Thu, 18 Mar 2021 03:33:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id f28sm175257lfk.67.2021.03.18.03.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:33:39 -0700 (PDT)
Subject: Re: [PATCH v16 1/2] drm/tegra: dc: Support memory bandwidth
 management
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210317185734.14661-1-digetx@gmail.com>
 <20210317185734.14661-2-digetx@gmail.com>
 <20210318093142.GB18038@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ad258c7-964e-d6e7-2222-2f85030ded76@gmail.com>
Date:   Thu, 18 Mar 2021 13:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318093142.GB18038@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.03.2021 12:31, Michał Mirosław пишет:
>>  static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
>> @@ -2430,6 +2781,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
>>  	.has_nvdisplay = true,
>>  	.wgrps = tegra194_dc_wgrps,
>>  	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
>> +	.plane_tiled_memory_bandwidth_x2 = false,
>>  };
> For globals you will have .x = false by default; I'm not sure those entries
> add much value.
> 
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

IIRC, in the past Thierry preferred to add the defaults to this driver
in order to ease reading/understanding of the code. So I added them for
consistency.

Thank you very much for helping with the review!

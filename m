Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BB301119
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 00:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbhAVXoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 18:44:17 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:39107 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAVXoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 18:44:16 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 47CC13EEDE;
        Sat, 23 Jan 2021 00:43:18 +0100 (CET)
Subject: Re: [PATCH v5 0/7] cpufreq-qcom-hw: Implement full OSM programming
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
 <20210122094646.35d6wrbj73jrhk7v@vireshk-i7>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <31a1ad25-30f5-8741-fa85-90b93f070f9d@somainline.org>
Date:   Sat, 23 Jan 2021 00:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122094646.35d6wrbj73jrhk7v@vireshk-i7>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 22/01/21 10:46, Viresh Kumar ha scritto:
> On 21-01-21, 20:52, AngeloGioacchino Del Regno wrote:
>>    **
>>    ** NOTE: To "view the full picture", please look at the following
>>    ** patch series:
>>    ** https://patchwork.kernel.org/project/linux-arm-msm/list/?series=413355
>>    **              This is a subset of that series.
>>    **
>>
>> Changes in v5:
>> - Fixed OPP table API abuse, in conjunction with the CPR3 driver
>> - Some minor cleanups
> 
> Tanya had some comments about the driver in the previous version,
> please let such discussions close before sending any new versions. I
> haven't seen any reviews for the major driver changes until this
> version and we are already on V5. Please wait for some time for people
> to review the patches.
> 

Well, okay... it's just that I didn't want reviewers to lose time with
something that had to be fixed, as it wasn't working anymore on the
newest RC, due to a commit that was (rightfully!) blocking the abuse of
the OPP API.

I know that it may be not practical to send a new version while a
discussion is in progress, but this looked like being a critical fix
for the driver that I'm sending.

In any case, this time it is a "final" version and will not get any more
changes unless requested by reviewers/maintainers.

-- Angelo

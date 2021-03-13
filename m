Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC4339BD4
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 05:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhCMEw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 23:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMEwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 23:52:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE77C061574;
        Fri, 12 Mar 2021 20:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=IyKSlCZ17KiihDViobh1cv3gEb1t3i+bcCJrnma1/Zk=; b=K8aaV+2aAlncJ4ybmQ/CEqJDQr
        XxNqSAiFpxyyw8sfQZZccj/uNXUzd2mClzfMgsDlmEOgWt5gFxkGbVgrMJ06hB32EFQRYNTKSlzpj
        G7l1kLSARbRo5Zp40blk9Or71sSNeNgOFbFx+tS1sIBC+dK+E3PdLQOp+u/cj4Gf9Hi1aBaHiIFy6
        V29FrfKXp0saBLzN39PhnZvWAN6rYoHfzlN/8rs9aMCIUsMUsTUBVafdXoy+3z2CUM5gWAq8U/I4Q
        jTTFxVw+tx3dtSh/TQpy4eshqiNTS9cX657uifXQg4cSilz92gMOFv1BWaZw0Ql9bW3zD7CEl2to7
        ViyVvpLg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKwGO-0017TD-BG; Sat, 13 Mar 2021 04:52:35 +0000
Subject: Re: [PATCH V3] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210313034951.13269-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <020910d9-b78d-d080-a030-c5a3954511ce@infradead.org>
Date:   Fri, 12 Mar 2021 20:52:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313034951.13269-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/12/21 7:49 PM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V2:
>   Incoporated the findings of Tom Saeger <tom.saeger@oracle.com>

    typo^^^^^^^

> 
>  drivers/cpufreq/s5pv210-cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 69786e5bbf05..73110b005716 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy


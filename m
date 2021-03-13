Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D8339A9F
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 01:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhCMA5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 19:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhCMA5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 19:57:14 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D699C061574;
        Fri, 12 Mar 2021 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=yf6a+FqunqEKy9nDVUqx8qlxaws+MgFWSVCqAn2Ab2A=; b=GhHxie1GiWNhULT1vj4uKavjzb
        lI8xI3YUvye9XWK91aIDktsXrUywv+6i9buj5Wx+dpP98HzZPodr4vP33TeWo7pBqvo/vfM/RAagY
        r5UZABcLnO0h1KtO9r3F5MDdGP53HUH5MlQzOROTSpRX51OnrlnPGsR4VLQxpcTJ3C3GQ4kQ1GVPU
        CHTAiVAcKjmPDaQRzFLXy38JKb6XNqGM/XnizsF4uc0Dnv+5v+vT3OsfNpOdcR/2X41n8CesOe+8+
        oKx9qgknynmM9zEKZaRdN9frGkcdrBFpN9cMvUpQcdnSu0eVd9YcreC0EbHEAo6SQvi2nunAfh+UY
        4fs1K14A==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKsac-0016Vi-VN; Sat, 13 Mar 2021 00:57:11 +0000
Subject: Re: [PATCH V2] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tom Saeger <tom.saeger@oracle.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210312232621.2083-1-unixbhaskar@gmail.com>
 <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
 <YEwMbGm83aRRxnuR@Gentoo>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db71b3a5-c45c-0d5a-3593-c96bb3fc4318@infradead.org>
Date:   Fri, 12 Mar 2021 16:57:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEwMbGm83aRRxnuR@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/12/21 4:50 PM, Bhaskar Chowdhury wrote:
> On 17:16 Fri 12 Mar 2021, Tom Saeger wrote:
>> On Sat, Mar 13, 2021 at 04:56:21AM +0530, Bhaskar Chowdhury wrote:
>>
>> sent a few additional typo fixes to your V1, can you add those to your patch?
>>
>> Regards,
>>
>> --Tom
> 
> Thanks, I have already sent out a V2 in public...I might make a V3 with your
> changes too...did you sent it to ???

It was just a reply to your v1 patch.

-- 
~Randy


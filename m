Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2376A76E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 05:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjHADVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 23:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjHADVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 23:21:10 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 20:21:03 PDT
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703131FCA
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 20:21:03 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id QcnzqyaRqQFHRQfv2qjzdg; Tue, 01 Aug 2023 03:19:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Qfv1qSk2TkDIKQfv1qzEVk; Tue, 01 Aug 2023 03:19:32 +0000
X-Authority-Analysis: v=2.4 cv=Q6DBXq6a c=1 sm=1 tr=0 ts=64c879c4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=IsyNV7-RnDjwaFrxwpMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q8xDoc0e3lwDSHDguSa5+mR825k++nOURzgRi1L1QjM=; b=w0vRXLpPlYdxEw939A2MVixiqw
        osSgoVZQAZPQEm7lqCh5b0Tyh6FNxMmL0lx10kA0X/tRQkrzVaUQ51vWgqvLep0h+6yE14lc36Pa4
        p6oaFQCebqtJc5egOX6KOxqWRZgnWQQf8tghftegCMdYYnft19+qi4hM0gFtD17aEMb6owVSdPdYy
        ilJWqff/aqNeXpdTzlX+AicmuLRUL+aTLci81Swb92upaukSQuY/sWwXRyUeARI1tipgDa1xI0Ux6
        iHfk0fAhUgxt590w/aC7CJP4O6x+kh5XaA89JYH7pMUsYuSFMuK+Qi9HmkoxtSWGVKllrSB09qw1U
        bBkTnRbQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60426 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qQfv0-000Kd9-1K;
        Mon, 31 Jul 2023 22:19:31 -0500
Message-ID: <8d83bd2e-9e66-c5fc-e351-1d57f710296c@embeddedor.com>
Date:   Mon, 31 Jul 2023 21:20:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZMgiiEmBORZRaobc@work> <202307311610.B1EB796684@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202307311610.B1EB796684@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qQfv0-000Kd9-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60426
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMHzeYhN6YE4/eQGnGtOXcmOUzLAkdw5ab9PKwKABwFO8qYgMbUyBFgOW9l3qfnrP0RkTJYuIHep/ruKXI0J7koIN7gI9uw1AfxrEHjPtX5EA7YcxALN
 jpeOq6by0bGZ4a88H/VnvF1Hzx3JKXhbJ4GGF9n6vlI8UuxCzTwgSbVxYPi74AuWl+wrFMU2yF+zFjaLVbzSpYSeBOAXnql9j5w=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/31/23 17:16, Kees Cook wrote:
> On Mon, Jul 31, 2023 at 03:07:20PM -0600, Gustavo A. R. Silva wrote:
>> Update the iteration conditions in the for() loop to avoid writing in
>> array `table` beyond its allocated size at:
>>
>> drivers/cpufreq/brcmstb-avs-cpufreq.c:
>> 449         table[i].frequency = CPUFREQ_TABLE_END;
>>
>> This fixes the following -Warray-bounds warning seen after building
>> ARM with multi_v7_defconfig (GCC 13):
>> In function 'brcm_avs_get_freq_table',
>>      inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
>> drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
>>    449 |         table[i].frequency = CPUFREQ_TABLE_END;
> 
> #define AVS_PSTATE_P0           0x0
> #define AVS_PSTATE_P1           0x1
> #define AVS_PSTATE_P2           0x2
> #define AVS_PSTATE_P3           0x3
> #define AVS_PSTATE_P4           0x4
> #define AVS_PSTATE_MAX          AVS_PSTATE_P4
> 
>          table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
>                               GFP_KERNEL);
> 	...
>          for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
> 		...
> 	}
>          table[i].frequency = CPUFREQ_TABLE_END;
> 
> I see "AVS_PSTATE_MAX + 1" being used for the allocation, and so the
> loop is likely correctly doing P0 through P4. If there is supposed to be
> a terminating element in the table, I think the correct fix would be to
> allocate an additional element, not stop the loop from processing P4.

Yeah; I think you're right. And it seems that this function header makes it
clear, too:

drivers/cpufreq/brcmstb-avs-cpufreq.c:
421 /*
422  * We determine which frequencies are supported by cycling through all P-states
423  * and reading back what frequency we are running at for each P-state.
424  */
425 static struct cpufreq_frequency_table *
426 brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)

I just sent v3:
https://lore.kernel.org/linux-hardening/ZMh45KH2iPIpNktr@work/

Let's see what the maintainers say.

Thanks for the feedback!
--
Gustavo

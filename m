Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466564EE808
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiDAGGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 02:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiDAGGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 02:06:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F34EA1C;
        Thu, 31 Mar 2022 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9zoMua7h1PBXReWbBpOpCKn/FklmpzaPyQL5ZjfOtww=; b=VafaguL0uaw8Xr/1iwnucZIENi
        MC8SJkuwDZX30tHc5RugcgtPFM2u7BlFyz6rhJ9I1ZcZ7gWwE9QsHHsoHpDbG7AtCExHJvaQHhI1J
        7O2kN0nol9+DZwFT/DJmcnLpbZcBTq5ainprR1h1saUM3RN35APZNk8/BsZTVZaP1i1d/zNTob5Jw
        w3cVNxViD5rZZCA+jHsMKi9B9oMqbe8OzNZ5YPy3UYQrp53rvCODnvH2/wDDAmw7XkluUPEFqeQEK
        QAGU7D6TSN/58z//QU4ac6T4sfP0qdPs8MGE8/0mufkSIMmu1VGLxtL8BcIgz4RRWapZYCwX7MyLK
        oEZssGSQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naAOj-000I8j-MS; Fri, 01 Apr 2022 06:04:38 +0000
Message-ID: <4c814e46-5a0a-1b1d-4814-90759d31e384@infradead.org>
Date:   Thu, 31 Mar 2022 23:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -pm] docs: driver-api/thermal/intel_dptf: Include
 isonum.txt
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/31/22 22:57, Akira Yokosawa wrote:
> For the "|copy|" substitution to work, need to include isonum.txt.
> 
> Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
> Hi,
> 
> This fixes a doc build warning reported by Randy at
> https://lore.kernel.org/r/73d98132-1d08-ef29-edb7-9e062b9154b8@infradead.org/.
> 
>         Thanks, Akira
> --
>  Documentation/driver-api/thermal/intel_dptf.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 96668dca753a..2df82719c5be 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. include:: <isonum.txt>
> +
>  ===============================================================
>  Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
>  ===============================================================

-- 
~Randy

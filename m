Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DB4EFF24
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiDBGVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Apr 2022 02:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2022 02:21:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C9176640;
        Fri,  1 Apr 2022 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=itmtQB8D2+JJbf4Uv6O2VeVcRlFlftGRty5bG22BMpo=; b=A8/ZT6VHlIqvweKWuDEGMwfCs7
        oF466WT0mKONiz7JrHNK0w5kTmAhwCHpWIl1UJU4ou/40IPB7mTpTVOQThZRaOvS7IvkpMOtrl57M
        G4BWJuwlHq5PxGZK4tFlWcVyudgmsZcjkNDomHoDQVqZKL1ZBvvqz5WPQD7QysUd2zacJsTGk+Jnr
        YhcPb9PplWmI7yQYIEaiX3aoSsWLxvzhiDbjk+Q1B5etw09dfU9YuvWgg+ulbb8wPXVLpk5NGERky
        gSeQLnwEtnna2IJmvCbeN+IU7S91FnHTc52K7Rh/dMhfj+Og1c2KwyEECdSyi6caYObXIRG9T2D5M
        gKJEe0Yw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naX6s-000m6w-Up; Sat, 02 Apr 2022 06:19:43 +0000
Message-ID: <56f92044-9aca-0c03-7b70-c2ee1eabbb22@infradead.org>
Date:   Fri, 1 Apr 2022 23:19:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -pm v2] docs: driver-api/thermal/intel_dptf: Use copyright
 symbol
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/1/22 16:19, Akira Yokosawa wrote:
> Using a substitution pattern of "|copy|" without including
> isonum.txt causes a doc build warning.
> 
> Using the symbol "©" itself is a better choice for those
> who read .rst sources.
> 
> Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes since v1 [1]:
> 
>   - Use © instead of including isonum.txt (Jon).
>   - Amend title and changelog.
> 
> v1 [1]: https://lore.kernel.org/r/e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com/
> ---
>  Documentation/driver-api/thermal/intel_dptf.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 96668dca753a..372bdb4d04c6 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -4,7 +4,7 @@
>  Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
>  ===============================================================
>  
> -:Copyright: |copy| 2022 Intel Corporation
> +:Copyright: © 2022 Intel Corporation
>  
>  :Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>  

-- 
~Randy

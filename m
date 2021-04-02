Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447453526F0
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhDBHcG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 03:32:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58735 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhDBHcG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 03:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617348725; x=1648884725;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OJTk7EUnlZbrZrYQtkT+QZ356U3xx16XjxpbG1q0V5U=;
  b=otye3UOi3acSQbkrWR+nKUiJdr++AGrwWfARlJlN4a07mWaW40CBwNlU
   voW142QQJwZhYmVJ6JyyTyji5A3tcKusRqhU5ElfaLWDwSLBnRc7y23da
   +aadB1A6T4QMAqOYJXwKOLnU1qToRR/AEqkOZdNALPAVLOGOKfN60kyeJ
   s6CcGu/zttKatO5D69hW75CodDGwl29l7Oz+ISjEcEQ6coLaV0VU1tMDh
   hubzvi8rJkfrwdWo0PzKExQkAQhgDfISoFUmQbeCWDUAw8XZ4JyHcgCkh
   f2FRdKMEWXNNRoa/11zdHobhZC+mpd2G2HN3jegQCSUp/cEVcvms8TibD
   Q==;
IronPort-SDR: JXLyo5qWOMu9GDkdmy1AX8qPncoe28owQLAw8TS9TlruEl3oyqAp/qi0D43Swvp35bNe4eQV8R
 XCCDB3qMq4zbCAA9PWB2tDfC1d8H2qyvDMcIce6nDgdy0PnGaFPGgnx+JwmiznChE4oZB5yY+N
 yd+pqZhTIfGwvbQr1vZZMd8k2lJfkC5J3V5z4OIZKd7CEZiwttkJZAhpED+1Nh8gRf+mCzWIWP
 5JWKy7O28ew23FvYUWJ+vw1+ToNj5d6V1ZYLjOnb7rhylH1BnKQN9C30YqZRdc2o7/F37oVAHL
 Juk=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="121538311"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 00:32:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 00:32:04 -0700
Received: from [10.12.73.8] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 2 Apr 2021 00:32:02 -0700
Subject: Re: [PATCH] power: reset: at91-reset: free resources on exit path
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
References: <20210209110109.906034-1-claudiu.beznea@microchip.com>
 <b18fc346-498d-4c6f-7f06-a6148a17d216@microchip.com>
 <ee7f39b3-8f7a-deb4-b4b2-dfc8e2ba86f9@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <f9519a82-4fce-13ac-f51e-8364bc5f8694@microchip.com>
Date:   Fri, 2 Apr 2021 09:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ee7f39b3-8f7a-deb4-b4b2-dfc8e2ba86f9@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/04/2021 at 16:42, Claudiu Beznea - M18063 wrote:
>>> +unmap:
>>> +    iounmap(reset->rstc_base);
>>> +    for (idx = 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
>>> +        iounmap(reset->ramc_base[idx]);
>> But if we keep this loop, I have the feeling that some kind of
>> "of_node_put()" is needed as well.
> No! In the loop:
> 
> for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
> 	reset->ramc_lpr = (u32)match->data;
> 	reset->ramc_base[idx] = of_iomap(np, 0);
> 	if (!reset->ramc_base[idx]) {
> 		dev_err(&pdev->dev, "Could not map ram controller address\n");
> 		of_node_put(np);
> 		ret = -ENODEV;
> 		goto unmap;
> 	}
> 	idx++;
> }
> 
> the of_node_put() is needed only if the loop is interrupted as the macro:
> for_each_matching_node_and_match() is defined as follows:
> 
> #define for_each_matching_node_and_match(dn, matches, match) \
> 	for (dn = of_find_matching_node_and_match(NULL, matches, match); \
> 	     dn; dn = of_find_matching_node_and_match(dn, matches, match))
> 
> and of_find_matching_node_and_match() will return a np with refcount
> incremented but at the next loop step the of_find_matching_node_and_match()
> will be called with the same np pointer and the np refcount will be
> decremented.
> 
> struct device_node *of_find_matching_node_and_match(
> 		struct device_node *from,
> 		const struct of_device_id *matches,
> 		const struct of_device_id **match)
> {
> 	// ...
> 	of_node_put(from);
> 	// ...
> }

Oh yes you're right Claudiu, I overlooked this one. Thanks for the 
in-depth explanation.

Best regards,
   Nicolas

-- 
Nicolas Ferre

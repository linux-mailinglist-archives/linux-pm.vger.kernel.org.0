Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0444689E04
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBCPWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 10:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjBCPW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 10:22:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7DA842A;
        Fri,  3 Feb 2023 07:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6E961F65;
        Fri,  3 Feb 2023 15:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2955C433EF;
        Fri,  3 Feb 2023 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675437552;
        bh=8hzdeXH6nbVJhHxk8oIwz5oklsjwdv9sehbJ7yVtANU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=FvL6gLo6MFuD/spR8WuafDDvZtd6FkTsa+myBrfVvv3+UA3eFz/CtSp2FJGGtgYo2
         OQWEHgpsOz9SzrFjUm1mHY9CvzVFfCnU5s8nzGjl/wXRW0JMDrrrqTLYCI9Gc8D04R
         ZbVy1AeOqfV9Wn/xd/aAoF0hRWYzgtYUZCC4jud6NBjM+Eh9TPC9HhnbkfBtRMNblK
         65L0jzQHragNZ2tnYSsxPaq3An6U111r6VUdm2AXVO4aojyRhvFPRHj8hNbwioQRKj
         VUkuQp4YGI5Eu9R0PKbK7DTwFOp85GUkCdCO2RVZk72p8mpZf5o8HSCVarc0tS6M1/
         oAlkinng+Wbhw==
Message-ID: <fd66e996-6e6c-7c04-4750-420f2e77383c@kernel.org>
Date:   Fri, 3 Feb 2023 16:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip DFI
 binding to yaml
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
 <20230203125012.3804008-19-s.hauer@pengutronix.de>
 <ed9c3224-2f1a-c335-3028-6c23f40f57f4@kernel.org>
In-Reply-To: <ed9c3224-2f1a-c335-3028-6c23f40f57f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/02/2023 16:14, Krzysztof Kozlowski wrote:
> On 03/02/2023 13:50, Sascha Hauer wrote:
>> Convert the Rockchip DFI binding to yaml. While at it add the newly
>> supported rk3568-dfi to the binding.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

BTW, for sure you already got this feedback because many patchsets from
you and from other @pengutronix were sent not using get_maintainers.pl
correctly.

Best regards,
Krzysztof


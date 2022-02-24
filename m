Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330704C2DEE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiBXOL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 09:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiBXOL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 09:11:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32361294FC2
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 06:10:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b11so4023915lfb.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8j7egoBWUKq4lvGP4Aglka/Vu1R/dd+5Ps0l1yx8YlA=;
        b=LxF5kwhxCu5MQu2tycIwnLAaZBlDPxSmj03TUvjBoi47MqksLBh/niYK82NIZsQhAg
         /4x79PXdzKTvOCeM24O/7IbMRySuBoykSyW+Lax9dUvYBdTCeAouVgVx3OIJjX00Ynfm
         F+YRDrwwPMt9Vjb/rKGle1OabJlqtrSjveV9jjK3d0gV+wTxj1B+eyUXxndsVV0QQJpm
         KgcqR3Q82GFUROv9gvQ1ZCYGkUDTRz80mWztSEvKUNeKVmfWv6FU4FjJ8Fi6HVFRtVBE
         j2rnaa6hvpNb7HC5oEG8WU9pY2r6Rc8NgpRni7PCdJlgSigtt4CsgaJLuAAZBExr9EXt
         YWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8j7egoBWUKq4lvGP4Aglka/Vu1R/dd+5Ps0l1yx8YlA=;
        b=LgIspyjWZhRzRmq5Z1UFM6wpIEjvE+q5UPLTUODtcQ4ymG5aTcNRawMHyou+jeSFpL
         wePQnuW3HehByQdivAsuD4QueoSpKtjJjqclbt+M2HmWDzcYWaMLtnIbGA9xjQk9DExg
         DtFF1sNDsFxd4xDwqYhLclKL3JEEKTapjyEp45Oj22+F/FBrzZMMI1dGWPoxHWttP2c9
         YEooscmCqschlDQnxj2nM+k13wMRnRIp3XGzrIrALzMvq5rAYSAH1vu4c9GKWMVFFIv1
         e5zMonCilnroIE29lnwxNCKVXf/9i56gfBk0OJzVq27pyVuCbRYTSCs5RWwAANnsJe4e
         6AgQ==
X-Gm-Message-State: AOAM5323Lma7c7r51SAOh9pctWOhP3YpqD+w5VS1ePAzYuDLheFT/zgn
        /MMYj5yYkXdgIh38qmNH+11yxBXO95U=
X-Google-Smtp-Source: ABdhPJzezsPtgeNFRnSfFw5lIdwwra/hCt6DP9aocyX+781ofG/GU02h3RXJ7nJ80S+FvN+tcEgJmQ==
X-Received: by 2002:ac2:4893:0:b0:443:3b8d:b54f with SMTP id x19-20020ac24893000000b004433b8db54fmr1831573lfc.73.1645711855466;
        Thu, 24 Feb 2022 06:10:55 -0800 (PST)
Received: from [192.168.2.145] (109-252-137-194.dynamic.spd-mgts.ru. [109.252.137.194])
        by smtp.googlemail.com with ESMTPSA id k3sm218375lfo.10.2022.02.24.06.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:10:54 -0800 (PST)
Message-ID: <088b1db4-6e59-0a69-104b-028510f21173@gmail.com>
Date:   Thu, 24 Feb 2022 17:10:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20220222214331.1557723-1-broonie@kernel.org>
 <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
 <666e7ad7-1eb2-f8bb-8ef8-d92d5e18d01b@gmail.com>
 <Yhd1LV9OPD/slCV8@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <Yhd1LV9OPD/slCV8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.02.2022 15:08, Mark Brown пишет:
> On Thu, Feb 24, 2022 at 02:35:42PM +0300, Dmitry Osipenko wrote:
> 
>> To make it more clear.. there was no problem with "suppressing a write",
>> the problem was that regmap reads are done from the cache, and if cache
>> isn't per-initialized, then you read zeros from the cache until write is
>> made.
> 
> With update_bits() that can result in an attempt to set a bit to zero
> not actually taking effect if it believes that the bit was already set
> to zero and there has been no change in the value of the register.

Alright, I tested this patch and see that there is no need to pre-init
the RBTREE cache.

I'm a bit doubtful whether this change will save us much memory since
there are 64 regs total. Nevertheless, the driver will continue to work
as before, so I'm now okay with the change.

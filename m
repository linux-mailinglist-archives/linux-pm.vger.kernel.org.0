Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176CC5FC88B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJLPkE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJLPkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 11:40:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2D45990
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 08:39:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n73so8879298iod.13
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmZMR3m2P4foh3/AnslPZcLh3BzKs5VTYcawpGmrgBQ=;
        b=W+BRf1i+101nPJSuleHKgC4CHXztnHYDxfdNnAyn8JowdXbRdwVFIhQVN2UGQ4oGXn
         5X/ZlQ41XNlTLur+74o4rlpD3Pb+ki4L3vMG1NzaBBTdd2nuxmkbWmfXRKit73RHL5Zj
         hoSxz0q6oIs9ZRT7HObmSGlK34ePhXhq4Rmag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmZMR3m2P4foh3/AnslPZcLh3BzKs5VTYcawpGmrgBQ=;
        b=Hv6fLaVworKcSQOZGDjf6nvCJj2uigOWm+WwqTMa3V8DXxo6pDHaCA5xJnvT/IRJEr
         8p9CXtVaQtGZIVVt1YZ1xSdDXPKhfHVbJGm98e0ej7N6E6vJHBG53qjUBGmcmqh1t6Hu
         hkcRmUGqVhcNeFfQHLcNi8AXG3LV/8J3vGye0YCmerNRT7SSTSUKRsnpGt5TMRXjhvV3
         zII6lbLJ/2Bv4JzsZJUQ4u2GSdh3vzRCTZV++4RuqGdGFU9MJQHefymLvcLz54VBW+rv
         sZviF/idYhSRE4X4PnM3tEcNjI/geMjNAk++/FHZMqnVXN748izO3IRcPGtJKtQwMZ5S
         LqnA==
X-Gm-Message-State: ACrzQf1K91suAh8YVr/FB4LPTilRw+Vr0mDxibZjTpNhE/jVNRgxkkum
        S5VERi13X3eM3ejcIftAH5YGiQ==
X-Google-Smtp-Source: AMsMyM6sQDFuW6B3FMNI5Tintw2F7xS9dbILnspf17C7yyJEJ54/S6qE91KJks7jM4ovi5G8RMLwWw==
X-Received: by 2002:a5d:9403:0:b0:6bb:dd42:ad53 with SMTP id v3-20020a5d9403000000b006bbdd42ad53mr10712635ion.106.1665589198606;
        Wed, 12 Oct 2022 08:39:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y1-20020a929501000000b002e988fe84d1sm5805274ilh.58.2022.10.12.08.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:39:58 -0700 (PDT)
Message-ID: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
Date:   Wed, 12 Oct 2022 09:39:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] power: cpupower: utils: Optimize print_online_cpus and
 print_offline_cpus function
To:     Li kunyu <kunyu@nfschina.com>, trenn@suse.com, shuah@kernel.org,
        ray.huang@amd.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221012101039.3142-1-kunyu@nfschina.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221012101039.3142-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/22 04:10, Li kunyu wrote:
> 1. Remove the initialization assignment of variables, and they will be
> assigned first.
> 2. Remove the mandatory conversion of returned value of malloc function,
> which returns void* type.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Can you tell me more about why this change is needed and how you determined
the need for this change?

thanks,
-- Shuah

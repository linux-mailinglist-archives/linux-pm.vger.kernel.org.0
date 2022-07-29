Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2F585518
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jul 2022 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiG2Sp3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jul 2022 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiG2Sp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2022 14:45:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6809220E6;
        Fri, 29 Jul 2022 11:45:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso9201095pjr.2;
        Fri, 29 Jul 2022 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c2EeijBCD5jUawkN2N+G+cRbwnfPrl4CcGCf6KqN3lo=;
        b=nj1dVE9U/6wk/Ik+GunR7coAPp8n0lglv3pUgjOO9utY20bdpgHD0T2yKlJ2v5c6LL
         kor6XJHPyQ9mDF7s8jBN2mex0sPIrSAXsZsYU/BaC/tI8EZmkO3MhHAuhf7+6b/i9fQX
         GGKsRpqJsW9laVPAyMfVP0qOOHre3hpBqCW5yYhOpCBmMBioQQPSAKZYNbNiFYB+QS0N
         cDngiKyo+K/mJdVG3jlNmpKC+5FQV6kySipykg/XGSi21TNnvU04MV6ER5Wqfxe2nGCn
         iSfakTaO9F6+NZORPSQTDQQGRv0cUV7LbzvbaV2N6TZKUH3LJ+EbwpqtSySNOqYRY3ws
         Hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c2EeijBCD5jUawkN2N+G+cRbwnfPrl4CcGCf6KqN3lo=;
        b=bq9B/eyRGPOpBudXqbVu6G7kRhWTin8HZhlvDU6lud8pe3igjsJ4ecYue3MdnwVdaa
         QsvPHUvISYubScCagVHPVyeSaFZXCWWEPGyvnNl1DSPXRPY7RvQJJIacqmNO+Iy77CnK
         xISe8EIaF3VbagfJW2No1BfA8Dj4S+N13ELlAbd2G3tgv5fIa84wnT6fhdJKKKZLpDEP
         tcpq/6y681JiWSj28Dt0GZIAJDSErzo6LY/elz+qdUTWPL1rJAvV3HdyknMQHyPbLl7T
         cB50iCsEXK6LnaznfBLP/4KKEX6AB8hO8hnMQnKRvfoMw276T1VeLbE74sZq47TSoCVu
         Gcqw==
X-Gm-Message-State: ACgBeo2xS/sbn2yKeQJn/he/5iyuteWzLCDBvvMxHFtgabF0v3oDK6ds
        UMOxmIdOrSziiWzmJAQLd5bDKZKU47Q=
X-Google-Smtp-Source: AA6agR7AJqk8Zo4pAhdk4DchNvrL1/Rf6CZo1y3t5iRdFp/ks1c/asvYiC6tU0ijzEVjuhnOiw0FHA==
X-Received: by 2002:a17:90b:3c2:b0:1f3:19ea:952 with SMTP id go2-20020a17090b03c200b001f319ea0952mr5693204pjb.158.1659120327144;
        Fri, 29 Jul 2022 11:45:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h15-20020a17090a050f00b001f30f823145sm5686760pjh.55.2022.07.29.11.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 11:45:26 -0700 (PDT)
Message-ID: <7d9607ed-f8eb-f3a2-22e4-4d2a240919c9@gmail.com>
Date:   Fri, 29 Jul 2022 11:45:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
 <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/28/22 02:20, Dmitry Baryshkov wrote:
> On Thu, 28 Jul 2022 at 12:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:
>>> To ease debugging of PSCI supported features, add debugfs file called
>>> 'psci' describing PSCI and SMC CC versions
>>
>> These 2 are for sure in the boot log. Having them is debugfs accessible
>> via file system add not much value as we would hit issues quite early in
>> the boot for most of the things related to PSCI.
> 
> Yes, it was just to have all the information in a single place.
> 
>>> enabled features and options.
>>>
>>
>> We have psci_checker.c which does some minimal testing of PSCI. I prefer
>> to add things to that rather than a debugfs as it is run during boot. IMO
>> it is usual useful to debug things that cause boot issue most of the time.
>> I am not against this so I will leave it to the maintainers.
> 
> In my case I was not debugging the boot issues (which of course would
> have required a different approach), but I was trying to understand
> runtime capabilities, thus debugfs fits pretty well.
> 
> Another point for the debugfs entry: most of the people run the kernel
> with the psci_checker being turned off, but with debugfs being
> enabled. If we are trying to narrow down firmware capabilities of the
> random device, it is much easier to ask them to cat the dbeugfs file
> rather than to rebuild the kernel.
> 

Yes I would agree with both of those points, in fact, I would go one step further and add the ability to probe an arbitrary PSCI function ID, since deployed firmware typically go beyond the standard PSCI scope and implement a variety of custom extensions (at least we do).

Thanks!
-- 
Florian

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD8577B1E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 08:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGRGfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGRGe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 02:34:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9B1705B
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 23:34:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 70so9813180pfx.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 23:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=S53fMGJ7d0alkGH+ulDHUMvLnCp992Os4EhV2Z3Vc40=;
        b=M1l54ay5r+9gA9iDuaHbt1PXGuBvWNoVXchA6ROAr9TQBryZ/CnJ26PZqZRccKEw4F
         qpe7QC3e78ETuC7W0zUIq8rTKN5Bm06w3EcK6mCKGQS6xXbqBtsGrQu0QQ74PuZtvSsc
         qRszhWok/lhvP62IiaQe5fnEcON/JE2Y+eYAa66B1gTDq9FWgJ7Mq68vPGLtXdxlPA2B
         Hc5p1nJTqiEnSkLEFrgZKejU4Z3AwCBcvjAf4CrmoGJ9y8hv3985HLS8OQfuS0OH987w
         adk450PypM9EmJCQMDmD4QonB6k4lTIh+8BOVd2RiWR8xg9SR4MkuR0dy17m8ewbiFrh
         ruzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=S53fMGJ7d0alkGH+ulDHUMvLnCp992Os4EhV2Z3Vc40=;
        b=Xibru//J0T4QCriJ2+vsWMKpk8mY9MGjmcuC65NqBKAm8ajDOM4kL/FcCF8j41OLi5
         FWfqCrwwpjFmN3fpzTgPOAm3oO01aU5elBwPK3ffu9PtfJDMRi27mqOaX4coFTAnzm/C
         fzJgZI2T5SEmNJkbTK94YV5AyTT6zuvC4/dtjMTDAS7RoPaGa/agZbkXg5NCw/F47vh+
         KPH3hoj17taPF5AWIV8qo8qVTuNnaMwG6pCq1cLUVpQVp88GoOQUNfYrZWRm/2DKLsxB
         /9wrgBUfn7wHc4vM8asqhwIYoOLVlbb/uksrww9Xyi00FhSDuNokszCzgxhe7BvslOFo
         780A==
X-Gm-Message-State: AJIora+RYVKvM7oOGeh7bPF7s1NGd9EWHNpyI8U32pvGNIEu23crl5xM
        bFeWEFGe0pLJgyhpnSk6F0ei7Q==
X-Google-Smtp-Source: AGRyM1vCzFhCX7Lu9ii1ZswpntAQGPAzMIjvRI4RiX/q+ZNlfw66sJWMpfTMSfuV62G0Npoa9ua7MQ==
X-Received: by 2002:a65:5b8e:0:b0:41a:3c3:b693 with SMTP id i14-20020a655b8e000000b0041a03c3b693mr7425087pgr.84.1658126095722;
        Sun, 17 Jul 2022 23:34:55 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id t13-20020a62d14d000000b00528a4238eadsm8547021pfl.13.2022.07.17.23.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 23:34:55 -0700 (PDT)
Message-ID: <e69cb444-2bee-870e-08ca-bbe3237d8166@linaro.org>
Date:   Mon, 18 Jul 2022 12:04:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   bhupesh.sharma@linaro.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
 <09ff7e3a-7dd5-db35-3795-89151afb5363@somainline.org>
In-Reply-To: <09ff7e3a-7dd5-db35-3795-89151afb5363@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,

On 7/15/22 8:26 PM, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
> 
> 
> On 1.07.2022 16:58, Bhupesh Sharma wrote:
> > Since for some QCoM tsens controllers, its suggested to
> > monitor the controller health periodically and in case an
> > issue is detected, to re-initialize the tsens controller
> > via trustzone, add the support for the same in the
> > qcom tsens driver.
> >
> > Note that Once the tsens controller is reset using scm call,
> > all SROT and TM region registers will enter the reset mode.
> >
> > While all the SROT registers will be re-programmed and
> > re-enabled in trustzone prior to the scm call exit, the TM
> > region registers will not re-initialized in trustzone and thus
> > need to be handled by the tsens driver.
> >
> > Cc: Amit Kucheria <amitk@kernel.org>
> > Cc: Thara Gopinath <thara.gopinath@gmail.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> Hi, I think this should be also checked and applied on init. This
> seems required for at least SM6375, as the controller starts (or
> well, doesn't start...) in an unknown state and the driver does
> not like it, as the TSENS_EN indicates it is disabled.
> Downstream runs this right at probe..

Hmm.. very interesting. I was not aware of the SM6375 case, as for SM8150
the controller starts in a valid state but may require reinit during operation.

So, I did not use the downstream approach to do it right at _probe() and then
later while get_temp() is called.

Let me add that in v2. BTW do you want me to set the need_reinit_wa as true
for SM6375 as well, or would you like to add that with a followup-patch ?

Regards,
Bhupesh

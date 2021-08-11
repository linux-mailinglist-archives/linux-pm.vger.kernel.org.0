Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAB3E9533
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhHKQBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhHKQBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 12:01:53 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBCC061765
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 09:01:29 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id u7so3384617ilk.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpQ2dLv+2SjFcyqbYfDN7mG4T0+fjj/loOOi4F/ipD0=;
        b=qyUsl8HOAQQACRIgrks20oXy9akLx0j/r5f47uLHcZwVs88sAABYQ48DyeMxpcaqIt
         ObXD50Mkt7uzzdP9/0oJza+HkGthD7WTi6yfmRMGXLl4reu5edFTThKhUqOoBlGr44vC
         Ksx800E2qsmf7hAn5kbHadKEmo7MNuQAtU4dfThd9Uiz3Fk+oZozltnm8NAtrgGU4ahw
         OCC2loltLmBY1gElRdRKZdyRkGxUtFm3/oPi4G7LAma0egp2fh27XRaMZ98/f6JPlPOa
         DeS0vQS4q+SNlsxhqUrx+RMYV7S5+osPruLfIIHcWhI711n2HQOzEHYnrYbbRuZQtp6P
         8+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpQ2dLv+2SjFcyqbYfDN7mG4T0+fjj/loOOi4F/ipD0=;
        b=MopITTI1Y7vXRf/eCJkX4BEPX4ZjaASmwgWfzLIc2PLslu2xgQPFX5X9V5R9Epa/TE
         O2fhVBZP1kNE5v1WUQeFQPBpFK7cYGh1iEec2QIuIFxjAJaXekZHJvZy9wUCAFZeQOnS
         uYxX0Bk89szSPAM+3VAIYzAeVV0g/40mN7EBNtc1fVQCx1f9AcWVxdczdQy2DQwCXo9C
         cJyPNj7LeL6/wqFxN0jZs+6vFog37D7L2bmsXM+81R66/7lN0pqC8ICIALb/nmdzPCbW
         cLYFqBpwVkSqNZp04NzfLWqxJzK+K7+4ENdW+zgv2gF9SxiQuepDyaFitL37aMzk5nKS
         GQmw==
X-Gm-Message-State: AOAM530jlW4rNYNp83+a6LV1mpKBVara5iivfd8RiqOyN67pBpyc3h0y
        AKHx59GxEFUFfG/c+QWY0iAXaQ==
X-Google-Smtp-Source: ABdhPJx4Wot4dAtvTIms/jBsHD8DZG6O8NChmPK1UElb7ftiVhsv01y5eaDdKeWwExu6g66SfrcIXQ==
X-Received: by 2002:a05:6e02:1d96:: with SMTP id h22mr252575ila.294.1628697689303;
        Wed, 11 Aug 2021 09:01:29 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t3sm6527418ilg.41.2021.08.11.09.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 09:01:28 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Stephen Boyd <swboyd@chromium.org>,
        Mike Tipton <mdtipton@codeaurora.org>, djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org>
 <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <0e659a74-ba52-2262-f7ce-eddf4a655b63@linaro.org>
Date:   Wed, 11 Aug 2021 11:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/10/21 6:31 PM, Stephen Boyd wrote:
> Quoting Mike Tipton (2021-07-21 10:54:32)
>> We're only adding BCMs to the commit list in aggregate(), but there are
>> cases where pre_aggregate() is called without subsequently calling
>> aggregate(). In particular, in icc_sync_state() when a node with initial
>> BW has zero requests. Since BCMs aren't added to the commit list in
>> these cases, we don't actually send the zero BW request to HW. So the
>> resources remain on unnecessarily.
>>
>> Add BCMs to the commit list in pre_aggregate() instead, which is always
>> called even when there are no requests.
>>
>> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
> 
> This patch breaks reboot for me on sc7180 Lazor

If I am using the interface improperly or something in the
IPA driver, please let me know.  I actually plan to switch
to using the bulk interfaces soon (FYI).

Thanks.

					-Alex

> [  107.136454] kvm: exiting hardware virtualization
> [  107.163741] platform video-firmware.0: Removing from iommu group 13
> [  107.193412] SError Interrupt on CPU1, code 0xbe000011 -- SError
> [  107.193428] CPU: 1 PID: 4289 Comm: reboot Not tainted 5.14.0-rc1+ #12
> [  107.193432] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> [  107.193436] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO BTYPE=--)
> [  107.193440] pc : el1_interrupt+0x20/0x60
> [  107.193443] lr : el1h_64_irq_handler+0x18/0x24
> [  107.193445] sp : ffffffc014093a10
> [  107.193448] x29: ffffffc014093a10 x28: ffffff8088295ec0 x27: 0000000000000000
> [  107.193465] x26: ffffff8080ed4c18 x25: ffffffd0beece000 x24: ffffffd0bef45000
> [  107.193476] x23: 0000000060400009 x22: ffffffd0be0bc1a0 x21: ffffffc014093b90
> [  107.193487] x20: ffffffd0bdc100f8 x19: ffffffc014093a40 x18: 000000000007d829
> [  107.193497] x17: ffffffd067412b54 x16: ffffffd0be0bc164 x15: ffffffd067413d0c
> [  107.193507] x14: ffffffd0bdd24fa4 x13: ffffffd0bdc26180 x12: ffffffd0bdc26260
> [  107.193517] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [  107.193528] x8 : 00000000000000c0 x7 : bbbbbbbbbbbbbbbb x6 : ffffffd0bde488dc
> [  107.193539] x5 : 0000000000200017 x4 : ffffff809b5c4b40 x3 : 0000000000200018
> [  107.193549] x2 : ffffff8088295ec0 x1 : ffffffd0bdc100f8 x0 : ffffffc014093a40
> [  107.193561] Kernel panic - not syncing: Asynchronous SError Interrupt
> [  107.193564] CPU: 1 PID: 4289 Comm: reboot Not tainted 5.14.0-rc1+ #12
> [  107.193567] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> [  107.193570] Call trace:
> [  107.193573]  dump_backtrace+0x0/0x1c8
> [  107.193577]  show_stack+0x24/0x30
> [  107.193579]  dump_stack_lvl+0x64/0x7c
> [  107.193582]  dump_stack+0x18/0x38
> [  107.193584]  panic+0x158/0x39c
> [  107.193586]  nmi_panic+0x88/0xa0
> [  107.193589]  arm64_serror_panic+0x80/0x8c
> [  107.193593]  do_serror+0x0/0x80
> [  107.193595]  do_serror+0x58/0x80
> [  107.193597]  el1h_64_error_handler+0x30/0x48
> [  107.193601]  el1h_64_error+0x78/0x7c
> [  107.193603]  el1_interrupt+0x20/0x60
> [  107.193606]  el1h_64_irq_handler+0x18/0x24
> [  107.193609]  el1h_64_irq+0x78/0x7c
> [  107.193612]  refcount_dec_and_mutex_lock+0x3c/0xb4
> [  107.193616]  ipa_clock_put+0x34/0x74 [ipa]
> [  107.193619]  ipa_deconfig+0x64/0x74 [ipa]
> [  107.193622]  ipa_remove+0xbc/0x110 [ipa]
> [  107.193625]  ipa_shutdown+0x24/0x50 [ipa]
> [  107.193628]  platform_shutdown+0x30/0x3c
> [  107.193631]  device_shutdown+0x150/0x208
> [  107.193633]  kernel_restart_prepare+0x44/0x50
> [  107.193637]  kernel_restart+0x24/0x70
> [  107.193640]  __arm64_sys_reboot+0x188/0x230
> [  107.193643]  invoke_syscall+0x4c/0x120
> [  107.193646]  el0_svc_common+0x84/0xe0
> [  107.193648]  do_el0_svc_compat+0x2c/0x38
> [  107.193651]  el0_svc_compat+0x20/0x30
> [  107.193654]  el0t_32_sync_handler+0xc0/0xf0
> [  107.193657]  el0t_32_sync+0x19c/0x1a0
> 
> Presumably some sort of interconnect is getting turned off earlier than
> before?
> 
>>   drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index f118f57eae37..b26fda0588e0 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -20,13 +20,18 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
>>   {
>>          size_t i;
>>          struct qcom_icc_node *qn;
>> +       struct qcom_icc_provider *qp;
>>
>>          qn = node->data;
>> +       qp = to_qcom_provider(node->provider);
>>
>>          for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>                  qn->sum_avg[i] = 0;
>>                  qn->max_peak[i] = 0;
>>          }
>> +
>> +       for (i = 0; i < qn->num_bcms; i++)
>> +               qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
>>
>> @@ -44,10 +49,8 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>   {
>>          size_t i;
>>          struct qcom_icc_node *qn;
>> -       struct qcom_icc_provider *qp;
>>
>>          qn = node->data;
>> -       qp = to_qcom_provider(node->provider);
>>
>>          if (!tag)
>>                  tag = QCOM_ICC_TAG_ALWAYS;
>> @@ -67,9 +70,6 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>          *agg_avg += avg_bw;
>>          *agg_peak = max_t(u32, *agg_peak, peak_bw);
>>
>> -       for (i = 0; i < qn->num_bcms; i++)
>> -               qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
>> -
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_icc_aggregate);


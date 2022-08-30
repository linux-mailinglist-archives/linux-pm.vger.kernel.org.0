Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D322A5A66A1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiH3OuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH3OuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 10:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539229C9B
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661871016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMgyN7KKHWBc6kUGC15Kytgi5k1dgZDjjbRIKs56ZQU=;
        b=C6p1nNLFgrcA1w0GbS/hl+g3E7HFQ6mT+ZYW+h3hWuiVc6T198TSdYuyuyq8r6IaeWK3eO
        U7e3vypJvc1JM4dpQmTILvPWYS+azYEXVf35Dk2m20bVwiq85mSRvIPjkyU0pCGOz5WRvM
        R34xHKOWa62hPGnpB4Kfak8HbtfSqDw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-kRWSFjNkO-CD1UfNLBAngA-1; Tue, 30 Aug 2022 10:50:13 -0400
X-MC-Unique: kRWSFjNkO-CD1UfNLBAngA-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso7555102edd.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 07:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HMgyN7KKHWBc6kUGC15Kytgi5k1dgZDjjbRIKs56ZQU=;
        b=KthpJM8OB78PjOyoV+Eb0UjyFuDxqGLm5upwYDFQwlSDPGu9GBoRs414OQw9ejAQUX
         4x43OIFRls+WVgDEhlH1ux6NXRLIri05kPrZt5pon70jxbhTSWPBghtchP3+JL6KhQ1H
         5lvxBLveGQj/18qonBiyJVIcO9gmuCt6fMLXW3wL2/B7+5S3cp0qLHBSNi9Am+t8ao4d
         PN7Y7sT5IC9xSx5L0ExqdxbPpz15seVAeW/CKdmr+zLJjD0fW7ZsI6XkfDBVvio0QEzn
         X2bImE2wJlNkev4soG10D4zeZEiuumuTV4mfXcroqhXzZ3nlUe87e/9Zpsv0sUDoRrqx
         oVKg==
X-Gm-Message-State: ACgBeo28V5ynBVUJFOYuug410v+JLxkf3Vil8wletLgBBWNUWTJvUeIO
        71NHC4b/jTRTxzufh3mNAZZHRyaBxYsCeYgkBFhFtWHYWdutoYz3KiuSIQadc//TD7x1oAWIJEx
        2oIWqjUm8B0ZN3zwJPEE=
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr15573485ejc.662.1661871012678;
        Tue, 30 Aug 2022 07:50:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5omIkQ2qHqLmuqgyMe1PNn8uLAHaQevnuGthpAqxbWhHzzxKNQ3+sDD48V+F3pjaJ0FAceAQ==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr15573463ejc.662.1661871012430;
        Tue, 30 Aug 2022 07:50:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906315a00b007417041fb2bsm3576629eje.116.2022.08.30.07.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 07:50:11 -0700 (PDT)
Message-ID: <6ecd5694-cb60-dda2-5092-cf14920c5877@redhat.com>
Date:   Tue, 30 Aug 2022 16:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] ACPI: s2idle: Add a new ->check() callback for
 platform_s2idle_ops
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20220829162953.5947-1-mario.limonciello@amd.com>
 <20220829162953.5947-2-mario.limonciello@amd.com>
 <CAJZ5v0iF1_MUptawLL4DD0RqZpysH2B+Pk5sj_=gLv9AOVdy=Q@mail.gmail.com>
 <88b5f4aa-d238-efb6-82fd-e227c42cc10c@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <88b5f4aa-d238-efb6-82fd-e227c42cc10c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/30/22 13:42, Limonciello, Mario wrote:
> On 8/30/2022 06:39, Rafael J. Wysocki wrote:
>> On Mon, Aug 29, 2022 at 6:29 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> On some platforms it is found that Linux more aggressively enters s2idle
>>> than Windows enters Modern Standby and this uncovers some synchronization
>>> issues for the platform.  To aid in debugging this class of problems in
>>> the future, add support for an extra optional callback intended for
>>> drivers to emit extra debugging.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> and I'm assuming that this is for Hans.
> 
> Thanks, and yeah I think it makes more sense for this to go through platform-x86.

Ok, I will review 2-4 and merge the entire series
through platform-x86.

Regards,

Hans


> 
>>
>>> ---
>>> v2->v3:
>>>   * Rename to *check
>>> v1->v2:
>>>   * Add a prototype for `acpi_s2idle_enter`
>>>
>>>   drivers/acpi/sleep.h      |  1 +
>>>   drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
>>>   include/linux/acpi.h      |  1 +
>>>   include/linux/suspend.h   |  1 +
>>>   kernel/power/suspend.c    |  3 +++
>>>   5 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
>>> index 7fe41ee489d6..d960a238be4e 100644
>>> --- a/drivers/acpi/sleep.h
>>> +++ b/drivers/acpi/sleep.h
>>> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>>>   extern int acpi_s2idle_begin(void);
>>>   extern int acpi_s2idle_prepare(void);
>>>   extern int acpi_s2idle_prepare_late(void);
>>> +extern void acpi_s2idle_check(void);
>>>   extern bool acpi_s2idle_wake(void);
>>>   extern void acpi_s2idle_restore_early(void);
>>>   extern void acpi_s2idle_restore(void);
>>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>>> index f9ac12b778e6..474aa46f82f6 100644
>>> --- a/drivers/acpi/x86/s2idle.c
>>> +++ b/drivers/acpi/x86/s2idle.c
>>> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>>>          return 0;
>>>   }
>>>
>>> +void acpi_s2idle_check(void)
>>> +{
>>> +       struct acpi_s2idle_dev_ops *handler;
>>> +
>>> +       if (!lps0_device_handle || sleep_no_lps0)
>>> +               return;
>>> +
>>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>>> +               if (handler->check)
>>> +                       handler->check();
>>> +       }
>>> +}
>>> +
>>>   void acpi_s2idle_restore_early(void)
>>>   {
>>>          struct acpi_s2idle_dev_ops *handler;
>>> @@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>>>          .begin = acpi_s2idle_begin,
>>>          .prepare = acpi_s2idle_prepare,
>>>          .prepare_late = acpi_s2idle_prepare_late,
>>> +       .check = acpi_s2idle_check,
>>>          .wake = acpi_s2idle_wake,
>>>          .restore_early = acpi_s2idle_restore_early,
>>>          .restore = acpi_s2idle_restore,
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index 6f64b2f3dc54..acaa2ddc067d 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -1075,6 +1075,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>>>   struct acpi_s2idle_dev_ops {
>>>          struct list_head list_node;
>>>          void (*prepare)(void);
>>> +       void (*check)(void);
>>>          void (*restore)(void);
>>>   };
>>>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>>> index 70f2921e2e70..03ed42ed2c7f 100644
>>> --- a/include/linux/suspend.h
>>> +++ b/include/linux/suspend.h
>>> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>>>          int (*begin)(void);
>>>          int (*prepare)(void);
>>>          int (*prepare_late)(void);
>>> +       void (*check)(void);
>>>          bool (*wake)(void);
>>>          void (*restore_early)(void);
>>>          void (*restore)(void);
>>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>>> index 827075944d28..c6272d466e58 100644
>>> --- a/kernel/power/suspend.c
>>> +++ b/kernel/power/suspend.c
>>> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>>>                          break;
>>>                  }
>>>
>>> +               if (s2idle_ops && s2idle_ops->check)
>>> +                       s2idle_ops->check();
>>> +
>>>                  s2idle_enter();
>>>          }
>>>
>>> -- 
>>> 2.34.1
>>>
> 


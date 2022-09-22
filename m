Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62565E68EB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIVQ54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIVQ5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 12:57:37 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53339F50B5
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 09:57:34 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeef8.dynamic.kabel-deutschland.de [95.90.238.248])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BF48261EA192A;
        Thu, 22 Sep 2022 18:57:31 +0200 (CEST)
Message-ID: <520d0a5b-cbae-554c-4905-5a68cc5f5ca6@molgen.mpg.de>
Date:   Thu, 22 Sep 2022 18:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
Cc:     linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: New error in 5.15: ACPI BIOS Error (bug): Could not resolve symbol
 [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Linux folks,


Moving from Linux 5.10.113 to 5.15.69 on

     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 
2.22.0 07/13/2022
     […]
     [    1.521806] smpboot: CPU0: Intel(R) Core(TM) i7-7700 CPU @ 
3.60GHz (family: 0x6, model: 0x9e, stepping: 0x9)

Linux logs the errors below:

```
$ dmesg --level=err
[    2.782085] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.792412] ACPI Error: Aborting method \_PR.CPU1._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.807882] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.818223] ACPI Error: Aborting method \_PR.CPU2._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.833675] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.844003] ACPI Error: Aborting method \_PR.CPU3._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.859452] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.869776] ACPI Error: Aborting method \_PR.CPU4._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.885227] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.895552] ACPI Error: Aborting method \_PR.CPU5._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.911018] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.921343] ACPI Error: Aborting method \_PR.CPU6._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
[    2.936810] ACPI BIOS Error (bug): Could not resolve symbol 
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
[    2.947136] ACPI Error: Aborting method \_PR.CPU7._CPC due to 
previous error (AE_NOT_FOUND) (20210730/psparse-529)
```

Any idea, where that comes from? We only build intel_pstate, but it was 
also selected in Linux 5.10.113.

     $ grep PSTATE /boot/config-{5.10.113,5.15.69}*
     /boot/config-5.10.113.mx64.434:CONFIG_X86_INTEL_PSTATE=y
     /boot/config-5.15.69.mx64.436:CONFIG_X86_INTEL_PSTATE=y


Kind regards,

Paul

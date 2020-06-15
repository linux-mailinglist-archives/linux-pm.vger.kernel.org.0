Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21141F8CE3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgFOEQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 00:16:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48768 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgFOEQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 00:16:25 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jkgXn-00088v-G3
        for linux-pm@vger.kernel.org; Mon, 15 Jun 2020 04:16:23 +0000
Received: by mail-pl1-f197.google.com with SMTP id m4so10461880pll.11
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2020 21:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dTUAMfA6Yb9JJ+DBqyoqUUgohjM4Kq4zP1H07PbLT8=;
        b=CuYlSwgIRYI9shRnHDdRa2IkG6sWuZ2DxNkRpRDqrv6aMd+5HWTHMB7ywLYMQD2ORX
         wtlE/qKmijr/U0OspLLh3/9Q+r2h1hfExp9TS828ON6tsEpI3vu3OEatPAIhP3ohMEUm
         1m3kpIk69uqQJ2irjoFkzxdySpGyf6ThFOc2OTJR/fw+1PaJfZ0K+uquqcahINqXd2m1
         5nzNZpiRcKyh4HSnr+N3P5oNZ3mcNj/CCznEiB9T4RTJcE3RRkAiA+LDQMUOkUDZVp5g
         hnHNoBx4G1yqCrCxeoyF7mtb8+1yiK1ZEgdx5ckVZeOjw/+xouGEEa+ibw0hHh2Maczu
         OT5A==
X-Gm-Message-State: AOAM532EBS7MI7yJcJY5Z/IRHJEATkyJYcxBRC2qWafHTZBU8ahwUFsO
        o3ko/uQhtES/x/+MPj0wa1CSGmNGESFeca4ajaxrJu1EMLy9fFJ/KFd/Q42Nn1ff7+e3MubTALJ
        VLuXR0lOPF3592ZvwsZnpy2lb3qR/uTJKA5iJ
X-Received: by 2002:a17:90a:bd09:: with SMTP id y9mr211307pjr.233.1592194582007;
        Sun, 14 Jun 2020 21:16:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOmA48BIP38b7J4IRdVrhi/5oTUccYifP9mArMiAlsamlbQPCY6fEV2UFefjL58tVP051eCw==
X-Received: by 2002:a17:90a:bd09:: with SMTP id y9mr211288pjr.233.1592194581662;
        Sun, 14 Jun 2020 21:16:21 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id 1sm12311083pfx.210.2020.06.14.21.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 21:16:20 -0700 (PDT)
Subject: Re: [THERMAL] INT3403 and new 0x91 thermal events in dmesg
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <ee531821-83f1-2c80-4e2c-b2a359af7583@canonical.com>
 <779a84cab9e01cbb8cafaea59ead79b26a2573df.camel@intel.com>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <990f39d9-82b8-73fe-e956-f5d7423a0616@canonical.com>
Date:   Sun, 14 Jun 2020 22:16:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <779a84cab9e01cbb8cafaea59ead79b26a2573df.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-13 8:44 p.m., Zhang Rui wrote:
> On Fri, 2020-06-12 at 15:02 -0600, Alex Hung wrote:
>> Hi,
>>
>> A user reported int3403 was flooding his dmesg like following
>>
>> [ 8.112761] int3403 thermal INT3403:00: Unsupported event [0x91]
>> [ 10.121722] int3403 thermal INT3403:00: Unsupported event [0x91]
>> [ 12.165233] int3403 thermal INT3403:00: Unsupported event [0x91]
>>
>> Buglink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1882823
>>
>> In int3403_thermal.c the events are defined up to
>> INT3403_THERMAL_EVENT
>> (0x90), and thus int3403 complains 0x91 is not supported.
>>
>> I did a quick search online and found this is not the only case:
>> https://www.spinics.net/lists/ibm-acpi-devel/msg04629.html (though
>> the
>> 0x91 was unrelated to this problem).
>>
>> This is likely a new feature in int3403 but I wasn't able to find any
>> specifications or documents. Does anyone know what it is and how this
>> can be added to int3403_thermal.c ?
>>
> I'm not sure if this is a new feature that we have to support or not,
> but before that, we can downgrade the error message just like what we
> did in 44c0c23725a1("drivers: thermal: processor_thermal: Downgrade
> error message").

Thanks for suggestions. I will send a patch to downgrade the error message.

Would it be a good idea to cc stable?


Cheers,
Alex Hung

> 
> thanks,
> rui
> 
> 

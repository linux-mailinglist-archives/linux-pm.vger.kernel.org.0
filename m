Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5275BB803
	for <lists+linux-pm@lfdr.de>; Sat, 17 Sep 2022 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIQLmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Sep 2022 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIQLmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Sep 2022 07:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8532FFEC
        for <linux-pm@vger.kernel.org>; Sat, 17 Sep 2022 04:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663414938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzetDHPEuYHOyKUUGQoVLG/7B0wMNg9j9zSS25jq5MM=;
        b=QVva219ELGYTWlE8WGRxOhArZZPkk/7IVZjTMaMAeq04Eft3F5H+Pjxqfob4A9LslUELQt
        HAP4V2p0zYFJVO+lWiexTiiwDJoCy6JL3R3KDU1zJHVhdW4yfwaqyIHvhar19IHUnkaCvi
        nlWkniaXylF55E58fl5lXhDcc0M2kmo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-9hkdRFboPWe2zCHF5019sg-1; Sat, 17 Sep 2022 07:42:16 -0400
X-MC-Unique: 9hkdRFboPWe2zCHF5019sg-1
Received: by mail-ed1-f71.google.com with SMTP id b17-20020a056402351100b00453b19d9bd0so332853edd.4
        for <linux-pm@vger.kernel.org>; Sat, 17 Sep 2022 04:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SzetDHPEuYHOyKUUGQoVLG/7B0wMNg9j9zSS25jq5MM=;
        b=F5lSbhByEhCu53zmzZJiztyF1FllD5GzVtOp7nGWv9Pqcfe8X2JJ1A/lOaJ5ig16+u
         I18DduwxmrYC5rSXvGHagpa5Mzu2DzGXaTxrx0YzSFJnfulKa9Ta6wR5WvjvC+MdoVLh
         mkoW82sLsgFv9YrwiueqE4YMQ+024xyEzbXl1tgFQ2rS0FDl3lwTmoTFhDskPwa7PH3c
         tviKYtitmDXtvQzywO0nr4L/79J9dlfZSKk1J7awy8dtraqLOjPv26PLG+CInDjTMesH
         2CAliqNW/C5TsOBjwzBv9xLAQ6nDcrBD0m49f4LMZewxIkzdJquqFjz+U2bgdQvkMqdi
         FZZw==
X-Gm-Message-State: ACrzQf2m+JcTDXNbb3iuZL37DmTI3rOb/W9NvHCHHLUQJG6yBmdN9q6F
        //Sdac2L05bRg1u/3fQTn1UpwfvTJjbD+R+GphEuUK0MrZNhyBNUlZaQOu7xsfVtgjMQi3IXj+/
        CQbWeXuv/9fCmTVba8XE=
X-Received: by 2002:a17:907:2d9e:b0:775:3737:ac45 with SMTP id gt30-20020a1709072d9e00b007753737ac45mr6450409ejc.714.1663414935044;
        Sat, 17 Sep 2022 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7oMErWER0UZu2Kpobfn3BHnBemLLcyN70BPZAUhIqgFsMLf6ExJ1mlCXDdXOp6xGiEBjxAdQ==
X-Received: by 2002:a17:907:2d9e:b0:775:3737:ac45 with SMTP id gt30-20020a1709072d9e00b007753737ac45mr6450390ejc.714.1663414934818;
        Sat, 17 Sep 2022 04:42:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b00730b61d8a5esm12095627eju.61.2022.09.17.04.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 04:42:14 -0700 (PDT)
Message-ID: <5097a283-6111-bedc-13c6-61a581f8b72c@redhat.com>
Date:   Sat, 17 Sep 2022 13:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <20220913005053.vk7qmhr6tqqynags@desk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220913005053.vk7qmhr6tqqynags@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/13/22 02:50, Pawan Gupta wrote:
> On Mon, Sep 12, 2022 at 04:38:44PM -0700, Pawan Gupta wrote:
>> Hi,
>>
>> This patchset is to fix the "unchecked MSR access error" [1] during S3
>> resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.
>>
>> Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.
>>
>> Patch 3/3 adds check for feature bit before adding any speculation
>> control MSR to the list of MSRs to save/restore.
>>
>> [1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/
> 
> Added the correct email-id of Hans de Goede <hdegoede@redhat.com>.

I have tested this series and I can confirm that it fixes the exception
which I was seeing on a Packard Bell Dot SC with an Atom N2600 CPU:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


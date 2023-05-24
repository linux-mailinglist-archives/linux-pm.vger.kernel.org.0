Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24870FDE3
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjEXS3D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 14:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjEXS3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 14:29:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D8E7
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 11:29:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-969f90d71d4so183528466b.3
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684952939; x=1687544939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5lgPY1OhSwXtRY0LRAeuO9w0cAYukxFSoQE2BhbX5Y=;
        b=doTct/umbGJ2NGSZfavFJNaiYz8FxhaAljg6NSt6hs8auwjLpc/TxrPJioDpEdbWBx
         aXgmHEME3QkebZ0nmTGnXfR+gHhJlk9NoLlSkefmoipWILRsvUxicr4lfEQv9ry1RMgu
         JpAaVHi6V2YtulRO+hGtCPpcl1AaITS8SCXsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952939; x=1687544939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5lgPY1OhSwXtRY0LRAeuO9w0cAYukxFSoQE2BhbX5Y=;
        b=HmEqmxU9PDmzRfi6TnGPY8limtoRXIe2wBYg9rRcZFbKqY667HpaCyorb3+wJB3qQi
         4iilLGrPrLZaFP3s4IqFbPeXiEsyM44IwkgIftHhdQOIb8k7GJlw4MCOstZNvNgo2PtU
         eiVcsM3VldbwiH5pQfLnxwYZhnk0OCiHpnfBS94igUArfueh2KNenBoEJK5eC78th+3G
         nwu4u1QZXjJiLt7uXRCiJEtzaTsFwZzXLprYq78WHMugd1V/aR6+N283yx2KxG1l3zbd
         8+nLI4EW9sCeFOgEpH2j8sJ/DR2ghknjo5J8pJqwDIw0m2J+mmeULskscHFrNJG8kvL3
         6mHw==
X-Gm-Message-State: AC+VfDzXe18EfCXPMCl9fH3ePwJDqRIcYPMLAww2veQcwMG4iY4n04KG
        VYaAUUpIjvH39KD8ZbwSY8i+RhNdbGFyYofNnhlTP5LI
X-Google-Smtp-Source: ACHHUZ5Izmgmjtk/D7L52Eh1B/knvLuYvNd1FqOG+aRTaek7hKNCTFztYmwupAL5vGZxkfV1x7VLwA==
X-Received: by 2002:a17:907:6d8f:b0:96f:7e14:3084 with SMTP id sb15-20020a1709076d8f00b0096f7e143084mr17732917ejc.44.1684952939404;
        Wed, 24 May 2023 11:28:59 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709067e4e00b00969dfd160aesm6082653ejr.109.2023.05.24.11.28.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:28:58 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96ff9c0a103so187808766b.0
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 11:28:58 -0700 (PDT)
X-Received: by 2002:a17:907:7b8d:b0:92b:3c78:91fa with SMTP id
 ne13-20020a1709077b8d00b0092b3c7891famr20565714ejc.28.1684952938255; Wed, 24
 May 2023 11:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230524131200.0f6fb318@rorschach.local.home>
In-Reply-To: <20230524131200.0f6fb318@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 11:28:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
Message-ID: <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
Subject: Re: [BUG 6.4-rc3] BUG: kernel NULL pointer dereference in __dev_fwnode
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 24, 2023 at 10:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> I started adding fixes to my urgent branch rebased on top of v6.4-rc3
> and ran my tests. Unfortunately they crashed on unrelated code.
>
> Here's the dump:
>
>  BUG: kernel NULL pointer dereference, address: 00000000000003e8
>  RIP: 0010:__dev_fwnode+0x9/0x2a
>  Code: ff 85 c0 78 16 48 8b 3c 24 89 c6 59 e9 e0 f7 ff ff b8 ea ff ff ff =
c3 cc cc cc cc 5a c3 cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 <48> 8b 87 e8 0=
3 00 00 48
>  83 c0 18 c3 cc cc cc cc 48

That disassembles to

    endbr64
    nopl   0x0(%rax,%rax,1)
    mov    0x3e8(%rdi),%rax
    add    $0x18,%rax
    ret

which looks like it must be the

    return dev->fwnode;

with a NULL 'dev'. Which makes sense for __dev_fwnode with CONFIG_OF
not enabled.

Except I have no idea what that odd 'add $0x18" is all about. Strange.

Anyway, the caller seems to be this code in power_supply_get_battery_info()=
:

        if (psy->of_node) {
            .. presumably not this ..
        } else {
                err =3D fwnode_property_get_reference_args(
                                        dev_fwnode(psy->dev.parent),
                                        "monitored-battery", NULL, 0, 0, &a=
rgs);
                ...

so I suspect we have psy->dev.parent being NULL.

>  I ran a bisect and it found it to be this commit:
>
> 27a2195efa8d2 ("power: supply: core: auto-exposure of simple-battery data=
")
>
> I checked out that commit and tested it, and it crashed. I then
> reverted that commit, and the crash goes away.

At a guess, it's

 (a) the new code to expose battery info at registration time:

+       /*
+        * Expose constant battery info, if it is available. While there ar=
e
+        * some chargers accessing constant battery data, we only want to
+        * expose battery data to userspace for battery devices.
+        */
+       if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
+               rc =3D power_supply_get_battery_info(psy, &psy->battery_inf=
o);
+               if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
+                       goto check_supplies_failed;
+       }

interacting with

 (b) the test_power_init() that does that

                test_power_supplies[i] =3D power_supply_register(NULL,
                                                &test_power_desc[i],
                                                &test_power_configs[i]);

which passes in NULL for the "parent" pointer.

So it looks like a dodgy test that was a bit lazy. But maybe a NULL
parent is supposed to work.

                Linus

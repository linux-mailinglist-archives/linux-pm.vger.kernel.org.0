Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2044D5183
	for <lists+linux-pm@lfdr.de>; Thu, 10 Mar 2022 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiCJSoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Mar 2022 13:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCJSoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2022 13:44:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC5101F1E
        for <linux-pm@vger.kernel.org>; Thu, 10 Mar 2022 10:43:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so8983119pjb.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Mar 2022 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tcpBRCafFc96YxnPZZLvkEaHne7CilEHy5P37o4x8ck=;
        b=drKB5SD+IaQ/lbOpJMWzuxBZpu4qNINYeoR9Dfa1/e7QULpShvQXkKLpwkaJsb6VMU
         h7zU3G6FIY+7Sle0SJkKVAHNPiMFZ6bVlATjydENqws5D712HHusL/XiAeDqNOceKXNm
         Rm6fSH1IIcLFr1IM5qO1CJkjOs7r+DfqnjffcTWhx5TJRtjQAMeQqhuwbRGTV5TnMOdn
         4V2l78p5pt6ClktPzOdsl4b7mvQWvLQH9l3Lw62pJTiZ2+jrUXm14SKaZesZpAzFy/oh
         dEIOvI7ua2moWSWIIzIqil/kSW7dYuncbDWtBOobJcTIQVAPUqDyaTM5p6zQdm8Yhkys
         jTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tcpBRCafFc96YxnPZZLvkEaHne7CilEHy5P37o4x8ck=;
        b=GjHMAEvNcEz//bWvAwODsDoCqSW5ux3LhOUXDPyO57i2TezS16A+25BYrze6WZnALo
         2lMt0jiSYevNt92/hWKu+YMhZer2z86f0y+sWyJ7aDcJzrvjYSTXPVSecy2iSTAawXGY
         LYcF0egqQn2HkNiYQ4zz6BZcSyMjHwAmeHVV/cBxon9r4DIgyo+g1T5/1lUr59bCz1Bb
         2tHuRt8TTIghzIYQ/juTAAl6pb7cpCT+D/M3R7L2kg/yawqLx5h2HZ79+jd8KgFkhrPo
         u9Q5N6EIyGjHCvj0aAWX08DO/giP/mHbxSHxRVu2u0VvMXLE5BuXXWPbsmVvxgfrpfkC
         kuTg==
X-Gm-Message-State: AOAM533luTY+mAU9Q1DCrwJcpl6kEYNvp61Cq9aWWo1tWJO076gAEx9p
        p6jaCRdkF84nPBW+dmE0UemgSg==
X-Google-Smtp-Source: ABdhPJy7mK7tcW9bJZHWeSSSFfJysyM03XwzSfo27k2AdDj7qjT5wZlQfOtMqBxnANvtn5ZXO39LUQ==
X-Received: by 2002:a17:903:1108:b0:151:9c42:7d1 with SMTP id n8-20020a170903110800b001519c4207d1mr6587067plh.54.1646937799272;
        Thu, 10 Mar 2022 10:43:19 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm10434790pjs.7.2022.03.10.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:43:18 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:43:18 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 09:32:08 PST (-0800)
Subject:     Re: [PATCH v11 1/8] RISC-V: Enable CPU_IDLE drivers
In-Reply-To: <CAK9=C2VzzT=GDyuptuxQj0y++Rb0SaZXCuoL1+ncpGWcYHqr1g@mail.gmail.com>
CC:     pavel@ucw.cz, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        milun.tripathy@gmail.com, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush@allwinnertech.com, anup@brainfault.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, guoren@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     pavel@ucw.cz, apatel@ventanamicro.com
Message-ID: <mhng-203b51aa-0594-403c-9b79-2eb763fabfd3@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 12 Feb 2022 04:49:46 PST (-0800), apatel@ventanamicro.com wrote:
> On Sat, Feb 12, 2022 at 5:13 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Hi!
>>
>> > From: Anup Patel <anup.patel@wdc.com>
>> >
>> > We force select CPU_PM and provide asm/cpuidle.h so that we can
>> > use CPU IDLE drivers for Linux RISC-V kernel.
>> >
>> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> > Signed-off-by: Anup Patel <apatel@vetanamicro.com>
>>
>> This is quite... interesting. Normally we have one signoff per
>> person...
>
> I was working for Western Digital (WDC) when I first submitted this
> series and recently I joined Ventana Micro Systems.

IIUC that's the correct way to go about this, it's certainly what I'd 
do.

>
> Regards,
> Anup
>
>>
>> Best regards,
>>                                                         Pavel
>> --
>> http://www.livejournal.com/~pavelmachek

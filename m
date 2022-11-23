Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536D6350FE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiKWHNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 02:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbiKWHNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 02:13:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F128E32
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 23:13:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f27so40831713eje.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdDiHpd9Kd9wLkqIN62CS8fwFdp78b61LCL8QytS/8I=;
        b=x7pPUQ2U0p2bHuzqL/arrNulgTqt2APW4k9iWzEU3nxpDTdXuOdRrmp5yQIeZ660qi
         YvylxMD8XVpn+79swn3uCU9SFhF6xlhVtakuDT+pplxJaJzCcNkcXqZ4y9peYSnle3Ao
         0wvJ7josxI/Gd5d/+Ls59YgrF7kTgdEqAcql0vc8wWLkcDd6qSFxP8cw7LnhzfecsqLU
         x170/jwYDLkszQoW2SnzC45hHKJuJpKznjj2FyD1urEZy5F5QisBPBq09Axe8LjJQ8uV
         6J4lYUfH0EW/uBAPtTNY15ff1QfFAz62vNTylFH2Rf/3CfRlilPeBLCjWw8ZMpCylTON
         xn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdDiHpd9Kd9wLkqIN62CS8fwFdp78b61LCL8QytS/8I=;
        b=kPGkuCy0wcqMARRU1Vt9wUHpyAs2w1TRgnvaJnh8tHDyaqf5d4jrd4yeqlYBeZw1LR
         IZ7SLuUCqmj2ykVlY2sYCqBpL/tcsmsSfJ5MZRp/dZOWnk3f7HxeEySE9pRkfO8K3R7q
         xPRCNrraMfKQ8DvMyPd634ZFJO7ZBLTrbmw/x3h+LReFbGkVxjo5IpDLO87wmbhA23Un
         vq9BvraDzfE/r2eAxMX5RrRpnKNQgF/LD9+vwr19v7goQy6KtQYOvC5AJplz3pRgrTzx
         FI2jzQviFuwJxoAWQrOX/DaOdfIW+yDxRHLCTdqzGF33WPAMFqzwH1N9KJvIy/IuhyBl
         1xtw==
X-Gm-Message-State: ANoB5pkrjPIWhRAQLi5+WMZYKYz/Cfv7ve+ezgLx/TvtAj6HXHiSXUaq
        Hs2pJyDb4uDgh3hYbH6jbKek4FYjmg1hFuYHtg6dIg==
X-Google-Smtp-Source: AA0mqf7JAjFhax2hraKTvKUP3TvGRf4o+psol3OTyqKMy4AFn0rpnZEmoo+B8ugy77cEVvyL28hiKJ8YrPf79+vBkoU=
X-Received: by 2002:a17:906:c042:b0:781:541:8f1d with SMTP id
 bm2-20020a170906c04200b0078105418f1dmr23280026ejb.117.1669187614595; Tue, 22
 Nov 2022 23:13:34 -0800 (PST)
MIME-Version: 1.0
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
 <57114829-c205-dece-abdb-1100947286d4@sholland.org> <CAK9=C2WLOa_zgboFE5UCgnwMB-kbWMAVtmXsBxoswqY63-5QHw@mail.gmail.com>
 <a591599e-d133-e19a-4898-5645c3862daa@sholland.org> <CAAhSdy2VdX9VivbuRhjN0cPXTi=nFWdiPwFs+hUv6iMqZu-q5g@mail.gmail.com>
 <4e9a46e2-eaa2-04cb-8b95-2fe9a091a96d@sholland.org> <CAAhSdy22jRmeMqAfJKtubo4wuOs29uax6uucz54RmoiySff7Nw@mail.gmail.com>
 <be1cb304-f871-6768-d3ae-a5b55fb17c46@sholland.org>
In-Reply-To: <be1cb304-f871-6768-d3ae-a5b55fb17c46@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Nov 2022 12:43:23 +0530
Message-ID: <CAAhSdy3920xAnc=Jt47tcYfj2nDYS0nGWZLU+Hx8tUjzfg1AxA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        conor.dooley@microchip.com, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 23, 2022 at 12:20 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/23/22 00:41, Anup Patel wrote:
> > On Wed, Nov 23, 2022 at 11:57 AM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> On 11/23/22 00:10, Anup Patel wrote:
> >>> On Wed, Nov 23, 2022 at 11:08 AM Samuel Holland <samuel@sholland.org> wrote:
> >>>>
> >>>> Hi Anup,
> >>>>
> >>>> On 11/22/22 23:35, Anup Patel wrote:
> >>>>> On Wed, Nov 23, 2022 at 10:41 AM Samuel Holland <samuel@sholland.org> wrote:
> >>>>>> On 11/22/22 09:28, Palmer Dabbelt wrote:
> >>>>>>> I also think we should stop entering non-retentive suspend until we can
> >>>>>>> sort out how reliably wake up from it, as the SBI makes that a
> >>>>>>> platform-specific detail.  If the answer there is "non-retentive suspend
> >>>>>>> is fine on the D1 as long as we don't use the SBI timers" then that
> >>>>>>> seems fine, we just need some way to describe that in Linux -- that
> >>>>>>> doesn't fix other platforms and other interrupts, but at least it's a
> >>>>>>> start.
> >>>>>>
> >>>>>> We need some way to describe the situation from the SBI implementation
> >>>>>> to Linux.
> >>>>>>
> >>>>>> Non-retentive suspend is fine on the D1 as long as either one of these
> >>>>>> conditions is met:
> >>>>>>  1) we don't use the SBI timers, or
> >>>>>>  2) the SBI timer implementation does not use the CLINT
> >>>>>>
> >>>>>> And it is up to the SBI implementation which timer hardware it uses, so
> >>>>>> the SBI implementation needs to patch this information in to the DT at
> >>>>>> runtime.
> >>>>>
> >>>>> Rather than SBI implementation patching information in DT, it is much
> >>>>> simpler to add a quirk in RISC-V timer driver for D1 platform (i.e. based
> >>>>> on D1 compatible string in root node).
> >>>>
> >>>> It would be simpler, but it would be wrong, as I just explained.
> >>>>
> >>>> Only the SBI implementation knows if the SBI timer extension can wake
> >>>> any given CPU from any given non-retentive suspend state.
> >>>
> >>> The SBI implementation would derive this information from platform
> >>> compatible string which is already available to the Linux kernel so
> >>> why does SBI implementation have to patch the DTB and put the
> >>> same information in a different way ?
> >>
> >> It is not the same information. The SBI implementation also chooses, at
> >> runtime, which timer hardware (CLINT, platform-specific MMIO timer,
> >> etc.) is used to implement the SBI timer extension. The value of the
> >> sbi-timer-can-wake-cpu property depends on this choice.
> >>
> >> Using D1 as an example, there are two MMIO timer peripherals ("sun4i"
> >> TIMER and "sun5i" HSTIMER) where the sbi-timer-can-wake-cpu property
> >> should be set. But the property should not be set if the CLINT is used
> >> by SBI.
> >>
> >> It would be perfectly reasonable for the SBI implementation to claim one
> >> of the wakeup-capable MMIO timers for itself, mark it as "reserved" in
> >> the DT passed to Linux, and thus force Linux to use the SBI timer or a
> >> native CLINT driver (C906 CLINT has S-mode extensions). Then the SBI
> >> timer _would_ be capable of waking the CPU from non-retentive suspend.
> >
> > Fair enough but the DT property should not be SBI specific because same
> > situation can happen with Sstc as well where a particular non-retentive state
> > does not preserve the state of stimecmp CSRs in the HARTs.
> >
> > Better to keep the DT property name as "riscv,timer-can-wake-cpu".
>
> Consider a platform where the Sstc-based timer cannot wake the CPU, but
> the SBI timer can, because it uses different timer hardware or a
> different interrupt delivery method. It seems like we need two different
> properties, one for Sstc and the other for the SBI timer. If both are
> supported, firmware cannot know which one S-mode software will use.

On a platform with Sstc, the SBI set_timer() call will internally update
stimecmp CSR. In fact, this is what OpenSBI already does.

Here's the text from Sstc specification:
"In systems in which a supervisor execution environment (SEE) provides
timer facilities via an SBI function call, this SBI call will continue
to support
requests to schedule a timer interrupt. The SEE will simply make use of
stimecmp, changing its value as appropriate. This ensures compatibility
with existing S-mode software that uses this SEE facility, while new S-mode
software takes advantage of stimecmp directly.)"

Based on the above, we don't need separate DT property for SBI timer
and Sstc.

Regards,
Anup

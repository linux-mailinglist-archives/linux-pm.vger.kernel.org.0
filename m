Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F37E55C0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjKHLpi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKHLph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 06:45:37 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A7198A
        for <linux-pm@vger.kernel.org>; Wed,  8 Nov 2023 03:45:34 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F2E440C4E
        for <linux-pm@vger.kernel.org>; Wed,  8 Nov 2023 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699443932;
        bh=2IgvXekzOkaF6fsnoEIuCg4cvc2eO7MUjZCXAyZm+lo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cZwSj0dam4Z1srulGHExEgAvZGJAtaXaV5iFn9emM2kaWMpuUGTaDPkc+j4exIFVu
         nvb54zx8YWxAXotL52GZUtmYOSCdm9PiOp/jlFsj4GbwpavipGlKpbHNJa9mfCOyts
         30mCgcpNXbhnTOhWeJ3psr4j9CqZzZfFvgS3hmQRe7xxVTdV8CK17cGBsrnlrVeRdH
         Myu01lEqB72z4Do8WgkVVgZNvo8wEQi6zQTRBC8STm012PmgDy4iLaO+BZkvJOh/A4
         gulTlYrwzISmUD8Yc1iDVt4LDfYtvPwYzbZE8TwurTCffg7aOfmdsK8Msn0Ah3u39P
         Me/PZup0dP+Vw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2786a8ebso60829495ad.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Nov 2023 03:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699443931; x=1700048731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IgvXekzOkaF6fsnoEIuCg4cvc2eO7MUjZCXAyZm+lo=;
        b=EWlsd+qTs3SMqKNyWGsE3UifSBuh8nY9+CxAlyBDXUIuBsi8IB35+Mc6litSu+PRyq
         dddf3I+/TGs7zPW+jcAFJOoGra83kLLlbrVjMxYukVdxpIlizaVB0zoo6hfb2H5aLcot
         oixOzqgtaDCg9nichXivU96r1WhhiCF613RACOIHOTFTrdSdPwkLn5lMcMNQ9PRVurBd
         rqA9XWIhw0fTvcA/8vy5W+dVzXxOLfIkp3kgHHB1U2ye4MyJZ1/GMBt+CBVJ3dg6Qzj2
         1hgqR4+KR8STRpzmXWBVNkjhkwEGk0DUaj9sqqpu9PwyCV1tV0/aTN6MOvcNVQzBqJ3K
         qjUg==
X-Gm-Message-State: AOJu0YzavQDO5rLncvUX3T64O1gq/UmAE4AUZHRAD0IT34HkrO3xh3yr
        HD3i/1AsO2akjJOlkQ6V7Lkdko5N3GYEQCPIUi+DsFKP2Dyq6AeIZ18GgU52BHeaDUgompK3TZx
        uRt1g6bg55nLwbDcIf6g0UEKR5g9Cw9HTxUE/i//frqzeOkrdTv9tx9YTBtmCOC33Tg==
X-Received: by 2002:a17:902:f686:b0:1cc:510c:a0b9 with SMTP id l6-20020a170902f68600b001cc510ca0b9mr1829656plg.34.1699443931003;
        Wed, 08 Nov 2023 03:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVG8KGj2/ZVjZ1tuZ/h9a06xFJ8bdulWnVrqn/MP8xbkcpUq8oyynRfMODCGDUPcRiJKmK25BUwPZbW98TCKA=
X-Received: by 2002:a17:902:f686:b0:1cc:510c:a0b9 with SMTP id
 l6-20020a170902f68600b001cc510ca0b9mr1829644plg.34.1699443930660; Wed, 08 Nov
 2023 03:45:30 -0800 (PST)
MIME-Version: 1.0
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
In-Reply-To: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 8 Nov 2023 13:45:18 +0200
Message-ID: <CAAd53p5+WaHCDav_3yLBg9mJiyi6saQiXTqx35nqZte=0mM-pA@mail.gmail.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com,
        vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kenneth,

On Sat, Nov 4, 2023 at 7:13=E2=80=AFPM Kenneth R. Crudup <kenny@panix.com> =
wrote:
>
>
> I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe behind a
> VMD device:
>
> ----
> [    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family=
: 0x6, model: 0x9a, stepping: 0x3)
> ----
> 0000:00:0e.0 0104: 8086:467f
>         Subsystem: 1028:0af3
>         Flags: bus master, fast devsel, latency 0, IOMMU group 9
>         Memory at 603c000000 (64-bit, non-prefetchable) [size=3D32M]
>         Memory at 72000000 (32-bit, non-prefetchable) [size=3D32M]
> a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable) [size=
=3D1M]
>         Capabilities: <access denied>
>         Kernel driver in use: vmd
> ----
>
> The only release kernel that was able to get this laptop to fully get int=
o
> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series from
> Ubuntu
> (remote git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/=
lunar).
>
> I'd bisected it to the following commits (in this order):
>
> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programm=
ing
> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD dom=
ain
> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
>
> Without the patches I never see Pkg%PC8 or higher(? lower?), nor i915 sta=
tes
> DC5/6, all necssary for SYS%LPI/CPU%LPI. I've attached a little script I =
use
> alongside turbostat for verifying low-power operation (and also for seein=
g
> what chipset subsystem may be preventing it).
>
> The first two are in Linus' trees, but were reverted (4ff116d0d5fd in
> a7152be79b6, 5e85eba6f50d in ff209ecc376a). The last three come from Ubun=
tu's
> Linux trees (see remote spec above). The first two remain reverted in the
> Ubuntu trees, but if I put them back, I get increased power savings durin=
g
> suspend/resume cycles.

I am working on this, hopefully I can come up with an upstream worthy
patch soon.

Kai-Heng

>
> Considering the power draw is really significant without these patches (1=
0s
> of %s per hour) and I'd think Dell would have sold some decent number of
> these laptops, I'd been patiently waiting for these patches, or some vari=
ant
> to show up in the stable trees, but so far I'm up to the 6.6 stable kerne=
l
> and still having to manually cherry-pick these, so I thought maybe I coul=
d
> bring this to the PM maintainers' attention so at least start a discussio=
n
> about this issue.
>
> Apologies about the Maintainer Spam, and if this is already being discuss=
ed.
>
>         -Kenny
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange Coun=
ty CA

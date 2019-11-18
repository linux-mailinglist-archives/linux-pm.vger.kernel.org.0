Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A83FFE37
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 07:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfKRGM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 01:12:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfKRGM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 01:12:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so16483354wrj.8
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2019 22:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AJsaT5DgrHtaCNma+B9BtLu3BvxW/8LIu7bVrOjvJcw=;
        b=zG0GfU55CfIq0bxqCfyIHFIxx3fvkMttFzS3Xkc1BHyNNxJ63t+K35DzNEi2QJdorL
         eAuy1vxsuQFq33tue6ItS9AVZgi0iP+xbGIJB+GW2xcHzbjsvNwcbSYUz31d+geX15Ko
         E31HfnnHnP8zKrOFKkMQJWguItFUW2eNV3A5Vy87q8PItuesaKxhwh5e/6IOhMMivIFG
         BiKyNMn8a2x0wFOqxXn3vGd4SMU/E78F9mBux91j2CvejF69EVbFQHzsDOsyQcL4PLrZ
         6i+SU7I4c2Mapi4d1HWYuguHDBKtXedYFCWauGtiIXNvqBuP1tcZtHowTHGiVnAn6jyS
         rE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AJsaT5DgrHtaCNma+B9BtLu3BvxW/8LIu7bVrOjvJcw=;
        b=KfvLnXXwUnxWW8vleg0GcEZWdC5WBW3zBM35CuXNzNL4ZZinTsE2ofEfPnPMhC6qkp
         3M7U6/WD0o+BxZipcnzBNuu27R6lSJucndF27yydXTLQ4AHW1KI+Gs7+EmITNoUszh9x
         Y+GiC+CQybkvR29ukzx5TOgxMGvrjW5L5i0W55WkwrGNkJMubRxMuJoI5Ghhyovss+Iu
         uxVmwKYoYqfrgw1hGdE4EypyzXJmvsNnTyjPA+Jj0yikK+6Bt8xuTq3IWrZG++DRVHEO
         9YAnN/JyJJ7EjPKuFhbSSjMoV+tP4+GceVsbttPz38RVQJcuGMxpSVwdo/bAeMV5H22z
         kZiQ==
X-Gm-Message-State: APjAAAUWI9q1wMgKhFUDaMDKC2mckAuZGmA844A5ceSWhu2QQMxAipL7
        HcpOl2PSEU4LfePhvpPPwSnBG2xveMr1CWlpj2vNWA==
X-Google-Smtp-Source: APXvYqwB3mALuF+xrfOFxo6FhxUJ3+/T3sFpcxYqdgA9qswdYF/EtXU0VTIbAKX+PRN8dPiqpo1l4F1iCFTwAIDgVcs=
X-Received: by 2002:adf:b746:: with SMTP id n6mr27431556wre.65.1574057545931;
 Sun, 17 Nov 2019 22:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20191107212408.11857-1-hch@lst.de> <cca46a52ee91548962e2f9da4cf2202e@mailhost.ics.forth.gr>
In-Reply-To: <cca46a52ee91548962e2f9da4cf2202e@mailhost.ics.forth.gr>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Nov 2019 11:42:14 +0530
Message-ID: <CAAhSdy0N0m+ibSdOKnn3XSfcbb3y068ek6aJNUzHaVVfRcPNbg@mail.gmail.com>
Subject: Re: QEMU RISC-V virt machine poweroff driver
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 16, 2019 at 3:45 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2019-11-07 23:24, Christoph Hellwig =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > Hi all,
> >
> > this patch add a driver for the test device in the Qemu RISC-V
> > virt machine which allows properly shutting down the VM.
> > It also is added to the riscv defconfig given that qemu-virt
> > is the most popular riscv platform.
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> We do this already through OpenSBI, I contributed a patch for this some
> time ago.
>
> https://github.com/riscv/opensbi/commit/51e543511a7425da1a5378e149de0b459=
28c7111#diff-36ecc47313ff13e406c53b99471f294e
>
> Last time I checked I could just halt and the system would shut down
> properly.

We only have poweroff SBI call in SBI v0.1 spec.

Also, we had proposed SBI v0.2 SRST extension having both
Poweroff and Reboot SBI calls but before we can have this SBI
extension we need to clarify scope of SBI interface in RISC-V
privilege spec so that we can have system-level SBI calls defined
in SBI spec. In future, we will bring back the proposal for SBI v0.2
SRST extension.

There are two cases in which we might need SOC specific
Poweroff and Reboot drivers in Linux:
1. SBI v0.2 onwards all SBI calls are optional so SOC vendor
can choose to provide explicit driver instead of implementing
SBI calls for Poweroff and Reboot.
2. The M-mode NOMMU Linux does not have SBI interface
so for this case SOC vendors will have to provide explicit
drivers.

If SOC Poweroff and Reboot mechanisms are simple enough
then SOC vendors can straight away use SYSCON Poweroff
and SYSCON Reboot drivers instead of writing it from scratch.

Regards,
Anup

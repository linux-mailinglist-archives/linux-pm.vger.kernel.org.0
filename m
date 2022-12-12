Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4464A4B1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 17:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiLLQS3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Dec 2022 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiLLQS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 11:18:27 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7550E13F0A
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 08:18:26 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id k3so5325932qki.13
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 08:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GRUo7G5Q62XQETjRjksV950LvDzFsXPpBx5Yuqgg4s=;
        b=XvLjdzg85PcNoWMoASM/omFmk5IZ1lrm0K2otXRq26wVKJ2ycACMDMD1l+m+k0bi7O
         VlUp/tUEsnWEMqomTQAysBUzJbKnqx2/cKhsOv4B0oyFzzsCEOcnhI2BSgJoZI/+6Tjo
         gXErG+iPfbOvRU9AJy+UOmQ0LOFN6siuiT98aAPQktaMRcETmBpqcgpSMnYz7pjr1VG/
         JGix7JPOgpA+kuvBh+p0ob/H7XaxCrUQB3acG9kP3iOkU8xSy4eEv6IWpvJoSWcepz6k
         G4y7JyOgQV7meE6HxCl0O+vuTjgUt2SCQA1jG+Yo7S77bUg64w0C+m3aPZKns7u1IT8H
         GQmQ==
X-Gm-Message-State: ANoB5pmVnjOKtysmfXfWK6sA2PD/qlpyWRERfsNsuK++bhCXoxrYiVt/
        HAT9BH/AE5RXHzYLvyMV5UNVhR1A1txMPjQ2fEM=
X-Google-Smtp-Source: AA0mqf6XJHF1UysCTa5RC8AaxQ+uqd3Di+GL/O62Jma4vr2nJd7rZaM0CVxtdIA2WlAUqYW3PYcSKfYooMS0VX1izrI=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr83666121qki.23.1670861905593; Mon, 12
 Dec 2022 08:18:25 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR09MB36477641F02DBE986ECABED5B0E29@VI1PR09MB3647.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR09MB36477641F02DBE986ECABED5B0E29@VI1PR09MB3647.eurprd09.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 17:18:14 +0100
Message-ID: <CAJZ5v0hYHE1mW=iqw-_cQhT3MpW+eFb0_q7yj4+cYq+uMz4q2A@mail.gmail.com>
Subject: Re: System Becomes Completely Frozen After Resuming from Suspend. Can
 Only Recover System Then By Forced Shutdown.
To:     Yell Radical <yellradical@outlook.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 12, 2022 at 5:06 PM Yell Radical <yellradical@outlook.com> wrote:
>
> Hello everyone and thank you for hard work at making the Linux user experience better.
>
> As explained in this email's subject, my system becomes completely frozen after resuming from suspend. It enters suspend just fine, but upon hitting the keyboard to wake it up, the screen wakes up and shows the login screen, but then the system becomes completely frozen. The touchpad stops responding to input, and so does the keyboard, making it impossible to change the tty or press the magic key combination, and the only way to recover the system then is with a forced shutdown (long pressing the power key).

Has it never worked or is this a new failure?

>
> I'm running the 6.1.0-rc8 kernel, and I've attached the dmesg log and system specs to this email for your reference.
>
> I would appreciate any help and am willing to try anything to resolve this problem, as it almost renders my laptop completely unusable without being tethered to the charger.
>
> Thank you again for all of your hard work and have a nice day.

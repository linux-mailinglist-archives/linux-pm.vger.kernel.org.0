Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8EA232FD5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG3Ju5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 30 Jul 2020 05:50:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgG3Ju5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 05:50:57 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k15DC-0001oY-EO
        for linux-pm@vger.kernel.org; Thu, 30 Jul 2020 09:50:54 +0000
Received: by mail-pj1-f70.google.com with SMTP id hi12so2725574pjb.6
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 02:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z6azR+BaptW7sOFFycRZIdapi2fWCVCt97iunL8FEoU=;
        b=HMEMtFs6+iIsWqRaZEoon3dkLhuVaG2IJfhajVLMfM26EaXKmxOFTCnI1T6OVJNLD9
         WYv/1HAh3FKule8W79dTGdvDkWibjCUn5xWuQLdgz4J1UcBmnFmUbgp8iGjnxmJ/pqp6
         rlyZciFvR0aJBXNBDZXW73lpVibx1gBuUtYWbn/4zmDKFG9mTDnwGBWNSEG0Uz4YkJuX
         ReA5Gr1rFbbFHMKWwSW6RVvc7Gul9iuySlRUmH4OQpy94v7tecixy/Mh36iaXGXvM5T7
         Ia9clHlu8XTOwToWvqn90voxjEU4Ch0psp4jPw6GkGukdaELjbbThSD7kxXUSOVAHdWT
         v2wA==
X-Gm-Message-State: AOAM532yPngxD4n2AtMrW95Lwu9oIXVavhdNsyyMpVFayOChV/HGaS94
        Q9LRRmwgzjEgJ0+VfRuS++pw8Y6E9/vDrJHfxcbM1h9KmPIKwVBfTSwwbDtVbvzG0aR9Jd09PZf
        z5SeNwL5eFVqknWsGb+5LzVntzW0Q4Ra2SSDp
X-Received: by 2002:a63:6dc1:: with SMTP id i184mr33887099pgc.345.1596102653022;
        Thu, 30 Jul 2020 02:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKPYOcNGUX0wVpj3tYWG+1sKAG3lC10wGIaPj/zNketX0viNGp0xJCXBhZ48tuwR0IqtKHtg==
X-Received: by 2002:a63:6dc1:: with SMTP id i184mr33887060pgc.345.1596102652602;
        Thu, 30 Jul 2020 02:50:52 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q17sm5410652pfh.32.2020.07.30.02.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 02:50:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Disable runtime suspend on
 Realtek devices"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <E52C04D8-67C6-4949-B988-A61F6FCD1434@holtmann.org>
Date:   Thu, 30 Jul 2020 17:50:48 +0800
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8FE329BB-706A-4D16-950C-A7571FE0B40A@canonical.com>
References: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
 <8DFB5D1A-AA7E-4960-9937-4FD00827937B@canonical.com>
 <E52C04D8-67C6-4949-B988-A61F6FCD1434@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Jul 30, 2020, at 15:30, Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Kai-Heng,
> 
>>> On Jul 30, 2020, at 07:17, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
>>> 
>>> This reverts commit 7ecacafc240638148567742cca41aa7144b4fe1e.
>>> 
>>> Testing this change on a board with RTL8822CE, I found that enabling
>>> autosuspend has no effect on the stability of the system. The board
>>> continued working after autosuspend, suspend and reboot.
>> 
>> The original issue was found on 8723DE. Do you have one to test with?
>> The rtw88 codebase has changed a lot and maybe it's already fixed in mainline.
>> Let me do some test and I'll report back.
>> 
>>> 
>>> The original commit makes it impossible to enable autosuspend on working
>>> systems so it should be reverted. Disabling autosuspend should be done
>>> via module param or udev in userspace instead.
>>> 
>>> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>> ---
>>> We have a few Chromebooks using the RTL 8822CE part over USB and they
>>> are running without problems with autosuspend enabled. While bringing up
>>> a new board, I found some power regressions that I was able to narrow
>>> down to this change so I'm requesting a revert.
>>> 
>>> I tested this on Hp Chromebook 14a (running 4.14 kernel and 5.4 kernel)
>>> with this revert:
>>> * Enabled autosuspend, used it normally with a HID device
>>> * Suspended the Chromebook and verified it worked normally on resume
>>> * Rebooted the Chromebook and verified Bluetooth was working on next
>>> boot
>>> 
>>> I didn't see the issue that was originally reported with this fix. For
>>> the original reporter, if you're still seeing this issue, there are
>>> other ways to disable autosuspend for your device:
>>> * set module param: enable_autosuspend=0
>>> * change your kconfig so BT_HCIBTUSB_AUTOSUSPEND=n
>>> * use a udev rule to disable autosuspend for specific vid:pid
>>> 
>>> Keeping this change in the kernel makes it impossible to enable
>>> autosuspend so it should be reverted.
>> 
>> It's apparently a driver/firmware/hardware issue, so the fix should keep inside the kernel.
>> However, the fix can be more precise and target only 8723DE.
> 
> lets do that and lets do it quickly since the merge window is close. Otherwise I really have to revert that patch.

Ok, I no longer observe the original issue with the patch reverted.
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> 
> Regards
> 
> Marcel
> 


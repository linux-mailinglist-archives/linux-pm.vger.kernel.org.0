Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D364D7742
	for <lists+linux-pm@lfdr.de>; Sun, 13 Mar 2022 18:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiCMR3J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Mar 2022 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiCMR3I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2022 13:29:08 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712FF2657D
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:27:59 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso10671351ioh.7
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=nkxZMlO8VyGWK7j6fOoE2bRgObi33Bn0TDG2ZS3w8Yc=;
        b=iPTGsVKL0cdU/FMDMnyiWA7KJAsArgfd8N7cGI3Og9wBkJ4+qtH9GUUWm5zPO6HNGQ
         zc4B0oE+4cRbKJSKHtmmTW/qHIlIIWWEiRCHX8rPVOAgrPp0zVJB2eWM7YydTG1Nxq4+
         GIjsgHymVejlD4BxYgwLLxpmuAsneH4IkpJh1DMA7v4P2YtnWLmtJD3O1VAVEUwWSCBT
         kP0N28haOYkpSNRXI3YwDEvVXFo01oci3dlR1kepH70iXu9WYyQ8XMpFhIWgUi8xqIyF
         95+sNmxdIqSjMea3501dTH1bXnSu+yO+Xqj/9mq3+6qCRcXrrFKoBKazu4V2W5VnKzRv
         dDtw==
X-Gm-Message-State: AOAM530Xo38i69CQr/vmp77p6nnNjfZvdgLQJ8a6NSMecCcmTJcjOgaS
        15tkOv3gMUctFMP7nEspp6DntJvTsvGl5hy4gfMXIWMhJEJ4
X-Google-Smtp-Source: ABdhPJycAJrA1vmL3pi0bVtscFr24KP8I5soXYdvxK35Tx/GKqgeOMn+92+vRd3vIgNzDcPuhTguZ1ZdDyvbL3Vb8SNwXRX7otxY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2505:b0:319:a7f4:131e with SMTP id
 v5-20020a056638250500b00319a7f4131emr17448490jat.309.1647192478817; Sun, 13
 Mar 2022 10:27:58 -0700 (PDT)
Date:   Sun, 13 Mar 2022 10:27:58 -0700
In-Reply-To: <79d2c7e0-c4ed-fa89-5d97-4b143356f814@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093a3f805da1ce2f7@google.com>
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On 3/13/22 08:35, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    92f90cc9fe0e Merge tag 'fuse-fixes-5.17-rc8' of git://git...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=118cd3be700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b64e79700000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652811a700000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
>> 
>
> hu->serdev should be checked before passing to pm functions
>
> #syz test:

want 2 args (repo, branch), got 3

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
>
>
>
>
> With regards,
> Pavel Skripkin

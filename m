Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C924D7743
	for <lists+linux-pm@lfdr.de>; Sun, 13 Mar 2022 18:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiCMR3J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Mar 2022 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiCMR3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2022 13:29:09 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C3193EE
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:28:00 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id a1-20020a927f01000000b002c76f4191c5so4931437ild.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=3Fcb52A0WOVWL1jTfsaJLyOjdTKVXacU/wBfrej2Jp0=;
        b=UWHmqyCSPLTlXHWaZPZJqa/ie7xnRMveP2shAkvze2Ejh8d55hkyBMj3mWVJCwbCp7
         K01jLgIhGydaYPV1mu29bmUSr1z/61meSUL3oy25RIyBTEN1OkUAOK64MKRDTTJmEsFb
         1BZC7bE9V3M4DcQIGFZegsLWc04bxKR8s59aDWmQruTacIUxWxd028n9wM8DsY+QZs1y
         JRqpjOLeXsmbz/k2eIOMAlQN412WU7miDhImY1m+nrbsIBoZ6C/TeWzZgILct0yJF2/+
         +Dn/VhnKI08oNsx7nz5C88pEACiVjkRSAfM3KEYVaj5ZH9x6EHd2KbaeCIAAeMW9NC74
         15og==
X-Gm-Message-State: AOAM532AgoWrhPS3vnjUvnkvYQ2Wm1TSHnyIVwVI1qBVDWU5TCCMygdj
        zpPUiRq49Wuq9Myw6D+BgGhLo82a9VFepvW5XwbcrAzWMVDz
X-Google-Smtp-Source: ABdhPJxO684NTslGcTCdpNgz2P0+bOgIgQ/DZ5z6F1KmF3Ajcv7PLy4/A8/x3AxFUMd9QMPfGtJwKRDa5YiriqrSEd439/xWNFK0
MIME-Version: 1.0
X-Received: by 2002:a92:c10c:0:b0:2c6:490:9870 with SMTP id
 p12-20020a92c10c000000b002c604909870mr15740992ile.289.1647192479855; Sun, 13
 Mar 2022 10:27:59 -0700 (PDT)
Date:   Sun, 13 Mar 2022 10:27:59 -0700
In-Reply-To: <79d2c7e0-c4ed-fa89-5d97-4b143356f814@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a37df805da1ce2c9@google.com>
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
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/79d2c7e0-c4ed-fa89-5d97-4b143356f814%40gmail.com.

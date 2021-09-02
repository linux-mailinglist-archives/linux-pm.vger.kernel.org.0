Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E73FF46D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbhIBT4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 15:56:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50849 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347479AbhIBT4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 15:56:07 -0400
Received: by mail-il1-f198.google.com with SMTP id v1-20020a92d241000000b0022b26140915so1967435ilg.17
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 12:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=38W35ScS07g6ekDXuVTNyXmTbkWYtJNx19lDEdhawfY=;
        b=RHFHrgcwdUmeZ0NUu9OP/7Z+imfUgtZWXn8r6tUdXYknNfFgOSPtuWJ+kRRHL5BIWP
         3GaKnbQ7HemI89CXQT/Zez7ol+oc7ZPkzghj6sJCdfdid0R543lWLct4xZCMQhYhR4tA
         KX7WlpDpvKJqTr+0F0/sk1JJJk7CZIRtoo9YisgruH4hx8WBgWEMaQJnt4wvaawCI6Cb
         cXNAhNkv68U5MZ7j0H0nfF4xOoPHRKPtg8xxNO6fVIfq2PdVoyaCokaN3ES6NmEYQkED
         MUawsHDmJ2FOhSzDHpqhTpGNR1UE4WtrSUhy0G3ivSgF6yX7wQHMtwpPkh6/TsP8Y47q
         /nnQ==
X-Gm-Message-State: AOAM530lu119uU7QrG5ruwFDbN6vRUSeuB2Yqez3K+r0pv4juDMhhHSn
        ThN0eRvUdWiyzZj7a3yCydLnFAOyHhvtjc8QWzbPR+cd6u9B
X-Google-Smtp-Source: ABdhPJzytE1DAvctVUnDlDSxsxQkuv6mjTkK8YNP2Fqo8BqktTCdgGE2jCx+TvMt+GMhWoSWTQ7WiAXzTXUXufJ9wKX8egOJtPKT
MIME-Version: 1.0
X-Received: by 2002:a6b:8b54:: with SMTP id n81mr39022iod.5.1630612508190;
 Thu, 02 Sep 2021 12:55:08 -0700 (PDT)
Date:   Thu, 02 Sep 2021 12:55:08 -0700
In-Reply-To: <fd90b222-4394-946a-24f8-fe3943e840ab@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000512e2405cb088fc1@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com

Tested on:

commit:         4a3bb420 Merge tag 'dma-mapping-5.15' of git://git.inf..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e782839f57ad47e
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b6fc2e300000

Note: testing is done by a robot and is best-effort only.

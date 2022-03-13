Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B564D774F
	for <lists+linux-pm@lfdr.de>; Sun, 13 Mar 2022 18:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiCMRmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Mar 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCMRmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2022 13:42:17 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331F8E1A3
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:41:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id e27-20020a056602045b00b00645bd576184so10719931iov.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2022 10:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LSM3VjxELhJj4+/mnArqOMDnWPb4GDPFt7f+AkdtHz4=;
        b=nwOuZbmK5RACbU0QwJR2YjQi9Gn6g84KLAA92ICBgFFxKtEsL0ya7FORDtu+veMQYs
         42MIRAPNGe0suETGanXxow8AtL/OPTW1L1HuD+OOSAj/G5Tf7F1rVR1r/vTvzR61GOug
         OCWsK8y3CqWJKIsUfer0SGFaONgYyQU5zNmPoBOPcjaPzBRh1IncG4G/rB+IfBfOC/D0
         dc9a40InwfQgtm7nEJ8K7Dqdygeh+f3K42vKKgWvFBn2oZRrufCp5ATnY2sSaLPKInVn
         WIiToBUuBuOwNucyDaedlG/qp1B77OpKZ22r0yzGA93KErum5e5Hbj4OQOwU3tY3Fi3B
         VFkw==
X-Gm-Message-State: AOAM531L6vUBQDETE7patux/yFxTGFnoDO+9jT/pGIdpxIVQ4fT+bU1N
        c23lSDiun3wUPLL6vlkexFswfCI9hgjPqdxQjzYC12wE9Vue
X-Google-Smtp-Source: ABdhPJy+VuMRzGzZk2ZJwKxb5f0DmK57Ah9ZX2L0UhW4J+twszZINyFRIWgVWuGEwpzBOJWe8vYgxxMkE6VJcTTdT10x2lqLaPSG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2402:b0:317:b534:2b8c with SMTP id
 z2-20020a056638240200b00317b5342b8cmr17109176jat.60.1647193269370; Sun, 13
 Mar 2022 10:41:09 -0700 (PDT)
Date:   Sun, 13 Mar 2022 10:41:09 -0700
In-Reply-To: <bc933e26-92f3-cfa6-9500-609c2d1015a2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2860905da1d11b5@google.com>
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com

Tested on:

commit:         aad611a8 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105cb5a5700000

Note: testing is done by a robot and is best-effort only.

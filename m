Return-Path: <linux-pm+bounces-33772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64966B42C3A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BF2485B8E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CE2ECE93;
	Wed,  3 Sep 2025 21:54:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BF2EDD47
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936473; cv=none; b=I5qSHeftraTxz7U3jijTCF4uJjweWi25XEAsIgXtSWjQgkmV/cROr7I0jktpeGGMRI5/IFp6bXz7CV99CqbC26/yq6vTEvAtyxFEMrTULW4pis29/mTO2b2f90cZyQ6iFP51Q+iXdCj3LTvdEpRn7iNPoSw+4vjLhjGoJw693YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936473; c=relaxed/simple;
	bh=G4mYCXoN4yRBxspHAQL769uJxZrsIjBLXNwvtiJGyI8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C5AoOLM7+1lKVqwcjfRSjfHsTXe5vARn9oblDRvb8MsAMpGXOIrQQSoJQTXPi9pICMKFNkrhJPE6Vjm5c2KOdwNMsuabloP9oRwSL/t9F1jkVDtVsyPrKXbDIBPjnXQd/Wgc7GHEBjZ07ADPIMoKRW3YRAmDzBQCkeGi+kFbmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f05a805d9bso6602145ab.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 14:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936471; x=1757541271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2O74hPI1AmCEb/MNAKEFM55bhmEH5GlfBH15kqp2jTI=;
        b=h2+T/eu1gc5uiB9iTitBGm1ZOWvzrKUwh+bWeImoaPhAND1igU4wN52CxsGFEtcsTO
         PLxDt/btXxiaOuO2zF1cvg4e/ABxsleGRLDNon0zK0HR+JUlFPl7+UmW6Xpp6FZ7bk5y
         xyiLrhBu13mx3nE1zT/HNn6MsyRqeii3j5YjrYrscP0RS0oEQdIgUgu9vKuZo2A+BHeX
         7oKJeiJYBQWW503iZLHhBD48lgB449AytNupVP4ovvBYoI9TTPYM7Bie/xfgH4QKGGTC
         tVPE+DZxB38j4GgAAkJHnFT5WngfopVPgKIKAU/BPIFQX9sc/nlmfKlVwBsVQxFHPKv0
         AJvw==
X-Forwarded-Encrypted: i=1; AJvYcCU1pR5Q64Ylzvnmzl09zkDsjaRfxEc2z575VrWJPNg5P8zKr5+bI9iw5wRGIKVbUT3W3Jhs/l78dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHI28SqLsZLvGlaMeQw76OyhLcFzisFTKdkJv8bnb5px/E/rHO
	TZV8RzU5ufSzubfJq1fc98sAq8GDgnzQjjoB16oJ4+xZ28a6KKCIH9I03+RhLt0C9v7OR4O9R/G
	7plVtekXEYhH2xu0SUjpVuPHhMdqkkdgFlXWuF8KJ79h+jtmIu+SRQYdSM3Q=
X-Google-Smtp-Source: AGHT+IGQ8GGe2aGNCS5FqoX3dQ8cs8QfO01N2mWEh4tvTIeUDa/c+oQzCz8n+Yhf3P8i8J3Kk9jlVMkptUoPJUd0UTZ+1fj8yVll
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:b0:3ee:f256:ad0f with SMTP id
 e9e14a558f8ab-3f40028a817mr292023965ab.9.1756936470782; Wed, 03 Sep 2025
 14:54:30 -0700 (PDT)
Date: Wed, 03 Sep 2025 14:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8b916.050a0220.3db4df.0205.GAE@google.com>
Subject: [syzbot] Monthly pm report (Sep 2025)
From: syzbot <syzbot+list1e6f2776186824071470@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 920     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 8       Yes   possible deadlock in rpm_suspend
                  https://syzkaller.appspot.com/bug?extid=361e2c54f7f4bf035391
<3> 7       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


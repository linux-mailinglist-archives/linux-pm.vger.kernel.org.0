Return-Path: <linux-pm+bounces-14825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C889873C2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B037B280FAB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB41114;
	Thu, 26 Sep 2024 12:43:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85958F9DA
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354604; cv=none; b=Wx1R+pGetjtyzAcyT3FDtNmyrJG9YolwVEGr5rhZiBJwBWPKGbEisx9oyACJVEJaNe696Z1ECFxjBA0ZDkyHAegxw/36oHNTvTm4FtZjNYrbvc6X0NHLXmmz16dEC9eHBwC2doK3lMks5M3KhFezbkF0GYExgCcOKY5iYG2tpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354604; c=relaxed/simple;
	bh=JyDPdanlq19dnEIjOGTUaJSbn0zGxru2p+hcq3U3v8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AnA5iBWQ8qKch8tn2lrf/phHizP2Gcz/9xdyrjYdv8/zspJ6Fr3zdy733g3HfuHjJKDP4LHTcTB8jm6e36xUNC0t8db2cmAAxwaxC9aYjXXvKPJ3crWpBWkF2OSGBP4/ld4Q63uVW0z5HG22egcjEjoB9ELhU0Be8cq0NYC6BZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8325010330fso95235939f.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 05:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354602; x=1727959402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6ML6Ssq8ICikN6jstwv2jWYGmi6nqCff9WtX1Tt2E8=;
        b=BmJTcCXjZ29e/D25qi7Po/yFdnmGiPsPl43nc2aDn/tY2SOBp3CzyxHgMVyiy9dpEU
         f++zzR0uLWXoum+KmGXSjSWNeFQlAbEiIdXLLE9HTNWStYw9TAFu/0klAohA4KslLsk6
         BIEm5pgIowQXKl1pbH0oPo7OcwUWzs+ZqFqRzofeO8U2BkiPwzv/DkDposY7ew3X79co
         Mz2TzPibu0wFm5ZRwSfrOKOKmq8YxUpUvBtnM6KJCLo9wquH+RaIn7tR8SiRNeWBVuxv
         EJrfaEDLTCR7koTkyABlqKBgiia9doS+sTpNV8sfS+zf4VCPM5Kr4VNIOPOqy+/ZIJRh
         j2zg==
X-Forwarded-Encrypted: i=1; AJvYcCVOD1evHsgbBB52TwGMtkd0/GW3tU/U+wS9dxpgvSj8bmPDzPlFiLOpyVk94XLPniMNWaUApygXew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0C/2QXN+Sta1mFnNz4LBJ/lH8cfHDHdkrKn39BzN5+1rNl26Z
	3X+0/rzXqgrURDj3ApJnXot9idqxd1SdbPOktyRY4xJNplfdR/aRIBvRG9K6EC2ElxrqybGP9Ln
	CD19COI1PRtdGq6NKAfdYf0wISGfRoQ7OQu8AZESu/lWANE4iwIvPuqo=
X-Google-Smtp-Source: AGHT+IEDI9pzcMSZd3ct2WD7ipuMjMl/GrDDJHwfITVk2w2T8J9J2g6yub2cYzTHh/tex/KRSpUKsr66jNvBC2ZLJHGZqVqziE7W
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a26d5f6f20mr63092455ab.0.1727354602557; Thu, 26 Sep 2024
 05:43:22 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f556ea.050a0220.211276.0072.GAE@google.com>
Subject: [syzbot] Monthly pm report (Sep 2024)
From: syzbot <syzbot+list3b69e62a08fee9ce4922@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 202     Yes   KASAN: use-after-free Read in netdev_unregister_kobject
                  https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
<2> 12      Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<3> 2       Yes   possible deadlock in dpm_for_each_dev
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


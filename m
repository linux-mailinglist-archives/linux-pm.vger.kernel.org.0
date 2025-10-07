Return-Path: <linux-pm+bounces-35766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D3BC086B
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 933024E4551
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E29256C70;
	Tue,  7 Oct 2025 07:53:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90534255F57
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823619; cv=none; b=Xd4cPqHKuOc+FaZXwRYRKNOEUJrisnESraC9+QhyjIfT2WVBe2k07JzuXQObgv76WehzLKgB1NbhCu4C79JzW+XZJ8Bdko2eed7bqkbr0Wq0hacfsIjE9b+Gs5Ledykaie7isO9Ls2TLI1VIYZTdFBwPfjKNXq6DS/p0Pb3qYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823619; c=relaxed/simple;
	bh=kGNFLG/ckhmeT9Zw+cAPniPYNQw6NxNwSlONzeCIgeE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bifxWIrWthLKTsqrcw1EXLnh65rlJfaQV4jl33XXBFkwhV5vuz/AzE651cM7uV3KRPa1g7qfLCELQNI6HgslzPXDwDZxcxNQ3OqWEGlElFwpRp4vZMvyUsUiOGLc0TvPr8HGbAyvDpFlm+CsuC5pD84X4YSlADZ1ffrP1lg6rYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f64261ab8so93501665ab.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759823617; x=1760428417;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61IV87ebMWT3tuw0sCB9VZ9YEKpJ4A25JtBbRgLMD4A=;
        b=wSGicFWv+mdNVD0AJy0+AByetZGsIELrKeofaZynF1A8YBY0tayBZp3pvEg1249tF/
         pPKu7+Qw/31t9ZaW5b867P5Pz+0GENGw5AAW00rZNzyRkKIatOOHzwc1Co9srnLcqpht
         WLBD3N2uTxQjTEH2Q2kJk2tbro+43C+LujizDFxBrZ28eAGhhrUxUzN2HZ9hampXd52s
         Kfv0EbOsBphP5ZfIlOK5tvwLyvlDty5QwwQXO9Hn4wC6MdaRoqduRD2lC5H6zVLALey2
         +E+cQwQ3vpGBYTteKZOOkX1MQ0cuk56CnsqSW33Si2ldrDyVGBvaj89CDpFU56qdzBf8
         FthA==
X-Forwarded-Encrypted: i=1; AJvYcCXyvCLG7ANQW8pFDo9RW1nQMTk+B6ro7339wjMdh353j4fUsEBIMnC9GgiYMnAg3XEdq2s/Nm4h4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90WHkDAhMivWIxNDLK7tN/Ew+Zky7GZq4dZ18hK5DnnDAbeTp
	jPfUUBIwViauEwvrWpqEXCh/aQAL0Tn/stOWMMPf9NRCjphUUBusKgaibD1DKkqIUDqfa9Jj4nQ
	xtdjA+sS0hrxRWt6QYSXB9fHSl3o/L6kCsnN+5Jwyt1GTF5ymHn+60wqE8gY=
X-Google-Smtp-Source: AGHT+IF5CbHZbgEg71CfwTv9mdrwsygLHnnQacv3F+QT1dFBjw++OTUzPvbvvmSG99wk/G4TfiQmk6gAC/FA+GcxirC7nFjpDR8z
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2e:b0:424:a3e:d79 with SMTP id
 e9e14a558f8ab-42e7ad8876emr203529215ab.21.1759823616777; Tue, 07 Oct 2025
 00:53:36 -0700 (PDT)
Date: Tue, 07 Oct 2025 00:53:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e4c700.a00a0220.298cc0.0476.GAE@google.com>
Subject: [syzbot] Monthly pm report (Oct 2025)
From: syzbot <syzbot+listf6d325d85dce60330781@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 955     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 9       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278
<3> 2       No    KASAN: slab-use-after-free Read in rpm_suspend
                  https://syzkaller.appspot.com/bug?extid=6c905ab800f20cf4086c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


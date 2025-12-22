Return-Path: <linux-pm+bounces-39767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE1CD489E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 03:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24FD30053C6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779D322B73;
	Mon, 22 Dec 2025 02:03:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803E23536B
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369001; cv=none; b=Kb4fYIaE7MnipP7d6EXMyLC+Zkj7RSGozoLxf+c58jYcOL2nkM1NKlAH1MUVN8z8WMiNT0nSmXfEiOCkFINivXDBi5jtGAsXdHEjf8hm8iSFWrK+XwNzVRUioRjKlIY47c4dJyvWsHS+yKt/RKv2bgIRyDIslpHqO5wwqpt+las=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369001; c=relaxed/simple;
	bh=jc0BUJLVC95uqqdLFZxTnK8/yqn43Gm0atOYgJVUlGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uTTLZQv3/ytrFFCK5wTyg5zBgSyz7YSH6/3iwGF9WekyZywn8Xdp/3kw6ZB9K5QSXca/GcYv75gPCF9SOibje5RNwRZh4ov3FVWZLhb/Dv7LnAuSzhZA2b2io6QBX4nU2jA2FPy5+Jz4cVN/gOZ9z+oLDUPKsnvqkjgGOs3aUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-44fe73611fdso5072659b6e.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 18:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766368999; x=1766973799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCSO3XPRhdYjLHtM0XwOXXLHlqbDsp3iUn5PUpAWdPY=;
        b=FCsvryLCdZtaUhCAvpJRamaMNk/oHgy1QhJZA95O8tfZFF4JlSJd6bOZEc6K3nScid
         P7tVzuoBD0O68fL/g2lLN5Hibu5CCybf/3CTZrvwbu9DZiRYjrQmwEw/uePhnscs1Fdm
         N+/1GgsT9dXCz0S3/UM4lksnSiQ5VrHESgQ0zJvF/iXjfePGKsIvbWcggLGCVbtkAmcB
         JKTGoiae8cXYYn/lLJqooumb1OpBamG6K/tZA/WnsQ6hXJSCP91tBvRYCSpyfczMxGh1
         y94XDGB+NjHxXKY8ivoeY3Pc/NUX/NsaeijgbyWZS1U8hTmLKQBOeCp+F45GZTRA7ktK
         clRw==
X-Forwarded-Encrypted: i=1; AJvYcCVOWnuehnKnU8SB/+qGWEji+V1le2huQYyoH4T0iLHb8lhSYqjI+GOwJ9Bzqq4ufWwNh5LVeBeq0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YySNJRCoXmfWDJI4MympjhPYL6E66auT5kkxC9od/VSMWqDKi6i
	B0UT2KP9Ts2EmY+IMiAd7L24VqBW5b1hHq8UgzbV1/CbGNnnae3o0PY6TKkohhzj0ZqTKrBzgtU
	cDUKEg2/g4W1aqPnk5BBe06YubhEHEBzcre/jlbb6sFckcXjXHetUmi05/+M=
X-Google-Smtp-Source: AGHT+IGbgHFAvjnDI3n0besczhEzxn73dklx6n6zD4147GTF1JgshLXZC9zXdPDhm2xOATdzBiykBZ5Z0k6ieesaQzBwPzC3dp2H
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7808:b0:65d:5e1:ed10 with SMTP id
 006d021491bc7-65d0e9875aamr2943695eaf.31.1766368998845; Sun, 21 Dec 2025
 18:03:18 -0800 (PST)
Date: Sun, 21 Dec 2025 18:03:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6948a6e6.050a0220.1b4e0c.002f.GAE@google.com>
Subject: [syzbot] Monthly pm report (Dec 2025)
From: syzbot <syzbot+listd49decb2c8809c2806bd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1172    Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 15      Yes   INFO: task hung in rpm_resume (2)
                  https://syzkaller.appspot.com/bug?extid=48dc1e8dfc92faf1124c
<3> 3       No    KASAN: slab-use-after-free Read in rpm_suspend
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


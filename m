Return-Path: <linux-pm+bounces-16558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA659B2A22
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 09:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B67282461
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DCE1917C9;
	Mon, 28 Oct 2024 08:24:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA38191473
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103873; cv=none; b=TmCxFx2Zp8C1zr6OVOVoWgAcbMrhJjvdSK+caYGknu1eDgdOcQgjgyXyB5f8xjlDJTDoh8zwZvRwRZeKouK5JP+MXEdrNCnlUZaSumNw/t3/OgQdw6JI5ayfepXIFNCBU1fhLqj1YrB1OJ2zOI+l/T821fmPiK+Ye+NcT3K5AsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103873; c=relaxed/simple;
	bh=jmC7Pe0GdCl+8d0ZZ5piEpZzEdBQZooAUiwb8lAOGXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lNnRgetOP4pi8Zk5WazdwxGec4t1u4IlIi2vBKfjO41t/aqxRYQPIN7CSSiS44Etdhiv49Qk1k1cdXRd7LZfyStI8VfhcKKOgs1jenHmvE+6ND4433QA5vWWlhlhSx1E4RDJJTW84DXaYAbygK5qlzQI7hoXbOu12ZgTC4hVt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so38667015ab.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 01:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730103870; x=1730708670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKk5yPts4IgoLdOJIpP3s6kZUoBQcwND8hldmTU8TgA=;
        b=HuvXAMs/3zXSKd/jkAm0s90VotWuO/ibNhCS0YcLfEmeggtVtjtVUL86NdzkfjROJt
         Auh290lNTekMOw/Rw1w8kUKslrNAaQB2nfVDdV+liL+UdHmldmDx6YZFbJuZMxwCEFVF
         TrqRqeoy8gUjGH3WI8LUpgol6l6RK8P8ok/7kb06CQhkOC67H0YxL1QdXhcE7qW4njmv
         nBbybPIuzdbtDVnLZeRGJzXDAwc/HBa6n2OagEs+TIfM0iMqYWiP7ZS9mCzMluXcJqeh
         p/CaQm+lrVNYOajOI8PCGpAWLEm7xpSc70JivDswKN7YkPMSFKHo1jvM3gFRJ/uPJtsK
         ChJw==
X-Forwarded-Encrypted: i=1; AJvYcCV++a4EyrJ/aBnq+XtE7XcaKDsV3MlQbMJAQphF5lymLoGaY2tamZ+ZzvyxQ0UlmNq70LOmMQajcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWW1Tb6F0F3hWZ/2llAegn6eEyICiLRDU72/krKoyMEahuKk8M
	g3jxaUSMD83dhtbKgFZdX9PH0cEmaNp5zM4UW/W0cnGNzF+B9zzrkRqXQ/iGllxwze+Wx2fQgOA
	jbNBR+ksto9VX53BqiNUqx0aj5WGgpTgWG8GRDD59o0RvmTn8xUV/K50=
X-Google-Smtp-Source: AGHT+IFJ2lIHo6rEXa8bzLhHTch49rUb7nJG7oBePYxA34HtAIOe3O4gzzh6zlLnjv8fTE9Xt3ciJOvgt0ZzN9DDJmq6dXrxK2+a
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:3a1:a619:203c with SMTP id
 e9e14a558f8ab-3a4ed301caamr52484355ab.23.1730103870258; Mon, 28 Oct 2024
 01:24:30 -0700 (PDT)
Date: Mon, 28 Oct 2024 01:24:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671f4a3e.050a0220.2b8c0f.0202.GAE@google.com>
Subject: [syzbot] Monthly pm report (Oct 2024)
From: syzbot <syzbot+list0ba9bfa5e41159be0b8d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 133     No    INFO: task hung in rpm_resume
                  https://syzkaller.appspot.com/bug?extid=73932f4591b9b973aa0c
<2> 49      Yes   WARNING in enable_work
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


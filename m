Return-Path: <linux-pm+bounces-20633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44DA15253
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 16:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9A188C4FB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECF189F3F;
	Fri, 17 Jan 2025 15:00:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE1509BD
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126028; cv=none; b=QMti5tzWezJH23Ff1yWVnI8DQScWQvwf9uWuxEtJqGF2Gv/X+l0Orc84nOHh0F4S65fEgb5md9MqhY3yq6s678mH4cBAIB7BWgKNmOx1Jdsya/eESMZx1dx/LeaDm5SlmmHB9/XQXSWYcBFT7neygc6IuhQAmmZD52eD4DX885Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126028; c=relaxed/simple;
	bh=pTDaV2ww5xsnzryQI+/1o/FmltHFSUU/4jE6djOvs+U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kibgk10SWsy33CwBz+ScLTTcDGpUA4MtbDbIJaEw4waGrUXHhs2kcmfh2Jt1QUawofw+db9fcwOhbsgsCIVmfcy0ZeQMMH9dhebS7Ktt0iQYPsVVmsNpCh/PHMTfgkfdddWFTNG5f4k/njXI/Ct05BFcwKXH25MPGIRGNR43uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce7c75cae9so25724655ab.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 07:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126025; x=1737730825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyUN2Z+de6JZlPgdKmwrElVvBTbUC/v9Sh1mPzJlkkw=;
        b=YU5gebM6RigQSfCy4PW+EhVjYhKVHsLZ16hRnLgRBYr7qAx1AnA1Hpak+pjotgjQNY
         Uouof9ttd2r+x4ahGImJEK8EXexXLeogO6kt2wCjFcG9JPEIfVgK/fMwOi1igPlQS/Cc
         pE5lxxc6JiDR3A2rgdslVGCtzuHOiBr3u+9yQc9FDfKgTxmaqq+kmLyPcO+rUdqLZ/hJ
         J8nNSP45Qck9YEEcqCix7B+m5wAayZxa5CEKoEtObT1fSj8RRRP+nb2hIGSk7Z2cGKsl
         130g0cxv1iiJutUAp1ipl3jshprOmb9vUejC8hQJ8otrydVSlMVNt16opL6hthmXAwMn
         vccA==
X-Forwarded-Encrypted: i=1; AJvYcCXWGXSCCGlyeh864JtlRfy1LvwgiVRj6OIl44cVgVOUEFYs9Ws6T0mtgqRyW07MXPcDe38tSaFv1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4TInhGejg9I3A/GsQMq3ZZgtwij2TxK5CCRBbI9wcZx3WElr
	0L1hQ/XsnBQzr8gA8jLTRpB2n5KEvwoA21Ux7ghmP5lhczm2+vQ0XaLnmKs+mbXzYmBQwLACv0w
	h3dRfrI854kqYST7BrzgRU18PVQ1dgUJR02JS9x4bujz0GsJ25clJu4M=
X-Google-Smtp-Source: AGHT+IElZZ5yvoOgOf9KfXdwnxqeuP/X1AeNnjEKdISwZF/8EA4wDAam6hKEOLGgO5UNVAbUaaEsBWzarYROQP2yvw8LSHwW5cRx
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d785:0:b0:3cf:6ea9:9c0f with SMTP id
 e9e14a558f8ab-3cf6ea99ce7mr40182725ab.8.1737126025063; Fri, 17 Jan 2025
 07:00:25 -0800 (PST)
Date: Fri, 17 Jan 2025 07:00:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a7089.050a0220.303755.0006.GAE@google.com>
Subject: [syzbot] Monthly pm report (Jan 2025)
From: syzbot <syzbot+list689f60b3f4f50c6fea20@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 466     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 6       Yes   possible deadlock in rpm_suspend
                  https://syzkaller.appspot.com/bug?extid=361e2c54f7f4bf035391
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


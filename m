Return-Path: <linux-pm+bounces-22611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE30A3F0D1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9641889CA0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9F205E2F;
	Fri, 21 Feb 2025 09:41:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB74205E28
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130884; cv=none; b=DpdjDeETxtfShKcbDWLS+kRRbbleADGTbkytydzf9RSnB0qXjC8dv8ej/I9voEmf2yZv7rRkqgywBjqKi9Q9gnN6+5ye1aAVebXqehallMuGARemT1bVBwggDLo23r8sng9ycyEJNBYNkybhCIu2bU/QQkeLUC1TjAuC232jyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130884; c=relaxed/simple;
	bh=ZkkWKXP5VI04+XhhK4BFzZn5nqZ0ICb2qmJ7kldPgGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S+hXVTXuoEabvS1Ig2gLOfS29HYsF1v3cwQZIvZ4N1npK4YP2p0XU45NU+Dzx4CUEs7pRfE1HD3Cc2E88O3rlgVsn3YcrJ2rBwGSAy7cxo9aG0KVVgc1xrmKsF8udqWwOSerJQNTaLFgviOyeAJMLCfo6So777OwAJ7uXG7xCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933a5so14732115ab.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 01:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130881; x=1740735681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T95fukwRaCyhjkDTbTMQl87Lxi7TRA8tZuBkDLMn1N4=;
        b=cKZl4nKih2ppHlPf6aE3rzOxbTL1CW/n7AUqXT31n5HUz0KrIPbEpDHMnHhfxhylLN
         a1Skg60lDG/EbXJLZw9NdB8TmBUgJxZLhJLiEhz3MqMySHrfDwf01wCEHlFVoHXf//Kv
         CFRnHYbUO+SuNg5gOF1ke6xc1AeCEcexoT7yAaQUiHqWsgA3TOaFBMS85B4WGaOcIdyc
         UEIIT7itfeCIFUpXlGWwyMC3/ffG/+gspS1ibp0ibmTnrfIqR9enra9y06kPMbcv6F9E
         qzGwQPETRlP85bw6vY0HeW6LrqiLCagTEbRHQXuUhe73KwX2lnquMWMcCmROPfVjeWGB
         XlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7BLS4SMdrOhIoyiOKWLOP3hl52ju/4FsRUaoD5/NkeGjuSFXDX3xqFsyPWHf5klQO4A3GZ1nsYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwJbw+kpxRQ2AKuRQy/EaEO18ykF3YtWNRAaXnZC1gxlG9H4d
	WxW3EEzeRvHBzmCRmkgL2j2orLd6iv0umOoCuwYa9hkbUJy9KuWTGivlTSy2p2M7d3AR58JtwZ/
	hoh9eG0XxOff1gduXwLjv7+QIS41/YojdhlF7VsdsZ7ul04Uyc8DUlIw=
X-Google-Smtp-Source: AGHT+IEF5bFtK+eCANJbgUQqmfBu+0vXYeTFRBcR8iV7drnQDTpoOIsrcWPIDwV5HrQ9LgxOXhepfrQaeAw9suS96bC1WqcVv1Jo
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d2cae47e92mr26100285ab.2.1740130881644; Fri, 21 Feb 2025
 01:41:21 -0800 (PST)
Date: Fri, 21 Feb 2025 01:41:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b84a41.050a0220.14d86d.0358.GAE@google.com>
Subject: [syzbot] Monthly pm report (Feb 2025)
From: syzbot <syzbot+liste374d52634bb41a6b682@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 586     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 3       Yes   possible deadlock in lock_system_sleep
                  https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
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


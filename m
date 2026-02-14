Return-Path: <linux-pm+bounces-42634-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEcTEFE7kGnUXgEAu9opvQ
	(envelope-from <linux-pm+bounces-42634-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 10:07:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9413B874
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 10:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 093BD301107E
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D72314D2F;
	Sat, 14 Feb 2026 09:07:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE91226159E
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060045; cv=none; b=q94lZjUfs2hSyFqcEf8dO/rOIO90VH3P72+ots6/3/I/Mx5SfG7LfjYIIHw9KVSBtuQYPS1XH/LpTW5f71Rhc9Oqd+PdJjP27gQaK2qCu8wIJxC7SAvpPs28upNfEMnb6AnRULITIekLT7cG1GvAAAD/WE8C0CIPuFHmQPl6N4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060045; c=relaxed/simple;
	bh=NhIZUZvRlciRBm/58ra/e1ssE3Wc5n7R140aJj+JSJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qTQnx5rYncy+CUzWKggLbxGop/9VOZ9B0JIYlj3bO8Kwga6padK2JB5T91hdFdv2GjF55kN8xQ2UHC5dKajtXArj0I75SUj5D17Ooj6QT59RDpfnBKJdRMc0DqoFW7XZgCUHPXfsMlKMtWn7dLTVQsgg5x0Prpqg/QAi7eWB4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-40f10a92fbcso1467760fac.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 01:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060044; x=1771664844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQNOoCfsP3pW0iPjsjgFmJxNldlO/YGcmhI9i2oUzxg=;
        b=bneKgl1VOjsAjB1VQYawmpPCjDIjMwMUP1VXsF14Q0SCuZE7HoRqr6sMrAzbw5k93J
         CHl3sWy+ZCgjjRK37ZriKdPJxRbFCmEZHakkeupTuf5Wr75BVf3qR5K8ro/wHu6pMzna
         OtUmacqV5q7zK/mf2QukMWJ1RQCcW6FHgrBVAxnAb4Q15Zn0KxyFYZAaxrL4d0nMH0/q
         3ELsLUjWpJtYH8ToD9fA4X2rarEmlZVviffVTQ5qH3NickMrpEcYM3hmb7twqt8UNMxj
         Tzph4onyetWuBJcIBMbMmjMnlHSUYUdWRw4dchIzpVuW+QXqNSG+so9ygQ7jhPF6cCMX
         LnXw==
X-Forwarded-Encrypted: i=1; AJvYcCX00iLC7BKUc0WmBOk7RNfRVfEOJ8Gb3CbfY/r0p3LHK5hIFtl8HPygtarigaSfnOzI+yB9lrouBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyetAgnEXDvAMaCww78V5S+EcJAM1F+KN+REhEavCHWRAJEzUNK
	NZYGzIo8y8QepPOL88gUG6+oXRhvJkqeO/xj9nmRH9v3WYgY54LHNY3r0safaOYoVc3/Woywuf6
	2QGPSZ+MY1r7mSFtgRF6WcJdgz2+/PfyjmUTf6guhf/Bxdo6/LvSLZaEFZXI=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c02:b0:676:e126:e7b1 with SMTP id
 006d021491bc7-677697931aamr2336578eaf.70.1771060043763; Sat, 14 Feb 2026
 01:07:23 -0800 (PST)
Date: Sat, 14 Feb 2026 01:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69903b4b.050a0220.3a4a67.00db.GAE@google.com>
Subject: [syzbot] Monthly pm report (Feb 2026)
From: syzbot <syzbot+list549f85dd95a4be76af58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REDIRECTOR_URL(0.00)[goo.gl];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42634-lists,linux-pm=lfdr.de,list549f85dd95a4be76af58];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: A1F9413B874
X-Rspamd-Action: no action

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1321    Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 17      Yes   INFO: task hung in rpm_resume (2)
                  https://syzkaller.appspot.com/bug?extid=48dc1e8dfc92faf1124c
<3> 2       No    KASAN: slab-use-after-free Read in thermal_zone_device_check
                  https://syzkaller.appspot.com/bug?extid=3b3852c6031d0f30dfaf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


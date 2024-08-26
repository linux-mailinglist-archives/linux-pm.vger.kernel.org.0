Return-Path: <linux-pm+bounces-12879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508D95F331
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945912851CE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72F153828;
	Mon, 26 Aug 2024 13:47:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD028FF
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680043; cv=none; b=hDMUcZzPtYpk1e0dm3usl8K+jgKEVpAgVOIDJR11RsALRU0dS9+k7DdhNyTDJ68JtqxrghHkWti8Blsc+BYkmfyaorJwHBdH+8A1g1lD8XkMx3rna/DogIqJnggb0Teb3toOtkSFs7rGRd85xRQChnrCujgE8kxzv1AfV7TqFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680043; c=relaxed/simple;
	bh=GrLK19NFTDZi0n7+WwEX7ZFQ7xccyFq2j2t2PaorsKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gwqU24I9Vsn+GcB7U+jxB9YlmUpaPiNOtzil12Kiu/cSwh1//eFvNhp5t/DkWhyy6eE2dDOTdy6IFgdXPvEMeQgIlhgDEJoKGwVfCUB1zEw9BZ99cwe7OHDU5j5Vug4Qm0JaiNaIb/LUZTWQ5FiMv4VOtcW4OvG3Ai8MZNgyfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37642e69d7eso33247825ab.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 06:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680041; x=1725284841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/v4DElyEzXK/XGFg6yIMB6qgM5jU/tl2EiZvQsE5kQ=;
        b=eRksKo2Xw80D+Lc/pIMA8ow4nXXIS1yb57/lnH3+QeCePB7iup0I3fhO+CnGM1zdV1
         g8esCem6wTkQ9xDXp5YarVyXjYGsVd/ydbcskqgZeZFCm5u5jSrpBGLOQcix0QDLtF3q
         D3PMP5I/Y2tjIcsY1VQj7d4mbe+tHMDB/lQci0OA4TDPZajs1BaAQ47x7c3Gzk92dX4Z
         YsfUYmwPqe58FYyrg1fKa/6pv5sHxSQ190Y+dZDatOIlNKh4qrlKZTADTcTU6mQx32sX
         qTVvf4AqobCbgiO7G9no/zNK8uzbrlCdCoUVyYpmxDgmEocn8iKuozTRGAjHtA9jPPLU
         4Y5g==
X-Forwarded-Encrypted: i=1; AJvYcCW37kbv1Q97KyAeQbtIIOH/hh32iT4lor5spm3MvEttzhumPGEpSJNaZlNlx+QMe7PBocOt40Dq5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFdJuc4gZho6oAN5RxEQePlZ6yewrXnJeCGKV2ENm5me4fWaT
	YsaTuzPeGCtfMwdAkLuCV2EqJGqq2oT5rk9xYaflKZqXZlq5BU1xYHb7h/TQ8elqAjOvuQJishy
	mUglisjQLOts2Zpl7xIBlstjkFWp7PYEIxFYjS/7LXjxZ8xA2NnVuvKw=
X-Google-Smtp-Source: AGHT+IGOYYbt7z1oqdAjWn68/nHeAdcfKU+VkfNGz/d+8uKjbo6pu6GEM1SxmtobT+lrwQx7IbDOKVEGw53NaicXz2Ij6mBY8VRY
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39e3ca0d1c2mr6727295ab.6.1724680041185; Mon, 26 Aug 2024
 06:47:21 -0700 (PDT)
Date: Mon, 26 Aug 2024 06:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034d59d0620965db3@google.com>
Subject: [syzbot] Monthly pm report (Aug 2024)
From: syzbot <syzbot+listeb96f98dd6da9fc4b8b6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 202     Yes   KASAN: use-after-free Read in netdev_unregister_kobject
                  https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
<2> 2       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278
<3> 1       No    WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


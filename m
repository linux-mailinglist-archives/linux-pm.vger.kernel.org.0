Return-Path: <linux-pm+bounces-15958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35F9A3F6F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B8282B17
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768691D3182;
	Fri, 18 Oct 2024 13:21:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D221CDA17
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257664; cv=none; b=HXF7ebEJn09BcUczyahkji6z6ab30qjBwPp/LDi+CCwPO1QFwLdrHOiqV4mnmlnGwgtp6o/PmiYhl8hcATw5tq4WBiAHE8WdQaaDN1cLLHjfLV8xltdVN0gSAozTPPu1bX3S674Knxi8LXlRPrXCjJb6Xo696Y+VEiGQKymNITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257664; c=relaxed/simple;
	bh=J2ISKYJq+P9aWYzcvEmJNTpTQm3p+pYlylkV+zAb+uc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KG29uCPydyYrjSiOaLMD0eSaroGvtt5IStZgdrEgwtwbpAyMkvPHcLDx6jiH1321i7fNT0/OER4G0f8ve+fNMzhFFISq22e+ANW+iCHHczaCAhHvQAEg10o9mjc+62JuKc1ahdGKrSCFcWCfO0B0hJ4ZnyEoyAnJWdEBHOHhK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so20885345ab.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 06:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257661; x=1729862461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsYwuI0Th+uVtMN7AlSOhFIFxHsr2HBMLpKgQ2C5NDw=;
        b=KYDu7q3qb/VDwqUbB3ao5NMUheRUZNF9zut1u5I+fO9w5Y69hVa/qKvq+V+giBJJHY
         AhGufHkXgqWlHb9E3Usb2fgwnh98XqkL/30pn3J/i5CL99XfcUiN3fHN3e4xu26YiO0X
         e/Z5L0iHo52ya+kUWGaIuEC06aTIR4UmrsN92DRyMOMoWRGO6Rn1Ua+n2VgV+VzV3m9S
         YipbehNwpDLWAziHlbQSiImMpZdn+OJahnt05Ndn3SMzYUUWqg+npifPsC5d3Rapw65j
         2HvH7sQ0KMbmpOnaA/YFkga8D7u0HctLLpYEp1vJx+6pkpMJQ6RwTuPQ7KKOP5xopPH0
         JkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrGc69PQKAzWVdClNpERhWiNXbL9tS50I+2d/A23v8nCKzwVeVZE9/pfWsx1HaP3WYVAchvLwLkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGC/K/PLkVqI5odx+tQeoDUBexg+qROeO7uVpflVtFof+OUyT
	NkdE2W28n0PSpPCkfbkx25lVirT5PzzYERHXykqc8xKsW3bTLEsBn7zYPbC+h+eGPkx5gQV7kn0
	3aJpXdp5/ywtYyzjs8qI4owyEBKMisuIEJpVkQmdYRVFV6y9MH/UWuaM=
X-Google-Smtp-Source: AGHT+IEBJH2H0YkAN3+kej2jAA+6Y4/nJq8KL+MjWGl3zwECcftJ2IWflNZlanDCdJEEAH367yNS/cixQ+dw4rG7mqrgBuHaxm1q
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:3a3:9337:4cf4 with SMTP id
 e9e14a558f8ab-3a3f40500famr20935825ab.4.1729257661749; Fri, 18 Oct 2024
 06:21:01 -0700 (PDT)
Date: Fri, 18 Oct 2024 06:21:01 -0700
In-Reply-To: <67124175.050a0220.10f4f4.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
From: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, daniel.lezcano@linaro.org, elver@google.com, 
	jannh@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, rui.zhang@intel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b8c8ba73c68bb3c3e9dad22f488b86c540c839f9
Author: Jann Horn <jannh@google.com>
Date:   Fri Aug 9 15:36:56 2024 +0000

    slub: Introduce CONFIG_SLUB_RCU_DEBUG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cc4c5f980000
start commit:   15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc4c5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=f24dd060c1911fe54c85
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1192f887980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417e830580000

Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
Fixes: b8c8ba73c68b ("slub: Introduce CONFIG_SLUB_RCU_DEBUG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


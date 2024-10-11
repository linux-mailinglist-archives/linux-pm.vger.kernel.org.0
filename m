Return-Path: <linux-pm+bounces-15534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C299A04F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 11:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21A71F2259D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45C20CCD0;
	Fri, 11 Oct 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSkibddR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA319413B
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639858; cv=none; b=uqRCC76ugCy4zJPYbMw/qVq1ozO6bTDg79VL2VpsSMRZK38Xwj88WLVWVE8ji6jYwaePllkn7Mstnuv8UOG7ls/djsXEltAuJ0JBeta9qHPe4LYp+tCga5F/vtN/qAHaBLkxA6gbkN6f2jOS3qSDPzhT9YhnNlV1BvCa3z0PWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639858; c=relaxed/simple;
	bh=8aQ6J79fQfCrxuHKR9Fn/uk4gMfL8jKvRrtRNj0C+38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Up227xTZVWAbQ36o+/XiIk0DHFRUXKcuTYdW7umDjRDk4E8uErKWdGNOJwvitJpS8Oc6INoWvm8vZGYqjS5X+ybFzz/rHIGQnMKaGPu4K6c7oPgNsm5dMtODBhpOvD9AnXameHRLbP9X9CC3b2eMiJBfzzhBK4caEaMjyNZYiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSkibddR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1521047a12.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728639856; x=1729244656; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+Nh6mE3eJyVTicxPgevEK+F//iCb2H2eXpbFWvWH00=;
        b=NSkibddRfVva1v9/48vj4GgOuq3S7CCF37w+HlbRPYdinMGCpYpVJP3LwXCgj0bj8Q
         pm/dfkgqYzWoPxmP8Axgn0pouO97gSFyR6plm762pSgcw8ZNxyV5D3dqFRFaQjn30Zmu
         Dke49Cegzc7pljuq4sZknsdop0p6+LVuAo+IwTtA/+GyDlMWFB6zzFr0NzijmYyKwJSU
         cH+Z0nyWNJbrZukyA5baMDymRIq9vdOYKx04a2ZOfp8Xqm2i2s2sG7cx3Ulgid78TV2e
         X1TPDNs/pdRWrmS5oDCoWF+qmmtuHX1cY8FqzOCZGiyRe6eEEIuEMOl1L0EWvGPqxP2V
         asTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728639856; x=1729244656;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+Nh6mE3eJyVTicxPgevEK+F//iCb2H2eXpbFWvWH00=;
        b=Ym2ttarxBO6O578pkA5aggXSKvjl4TVAbU0GNnHB6GDV+TcHX9QVvS21Gri2xxoNQy
         ELTEIpvktdyElK4tjuEb5wuUX4JUoJmpA8WB43fB5KWuTX292bh8Qam0hTGIfHEFf15O
         wiE2ub8542xKiOVtcBhBSMw/MXM9FJxjRVN3TAzS2rHkzJ93O3rLTwDaqpNoNr2az9b3
         2fuS2SQ2vLVTAjxTzo3Y4AdXVGIQYq//vrVDrEnMhH/CFKbHR93w2P3UbbLHO0OIIfTH
         TQLVumnzTcJxPf7DzeKtge5HKDA1ehtm3zHR4Sx9fEsSZS4PimNnvPhJsSs/UXcRk9nz
         yXIQ==
X-Gm-Message-State: AOJu0YwRwBWBxjA7RARARmycF0LUFMcqd4yx00218UAwoW7K7yyP4tzi
	GmAUkJ+lXWQeaPKPpnkftpRYHsYhlB8Y74VDATt+WFxbxcLMqL9tiZXUEbUOumij22rtbCxUveb
	Yo7WjJtXuT2EYEfmwv1tqp1l/UOvnxpGI
X-Google-Smtp-Source: AGHT+IEINHlVlEnaCkcmEkBdg7Lqkibjyjp22h5mmqhDc+flUnu6QcpAXk3uY9Gc0G8NuIEhF+A2yDU1vECGlvYUxIU=
X-Received: by 2002:a05:6a21:4d8c:b0:1d8:a3ab:720e with SMTP id
 adf61e73a8af0-1d8bcef69b3mr3115938637.3.1728639856515; Fri, 11 Oct 2024
 02:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Fri, 11 Oct 2024 15:14:05 +0530
Message-ID: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
Subject: ARM64: CPUIdle driver is not select any Idle state other then WFI
To: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi @all,

I am working on one custom SoC. Where I add one CPUIdle state for
``arm,cortex-a55`` processor.

idle-states {
      entry-method = "psci";
       cpu_ret_l: cpu-retention-l {
         compatible = "arm,idle-state";
         arm,psci-suspend-param = <0x00010001>;
         local-timer-stop;
         entry-latency-us = <55>;
          exit-latency-us = <140>;
          min-residency-us = <780>;
    };
};

I am using ``Menu governor`` with the ``psci_idle driver`` in its original form.
After booting Linux I find out that the CPUIdle core is never going
inside the ``cpu-retention`` state.
To check time spent by CPU in any state. I am using the below command.

``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``

OUTPUT:
0 ===>CPU0 state0 (WFI)
0 ===>CPU0 state1 (cpu-retention)

increasing some time value ===>CPU1 state0 (WFI)
0 ===>CPU1 state1 (cpu-retention)

increasing some time value
0

increasing some time value
0

What am I doing wrong? Why does ``cpu-retention`` state time not increase?
Any pointer will be helpful.

Regards,
Vivek


Return-Path: <linux-pm+bounces-40604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFAD0DD73
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3575301671E
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F103521A434;
	Sat, 10 Jan 2026 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acvyhck0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB241DF25F
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768077827; cv=none; b=c0uq3VY0vv56GpWBoERsn+gccJkKPQ4RsTeHFmqrcjiIPf60OTxWlW8s+EB3ssY6u/Rn4igLiK9/2Um2gzT1OhF/Q208L38b5LlLq9CkhfUfuv3FRVlV0u5M1YcY03aKy/mT5qT/4MWw5WRMDcUD5BxUcA53xfdpe0wRyBHHdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768077827; c=relaxed/simple;
	bh=A+W0xbk0+zRrB7Jp4YvTs8Zwe0xccefwhCGmrjWwocU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+kAjzOBUwMY4h9gvV98QpdwgvWd4K2ImvnKcsn6j+RHaYf21f5jvS7I1FfZZ3ZqW2IcU2OJvDbIenE4D4FmetkvyTlEuxRucgWj0BgYYaABiYqvBDy9QwXqbgyKOUdX+Mqif1MHpOBE8fugD2SqLKxP6TFUEH7s/9rrAl0R5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acvyhck0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so187642b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768077825; x=1768682625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gab+lJvv/mboOC7S9VV+ri8/78oU/QOSV7JcElBVbJs=;
        b=acvyhck0xxjwfFIhEdSPKiDXXB6/lIG9NGAS/FsXIRAqgG5iLYDmJa76wSB7QmoQws
         JUDSvJAY5JrEWqF8c/kJF4OheY6UlSKhnzqY5hjUqHcxETBCQpXSdWRaX1rqvt9SVEAX
         EsydFxLwxRt7PPqVn3/nP/qdBV7XCSxDF0Sr7NwNFIJFqZWsdSRUdXSxpULGcuKCaP1/
         lIzRwIZP8YCc+lyjX+PfoUHLi63dGEr6f0VdLDgPF8xS6kz8gUvHZYNV4EzzIEIB9Cxm
         gthCasqRXPCr8FaUmT1Px0uB84UhdnJQKlBgZUw+H7NGzdJoWEzzxbWekvagJXUqDoll
         jFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768077825; x=1768682625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gab+lJvv/mboOC7S9VV+ri8/78oU/QOSV7JcElBVbJs=;
        b=YZZN1mGeeJIW6W+aRWe2ssPmvZGHGPnJ29vitauYmTZxd4YNZAHLSaWHh54n2o3voF
         HPiLYG2NcfmXm2jIViS4eB4H+K5V2hy3zKLJPLpfzoPU6A8oHLp51OaVbWpIMpBG+aLr
         EKkpf1FCui44N2KMIO4+jvyclDHs6KVV4rfUzhxkMkAmqLeCSDphcHjBCdN/5YnU4Vj2
         n0Y4rQgXzD/cKbnsdhNGCFK7bwNu1TY4KO9zoCJ5pvIAUYfvXeOklnWx0IkdaoZAV93v
         lTS0QOOlRXUHK6cdvtVCTWatZrVPIn2T1XVxVYvYzbNYqdjUczl+0w0Amz/qYxhlbBRn
         Mo5w==
X-Forwarded-Encrypted: i=1; AJvYcCXdJ1mBhycSWdvYRjBSOnEPNZqet1Yb2OZFE2R9x6Huj5J6cOSONFTNt3LRXAG9FBnSzgYKXtJRNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOo8+g2RbKoNhqPhnDzqbZVdVAzVWa6/+P5J3jk5MaEjgjHGm
	W9qjXgI2A/6FpKYUz3DeY4oyS9No5RANvLhWq+vZ7npQe1Rmt1h5RLNG3S26kA==
X-Gm-Gg: AY/fxX5WRkFmrKCOJ6+uw3vJ0FX4rhVg/HTeeFXAtah3jWWcVxZjQhhZ1xSUbfxZVLE
	cONhg0vsuDn+F5n/7DM/B+FSMGw08zGmKmYss5g5/aWJIPQIP2HxmWcaF2PRUwUSfzqCRkCPwT9
	0C6PF3jbvJNFwQ/Rsvt7AoC9I8q2Wh1SPfnXcpVD1L0MU8Kav/eKjJJUaUfaWxv61baD8Xal6b+
	JSgaIK/yo18FvohexxClHiwIzjajuUCtn/EInMOidyUO//uizcozG2KCLU0uXKHCWz2XU21HbXy
	MltdAN3RAMUN74HpVLiKFwMSGZlNNRwJzQGZ85ymngfn0fpsP8TNJv9xA6FPV2knTtBfgeToWl/
	Cnmscilr0S3ibivfTs46LZgj7cCyUUkB/sNnCjucA7S+XN363cswynUcJiGz4Ixs4WBl0C5JmiI
	4LWmH6yqAIZoL4CSMjGsY1y+R4Yrnl7C6pt5WfCy/kyXYkinUnD6ETS7pmvQ==
X-Google-Smtp-Source: AGHT+IEFhIWWLTszvWaJvJLjviKPKe2GeMsrNAUILW/iBYbvjE1a/2u9gukrm/pz2LXkvZfPeHSLbQ==
X-Received: by 2002:a17:902:ea04:b0:2a0:9040:6377 with SMTP id d9443c01a7336-2a3ee42a945mr123670065ad.18.1768072230671;
        Sat, 10 Jan 2026 11:10:30 -0800 (PST)
Received: from google.com (61-230-24-179.dynamic-ip.hinet.net. [61.230.24.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7856sm136174865ad.68.2026.01.10.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:10:30 -0800 (PST)
Date: Sun, 11 Jan 2026 03:10:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: quic_mdtipton@quicinc.com, mike.tipton@oss.qualcomm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: debugfs: initialize src_node and dst_node
 to empty strings
Message-ID: <aWKkI02I-zgf3h0W@google.com>
References: <20260109122523.125843-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109122523.125843-1-djakov@kernel.org>

Hi Georgi,

On Fri, Jan 09, 2026 at 02:25:23PM +0200, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> The debugfs_create_str() API assumes that the string pointer is either NULL
> or points to valid kmalloc() memory. Leaving the pointer uninitialized can
> cause problems.
> 
> Initialize src_node and dst_node to empty strings before creating the
> debugfs entries to guarantee that reads and writes are safe.
> 
> Fixes: 770c69f037c1 ("interconnect: Add debugfs test client")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>

I verified this patch on qemu.
Without this patch, reading the debugfs node triggers a NULL pointer
dereference [1].

# cat /sys/kernel/debug/interconnect/test_client/src_node

The patch resolves this issue. Thanks!

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

[1]:
[   53.134642] traps: skippy[737] trap invalid opcode ip:7f125b62e967 sp:7fff26f593c0 error:0 in ld-2.27.so[25967,7f125b609000+2b000]
[   53.171664] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   53.172274] #PF: supervisor read access in kernel mode
[   53.172556] #PF: error_code(0x0000) - not-present page
[   53.173103] PGD 0 P4D 0 
[   53.173433] Oops: Oops: 0000 [#1] SMP NOPTI
[   53.176057] CPU: 51 UID: 0 PID: 738 Comm: cat Tainted: G                 N  6.19.0-rc4-virtme #2 PREEMPT(voluntary) 
[   53.176747] Tainted: [N]=TEST
[   53.176964] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   53.177493] RIP: 0010:strlen+0x4/0x30
[   53.178437] Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <80> 3f 00 74 18 48 89 f8 0f 1f 40 00 48 83 c0 01 80 38 00 75 f7 48
[   53.179507] RSP: 0018:ffffb279018ffe10 EFLAGS: 00010246
[   53.179831] RAX: ffffffffba33cde0 RBX: 0000000000000000 RCX: 0000000000000002
[   53.180215] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
[   53.180563] RBP: 0000000000000001 R08: ffffffffb9061ec0 R09: 0000000000000000
[   53.181030] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000040000
[   53.181366] R13: ffffb279018ffee8 R14: ffff8dcec5c30540 R15: 0000000000000000
[   53.181803] FS:  00007f54fc097740(0000) GS:ffff8dcf4145f000(0000) knlGS:0000000000000000
[   53.182251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.182541] CR2: 0000000000000000 CR3: 000000000838d000 CR4: 00000000000006f0
[   53.183078] Call Trace:
[   53.184925]  <TASK>
[   53.185202]  debugfs_read_file_str+0x49/0xf0
[   53.185961]  vfs_read+0xc2/0x3a0
[   53.186195]  ? __hrtimer_run_queues+0x160/0x2a0
[   53.186442]  ? __pfx_read_tsc+0x10/0x10
[   53.186634]  ? ktime_get+0x3b/0xd0
[   53.186974]  ? lapic_next_event+0x15/0x20
[   53.187147]  ? clockevents_program_event+0x99/0xf0
[   53.187374]  ksys_read+0x6b/0xe0
[   53.187563]  do_syscall_64+0xa4/0xf80
[   53.187867]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   53.188365] RIP: 0033:0x7f54fc129687
[   53.189177] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   53.190393] RSP: 002b:00007ffde7e25960 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[   53.190900] RAX: ffffffffffffffda RBX: 00007f54fc097740 RCX: 00007f54fc129687
[   53.191488] RDX: 0000000000040000 RSI: 00007f54fc056000 RDI: 0000000000000003
[   53.191963] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   53.192351] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f54fc056000
[   53.192776] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000
[   53.193345]  </TASK>
[   53.193572] Modules linked in:
[   53.194157] CR2: 0000000000000000
[   53.195723] ---[ end trace 0000000000000000 ]---
[   53.196335] RIP: 0010:strlen+0x4/0x30
[   53.196556] Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <80> 3f 00 74 18 48 89 f8 0f 1f 40 00 48 83 c0 01 80 38 00 75 f7 48
[   53.197634] RSP: 0018:ffffb279018ffe10 EFLAGS: 00010246
[   53.198037] RAX: ffffffffba33cde0 RBX: 0000000000000000 RCX: 0000000000000002
[   53.198388] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
[   53.198793] RBP: 0000000000000001 R08: ffffffffb9061ec0 R09: 0000000000000000
[   53.199193] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000040000
[   53.199544] R13: ffffb279018ffee8 R14: ffff8dcec5c30540 R15: 0000000000000000
[   53.199959] FS:  00007f54fc097740(0000) GS:ffff8dcf4145f000(0000) knlGS:0000000000000000
[   53.200322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.200615] CR2: 0000000000000000 CR3: 000000000838d000 CR4: 00000000000006f0
Killed                     cat src_node



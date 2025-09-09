Return-Path: <linux-pm+bounces-34193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634E2B49F5D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 04:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5102A1BC54F4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A652566D3;
	Tue,  9 Sep 2025 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IfmFqjJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC09222565;
	Tue,  9 Sep 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386027; cv=none; b=dle4YlJH6ynmrqUfuYEwPaH/V5gsBpn1S7Pw23r74/YTGoCpGVde1REMbw5dqNlMtxTOxITcm+Y/8Niqskg7EksCjhxgC7w05DeoRCu9PjgbO74guKbkEs8CuksZ4sQevVXaR+yTKiGJGxLMgP/unlbilfajrweAsZvbx+snsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386027; c=relaxed/simple;
	bh=YFytggKE3/r0gV08mg1HQPgEX6IZRGpx2+YlNZw6fAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbx4yFgaWr+tZNUz7Rbr5BhLhD5W3nbqoPpSVW43mwk7su8ZX0pEJLO94FA9iV62YJahwj6Kbf+tf4bEJl+ATbLyAsPaqHBpkesysgW2s5HjaxUaboiF2udzdccXFJx7M86ghnJhXcVITqwegXN2QFehthhKmhAwiDZWwgJKn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IfmFqjJc; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757385968;
	bh=L8hQjVh+mUDXEkjLruGWrolOFzVSakfWaJvc2hCg9Og=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IfmFqjJcCewu80yU6qKrv5g330Ul224g7PlqjzOQZ9jMXloSqwzGlTZToc3BbgKbb
	 swI7enqWxbSpxwnDi75ad/7eQmgO5lYAWCwr3AuYiO04ywaqJrKZ1jzRbhQpxyeOp5
	 +WZzTQM+CHknEOn23yYEIqoBBheSm19ssEz+l8cs=
X-QQ-mid: zesmtpip3t1757385941t961e95f2
X-QQ-Originating-IP: Frk8i664kPPQ92DA/s1R2O/T5OFzVpyT3+ZbamSxsLg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 10:45:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10612580091879111053
EX-QQ-RecipientCnt: 9
From: tuhaowen <tuhaowen@uniontech.com>
To: saravanak@google.com
Cc: huangbibo@uniontech.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	tuhaowen@uniontech.com,
	wusamuel@google.com
Subject: Re: [PATCH v2] PM: Add configurable sync timeout for suspend and hibernation
Date: Tue,  9 Sep 2025 10:45:38 +0800
Message-Id: <20250909024538.15946-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAGETcx_C_UcjjPOfUip=L28P3PWjMvmSc4nZJ5ML=tScUXfk2w@mail.gmail.com>
References: <CAGETcx_C_UcjjPOfUip=L28P3PWjMvmSc4nZJ5ML=tScUXfk2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NThgMOl/3vH7i0HA3LKp1KM4UXA5K0mrxeL6HzDodXUx4X/U1aC9WXeJ
	NTIVcc1yl+xPTL6kKivuJEhR2BXm3Ddzl1ybeynSSWZ0m48Hxuy4oAEpAQkap4uVY/QGpGA
	ucbQYggLhKUoaONOWjyli1rfuxJUX5UEYubXLwhoBwi2TE2q/9noyPfmWi85a7EGEeI7UEZ
	Yj1XIfPCPU2IsJmEn4MXC1o9G9WFO0+4Wlpfp7TfGZaoc93tuywq8IwlpLQZnTZZstCvXLc
	Y6ppd2bvoAQQQfqEZagl8Q22U17CIcjWfLc1jw7jsnuiNivHJiUC8HlVBzk4nAquJYrImhF
	lagxy1D+hgrhn2hHMKywHAnM232T0LSmzF4d0S1SYjqUPSMQdzn8bKworXuGEmyMsD1sjRm
	k7loI3AsJvjklUB1GiZGxCUYJX4iEG3Qs5/RJNZY5EtufK8Q4Lc047X/TZI9oEjmKpp9n7j
	+AK8bon0QsHU2RkUV0RnEVJcoEFTU40d66mmAV5jfQKiu7SBxVb/ABSWG2m7cFrzL+jI2ZE
	UnfO4qUHtg+TpuR+CD4TiA8vB40CrWkYVAKl+xwd4xDkcZ5uL2na0ZLf3RvvpUdjAbclJod
	gRRJ+tuc2t2aWBF8G0bRC8pVqh0qy0Hj5pPD0XcwEGWJoJHTfaa4X0wjLdWDgD74RwRfMDH
	nahcIf1bzAgkfnqtN+g/J2BUY4EHB1oxyCV2AvieiZ+xZg34n0MOyXF3jxwhk9c17NZ3V7f
	J15T0JqR4k9lrByVhCtV3T+KtfUdF0iQ4wuolAtIRZjmHJXQoSFAIeDllOyQhnkP4bbsst7
	iHDWd+hmR3rWY8NYybIKWRo2exHsiYGtXtftmwMLUMVt3VOPmUslXfIso3c8WKBonB0VHFz
	qd3iZxTxTVVHQ5RmgXAZeYHNRBX6WlkxDvW9R88BZ5hw8o4ahmN5W90tUj10AQBd/dfSLJ8
	KLlt69t/SCx7oMRUoovxREyCtnSdbrDb1kyj5Q3AyxEmCkG1mxFxtJPGK2oy962qjZh0njG
	1pPpKYpQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi Saravana,

Thank you for your detailed feedback and suggestions. I appreciate you
taking the time to review my approach. Let me address your concerns and
explain the real-world issues I'm trying to solve.

> This doesn't really fix our issue where we want to abort suspend only
> if we have to stay awake. If there's no need to abort the suspend (to
> deal with some user/wake source request), then it's okay to take the
> time to sync and then suspend. If you abort the suspend, it's just
> going to get attempted again and in fact waste power.

I understand your perspective, but I'm addressing a different class of
problems. The key issue is user experience and system reliability when
sync operations become indefinitely blocked.

> I also don't understand how your patch fixes anything. If anything
> this makes things worse because the user might have expected their
> device to have hibernated only to come back hours later to see their
> battery dead. And even if the user is actively monitoring it, you
> still need to sync the file system fully before you eventually
> suspend. So, this doesn't really save any time or the need to sync.

This highlights exactly the problem I'm trying to solve. When a user
initiates suspend/hibernation, the screen goes black immediately, giving
the impression that the system has successfully entered sleep state.
However, if ksys_sync() is blocked (which can happen in several scenarios
I'll describe below), the system appears to be suspended but is actually
still running at full power consumption in the background.

The user has no way to know the system is stuck in sync - they see a
black screen and assume suspension succeeded. This leads to exactly the
scenario you mentioned: coming back hours later to find the battery dead,
but with the added risk of data corruption since the sync never completed.

> Can you explain the actual real world issue you are trying to fix? If
> it's the UI hanging and not responding to keypress/mouse move, then to
> me it looks like those should be marked as wake sources.

Here are the specific real-world scenarios I've encountered:

1. **Device removal during file operations**: When copying large files
   to USB drives and then initiating suspend, if the USB device is 
   removed during the sync process, some filesystems may not properly
   handle the device disappearance. The sync can become indefinitely
   blocked waiting for I/O operations on a device that no longer exists.

2. **Faulty storage devices**: Slow or failing storage devices can cause
   sync operations to hang for extended periods, making the system appear
   unresponsive.

I've observed stack traces like this when the block device is removed during sync:

```
[<0>] __switch_to+0xd0/0x168
[<0>] iterate_supers+0x88/0x118
[<0>] ksys_sync+0x48/0xb8
[<0>] ksys_sync_helper+0x18/0xa0
[<0>] pm_suspend+0x260/0x3e8
```

In this case, ksys_sync() is permanently blocked and will never complete,
even though the user believes the system has suspended.

My timeout approach provides several benefits:

1. **User feedback**: If I set a 1-minute timeout and sync doesn't
   complete, the system fails suspend gracefully and returns control to
   the user. This gives them clear indication that something went wrong,
   rather than leaving them with a black screen and unknown system state.

2. **Prevents false assumptions**: Users won't mistakenly believe their
   system is suspended when it's actually consuming full power.

3. **Allows recovery**: Users can investigate the issue, safely eject
   devices, or take other corrective actions.

> However, if you are really set on proving the need for a timeout and
> implementing it, you can always add it as a separate patch after our
> patch lands. You can set up a timer to call pm_system_wakeup(). Or
> just grab a wake source after a time period.

I appreciate this suggestion, and I'm certainly willing to coordinate our
approaches. However, I believe the sync timeout addresses a fundamentally
different problem than wakeup-event-based abortion.

Regarding your concern about sync completion after timeout, I want to
clarify that in my updated implementation, I've removed kthread_stop() to
ensure the sync operation continues in the background even after timeout.
This means:

1. The suspend operation fails immediately with a timeout error, giving
   the user feedback
2. The sync operation continues running in the background to completion
3. Data integrity is preserved while providing responsive user experience

This approach ensures that we get both the user experience benefits
(immediate feedback) and data safety (background sync completion).

I believe both our approaches serve different but complementary purposes:
- Your approach: Handle cases where wakeup events should abort sync
- My approach: Handle cases where sync becomes pathologically slow or 
  blocked

Would you be open to discussing how we might integrate both approaches?
I'm happy to work on this as a follow-up patch series after your changes
land, or we could explore a unified solution that handles both scenarios.

> In fact, thinking more about this, you are generally having a problem
> with suspend taking too long to complete. Doesn't matter if it's due
> to file system sync or anything else. In which case, you should just
> use a timer to call pm_system_wakeup() and not fix just file system
> sync (which happens to be the current long pole).

This is an interesting perspective. However, I believe filesystem sync
deserves special attention because:

1. It's currently the most common source of indefinite hangs during
   suspend
2. The consequences of interrupted vs. timed-out sync are different
   (data integrity)
3. Sync has specific requirements for background completion that other
   suspend operations may not have

I'd be very interested in your thoughts on this approach and whether we
can find a path forward that addresses both our use cases. I really
appreciate your patience in this discussion and look forward to
continuing our collaboration on this important issue.

Thanks again for taking the time to review and provide such detailed
feedback.

Best regards,
Haowen Tu


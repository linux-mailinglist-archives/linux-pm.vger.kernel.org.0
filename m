Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24B550DB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfFYNy2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 09:54:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39141 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYNy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 09:54:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3062529wma.4
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wgmCRdWeMADRLl2IN83fRZAyv4ZPYOqJyJ/xhWpFO14=;
        b=bdNHuOzPGeplfikViEOEhAYS/D3RaE6dUdIK461Z3B5t5jwpHXXjLsOxKDr71XWhsk
         chk0Z12S79AQ0rh+MNH+TMINxUijIiQ/SSgp4DbxzWKOXJJH2EXmKdZ7mULl4b3hr7fl
         F9J88GBIIPj7jraEdrsd/HmhllrdLs4hVEBgMEFCU9Gm9vf2QZj/1inFKdx94AEque8h
         0dcdB5iqlL3SjWFXEnUpvY9v10EuyyGaU2IvwtoGCqitf24ySIUE5SlAXoMvZzGlwIbj
         73j6B55v+lWQLgS++nqzo5llUXrioyZ3tSyqtCd4Lhr97KvMSHwtSRiuKe6lwrfD9Pjm
         cCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wgmCRdWeMADRLl2IN83fRZAyv4ZPYOqJyJ/xhWpFO14=;
        b=LWjd8vSyEzvtTmaYMkCylrIXhsOWa1uWF+HFdI8SmKJ3JW9XTGCsnreo26OCCJm4UZ
         z68gPmWt6Suql2mnCfoIt1gCxVc/uH+l31hhbl5kNB73SuZm6cq0MT4eugDPOH1P/SBL
         Y3NIx8UG2A9KU/3AKkCZmu9GH8d2JgLC+5KwEgj+L1+FfRdsC0J6kWnopNd71dyVxECj
         mAzk98zBYiwVXe3xdCy48ACRjASkfUnpQmLCMUwicPuKa6uskTlM3H7QmALat1wwMvnL
         AZgk1ggPBa2BwUv1QfeWOGxcqDPeJkev/11RvmVu16YCx8n7be2iN3I042DACIoFZyAu
         qlXg==
X-Gm-Message-State: APjAAAWckMvibK32aE53+uQPr2mrPStFyTkglSPkoy2RUXsWHgyR1gjO
        3Ws/yBp9alK5xS8DWKUvS9JZLzS1qrir+w==
X-Google-Smtp-Source: APXvYqz9g+RysU7UwjVtpyNN8A9dvGNT0P4kStL54IwzhWC0Y1TXD5LazH8Fw44VRQz1HyBcY9Cz9w==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr18366722wmh.134.1561470865609;
        Tue, 25 Jun 2019 06:54:25 -0700 (PDT)
Received: from numan ([95.0.155.39])
        by smtp.gmail.com with ESMTPSA id y4sm3393490wrn.68.2019.06.25.06.54.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:54:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:54:20 +0000
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        guido.aulisi@gmail.com
Subject: [regression, bisected] Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20190625135412.78d4e4c3@numan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If laptop is put to suspend or hibernate by closing lid, via power
manager or by using any other method and then it is resumed/waked up,
keyboard is not responding but mouse or trackball can be used. Although
I can wake laptop up by keyboard, after that I am stuck at the password
prompt. This bug is present ever since using 4.10-rc1 kernel and mostly
on Sony laptops. The last working kernel version is 4.9.0-rc2.

git bisect points 9d659ae14b545c4296e812c70493bfdc999b5c1c 
as the first bad commit[1].

I tried some kernel parameters related to i8042 driver:
i8042.debug=1 i8042.reset=1	keyboard not working
i8042.debug=1 i8042.kbdreset=1	keyboard not working
i8042.debug=1 i8042.nomux=1	keyboard not working
i8042.debug=1 i8042.noaux=1	keyboard working, but touchpad not
working

A user reported that on some rare occasions, keyboard responded to key
press but it remained pressed forever even if stopped pressing it. And
another user reported that passing the options i8042.reset=1
i8042.dumbkbd=1 i8042.direct=1 resulted in the keyboard functioning
after resume. However, there was a long delay before the keyboard or
mouse responded to input on the lock screen.

This one line patch, which can be a hint, from Takashi Iwai essentially
reverts the commit 9d659ae14b545 mentioned in the above and keyboard is
working as expected after resuming from suspend/hibernate, if this
patch is applied. 

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
  * Bit2 indicates handoff has been done and we're waiting for pickup.
  */
 #define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_HANDOFF	0x00
 #define MUTEX_FLAG_PICKUP	0x04
 
 #define MUTEX_FLAGS		0x07
 
- The first bug report on bugzilla.kernel.org[2].
- LKML thread[3]
- Another report on OpenSUSE bugzilla[4]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=9d659ae14b545c4296e812c70493bfdc999b5c1c
[2] https://bugzilla.kernel.org/show_bug.cgi?id=195471
[3] https://lkml.org/lkml/2018/8/31/707
[4]  https://bugzilla.opensuse.org/show_bug.cgi?id=1114588

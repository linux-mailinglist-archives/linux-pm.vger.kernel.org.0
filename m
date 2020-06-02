Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D21EB288
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFBAHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFBAHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 20:07:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B6C05BD43
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 17:07:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f5so1262309wmh.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=/isNv6SGnX5LsLB01BWCVpvM2d/HaAsQOpGW8ggH+6Y=;
        b=shoS+Izrlimff66QPQteZKNveX7M94sZZkXIhOiQJJe+25Di7AKrSlxOCJbAgCuwXI
         O/2ovZyc069xkn9JXihv0Fgl6/xoxXjnVobQMKXHw4URObX5vjPhVGVm5fTY8HDXu8Ac
         k9KNObAaOCC8on3JUm1MQ+WuG/gCQ4/GvOSDTB0KGvAoPPQ5usFiE8w2+12VsAQypk9P
         1nzKdm+wSpeX7RTNrBXgucjNjSGJKmM58J9gRiZKaMqM7eqn7meAUvuLlBKq9s+zTqao
         XMGTPZ+N29rPZ/CRk8T8oZrGo9ueq2yFbPgME4i+WITu76+1dWjVLL36oHIz3SQydkmZ
         0JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/isNv6SGnX5LsLB01BWCVpvM2d/HaAsQOpGW8ggH+6Y=;
        b=P765cBNQ9aYqhURRqBDGpxkZyx/qMQgezcqSS6vf1JNmPI0A9hx1SLDCqIt2Prd+Ck
         3yOCdT+XpVbpFP0ZWYwPiyMmpqOd8XALtvfWPacJEuUBDWhIH6A4/1vVDWWsyUA5/Fb0
         13+u6D6nnPzzKQURv0AptK3FB0vEq3Ah8wqyeddRD69FOUs8wLm5nIQXCYbov31x0W3U
         /g3/IqOvPWmLqIhz/GswVEsujgbbOE9rc1iuAkkxa4cTPobpvPwbWptNGcEQKDk9nhXA
         +s5cxRPk8yI4CCWKUC9DuoddOvGtHpgJyDoDcmhBO0an0iKGfZ0HvR8eZQNb3/fI2D8f
         J+XQ==
X-Gm-Message-State: AOAM530SBzb7y1MtctTz+2mBkYFcofjKF1gq4y1MraWkcnbqUoBiQBa6
        1OeKaLZ6IXsQeuH6qz0PKjJsggmleS7xt2gOZKQX/n1BWZq7Jg==
X-Google-Smtp-Source: ABdhPJw+dDYPhNZspHV8oM5ALd1Xq1803dli9lham6WJv2G6ZgaKMjTuRnobtlXBtV0NQxI8oHGV5cuqc6UxmUISuUM=
X-Received: by 2002:a1c:230a:: with SMTP id j10mr1517131wmj.124.1591056426774;
 Mon, 01 Jun 2020 17:07:06 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 1 Jun 2020 18:06:50 -0600
Message-ID: <CAJCQCtQVGqxtZZTRgscT7e4inTacAd7KAmoNOz3gB4Hf1Nkp0w@mail.gmail.com>
Subject: PM: Image not found (code -22)
To:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm seeing this when attempting to hibernate using 'systemctl
hibernate' with thefollowing kernels. These are the last lines in the
journal for each kernel version.

5.5.19-100.fc30.x86_64

[  197.383204] fmac.local systemd[1]: Reached target Sleep.
[  197.384902] fmac.local systemd[1]: Starting Hibernate...
[  197.402982] fmac.local kernel: PM: Image not found (code -22)

5.6.13-300.fc32.x86_64

[   65.151923] fmac.local systemd[1]: Reached target Sleep.
[   65.153707] fmac.local systemd[1]: Starting Hibernate...
[   65.230276] fmac.local kernel: PM: Image not found (code -22)
[   65.165588] fmac.local systemd-sleep[2484]: Suspending system...
[   65.233176] fmac.local kernel: PM: hibernation: hibernation entry

5.7.0-0.rc7.1.fc33.x86_64

[   46.426356] fmac.local systemd[1]: Reached target Sleep.
[   46.427600] fmac.local systemd[1]: Starting Hibernate...
[   46.923201] fmac.local kernel: PM: Image not found (code -22)
[   46.440792] fmac.local systemd-sleep[2461]: Suspending system...
[   46.925332] fmac.local kernel: PM: hibernation: hibernation entry


1. The terminology is confusing: sleep, suspend, hibernate. These
things aren't all the same thing. Suspend is ambiguous, it could be
suspend-to-ram or suspend-to-disk.

2. What is "image not found code -22"?

3. Does hibernation: hibernation entry mean the hibernation definitely
was committed to disk?

4. I don't read C pretty much at all, but I can tell in hibernate.c
that there are multiple steps for hibernation entry including multiple
sanity checks. And the same for hibernation exit/resume. And yet there
seems to be a lack of milestone reporting for each one of these so a
mortal use could have some idea which one of these did and did not
work. This makes hibernation difficult to troubleshoot.

5. In each subsequent boot following the ostensibly successful
hibernation entry (entry doesn't really mean anything, did it succeed?
did it fail? I have no idea) - there are only these kinds of messages:

 [    0.073695] fmac.local kernel: PM: hibernation: Registered nosave
memory: [mem 0x00000000-0x00000fff]

There is no PM message indicating that the kernel command line for
resume is being honored. There is no PM message indicating that resume
is going to be attempted. There is no PM message whether there's an
image being looked for. There is no PM message whether an image was
found or not. There is nothing.

Clearly it's not working. But also basic progress reporting is not
even present, so I don't in fact know for sure from these messages,
whether the hibernation image actually made it to disk. Whether it was
even looked for on boot. And if not, why not.

$ cat /proc/cmdline
BOOT_IMAGE=(hd5,gpt4)/boot/vmlinuz-5.7.0-0.rc7.1.fc33.x86_64
root=UUID=02f5bdeb-534b-403c-8420-68834b4689fe ro
rootflags=subvol=root log_buf_len=2M mitigations=off enforcing=0
resume=UUID=afbc3995-f82b-44fc-9ce8-0eca59bf5709

Here's the complete dmesg for the most recent "image not found"
message, maybe there's some hint elsewhere that suggests why it can't
be found?

https://paste.centos.org/view/4516a549


If the image was not written out or could not be written out or really
is "not found" then I don't see why hibernation entry even happened.
This is 100% data loss every single time - even though this is a test
machine and I don't care :D It is for sure not fail safe.


Thanks,

-- 
Chris Murphy

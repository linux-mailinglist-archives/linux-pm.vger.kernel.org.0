Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A43FF404
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbhIBTUL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhIBTUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 15:20:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1389C061575;
        Thu,  2 Sep 2021 12:19:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t12so6469619lfg.9;
        Thu, 02 Sep 2021 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=mwjgJNjBniSzsEj1HaYyIhivOVPcoXtS3Ukd76mgzXM=;
        b=UJ/cifzliT/oWNMZPkFUU3XsDePAuxE73UWHudc9FH5NUT6d4l6wS5NZJuFFNrX3SP
         HI4dJExelUrVQTIGcSsYxUAD474xrph2KlPgB0hOsjSs9RPi8FDa00RUOS9gxrXuUNdf
         4aDIqv83xJrBEOJpFfMzqZ/dAQjFu8lf0mQthHIgsZpDZN0pMd2F4s0lgPtmCpC2GxqO
         uCaIoobGKdA55AtxojwRPCl+9UWiU7cpyZyEAUN0C+L23F67I11kK62VWZCTnNcSmGiG
         moj5iUVNygs5LaL9Vs2RP3shmRi1/lWnt0xY83lt7e4r4YvK5h4p8AalhkytSxBJZIN/
         HBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=mwjgJNjBniSzsEj1HaYyIhivOVPcoXtS3Ukd76mgzXM=;
        b=IXvXWk+fYz+3g14HnKf80v4jP201qOyWKvu1slvig/VJ/cjD19ahxxF9YzKgZG0sdk
         LhbrSP1HqeAIIUKNGcPTPzVWTqri4+5XR2+Rstz3CoTCCiaAtsXn0WkuUO9yW/NaAGvw
         EyzwjdmR0hPOH28whXtcHOFp9qgxE9m9b22zDVeaCBPFjwWLa57u7FDWJrJ4PKQrquVF
         /RGAh9taj4uTrckYe4npNtnMVNsuH8DNxi96JsQ6GaayPQYzeCeAakQi6tCqAVykuoZL
         16QmNDUAMt/QRKUp+lJbEBwogimWdCVnZeWkRe16GlnBAsQqSq97IFcLJbpls+ac/vBR
         mkRg==
X-Gm-Message-State: AOAM531OCCKDA6jdPd7MIlETXzaaEtPwXrQwq8WNU0K2aPk2YAth1ke9
        Z1kRuUenwUAJieGhBPP8pzU=
X-Google-Smtp-Source: ABdhPJz0MTtHh1jRnq+j1veCepXejo99iYVaR+1nCmpRAzk8t4Z3+U1VhlorBFxQSgHYgYhmIHQ3Dw==
X-Received: by 2002:a05:6512:2202:: with SMTP id h2mr3825293lfu.494.1630610349946;
        Thu, 02 Sep 2021 12:19:09 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id i5sm277256lfu.274.2021.09.02.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 12:19:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ChaGsM0YHzmY0PHkqKKduqB2"
Message-ID: <fd90b222-4394-946a-24f8-fe3943e840ab@gmail.com>
Date:   Thu, 2 Sep 2021 22:19:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
Content-Language: en-US
To:     syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
References: <00000000000002044305caf6fd02@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000002044305caf6fd02@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------ChaGsM0YHzmY0PHkqKKduqB2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/21 01:57, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1374b85d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c32e23fada3a0e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fde215300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa9149300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
> 
> Bluetooth: : Invalid header checksum
> Bluetooth: : Invalid header checksum
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
> BUG: KASAN: null-ptr-deref in __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
> Write of size 4 at addr 0000000000000388 by task kworker/u4:4/244
> 


Looks like missing if (hu->serdev)

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin
--------------ChaGsM0YHzmY0PHkqKKduqB2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Bluetooth-hci-fix-GPF-in-h5_recv.patch"
Content-Disposition: attachment;
 filename="0001-Bluetooth-hci-fix-GPF-in-h5_recv.patch"
Content-Transfer-Encoding: base64

RnJvbSBhMzBkZmE5M2ZjNmY3ZTJlY2M3NzU5YWM3NWM3NDJlNTEyYjUyN2YwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBTa3JpcGtpbiA8cGFza3JpcGtpbkBnbWFp
bC5jb20+CkRhdGU6IFRodSwgMiBTZXAgMjAyMSAyMjoxNzowNSArMDMwMApTdWJqZWN0OiBb
UEFUQ0hdIEJsdWV0b290aDogaGNpOiBmaXggR1BGIGluIGg1X3JlY3YKCi8qIC4uLiAqLwoK
U2lnbmVkLW9mZi1ieTogUGF2ZWwgU2tyaXBraW4gPHBhc2tyaXBraW5AZ21haWwuY29tPgot
LS0KIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5jIHwgOCArKysrKy0tLQogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2JsdWV0b290aC9oY2lfaDUuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5j
CmluZGV4IDBjMGRlZGVjZTU5Yy4uZWIwMDk5YTIxMjg4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2JsdWV0b290aC9oY2lfaDUuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfaDUuYwpA
QCAtNTg3LDkgKzU4NywxMSBAQCBzdGF0aWMgaW50IGg1X3JlY3Yoc3RydWN0IGhjaV91YXJ0
ICpodSwgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGNvdW50KQogCQljb3VudCAtPSBwcm9jZXNz
ZWQ7CiAJfQogCi0JcG1fcnVudGltZV9nZXQoJmh1LT5zZXJkZXYtPmRldik7Ci0JcG1fcnVu
dGltZV9tYXJrX2xhc3RfYnVzeSgmaHUtPnNlcmRldi0+ZGV2KTsKLQlwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZCgmaHUtPnNlcmRldi0+ZGV2KTsKKwlpZiAoaHUtPnNlcmRldikgewor
CQlwbV9ydW50aW1lX2dldCgmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGltZV9tYXJr
X2xhc3RfYnVzeSgmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGltZV9wdXRfYXV0b3N1
c3BlbmQoJmh1LT5zZXJkZXYtPmRldik7CisJfQogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjMz
LjAKCg==
--------------ChaGsM0YHzmY0PHkqKKduqB2--


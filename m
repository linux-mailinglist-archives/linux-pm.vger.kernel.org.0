Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0182518D26F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 16:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCTPK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 11:10:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36658 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCTPK6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 11:10:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so1913206wrs.3;
        Fri, 20 Mar 2020 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=r/HJVW45rg7ZqchRNDlAomvDfH0elmnsWp+QvkJ8qcs=;
        b=TN+StXxrSvaW1MM29M7PTAzvwViDUQT3dHiUZY3Fgqx2UD7PDEq2DSAg2c92Qsn5hY
         g9sd5xGrcY86MYsNWDKiT5SNP6QLXvl6BV46uWiarVjfrpXzug3q3SxTq4gN/PA+FK50
         Uf9RL/lPpv7CCkJ2yllaq20XHAKntwB7cDXXya/06u7NWLePHXIEl98urkShwYFdbU4p
         eAT1g1V5LsH8qI1bXNaJF66nlW53KyU9dP0eV4qSZNoan57RZy6VwNQx51JghxZuo5Nl
         OkY/XnkVsFhjfNdtf1L3LT9nQy0p8jiJ9pW/QBSBa46Ir9rYwPt6N2/xu77um9KW2Shw
         KVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=r/HJVW45rg7ZqchRNDlAomvDfH0elmnsWp+QvkJ8qcs=;
        b=AV+WHxRfekJBR8EuayfcBkAySIFv05zkljOGMJf5zFNCt245VLpOR/WGlfaXh1tPC4
         BcC74rQnmKBxpoBtiP0Q2leQHxBY7kdH/ZW0wccqKixhSJ1uJCgqA1iDKb0bqDenj3ad
         shAMkIITK3qf76s+br6tRTO9Cj6QytWt6dJuPXMCWpvWEtuzJo32lsERMDjq30dgETqw
         ZknDjnYkkAM62AqH+cuSyfHIvqvusv+eLQvkDG7Vnws9hQ8K1ohQRf84IVv0V4ynWi2V
         7QMs3BrhQ/lPuS+JUYXnNCBCUQeJ3mz0AkcOnWJEjNvjRnyHEqiS1P2AIDtkRUodWl6k
         gGHQ==
X-Gm-Message-State: ANhLgQ2uSzeUFxYYLRoOGvlR5slFXYIyoUZp4mPcpqw5Hzya02TUYAWi
        JRNo/BloTojO7eH+0bb05GM=
X-Google-Smtp-Source: ADFU+vth79CKxwi4leU6rH1zJHxdHJm9oUjQihXp7rwe9rB7ljPyHKeuY50C2t3QsyxvjvDIpWDuag==
X-Received: by 2002:a5d:458c:: with SMTP id p12mr12319023wrq.66.1584717056945;
        Fri, 20 Mar 2020 08:10:56 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id z22sm8144090wmi.1.2020.03.20.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:10:56 -0700 (PDT)
Date:   Fri, 20 Mar 2020 15:10:55 +0000
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: weird cooling_device/cur_state sysfs behaviour
Message-ID: <20200320151055.h32rh5hpnv7xyuey@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,
Hope you're doing well with the situation.

I fill that my board get a cold too...

When I write to a sysfs node, I have a weird behaviour about the function that is called behind.
This bug appears on an arm32 odroid-xu3, and only after v5.4, v5.3.18 behave correctly.


Here my modification to see what's going on:

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..a437ae3f4b9f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -706,11 +706,22 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
        unsigned long state;
        int result;
 
-       if (sscanf(buf, "%ld\n", &state) != 1)
+       dump_stack();
+
+       printk(KERN_INFO "%s:%d:%s buf = \"%s\", count = %zu\n",
+              __FILE__, __LINE__, __func__, buf, count);
+
+       if (sscanf(buf, "%ld\n", &state) != 1) {
+               printk(KERN_INFO "%s:%d:%s\n",
+                      __FILE__, __LINE__, __func__);
                return -EINVAL;
+       }
 
-       if ((long)state < 0)
+       if ((long)state < 0) {
+               printk(KERN_INFO "%s:%d:%s\n",
+                      __FILE__, __LINE__, __func__);
                return -EINVAL;
+       }
 
        mutex_lock(&cdev->lock);
 
@@ -719,9 +730,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
                thermal_cooling_device_stats_update(cdev, state);
 
        mutex_unlock(&cdev->lock);
+
+       printk(KERN_INFO "%s:%d:%s result = %d, count = %zu\n",
+              __FILE__, __LINE__, __func__, result, count);
+
        return result ? result : count;
 }
 
+
 static struct device_attribute
 dev_attr_cdev_type = __ATTR(type, 0444, cdev_type_show, NULL);
 static DEVICE_ATTR_RO(max_state);



And here the prob:
Thursday 2019-02-14 10:26:46 root@odroid-xu3-0 ~
$ echo 11 > /sys/devices/virtual/thermal/cooling_device1/cur_state                                                                                    
[  908.109955] CPU: 5 PID: 500 Comm: bash Not tainted 5.4.0-dirty #6
[  908.114910] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  908.121014] [<c0112f08>] (unwind_backtrace) from [<c010df38>] (show_stack+0x10/0x14)
[  908.128796] [<c010df38>] (show_stack) from [<c0ae89cc>] (dump_stack+0xa4/0xd0)
[  908.135962] [<c0ae89cc>] (dump_stack) from [<c0759e0c>] (cur_state_store+0x2c/0x14c)
[  908.143686] [<c0759e0c>] (cur_state_store) from [<c033b360>] (kernfs_fop_write+0x100/0x1e0)
[  908.152035] [<c033b360>] (kernfs_fop_write) from [<c02a93f4>] (__vfs_write+0x2c/0x1c0)
[  908.159908] [<c02a93f4>] (__vfs_write) from [<c02ac25c>] (vfs_write+0xa4/0x188)
[  908.167163] [<c02ac25c>] (vfs_write) from [<c02ac4b0>] (ksys_write+0x58/0xd0)
[  908.174242] [<c02ac4b0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[  908.181874] Exception stack(0xeb915fa8 to 0xeb915ff0)
[  908.186800] 5fa0:                   00000074 0050ba08 00000001 0050ba08 00000003 00000000
[  908.195083] 5fc0: 00000074 0050ba08 b6eb3db0 00000004 00000003 00000003 00000000 00000000
[  908.203218] 5fe0: 00000004 bef3c830 b6e4b5b3 b6dd4746
[  908.210744] drivers/thermal/thermal_sysfs.c:712:cur_state_store buf = "11
[  908.210744] ", count = 3
[  908.221520] drivers/thermal/thermal_sysfs.c:735:cur_state_store result = 1, count = 3
[  908.228681] CPU: 5 PID: 500 Comm: bash Not tainted 5.4.0-dirty #6
[  908.234268] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  908.240372] [<c0112f08>] (unwind_backtrace) from [<c010df38>] (show_stack+0x10/0x14)
[  908.248159] [<c010df38>] (show_stack) from [<c0ae89cc>] (dump_stack+0xa4/0xd0)
[  908.255325] [<c0ae89cc>] (dump_stack) from [<c0759e0c>] (cur_state_store+0x2c/0x14c)
[  908.263048] [<c0759e0c>] (cur_state_store) from [<c033b360>] (kernfs_fop_write+0x100/0x1e0)
[  908.271398] [<c033b360>] (kernfs_fop_write) from [<c02a93f4>] (__vfs_write+0x2c/0x1c0)
[  908.279271] [<c02a93f4>] (__vfs_write) from [<c02ac25c>] (vfs_write+0xa4/0x188)
[  908.286527] [<c02ac25c>] (vfs_write) from [<c02ac4b0>] (ksys_write+0x58/0xd0)
[  908.293608] [<c02ac4b0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[  908.301241] Exception stack(0xeb915fa8 to 0xeb915ff0)
[  908.306168] 5fa0:                   00000074 0050ba09 00000001 0050ba09 00000002 00000000
[  908.314448] 5fc0: 00000074 0050ba09 b6eb3db0 00000004 00000003 00000003 00000000 00000000
[  908.322581] 5fe0: 00000004 bef3c830 b6e4b5b3 b6dd4746
[  908.328660] drivers/thermal/thermal_sysfs.c:712:cur_state_store buf = "1
[  908.328660] ", count = 2
[  908.338432] drivers/thermal/thermal_sysfs.c:735:cur_state_store result = 1, count = 2
[  908.345695] CPU: 5 PID: 500 Comm: bash Not tainted 5.4.0-dirty #6
[  908.351172] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  908.357276] [<c0112f08>] (unwind_backtrace) from [<c010df38>] (show_stack+0x10/0x14)
[  908.365062] [<c010df38>] (show_stack) from [<c0ae89cc>] (dump_stack+0xa4/0xd0)
[  908.372227] [<c0ae89cc>] (dump_stack) from [<c0759e0c>] (cur_state_store+0x2c/0x14c)
[  908.379951] [<c0759e0c>] (cur_state_store) from [<c033b360>] (kernfs_fop_write+0x100/0x1e0)
[  908.388302] [<c033b360>] (kernfs_fop_write) from [<c02a93f4>] (__vfs_write+0x2c/0x1c0)
[  908.396176] [<c02a93f4>] (__vfs_write) from [<c02ac25c>] (vfs_write+0xa4/0x188)
[  908.403433] [<c02ac25c>] (vfs_write) from [<c02ac4b0>] (ksys_write+0x58/0xd0)
[  908.410511] [<c02ac4b0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[  908.418145] Exception stack(0xeb915fa8 to 0xeb915ff0)
[  908.423068] 5fa0:                   00000074 0050ba0a 00000001 0050ba0a 00000001 00000000
[  908.431352] 5fc0: 00000074 0050ba0a b6eb3db0 00000004 00000003 00000003 00000000 00000000
[  908.439487] 5fe0: 00000004 bef3c830 b6e4b5b3 b6dd4746
[  908.445365] drivers/thermal/thermal_sysfs.c:712:cur_state_store buf = "
[  908.445365] ", count = 1
[  908.454762] drivers/thermal/thermal_sysfs.c:716:cur_state_store
-bash: echo: write error: Invalid argument




As you can see, the function is recalled with one character less, until the "buffer is empty".
I don't understand why. Can anybody help me for this thing?
Many thanks in advance.

Best Regards,
Willy


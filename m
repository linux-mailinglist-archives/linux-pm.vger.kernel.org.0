Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485EA2FCEB6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 12:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbhATLBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 06:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731398AbhATJcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 04:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611135026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBEHTu6Bu4ohAuOu7gRJBoClExSCGrjx9SGtkFNBopE=;
        b=hJ6SfqejgT492mZ1YBx0gE3Mm+eX/0LEzSMXovridnCfHAfdFPKuZibPRqBjfFjI627oqD
        8hEtJ5q5AEbi69Ku2XFT7e7sz9ehy4n9weccCl3WAU19w0QgYb9iQqBlC6zr7IGXVwOiNX
        EgehTPl7buuKKYeyBwlFAzk3MDVLjbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-bnFzU7UkN0q9whIEGbKNaA-1; Wed, 20 Jan 2021 04:30:22 -0500
X-MC-Unique: bnFzU7UkN0q9whIEGbKNaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CBB2107ACE4;
        Wed, 20 Jan 2021 09:30:21 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D19406F99D;
        Wed, 20 Jan 2021 09:30:17 +0000 (UTC)
Date:   Wed, 20 Jan 2021 17:30:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernelfans@gmail.com, kexec@lists.infradead.org,
        linux-pm@vger.kernel.org, dyoung@redhat.com
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and
 suspend
Message-ID: <20210120093015.GE20161@MiWiFi-R3L-srv>
References: <20201118185917.GA433776@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118185917.GA433776@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> Hello Pingfan Liu,
> 
> The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> and suspend" from Jul 31, 2018, leads to the following static checker
> warning:
> 
> 	kernel/power/main.c:27 lock_system_sleep()
> 	warn: called with lock held.  '&system_transition_mutex'

This is a good finding. I think we can simply remove the lock/unlock
pair of system_transition_mutex in kernel_kexec() function. The dead
lock should be easily triggered, but it hasn't caused any failure report
because the feature 'kexec jump' is almost not used by anyone as far as
I know. We may need to find out who is using it and where it's used
through an inquiry. Before that, we can just remove the lock operation
inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks. 


diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 80905e5aa8ae..a0b6780740c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1134,7 +1134,6 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-		lock_system_sleep();
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1197,7 +1196,6 @@ int kernel_kexec(void)
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
-		unlock_system_sleep();
 	}
 #endif
 

> 
> kernel/reboot.c
>    345  
>    346          mutex_lock(&system_transition_mutex);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The patch changed the code to take this lock.
> 
>    347          switch (cmd) {
>    348          case LINUX_REBOOT_CMD_RESTART:
>    349                  kernel_restart(NULL);
>    350                  break;
>    351  
>    352          case LINUX_REBOOT_CMD_CAD_ON:
>    353                  C_A_D = 1;
>    354                  break;
>    355  
>    356          case LINUX_REBOOT_CMD_CAD_OFF:
>    357                  C_A_D = 0;
>    358                  break;
>    359  
>    360          case LINUX_REBOOT_CMD_HALT:
>    361                  kernel_halt();
>    362                  do_exit(0);
>    363                  panic("cannot halt");
>    364  
>    365          case LINUX_REBOOT_CMD_POWER_OFF:
>    366                  kernel_power_off();
>    367                  do_exit(0);
>    368                  break;
>    369  
>    370          case LINUX_REBOOT_CMD_RESTART2:
>    371                  ret = strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1);
>    372                  if (ret < 0) {
>    373                          ret = -EFAULT;
>    374                          break;
>    375                  }
>    376                  buffer[sizeof(buffer) - 1] = '\0';
>    377  
>    378                  kernel_restart(buffer);
>    379                  break;
>    380  
>    381  #ifdef CONFIG_KEXEC_CORE
>    382          case LINUX_REBOOT_CMD_KEXEC:
>    383                  ret = kernel_kexec();
>                         ^^^^^^^^^^^^^^^^^^^^
> Called with lock held.
> 
>    384                  break;
>    385  #endif
> 
> But kernel_kexec() also tries to take the &system_transition_mutex so
> it will dead lock.
> 
> kernel/kexec_core.c
>   1125  int kernel_kexec(void)
>   1126  {
>   1127          int error = 0;
>   1128  
>   1129          if (!mutex_trylock(&kexec_mutex))
>   1130                  return -EBUSY;
>   1131          if (!kexec_image) {
>   1132                  error = -EINVAL;
>   1133                  goto Unlock;
>   1134          }
>   1135  
>   1136  #ifdef CONFIG_KEXEC_JUMP
>   1137          if (kexec_image->preserve_context) {
>   1138                  lock_system_sleep();
>                         ^^^^^^^^^^^^^^^^^^^
> Here.
> 
>   1139                  pm_prepare_console();
>   1140                  error = freeze_processes();
>   1141                  if (error) {
>   1142                          error = -EBUSY;
>   1143                          goto Restore_console;
>   1144                  }
>   1145                  suspend_console();
>   1146                  error = dpm_suspend_start(PMSG_FREEZE);
>   1147                  if (error)
>   1148                          goto Resume_console;
>   1149                  /* At this point, dpm_suspend_start() has been called,
>   1150                   * but *not* dpm_suspend_end(). We *must* call
>   1151                   * dpm_suspend_end() now.  Otherwise, drivers for
>   1152                   * some devices (e.g. interrupt controllers) become
>   1153                   * desynchronized with the actual state of the
>   1154                   * hardware at resume time, and evil weirdness ensues.
>   1155                   */
>   1156                  error = dpm_suspend_end(PMSG_FREEZE);
>   1157                  if (error)
>   1158                          goto Resume_devices;
>   1159                  error = suspend_disable_secondary_cpus();
>   1160                  if (error)
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


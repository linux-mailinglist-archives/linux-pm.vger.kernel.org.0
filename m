Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5382B8441
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgKRS7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 13:59:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRS7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 13:59:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIIi84Q062088;
        Wed, 18 Nov 2020 18:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=oKLa2LrlEgJC4O/fNsIc01KkHpdEzCUl7HIEy0vGQCk=;
 b=zBm4P7m1rfqAaxvPPKLfT3Ki9h/rJRWYHSM4+WCPuHkyyxSe4mv2YNS5ABl0B8Gk1pGQ
 nckLFmiKahNpjZwncUjIjeU2v8qOKOG5fg3B6NXhfbEeb6Ayse+VDcN+yaPqpNPKAp+W
 GwCYdBAKtRDjD0HrwTffhW6kG+z8heIPPH7BIJooLUBDKTSrOxZLAOAurv6PnwJ7TODY
 Go00qwfq661doEs8SgluAfo+B/Kd8PF+tf57NJGvbwn5h5mbLwWy9UOTBLQRMHFAqIWn
 HFJKbOwCPOsv1E6JNHicpUCFOgF/bER5opYqNBjEWm9/TI7o2olFJxIpvl9qH3aXT/cO cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vn9muw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 18:59:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIIfM5t035206;
        Wed, 18 Nov 2020 18:59:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umd0xvgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 18:59:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AIIxNcH011191;
        Wed, 18 Nov 2020 18:59:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 10:59:22 -0800
Date:   Wed, 18 Nov 2020 21:59:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kernelfans@gmail.com
Cc:     linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: [bug report] PM / reboot: Eliminate race between reboot and suspend
Message-ID: <20201118185917.GA433776@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180130
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Pingfan Liu,

The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
and suspend" from Jul 31, 2018, leads to the following static checker
warning:

	kernel/power/main.c:27 lock_system_sleep()
	warn: called with lock held.  '&system_transition_mutex'

kernel/reboot.c
   345  
   346          mutex_lock(&system_transition_mutex);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The patch changed the code to take this lock.

   347          switch (cmd) {
   348          case LINUX_REBOOT_CMD_RESTART:
   349                  kernel_restart(NULL);
   350                  break;
   351  
   352          case LINUX_REBOOT_CMD_CAD_ON:
   353                  C_A_D = 1;
   354                  break;
   355  
   356          case LINUX_REBOOT_CMD_CAD_OFF:
   357                  C_A_D = 0;
   358                  break;
   359  
   360          case LINUX_REBOOT_CMD_HALT:
   361                  kernel_halt();
   362                  do_exit(0);
   363                  panic("cannot halt");
   364  
   365          case LINUX_REBOOT_CMD_POWER_OFF:
   366                  kernel_power_off();
   367                  do_exit(0);
   368                  break;
   369  
   370          case LINUX_REBOOT_CMD_RESTART2:
   371                  ret = strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1);
   372                  if (ret < 0) {
   373                          ret = -EFAULT;
   374                          break;
   375                  }
   376                  buffer[sizeof(buffer) - 1] = '\0';
   377  
   378                  kernel_restart(buffer);
   379                  break;
   380  
   381  #ifdef CONFIG_KEXEC_CORE
   382          case LINUX_REBOOT_CMD_KEXEC:
   383                  ret = kernel_kexec();
                        ^^^^^^^^^^^^^^^^^^^^
Called with lock held.

   384                  break;
   385  #endif

But kernel_kexec() also tries to take the &system_transition_mutex so
it will dead lock.

kernel/kexec_core.c
  1125  int kernel_kexec(void)
  1126  {
  1127          int error = 0;
  1128  
  1129          if (!mutex_trylock(&kexec_mutex))
  1130                  return -EBUSY;
  1131          if (!kexec_image) {
  1132                  error = -EINVAL;
  1133                  goto Unlock;
  1134          }
  1135  
  1136  #ifdef CONFIG_KEXEC_JUMP
  1137          if (kexec_image->preserve_context) {
  1138                  lock_system_sleep();
                        ^^^^^^^^^^^^^^^^^^^
Here.

  1139                  pm_prepare_console();
  1140                  error = freeze_processes();
  1141                  if (error) {
  1142                          error = -EBUSY;
  1143                          goto Restore_console;
  1144                  }
  1145                  suspend_console();
  1146                  error = dpm_suspend_start(PMSG_FREEZE);
  1147                  if (error)
  1148                          goto Resume_console;
  1149                  /* At this point, dpm_suspend_start() has been called,
  1150                   * but *not* dpm_suspend_end(). We *must* call
  1151                   * dpm_suspend_end() now.  Otherwise, drivers for
  1152                   * some devices (e.g. interrupt controllers) become
  1153                   * desynchronized with the actual state of the
  1154                   * hardware at resume time, and evil weirdness ensues.
  1155                   */
  1156                  error = dpm_suspend_end(PMSG_FREEZE);
  1157                  if (error)
  1158                          goto Resume_devices;
  1159                  error = suspend_disable_secondary_cpus();
  1160                  if (error)

regards,
dan carpenter

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7810193D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfKSGTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:19:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfKSGTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:19:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ69ENq152442;
        Tue, 19 Nov 2019 06:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=JrDgdyR7Xidziim1tDHzGIvDWJrxtek74M3qnDhMihQ=;
 b=qFwpYg35GtAX/9CE90a/Lrg0CTk1yAo7Wd+u4e/yFRgZiallqZccY+tLjE6ACy3bFmT9
 Rvoy9T11u44ax3KEowyT8WbyfouCwHHYTMNZXk5TI6RjSPjGFgdIHP+Wuw8HCA5ZUf2l
 GO/Pd2LlYFHDYEeCmFB5C6cKrSOBBZGfaI3OjesuaR673aRrAX77iqjI8gguiPaHXCF2
 0+4PnNCIwuGmLi5rqilhrtAWREp8H9uFWLzgA8qF5amu4sqwNAmrZjxVRcZdlMEBgiTP
 NSYLsm5Hh3YR/hsq2LJuaIQuwx9oy1nEKsqVZqGTXUKfRosDuB9evaX9vdCn4VxRpWL2 +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92pmqq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:19:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ68urv105745;
        Tue, 19 Nov 2019 06:19:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wbxm3qxmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:19:02 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ6J2Oa003174;
        Tue, 19 Nov 2019 06:19:02 GMT
Received: from kili.mountain (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:19:01 -0800
Date:   Tue, 19 Nov 2019 09:18:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kernelfans@gmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] PM / reboot: Eliminate race between reboot and suspend
Message-ID: <20191119052701.fcbfdpdhylqpdyye@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190057
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Pingfan Liu,

The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
and suspend" from Jul 31, 2018, leads to the following static checker
warning:

	kernel/reboot.c:395 __do_sys_reboot()
	error: double unlocked 'system_transition_mutex' (orig line 387)

kernel/reboot.c
   310  SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
   311                  void __user *, arg)
   312  {
   313          struct pid_namespace *pid_ns = task_active_pid_ns(current);
   314          char buffer[256];
   315          int ret = 0;
   316  
   317          /* We only trust the superuser with rebooting the system. */
   318          if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
   319                  return -EPERM;
   320  
   321          /* For safety, we require "magic" arguments. */
   322          if (magic1 != LINUX_REBOOT_MAGIC1 ||
   323                          (magic2 != LINUX_REBOOT_MAGIC2 &&
   324                          magic2 != LINUX_REBOOT_MAGIC2A &&
   325                          magic2 != LINUX_REBOOT_MAGIC2B &&
   326                          magic2 != LINUX_REBOOT_MAGIC2C))
   327                  return -EINVAL;
   328  
   329          /*
   330           * If pid namespaces are enabled and the current task is in a child
   331           * pid_namespace, the command is handled by reboot_pid_ns() which will
   332           * call do_exit().
   333           */
   334          ret = reboot_pid_ns(pid_ns, cmd);
   335          if (ret)
   336                  return ret;
   337  
   338          /* Instead of trying to make the power_off code look like
   339           * halt when pm_power_off is not set do it the easy way.
   340           */
   341          if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
   342                  cmd = LINUX_REBOOT_CMD_HALT;
   343  
   344          mutex_lock(&system_transition_mutex);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This used to be reboot_mutex.

   345          switch (cmd) {
   346          case LINUX_REBOOT_CMD_RESTART:
   347                  kernel_restart(NULL);
   348                  break;
   349  
   350          case LINUX_REBOOT_CMD_CAD_ON:
   351                  C_A_D = 1;
   352                  break;
   353  
   354          case LINUX_REBOOT_CMD_CAD_OFF:
   355                  C_A_D = 0;
   356                  break;
   357  
   358          case LINUX_REBOOT_CMD_HALT:
   359                  kernel_halt();
   360                  do_exit(0);
   361                  panic("cannot halt");
   362  
   363          case LINUX_REBOOT_CMD_POWER_OFF:
   364                  kernel_power_off();
   365                  do_exit(0);
   366                  break;
   367  
   368          case LINUX_REBOOT_CMD_RESTART2:
   369                  ret = strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1);
   370                  if (ret < 0) {
   371                          ret = -EFAULT;
   372                          break;
   373                  }
   374                  buffer[sizeof(buffer) - 1] = '\0';
   375  
   376                  kernel_restart(buffer);
   377                  break;
   378  
   379  #ifdef CONFIG_KEXEC_CORE
   380          case LINUX_REBOOT_CMD_KEXEC:
   381                  ret = kernel_kexec();
   382                  break;
   383  #endif
   384  
   385  #ifdef CONFIG_HIBERNATION
   386          case LINUX_REBOOT_CMD_SW_SUSPEND:
   387                  ret = hibernate();
                        ^^^^^^^^^^^^^^^^^
The first thing that hibernate() does is call lock_system_sleep() which
use to take the pm_mutex, but now it takes system_transition_mutex so
it will just hang forever.

   388                  break;
   389  #endif
   390  
   391          default:
   392                  ret = -EINVAL;
   393                  break;
   394          }
   395          mutex_unlock(&system_transition_mutex);
   396          return ret;
   397  }

regards,
dan carpenter

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E21620A8
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 07:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgBRGFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 01:05:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 01:05:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I62kh1042519;
        Tue, 18 Feb 2020 06:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xHYB9ApyxtCd8sJEDxP4CyHzMENkv5YG5prVMkaKwwU=;
 b=KentcE9mWSEfHTiuOOp9DfTDnGgCYGdRIOnocnj7+JZzRjQWg9t4ekBy3B+/m71gyq6i
 9ozJDpxkpTV553gKJfIK68NJjjNTeR0wbE1VFfkjhDHYhKrdTLtPCMzFD/anqslolDup
 4dP2SjOOwhkVAw++2/d6JCjLNtKeku8MZBzfl6I9Vt7XfGvjUJ+joOedlX3rtiXVYuy4
 sKobK+cx8paAJ8TOgRYFyoR+uISimdI7U7NIpD23iLdqgkPPGjA/MJgqhkX8sArveAX/
 V4YTw327k3gzUZVqc7IaCbrGQKbe28DJ3iN0q6OVtJIgsEEkLCYxqbg/G8uU1eDrK44J 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y7aq5pg5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 06:05:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I61gqV129744;
        Tue, 18 Feb 2020 06:05:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y6tep0u58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 06:05:50 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01I65neJ030022;
        Tue, 18 Feb 2020 06:05:49 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 22:05:49 -0800
Date:   Tue, 18 Feb 2020 09:05:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     leonard.crestez@nxp.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] PM / devfreq: Use PM QoS for sysfs min/max_freq
Message-ID: <20200218060542.yylim4ke6toujhjd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=1 mlxscore=0 mlxlogscore=824 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=881 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180049
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Leonard Crestez,

The patch 27dbc542f651: "PM / devfreq: Use PM QoS for sysfs
min/max_freq" from Dec 5, 2019, leads to the following static checker
warning:

	drivers/devfreq/devfreq.c:723 devfreq_dev_release()
	warn: 'err' can be either negative or positive

drivers/devfreq/devfreq.c
   701                                           DEV_PM_QOS_MIN_FREQUENCY);
   702          if (err && err != -ENOENT)
   703                  dev_warn(dev->parent,
   704                          "Failed to remove min_freq notifier: %d\n", err);
   705  
   706          if (dev_pm_qos_request_active(&devfreq->user_max_freq_req)) {
   707                  err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
   708                  if (err)
                            ^^^
   709                          dev_warn(dev->parent,
   710                                  "Failed to remove max_freq request: %d\n", err);
   711          }
   712          if (dev_pm_qos_request_active(&devfreq->user_min_freq_req)) {
   713                  err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
   714                  if (err)
                            ^^^
If dev_pm_qos_remove_request() returns 1 it means that the "aggregated
constraint value has changed".  It's not necessarily a failure so should
we really print a warning?

   715                          dev_warn(dev->parent,
   716                                  "Failed to remove min_freq request: %d\n", err);
   717          }
   718  
   719          if (devfreq->profile->exit)
   720                  devfreq->profile->exit(devfreq->dev.parent);

regards,
dan carpenter

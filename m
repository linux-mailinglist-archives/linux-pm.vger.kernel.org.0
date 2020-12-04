Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF92CF013
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgLDOyf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 09:54:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50124 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgLDOyf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 09:54:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4Eo6s4065008;
        Fri, 4 Dec 2020 14:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=9MHfyxqx2kJhps4BQcT6LNPWJ+VfhnrI4unP/wMVmw4=;
 b=CO/L17naeBNRYBBA3TvNM0LQGkB7iH7WglGflfoxhLEGfADYU1WrWKcK5XAkmEcE1qya
 1kYTcGZ747XvTo5XDIjy67YNpUfJY0m/MsxSEHGIyk8qtrZLRXBA/+0rEmIG3mMfJVdW
 hVStOpqQqRqJXhkdBPgteCLWb6A3vjWwP1q7W9zhGLt73VYeQPIjbWgOQMSJHSjlkPBs
 2wWVnVseDn7bfkmgfi1PWhb0C3BXifYxYMtO9dujU6khqxicqDwzl0dtDATTVcYbW037
 CKVbBu+JBOkN9y3eagTQ+1zowO/lT1nkH5xDYOCx1nYV9lG1la0eD+mwwjMiOflMoq/M QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 353dyr3jmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 14:53:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4EoHkL184425;
        Fri, 4 Dec 2020 14:51:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3540f3dj5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 14:51:52 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B4EppF2015248;
        Fri, 4 Dec 2020 14:51:51 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Dec 2020 06:51:50 -0800
Date:   Fri, 4 Dec 2020 17:51:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] power: supply: generic-adc-battery: Use GPIO descriptors
Message-ID: <X8pNAJq2LdPJ29w9@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=3 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=962
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012040086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=993
 suspectscore=3 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040086
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Linus Walleij,

The patch b0327ffb133f: "power: supply: generic-adc-battery: Use GPIO
descriptors" from Oct 30, 2020, leads to the following static checker
warning:

	drivers/power/supply/generic-adc-battery.c:97 gab_charge_finished()
	warn: signedness bug returning '(-4095)'

drivers/power/supply/generic-adc-battery.c
    93  static bool gab_charge_finished(struct gab *adc_bat)
    94  {
    95          if (!adc_bat->charge_finished)
    96                  return false;
    97          return gpiod_get_value(adc_bat->charge_finished);

The gpiod_get_value() can return negative error codes so it's not
necessarily clear if that should translate to a true as it does now or
to a false...

    98  }

regards,
dan carpenter

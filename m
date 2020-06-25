Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A91209BB1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbgFYJFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 05:05:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39284 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389473AbgFYJFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 05:05:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05P92DCN042815;
        Thu, 25 Jun 2020 09:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6p1/RFHaVHhyTKsdD/zUstV9/O0VSIYItjrUNz/5ZuQ=;
 b=gdjDuDb8HlQHOTbgcFWIg4JP3G6b5wP2LokCkNkbCFnC7vyzgVxlEqx4VRAPPswUIety
 Wg8pKIl/gFVoFJMKt5GpDNgvI4EXZmi0QVhLp5+105xvLBxLvKLQxulXnsqKMWUm7jer
 W6dv7I4p1b/zQKhxAP2wp2dH4rQP6Hd4ReYXrPflQtKLvGNPPqk9tYIF1KZQ0tQ93A1W
 UbZC8Aq7N36wvOdKg6B5gbx/8wBoxQvWNGea6MUTDTfaPA3/2sgfW2vmiTaz45VlVmpt
 jMGEHmxbzwM70P8uWtw5yNnrwhTAzEIQLNTY5ruDJbRyDgxK9x4PubdWG5lnhGm/o+dy bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31uustycw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 09:05:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05P94FGj168673;
        Thu, 25 Jun 2020 09:05:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31uur8nnx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 09:05:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05P94vI2031214;
        Thu, 25 Jun 2020 09:04:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 09:04:57 +0000
Date:   Thu, 25 Jun 2020 12:04:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] intel_idle: Fix uninitialized variable bug
Message-ID: <20200625090449.GA2549@kadam>
References: <20200624131921.GB9972@mwanda>
 <CAJZ5v0hG2FL0VSeE+ind9MSMc_c7nA4KjKxFPdMhVOPrMdYJKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hG2FL0VSeE+ind9MSMc_c7nA4KjKxFPdMhVOPrMdYJKQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 03:41:05PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 3:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The "tick" variable isn't initialized if "lapic_timer_always_reliable"
> > is true.
> 
> If lapic_timer_always_reliable is true, then
> static_cpu_has(X86_FEATURE_ARAT) must also be true AFAICS.
> 
> So the lapic_timer_always_reliable check in there looks redundant.

Can the lapic_timer_always_reliable variable just be removed entirely
and replaced with an static_cpu_has(X86_FEATURE_ARAT) check?

regards,
dan carpenter


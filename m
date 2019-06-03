Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD59232E02
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfFCKvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 06:51:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfFCKvW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 06:51:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53AmuCS163383;
        Mon, 3 Jun 2019 10:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Gu0o0x2fagVzjtrF48ON8xTqqLz95bguenIm3DqiX/I=;
 b=4Uvuk/qB/oEB4hTs8/cHJh9Gr/kYFed7PoUSTY088uzZ4r4LkBxAYvpMrToI7XmJ1maA
 fkpngaf9PidlKm75nVL9wK0c0fVjTlrOkV082MwxJMLxdxA4g+Afa0B+suSUtiQTx7ve
 TN8v4C7Qf54Fqa+n7gBtWpHeCjwSWvnY3XMvHizag1QSGeTMW+AfyJJgFhJMDqCreiDP
 RldBki0tV6iLiFaiTQeEZ7Iia8hdtzQsfk3c39Ilfj0IDIKzZjnIqHRL2CoTFBWvLhVl
 BYY3GFfOytxXHFtPm5hq7Ggftf+1DDCTW+wJ5iVcVgKSCXNOf8Yv7v+5X33iEu6a1srv sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0q61hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 10:51:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53AoDWL089637;
        Mon, 3 Jun 2019 10:51:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2svnn86wj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 10:51:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x53Ap9kf015060;
        Mon, 3 Jun 2019 10:51:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Jun 2019 03:51:08 -0700
Date:   Mon, 3 Jun 2019 13:51:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     "Shenhar, Talel" <talel@amazon.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal: mmio: remove some dead code
Message-ID: <20190603105101.GH31203@kadam>
References: <20190515093420.GC3409@mwanda>
 <87257cd4-a7c8-3531-1033-84a6f79e6588@amazon.com>
 <20190603020901.GA7918@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603020901.GA7918@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906030080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=989 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030080
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 02, 2019 at 07:09:03PM -0700, Eduardo Valentin wrote:
> hey Dan, Talel,
> 
> On Mon, May 20, 2019 at 05:26:51PM +0300, Shenhar, Talel wrote:
> > 
> > On 5/15/2019 12:34 PM, Dan Carpenter wrote:
> > >The platform_get_resource() function doesn't return error pointers, it
> > >returns NULL.  The way this is normally done, is that we pass the NULL
> > >resource to devm_ioremap_resource() and then check for errors from that.
> > >See the comment in front of devm_ioremap_resource() for more details.
> > >
> > >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Talel Shenhar <talel@amazon.com>
> 
> Cool. I will be collecting this. The only change I will do while
> applying this is that the subject will look like this:
> "thermal: thermal_mmio: remove some dead code"
> 
> Just to match the file / driver name.
> 

I feel like it's duplicative to have "thermal" twice, but whatever.
What I normally do is I copy-and-paste what other people use because the
prefered format varies from subsystem to subsystem.  Here the only
previous patch was:

71aa3693493d thermal: Introduce Amazon's Annapurna Labs Thermal Driver

This format was obviously even worse...

I'm often the first person to send a patch for new drivers.  It used to
be common for people to not use a correct patch prefix for the patch
which adds a driver.  But what happened was people got annoyed with the
prefixes I chose.  And I was like, "Nah.  Forget about it.  I got here
first and I claim this land for my ownself.  Be grateful I didn't choose
a snide or rude patch prefix because that's my authority as a prefix
chooser."

regards,
dan carpenter


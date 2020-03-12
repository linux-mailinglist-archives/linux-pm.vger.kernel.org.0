Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DDA182911
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 07:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgCLGcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 02:32:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbgCLGcB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 02:32:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C6Rl2M011219;
        Thu, 12 Mar 2020 06:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=96anitlCLucRc7Rxq6Z65CxVwAN+xtGFFnozhiQVg1M=;
 b=MdmdNzqJUr1kCzQwNGsk6HMI/L73k9iHploydfbFztc9r64/ijOrEMVd+HU1+qYFMThc
 ELzN7uEZMjoJr3c9DVlne/xtxQrVnntXbZA2Pni/z4S6aXF/VHJvjIR24Q0dNyqJIOaB
 fCQ/Ke4ImT0F4+XjIBYB1ctJswnqqUjaYiV3lTUJLbreCZYYEvGc9FgyLU8Bj7Isfjew
 0e32QVftWg9DjX5/kk7hE+/zVPWj0Kzw8vLZsA1jdsu1G4J1zGp/NX5TKQBOtRAks0cw
 Iq2aUhOhybIGJ64mdfDjlsoXDEeSjWbbk2Mu44/Fz0qJWK2L+S/PEjfniiTQhd+Pdg8Y AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yp7hmc1u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 06:31:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C6MLjp155279;
        Thu, 12 Mar 2020 06:31:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yp8qymc4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 06:31:40 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02C6Vcfh025334;
        Thu, 12 Mar 2020 06:31:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 23:31:37 -0700
Date:   Thu, 12 Mar 2020 09:31:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / devfreq: Fix handling dev_pm_qos_remove_request
 result
Message-ID: <20200312061800.GE11583@kadam>
References: <CGME20200312031520epcas1p3ae8085a7d85da5b41776136f61ad40a3@epcas1p3.samsung.com>
 <ea4c8b53f2a045116a5f70e24374ce62c85f0b81.1583982882.git.leonard.crestez@nxp.com>
 <780efc9c-a85f-ef9f-e64f-68e5edce4cd3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780efc9c-a85f-ef9f-e64f-68e5edce4cd3@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120033
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 12, 2020 at 12:30:42PM +0900, Chanwoo Choi wrote:
> On 3/12/20 12:15 PM, Leonard Crestez wrote:
> > The dev_pm_qos_remove_request function can return 1 if
> > "aggregated constraint value has changed" so only negative values should
> > be reported as errors.
> > 
> > Fixes: 27dbc542f651 ("PM / devfreq: Use PM QoS for sysfs min/max_freq")
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Since you're resending anyway, could you remove the blank line after the
Fixes tag?  All the tags go together at the end.  (The blank line does
not matter at all to anyone, purely aesthetic).

regards,
dan carpenter


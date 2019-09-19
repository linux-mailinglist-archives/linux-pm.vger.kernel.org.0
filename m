Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38FCB765A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfISJdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:33:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36066 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfISJdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:33:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J9OI66018021;
        Thu, 19 Sep 2019 09:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ntE+c9cESazn72DuT4SsObOcii7mo2s3N68Qv9djNSw=;
 b=V54QvGT+VYQNpveqIkWSOpQzqmOSxvNze/4+IsHujmBXR1puO+PnSm+OFjQLE+64pIBH
 3qP39ipm4Kho7S6ZHmcBOjA8mzJ+e3KCkXQ1xyroKesqkUFXtwtiWMMsOIpv86zuPKSt
 /ze9oN6AhzieZKCrHeXwDd2A5aOEtpP/OYD+iYsC7Na17P/cc5tCkYOz9C4yJLLexgu6
 toq91MbiBoWIcZrvHvkL2caEYqXHl7xWz0Tt+3QG/+GOz6Nuyp6zY8AoedabO5Kx+DTe
 60nDzRa04VjJqpqmoHOnG6p5qq0WNRsd3SlJSJ8+VrZNsf8cIdLz5mlEWo7zE3NFewin lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v3vb4tny5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 09:33:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J9SsYw169589;
        Thu, 19 Sep 2019 09:33:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v3vbfrjxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 09:33:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8J9Wx3D018214;
        Thu, 19 Sep 2019 09:32:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 02:32:59 -0700
Date:   Thu, 19 Sep 2019 12:32:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 1/2] memory: samsung: exynos5422-dmc: Fix kfree() of
 devm-allocated memory and missing static
Message-ID: <20190919093246.GF20699@kadam>
References: <20190919092641.4407-1-l.luba@partner.samsung.com>
 <CGME20190919092652eucas1p12dbf9ba9d60a0c89cb7de05ab61893be@eucas1p1.samsung.com>
 <20190919092641.4407-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919092641.4407-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190090
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks!  Looks good.

regards,
dan carpenter


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09F1F19F5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFHNZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 09:25:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgFHNZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 09:25:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058DIVV3009696;
        Mon, 8 Jun 2020 13:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g+1brnPZ5OzPDeNs4PfHGUTw5EjIjHf2rZ33XxmyH2A=;
 b=L9Q6MgLscregteDP1PDsvEBMkIniBDDCn18Lfj3jsgt3+O8Spd5PUHNrWj8GOPOXVi6f
 WeN0CAdSawapqJkObo9Dw0J9oHnwGLTdCGmTTJ80jo44XaTn2oUyyW1XKsI5dJcoUmAM
 uLDW2PTnwbLMNMkba/wtaHtgpBSacNq1Zs3PzpuyiaNX1CPOKCn4nyq/Lr66vCsdt+YO
 8wHlLEvWdK6jwRrUCWBfudWBKbKsTk0vRJhKhh0Qbz6xJtp07ljv4EUBTnB61y25U1D/
 WVonYhsb78B0QGUJOm8sr9fLyhP026j55otjQpOuuBvDGTg0+I5xhOldqg8oznG3q3uL JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31g3smpspj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 13:25:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058DNn0V108563;
        Mon, 8 Jun 2020 13:25:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31gmqm7gju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 13:25:20 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058DPJkd008134;
        Mon, 8 Jun 2020 13:25:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 06:25:18 -0700
Date:   Mon, 8 Jun 2020 16:25:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     kbuild@lists.01.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, lkp@intel.com,
        Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        Dietmar.Eggemann@arm.com, cw00.choi@samsung.com
Subject: Re: [PATCH v8 4/8] PM / EM: add support for other devices than CPUs
 in Energy Model
Message-ID: <20200608132507.GP22511@kadam>
References: <20200608115155.GY30374@kadam>
 <b347fb60-46d3-e59c-59fa-a2b10932fc49@arm.com>
 <20200608125127.GN22511@kadam>
 <da0debe1-73da-33f1-c24e-154c2123c522@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0debe1-73da-33f1-c24e-154c2123c522@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080100
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not really a proper bug report so it doesn't deserve a reported-by.

Thanks, though!

regards,
dan carpenter


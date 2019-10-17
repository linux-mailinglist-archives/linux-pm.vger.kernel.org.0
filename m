Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD87FDB830
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437589AbfJQUSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 16:18:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQUSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 16:18:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKEKmU057514;
        Thu, 17 Oct 2019 20:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=acw8xQL/F51wBLTFsWcK2zjShLTVKrm/1mu9VCqy+Ks=;
 b=OgXchoI9EIqkkKVV7FXVGmqMSU4rNWzpp93W30turopnqukVu5gP1YA7lqK9I7Cec02I
 AUnmnMItffHr1z9HUgmG3g0vsbpW90/RwAbT2SR06BOP6NEMWtonFrg/vhK+SzTTxTPs
 IgKM4UuIHZn2OoFy7CLQBxcksByIDqSj2VpTnDC71Ig2ADUf4BFgmCAhGcFQCPZEWWYq
 sjbemWsF4PXsHPLSmkFngKNtXs75PuWXpSgbhrtehixv8T3FLe7BiHAHAtVfD8Ko8gPm
 YvRtvGUiAH7ZDlRcO2T16eNeCCS9xY7jA3SXluMMvLhb4b+arzYoxnMQgj3HO6UkBCah kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sr0tuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 20:17:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKDE5W126580;
        Thu, 17 Oct 2019 20:15:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vpcm3j4ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 20:15:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HKFnsQ006893;
        Thu, 17 Oct 2019 20:15:50 GMT
Received: from [10.175.166.205] (/10.175.166.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 20:15:49 +0000
Subject: Re: [PATCH] cpuidle-haltpoll: make haltpoll aware of 'idle=' override
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1571272750-29798-1-git-send-email-zhenzhong.duan@oracle.com>
 <CAJZ5v0h7+53bT4oF109b-ah3wjFNYxz+PNr7DOBQ7rpRKbtGWQ@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <4ba66cc7-f8ff-05a0-cdee-e1bbba677e67@oracle.com>
Date:   Thu, 17 Oct 2019 21:15:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h7+53bT4oF109b-ah3wjFNYxz+PNr7DOBQ7rpRKbtGWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=993 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170182
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/19 8:20 PM, Rafael J. Wysocki wrote:
> On Thu, Oct 17, 2019 at 2:41 AM Zhenzhong Duan
> <zhenzhong.duan@oracle.com> wrote:
>> and haltpoll
>> is built in. If haltpoll is built as a module, still give a chance for
>> admin to use it despite 'idle='.
> 
> Why exactly?  Do you have any particular use case in mind?
> 
There was no concrete use-case in particular; we thought that when building as a
module, that the general usage would be for cpuidle-haltpoll to be inserted (or
removed) at some point in the time. And hence allow it to override boot 'idle='
given that you can always remove the module and go back to 'idle='.

> Otherwise I'd prefer the behavior to be consistent regardless of
> whether or not it is a module..
> 
It's best we just remove the conditional and keep it consistent across builtin
and module.

	Joao

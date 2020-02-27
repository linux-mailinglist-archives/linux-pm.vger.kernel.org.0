Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B12170F9D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 05:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgB0EWq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 23:22:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19815 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgB0EWp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 23:22:45 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200227042243epoutp018ab285010aecc75427059854d16ebceb~3J6BHTOMu3059730597epoutp014
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 04:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200227042243epoutp018ab285010aecc75427059854d16ebceb~3J6BHTOMu3059730597epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582777363;
        bh=DKtRV6oNruS4ryi/QvX//Su7UQWSj/ubLBAPJNAZyf8=;
        h=To:Cc:From:Subject:Date:References:From;
        b=FK6vxPit7InpJWABEoaETi6g/pzU0LEvvz4K9Mn1u723qJkGknvOEaY+2vje32Kzc
         zH+kO6b5nfrNQkMf4RqIAzbHdDT1yXzmWZGP551H9+BTNSDmcIgV/2qybz3egiapnI
         T7CNoLNLyFDT0DezLsKWxL+OyhTZttPMcHN3+gvk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227042242epcas1p17ae5ceadbd297c77ee5625799847beed~3J6AeSkmx0751807518epcas1p1Y;
        Thu, 27 Feb 2020 04:22:42 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48Sff43gHCzMqYkZ; Thu, 27 Feb
        2020 04:22:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.68.52419.904475E5; Thu, 27 Feb 2020 13:22:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227042233epcas1p2541b00baa994f262d07c4dc65da99c1c~3J53i-ZMU0590005900epcas1p2c;
        Thu, 27 Feb 2020 04:22:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227042233epsmtrp17fb3780616652201c6735e78d35fa5fb~3J53h-Aq71529215292epsmtrp1V;
        Thu, 27 Feb 2020 04:22:33 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-12-5e57440947b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.13.06569.804475E5; Thu, 27 Feb 2020 13:22:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227042232epsmtip2eb9d48297a636dd4a86f348066c1e19d~3J53U4CSR2557025570epsmtip2E;
        Thu, 27 Feb 2020 04:22:32 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq fixes for v5.6-rc4
Organization: Samsung Electronics
Message-ID: <c9cf6c14-2ff7-6809-2bc7-83ca7974c3b7@samsung.com>
Date:   Thu, 27 Feb 2020 13:30:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmvi6nS3icwbMrMhYTb1xhsbj+5Tmr
        xeVdc9gsPvceYbS43biCzeLM6UusDmwem1Z1snlsudrO4tG3ZRWjx+dNcgEsUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGVcaLrAW3Oeq
        uLqqna2B8SdHFyMnh4SAicTdYw9Yuxi5OIQEdjBKvPl3kAXC+cQoMf3ecajMN0aJrQd7mGBa
        9hz4xQ6R2MsosWLbZqiW94wSK7/OB2rh4BARsJfo+JAJEmcWmMMk8WjSGjaQbjYBLYn9L26A
        2cICehIvZ55nBLH5BRQlrv54DGbzCthJTGuYyA5iswioSrTenAJWLyoQJnFyWwtUjaDEyZlP
        WEBsZgFxiVtP5jNB2PIS29/OYQZZLCFwgk1i8uozbBBnu0icPHAW6gVhiVfHt7BD2FISL/vb
        oOxqiZUnj7BBNHcwSmzZf4EVImEssX/pZCaQz5gFNCXW79KHCCtK7Pw9lxFiMZ/Eu689YM9L
        CPBKdLQJQZQoS1x+cBdqraTE4vZOqHM8JD60TmKewKg4C8k7s5C8MwvJO7MQFi9gZFnFKJZa
        UJybnlpsWGCMHN2bGMEpU8t8B+OGcz6HGAU4GJV4eAuSwuKEWBPLiitzDzFKcDArifBu/Boa
        J8SbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgek8ryTe0NTI2NjYwsTQzNTQUEmc92GkZpyQ
        QHpiSWp2ampBahFMHxMHp1QDY1TnPLurxh3eHEGNy0J3ed63iMx7eV1ag9dQ/e5Frewl2jxZ
        fpeFTvN0hcWfLl5ZIR7GcLPYY2/91PCfJ04oLt56pjVxVXdu2QeBM36ab+6/vWf/SPDQEgmd
        iNeNJyKrL35enf5TTkFjve5hxdmfO5pnGJ7f1LP+7IXGf1na55L8bt8R13/+RYmlOCPRUIu5
        qDgRACnc5YCvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvC6HS3icwc1GW4uJN66wWFz/8pzV
        4vKuOWwWn3uPMFrcblzBZnHm9CVWBzaPTas62Ty2XG1n8ejbsorR4/MmuQCWKC6blNSczLLU
        In27BK6MKw0XWAvuc1VcXdXO1sD4k6OLkZNDQsBEYs+BX+xdjFwcQgK7GSWm7u9nhUhISky7
        eJS5i5EDyBaWOHy4GKLmLaPEtqd32EDiIgL2Eh0fMkHizALzmCRO3l/EAtLLJqAlsf/FDTYQ
        W1hAT+LlzPOMIDa/gKLE1R+PwWxeATuJaQ0T2UFsFgFVidabU8DqRQXCJHYuecwEUSMocXLm
        E7CZzALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj4CwkLbOQtMxC0jILScsCRpZVjJKpBcW5
        6bnFhgVGeanlesWJucWleel6yfm5mxjBkaCltYPxxIn4Q4wCHIxKPLwFSWFxQqyJZcWVuYcY
        JTiYlUR4N34NjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TB
        KdXAuIDjI2Pn9tdCPn+vqD6siu/tzXQUD/gjqP7padDug14KFyJu/J3X2qpSmvux3OT02i2e
        n2sTeud92Nc9bd1OqQN+b1cZ5CyPmHXOfcGjdedPWSTGWM1/ylKVKzB744TkEKXVLbINjy61
        TxF9/7vgFQ9XcMdbXZdvit+aggTClgdu2HhgzeNdr5VYijMSDbWYi4oTATZbYUCAAgAA
X-CMS-MailID: 20200227042233epcas1p2541b00baa994f262d07c4dc65da99c1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200227042233epcas1p2541b00baa994f262d07c4dc65da99c1c
References: <CGME20200227042233epcas1p2541b00baa994f262d07c4dc65da99c1c@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-fixes pull request for v5.6-rc4. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
And this patch will be applied to stable tree.
- tag name : devfreq-fixes-for-5.6-rc4

Best Regards,
Chanwoo Choi


The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.6-rc4

for you to fetch changes up to 66d0e797bf095d407479c89952d42b1d96ef0a7f:

  Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs" (2020-02-24 11:14:29 +0900)

----------------------------------------------------------------

Detailed description for this pull request:
1. Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"
- This changes as devfreq(X) cause break some user space applications
such as Android HAL from Unisoc and Hikey. In result, decide to revert it
for preventing the HAL layer problem.

----------------------------------------------------------------
Orson Zhai (1):
      Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"

 drivers/devfreq/devfreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

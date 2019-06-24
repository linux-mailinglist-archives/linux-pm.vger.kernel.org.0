Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B67503B2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFXHh5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:37:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19731 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXHhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 03:37:50 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190624073746epoutp0101e0b4efc762c0bf10c412d7a071c879~rElhYj5RQ0428604286epoutp01Z
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 07:37:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190624073746epoutp0101e0b4efc762c0bf10c412d7a071c879~rElhYj5RQ0428604286epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561361866;
        bh=hZZu54p+MpOQw7pjLcHefLtdEZhcZzg7toiu4G8PxMI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=BwzWJ/ETwBSj+fMM+9PwWWzwyigrr07z05Xx7YcWASCvpR9y+r7j9CLqBXlS+b8Y4
         OTLCVnlHFVCaeGVmh0COQwxveMlr+Qs3fWouEZwpgIMHrBNUwy7TDhdWtB9O7VdJnC
         Sbi6TS/H+oXLWvujm/5A8F8dFaS5Ju149Al1pWkc=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624073744epcas1p24d39a53ba61b5949c2af6bf108108416~rElfLZr6t0162501625epcas1p2j;
        Mon, 24 Jun 2019 07:37:44 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-72-5d107dc69115
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.3D.04108.6CD701D5; Mon, 24 Jun 2019 16:37:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] PM / devfreq: Fix kernel oops on governor module
 load
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190621213949.27018-1-ezequiel@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624073742epcms1p29979ff8c388b70e6e03b0e6f7ccf51db@epcms1p2>
Date:   Mon, 24 Jun 2019 16:37:42 +0900
X-CMS-MailID: 20190624073742epcms1p29979ff8c388b70e6e03b0e6f7ccf51db
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe737uFo3X6fVycLWpYIC3W46m6FWqLHIyKgoKluX7bKJ+2J3
        SmqBpWWYipFRrPyIlNBlDVObGqFLlL7/KUOkUOiDLDOcgSlh+xL77+Hhd85zznlfkpCUiqLJ
        HJONs5pYAy0KE3Q+3SyLHTiLs+WztYnK99Nfhcp7I26k7HJOi5UPX1cIla/O/xArPZX9aKdI
        5frQiFRV7S1I5WmLySKO5SbrOVbLWaWcSWPW5ph0KfTeg+o0tSJRzsQyScpttNTEGrkUOj0z
        K3Z3jsGbS0vzWUOe18pieZ6WpSZbzXk2Tqo387YUmrNoDZYkSxzPGvk8ky5OYzZuZ+TyrQov
        eCpXP158TWDpFZ9+59AVo8uichRKAk6AvoulyKcl2IVgvvpIOSJJCkfAX1ekz47E+6GuqkUY
        QGgoHn5CBHwZXBrt9JeKcCx0OD8IfDoKH4aashEvE0YS+A2Cu6MeFMii4EbZZ0FAr4FHdzuQ
        LysUJ0Nr0/aAvQKGHRPiBT05UB8sjYILH18RAR0Bo3960EKbGzXzwZZFMHT9jtiXC7gUQaWj
        JgjJ4GXtM/++FN4HU2+m/AECvBEm6idDAkw6OBqH/DyB18GjiVuEbzYCb4YH3bIAsh665mqD
        yHL4+btCuLCWq+5TsM0mcPc0BudfCy+u3w7OrIIxz6B/NgkuQWC/ORtSjaT2xVPb/0u2LyY3
        IKIFreQsvFHH8YxF8f/btiH/D9yS5EIDrzPdCJOIXkZhZ3i2RMjm8wVGNwKSoKOoJhZnSygt
        W1DIWc1qa56B491I4T3AFSJ6hcbs/c8mm5pRbI2Pj1cmMIkKhqFXUeqlwyckWMfauFyOs3DW
        hboQMjS6GJ3Tq8bWdwoLC3Y4FLs2Gqh6ednz5gP3XTMlsxevZmu6W3MaD/XMhHwvMZ5rSGoB
        Z37DrzODQx1zGYXpmrfoW1/Wht5wj720+2iqq42TRMTAtLOp6EyHrfdIzJdqe//giyXD+1If
        U3vSXHXa9gwD2xT1fvV4+0nLoYiyLsfx6GZawOtZZgth5dl/oaHK0JcDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190621214003epcas5p4682d7d258b3ec2ae92521111fe8864ab
References: <20190621213949.27018-1-ezequiel@collabora.com>
        <CGME20190621214003epcas5p4682d7d258b3ec2ae92521111fe8864ab@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> A bit unexpectedly (but still documented), request_module may
> return a positive value, in case of a modprobe error.
> This is currently causing issues in the devfreq framework.
> 
> When a request_module exits with a positive value, we currently
> return that via ERR_PTR. However, because the value is positive,
> it's not a ERR_VALUE proper, and is therefore treated as a
> valid struct devfreq_governor pointer, leading to a kernel oops.
> 
> Fix this by returning -EINVAL if request_module returns a positive
> value.
> 
> Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
> * Rework the fix as suggested by Enric and Chanwoo,
>   handling the return vaue.
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


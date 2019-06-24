Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13A4FF25
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 04:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFXCNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 22:13:09 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:53128 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFXCNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 22:13:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190624021306epoutp01a677634a608ad041a583bb056a3a523c~rAKDHUwim0818608186epoutp01g
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 02:13:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190624021306epoutp01a677634a608ad041a583bb056a3a523c~rAKDHUwim0818608186epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561342386;
        bh=Bjxv0RRUWPDBM+vlsvLdx6BQWrwtvpQPL5LR7DGLxjw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hzjpX5+9hx/a1tdVMF8nJlqTy4AoOattbUJB3gjjl2g9E4cDDgyE9EZSCiKyYCk+j
         AAxsgbzscgkEwuqqh8zB5aSwmHq5Hbw1hY7hQdcmF4cgc1m7EqhAuZDv3vU7K8i5Lx
         O9AvXL2KfXmItk6fZhNotQzX4qzE3540oCxuNXuo=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190624021301epcas1p32614991eb0c0533de1d556cbf4945e11~rAJ_vt4kw0385803858epcas1p3A;
        Mon, 24 Jun 2019 02:13:01 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-02-5d10319df346
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.4A.04257.D91301D5; Mon, 24 Jun 2019 11:12:45 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v1 01/11] PM / devfreq: tegra30: Change irq type to
 unsigned int
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190623214658.11680-2-digetx@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624021245epcms1p5366dd98904dac95625dc2deb4b649cb1@epcms1p5>
Date:   Mon, 24 Jun 2019 11:12:45 +0900
X-CMS-MailID: 20190624021245epcms1p5366dd98904dac95625dc2deb4b649cb1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj285ydHZfLz2n1YWXrQBeFpUedHStDSGJQghFUWDIPeprD3diZ
        KytIUqk0zUIr5qUsI9PCC16ms5QZRZlFiYWEJd3MUrtohFjUtjOxf8/38Lzv87zv95KY7DIR
        QmoNFs5sYHUUIcHb+8IUiioapkaOl9PMy5kxEdPw/R1g8m1XcWbgxISYGeyqJJjp4nuAOT1j
        I5jZrmqcKbn9nEjwU9lHaoGq0zYiVhXnTRGqktZ6oJpuCU0WpWRtyeTYDM4s5wzpxgytQRNP
        7dit3qZWxkbSCjqO2UjJDayei6cSdyYrtmt1rkCU3Mrqsl1UMsvzVMTWLWZjtoWTZxp5SzzF
        mTJ0pjjTBp7V89kGzYZ0o34THRkZpXQJ07Iyx2YLRKZx38ODde+JXNDoWwj8SARjUF7BW8KN
        ZdAO0IXRfYWAJKUwEP2xB7npILgHnSmxAUFCodzhu5jAR6BTo+0enoAK1NY0ghcCCRkM5wC6
        0/lO5H5gsBOgqdY3YsFMii6d/IALeDnquNHmqfaDsejRi1PeQEvQcMOkeB5/vX8ZCDgYFbwe
        wAQciEZnHWC+z6Wyv96eR9GLi9fEbmME8wEqbijziiLQ46qHnimlMAl9cvzyYByuQd+c173F
        iej0UJHIjTG4CnVMVmLuTWAwDDV2RQiS1ahzrgoIksVo6ucZ0fxc9ur33vxrkdNR682/AvVf
        rPFmVqGzM+WYsMWbAHU046VAblvYte0/Y9uC8RWA1YOlnInXazieNsX8/7stwHOc4YwddD/Z
        6QSQBJS/FDYFpMpErJXP0TsBIjEqWOqv80+VSTPYnCOc2ag2Z+s43gmUrvnPYSFL0o2uUzdY
        1LQyKjo6momhY5U0TS2TqhcNH5BBDWvhsjjOxJnn63xJv5BcEBy0SSKRfbM23uofqa7T3teG
        Nj/tt35pOb+4rHZ2fXivpXSiyOiYHIxS1ZT77F33O+djwLFDnxVvQ7ldn5Z2/6ocL5qx90w/
        S8Ff6VoqHMPyvocpuWUXjgds7H/c8yCh4od9haYmxzDUdnK5JDVtQmrVjoUm1Ww+mNTb7uMT
        s3L/KgrnM1k6HDPz7D9DtmwasgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190623214841epcas5p161cceab51cb10d5146e57d49a696d5e5
References: <20190623214658.11680-2-digetx@gmail.com>
        <20190623214658.11680-1-digetx@gmail.com>
        <CGME20190623214841epcas5p161cceab51cb10d5146e57d49a696d5e5@epcms1p5>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>IRQ numbers are always positive, hence the corresponding variable should
>be unsigned to keep types consistent. This is a minor change that cleans
>up code a tad more.
>
>Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

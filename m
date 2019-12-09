Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B59116F64
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLIOon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:44:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59574 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfLIOon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 09:44:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191209144441euoutp01e39f158eb63709a05237d1fb238c032b~euyO0dCiD0633306333euoutp01P
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191209144441euoutp01e39f158eb63709a05237d1fb238c032b~euyO0dCiD0633306333euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575902681;
        bh=74NcjUz2aBul+YikKJGtZMeJkoPh7D4A8z9T7rQO0N0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=q2fNbuycy85eU095O6BlUxswZdtqiC9HQJeMedJcDfn1d0KRfQypaYnOdeyJN68XD
         XfKHM0jUTJpIAyVZ8D9rwYo/x0j85vt+r8xm+t1uHW+GbWP0e7gWAnj9FmzH1qos3p
         yJaWv+Y87Mm+iVK7nZNCR1tuSUfsKgOBy7Y0dwNY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209144441eucas1p2998cedfcee44ffcf8a901864fe2d37c1~euyOj_fqB2843328433eucas1p2b;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.03.60679.9DD5EED5; Mon,  9
        Dec 2019 14:44:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209144440eucas1p10fc74a8cbc07df72bf1bcd52a7260c42~euyOIcqad1586615866eucas1p1c;
        Mon,  9 Dec 2019 14:44:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209144440eusmtrp2c5b6dfaca43dbc79f1c1d6fb9593c578~euyOHuG9C2834828348eusmtrp2h;
        Mon,  9 Dec 2019 14:44:40 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-ca-5dee5dd9bf92
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.09.08375.8DD5EED5; Mon,  9
        Dec 2019 14:44:40 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144440eusmtip258bab48ac656aa817dedf31932e6f2bc~euyNnIYfe1459414594eusmtip2C;
        Mon,  9 Dec 2019 14:44:40 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 0/4] PM / devfreq: add possibility for delayed work
Date:   Mon,  9 Dec 2019 15:44:21 +0100
Message-Id: <20191209144425.13321-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87o3Y9/FGmy9LWyxccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGU0fZ7AXPCFo+LZk08sDYz/2LoYOTkkBEwkupu+soDYQgIrGCVO
        nZHvYuQCsr8wSqz90c4EkfjMKNF3JwymoePqc2aI+HJGielT+eEazrx/xQqSYBPQlzh49iTY
        VBEBaYnORROZQIqYBY4xSew69BesSFjAWeLtkYtANgcHi4CqxKe5uSBhXgEbiXdTt4CFJQTk
        Jea81YAIC0qcnPkEbCQzULh562xmkJESAt/ZJC5ffc8CcZyLxJO218wQtrDEq+Nb2CFsGYn/
        O+czQdjlEk8X9rFDNLcwSjxo/wjVbC1x+DjEPcwCmhLrd+lDhB0ljq46wwRxD5/EjbeCEDfw
        SUzaNp0ZIswr0dEmBFGtKvH8VA/UJmmJrv/rWCFsD4lbS6YygpQLCcRKfPohNYFRYRaSx2Yh
        eWwWwgkLGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaY0/+Of9nBuOtP0iFGAQ5G
        JR7eBQ7vYoVYE8uKK3MPMUpwMCuJ8C6Z+CpWiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopex
        QgLpiSWp2ampBalFMFkmDk6pBsaCiXvO/rmwSHRlD+vSicdK5A5P/65SO//6pUMb1Gdzc/1S
        rZeXZJfWrSzWu6nyUVn9xs9Cm89Zd75st9uzQDzaSPjfL52bip7zOXRWcjnM/Zz4qjX6usYN
        x+WzQ48WsM829GM37NhibRafxyD29o3/C/2a5E/3729/YP3q+5xl/9iakqbxpAQqsRRnJBpq
        MRcVJwIAwufg4C0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7o3Yt/FGmxZYWixccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0
        fZ7AXPCFo+LZk08sDYz/2LoYOTkkBEwkOq4+Z+5i5OIQEljKKPFn221miIS0ROPp1UwQtrDE
        n2tdbBBFnxglJl1exAKSYBPQlzh49iSYLQLU0LloIlgDs8AZJolfLRUgtrCAs8TbIxdZuxg5
        OFgEVCU+zc0FCfMK2Ei8m7oFLCwhIC8x560GRFhQ4uTMJywQU+QlmrfOZp7AyDcLSWoWktQC
        RqZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgQG+7djPzTsYL20MPsQowMGoxMO7wOFdrBBr
        YllxZe4hRgkOZiUR3iUTX8UK8aYkVlalFuXHF5XmpBYfYjQFOnUis5Rocj4w+vJK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBO2vvsoAjv7UZp9snpy5JPT57s
        aVK9XTbG4MXJfNXQI2VHAtgFDlX/i/+qJsvxYGF/yReO9t+aRTNXWf95YnF5xhYPboM1l9TS
        1+d6Z7nuPMv9Rk2Wu0Rm0zyzV7w+efYKh5fqV17jnBiyZ36VD6+9n/EF8+yG+DnH+coav92+
        pOslcv3PoWIlluKMREMt5qLiRADITzhZhgIAAA==
X-CMS-MailID: 20191209144440eucas1p10fc74a8cbc07df72bf1bcd52a7260c42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144440eucas1p10fc74a8cbc07df72bf1bcd52a7260c42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144440eucas1p10fc74a8cbc07df72bf1bcd52a7260c42
References: <CGME20191209144440eucas1p10fc74a8cbc07df72bf1bcd52a7260c42@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add possibility for changing work from deferred to delayed in devfreq
workqueue. This can be done with

echo 1 > /sys/class/devfreq/devfreqX/delayed_timer

Second way is to use config option, in that case delayed timer will be
used from devfreq start.

Default behaviour is to stick with old delayed timer.

This patchset was inspired by Lukasz Luba patches and discussion that
follows, see

[v1] https://marc.info/?l=linux-pm&m=154904631226997&w=2
[v2] https://marc.info/?l=linux-pm&m=154989907416072&w=2
[v3] https://marc.info/?l=linux-pm&m=155001027823904&w=2

Kamil Konieczny (4):
  PM / devfreq: reuse system workqueue machanism
  PM / devfreq: add possibility for delayed work
  PM / devfreq: Kconfig: add DEVFREQ_DELAYED_TIMER option
  PM / devfreq: use delayed work if DEVFREQ_DELAYED_TIMER set

 Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
 drivers/devfreq/Kconfig                       | 12 ++++
 drivers/devfreq/devfreq.c                     | 55 +++++++++++++++++--
 include/linux/devfreq.h                       |  2 +
 4 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.24.0


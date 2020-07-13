Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59721D185
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGMITv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:19:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19707 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgGMITv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 04:19:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200713081947epoutp018baf974c3fb8b83c10f8a48dc464f9f4~hQhHfqGG40053700537epoutp01C
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200713081947epoutp018baf974c3fb8b83c10f8a48dc464f9f4~hQhHfqGG40053700537epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594628387;
        bh=yu6itZWiAmcUaJ+QXSa0fa211Ngc9QUGJ4KMoZyhcMQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kdkwnrwzYsksIqXYZ0mU020jdOx6pqrrVpPmCu0gYO5I6wsZ4hCLWXeSnuUIusQo3
         iTClZi2Sv0LUhPol5T4pbcFqjL2F2skU+rKDwZFMl/EaIRF0xhcBXMme/oWbUdQ7zH
         GJQm1wfE02VyqvAmJuWg8NxCRpF2J1+XakzDYLWM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200713081947epcas1p32422b17ad8f84d8ef9bb2e67caf9216b~hQhG8793o2571125711epcas1p3k;
        Mon, 13 Jul 2020 08:19:47 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4B4xQS2V6TzMqYkp; Mon, 13 Jul
        2020 08:19:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.20.19033.0291C0F5; Mon, 13 Jul 2020 17:19:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200713081943epcas1p451280630c83a47b2687ab84d28ccdea0~hQhD8Rjgo2871028710epcas1p4U;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713081943epsmtrp21084a2aade8c8ce5db93c132e8577fe5~hQhD7YNmK2276722767epsmtrp2c;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-ff-5f0c19209e19
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.F3.08303.F191C0F5; Mon, 13 Jul 2020 17:19:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713081943epsmtip269a92944d6051baa2df175ffac540b2d~hQhDtGyjk2539325393epsmtip2E;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v2 0/2] PM / devfreq: Add governor flags
Date:   Mon, 13 Jul 2020 17:31:11 +0900
Message-Id: <20200713083113.5595-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQFdBkifeYN1JHotll44yWky8cYXF
        4vqX56wWqz8+ZrRYc/sQo8WPDaeYLVpmLWKxONv0ht1ixd2PrBaXd81hs/jce4TRYmFTC7vF
        7cYVbBY/d81jceDzWDNvDaPHjrtLGD12zrrL7rFpVSebR2/zOzaPje92MHn8nbWfxaNvyypG
        j8+b5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4CuV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoY
        GJkCFSZkZ7RtXstasFywYmv/FaYGxh6+LkYODgkBE4l7q5hBTCGBHYwSmxW6GDmBzE+MEq+f
        VHcxcgHZnxkl/rxczwaSACk/s2I9K0RiF6PErCvb2CCcL4wS/W3fmEGq2AS0JPa/uAHWISJg
        JXH6fwczSBGzwDwmicWnr7KAJIQFLCS23F8EVsQioCpxvuMGWJxXwFLi2u9VTBDr5CVWbzgA
        1iwh0Moh0dD/lR0i4SLxY9dNRghbWOLV8S1QcSmJz+/2Qt1aLbHy5BE2iOYORokt+y+wQiSM
        JfYvncwE8jSzgKbE+l36EGFFiZ2/54LNZBbgk3j3tYcVEkS8Eh1tQhAlyhKXH9yFuk1SYnF7
        J9QqD4mOS7OYIWEXK7H3Sjv7BEbZWQgLFjAyrmIUSy0ozk1PLTYsMEKOo02M4PSoZbaDcdLb
        D3qHGJk4GA8xSnAwK4nwRotyxgvxpiRWVqUW5ccXleakFh9iNAUG2ERmKdHkfGCCziuJNzQ1
        MjY2tjAxNDM1NFQS5/13lj1eSCA9sSQ1OzW1ILUIpo+Jg1OqgSnDP1qTw9r9+g7Oy24N8xLa
        NQvWL3R3fbXu6gr7ze3KS17Vz8g8ufujwYLPpjI16z/0d9s0qG+Kf2xZs99Z90ew8cpHEtv7
        W/VDF3/aW3Va/tfcs9rvN2069nF9oe8v5iPdNoEJ54y3F2is0F+9+tCu55cn2Ae05bXzHJfr
        dmhm2CYZIvO19YT4ysbsa1G2Pp7hpiLa65jlcsTWzGDkXXK0TevnpBO3Jyy3/1aqeHtdbuSP
        7tOKR+yDWi5t7Tz7ynsWJ+9OhaCnwjFVC21rjlcV1Z1qZTvFGW6Z3igVw/2e0eXPprbSN3bX
        /psU3VhqXBaUtoBBsdOu9GHU1O1TUifPseI+aSof4Mn+Lbf4tBJLcUaioRZzUXEiABQ8SZsY
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSvK68JE+8wY1fWhbLLh1ltJh44wqL
        xfUvz1ktVn98zGix5vYhRosfG04xW7TMWsRicbbpDbvFirsfWS0u75rDZvG59wijxcKmFnaL
        240r2Cx+7prH4sDnsWbeGkaPHXeXMHrsnHWX3WPTqk42j97md2weG9/tYPL4O2s/i0ffllWM
        Hp83yQVwRnHZpKTmZJalFunbJXBltG1ey1qwXLBia/8VpgbGHr4uRk4OCQETiTMr1rN2MXJx
        CAnsYJR4t/ocG0RCUmLaxaPMXYwcQLawxOHDxSBhIYFPjBIrn3iD2GwCWhL7X9wAKxcRsJG4
        u/gaC8gcZoE1TBLvth9iAkkIC1hIbLm/CKyIRUBV4nzHDRYQm1fAUuLa71VMELvkJVZvOMA8
        gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4JDV0trBuGfVB71DjEwcjIcY
        JTiYlUR4o0U544V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TB
        KdXA5OT0K/Lnfentt/gkF618uYF77hmFQ5+m7imQCF+SF1Mffthn1wyHBIFJHsadISsF+6+1
        bzdMqjDt75WIk9m755TOxHMyYTN1Zj9J1bFlKXT6VfbB7MX6u06z57Zavvu16AvD5C4+422Z
        f3+dsOd+vO/tgdXuTBcrm50aRfYsMb12qvy3j/EByxmqxyeHf1WN5ov1ffRBxy/Ya8Llw8qO
        O9/F1X4+73i5UHX1XtENUa57dTLqhU7OX8R+hKn06N+Js64db2f/9PhTV3x/I+8C0+u5j27P
        t9X4811p8XapPz/XyrxP7LLQFE2pan6Ufp6fR+u9Yudux8uh0hvfnY822/JlfW64mJKGSl/k
        D8GVq5VYijMSDbWYi4oTAejwnufIAgAA
X-CMS-MailID: 20200713081943epcas1p451280630c83a47b2687ab84d28ccdea0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713081943epcas1p451280630c83a47b2687ab84d28ccdea0
References: <CGME20200713081943epcas1p451280630c83a47b2687ab84d28ccdea0@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devfreq provides the multiple governors and sysfs interface for user.
But, some sysfs attributes are useful or not useful. Prior to that
the user can access all sysfs attributes regardless of availability.

So, clarify the access permission of sysfs attributes according to governor.
Provide the governor flag to specify what is necessary or not.
When adding the devfreq governor, governor can specify the available
attributes with DEVFREQ_GOV_ATTR_ATTR_* defintion as following.

[Definition for sysfs attributes]
- DEVFREQ_GOV_ATTR_GOVERNOR
- DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS
- DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES
- DEVFREQ_GOV_ATTR_CUR_FREQ
- DEVFREQ_GOV_ATTR_TARGET_FREQ
- DEVFREQ_GOV_ATTR_MIN_FREQ
- DEVFREQ_GOV_ATTR_MAX_FREQ
- DEVFREQ_GOV_ATTR_TRANS_STAT
- DEVFREQ_GOV_ATTR_POLLING_INTERVAL
- DEVFREQ_GOV_ATTR_TIMER

Also, the devfreq governor is able to have the specific flag as follows
in order to implement the specific feature with DEVFREQ_GOV_FLA_*.
For exmaple, the devfreq deivce using passive governor cannot change
their own governor because passive governor requires the 'immutable'
feature with DEVFREQ_GOV_FLAG_IMMUTABLE.

[Definition for governor flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
: If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
: Devfreq core won't schedule polling work for this governor if value is set.


Changes from v1:
- Rebase it on latest devfreq-next branch
- Fix typo issue of tegra30-devfreq.c and test it with COMPILE_TEST

Chanwoo Choi (2):
  PM / devfreq: Clean up the devfreq instance name in sysfs attr
  PM / devfreq: Add governor flags to clarify the features

 drivers/devfreq/devfreq.c                 | 186 +++++++++++++++++-----
 drivers/devfreq/governor.h                |  44 ++++-
 drivers/devfreq/governor_passive.c        |   3 +-
 drivers/devfreq/governor_performance.c    |   1 +
 drivers/devfreq/governor_powersave.c      |   1 +
 drivers/devfreq/governor_simpleondemand.c |   3 +
 drivers/devfreq/governor_userspace.c      |   1 +
 drivers/devfreq/tegra30-devfreq.c         |   6 +-
 8 files changed, 192 insertions(+), 53 deletions(-)

-- 
2.17.1


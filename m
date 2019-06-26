Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399E655D7A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFZBad (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:30:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42963 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZBad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:30:33 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190626013031epoutp015e70d74d7303ef37e3423d2338013460~rm3cBhQqn2349823498epoutp01f
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 01:30:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190626013031epoutp015e70d74d7303ef37e3423d2338013460~rm3cBhQqn2349823498epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561512631;
        bh=vSMrV2147YIb7tDDS50bEc6dNLClli0ADfjAuW26DSg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=stLgmO2BeCymf5VkemQCe/h9+YftKu+ZspE/Qyyr07crK42++r2anzjAcRFhc3fTZ
         2PJUSoAW3C9KiqGR0vTMn9Pb5j2lTlvJoYGARfGuphsByOVXOUGGb3ChNKDpBIIhxr
         KZ/YjoJfDszX58MXJ3PPU13oh5xVJT7KUVndGSQg=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190626013028epcas1p39cce0bafc6bab8d85060092a770e1cb1~rm3ZR0n962159521595epcas1p3v;
        Wed, 26 Jun 2019 01:30:28 +0000 (GMT)
X-AuditID: b6c32a39-d0c179c00000100c-99-5d12caad84b2
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.CA.04108.DAAC21D5; Wed, 26 Jun 2019 10:30:21 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in
 devfreq
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Saravana Kannan <saravanak@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190625213337.157525-4-saravanak@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190626013021epcms1p4a7a6689eb78265c48c7c2289dc30615b@epcms1p4>
Date:   Wed, 26 Jun 2019 10:30:21 +0900
X-CMS-MailID: 20190626013021epcms1p4a7a6689eb78265c48c7c2289dc30615b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmge7aU0KxBv/3K1q8PKRpcf3Lc1aL
        HdtFLM42vWG3uLxrDpvF594jjBZvfpxlsjhz+hKrRdehv2wW/65tZLHY/OAYmwO3x7bd21g9
        Fmwq9di0qpPNY8vVdhaPvi2rGD2O39jO5PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IyDi/8wFvxhqjiwYzZbA+MWpi5GTg4J
        AROJSb3rGbsYuTiEBHYwSvzespm5i5GDg1dAUOLvDmGQGmGBAInlh58wgthCAkoSDTf3MUPE
        9SU6HmwDi7MJ6Eps3XCXBWSOiMAjRolty7+wgTjMArcZJXb+72SF2MYrMaP9KQuELS2xfflW
        sG5OAWuJk//eQV0kKnFz9Vt2GPv9sfmMELaIROu9s8wQtqDEg5+7GWHmzJjyH2pmtcS16YvZ
        QRZLCLQwSvSungJVpC9xZu5JNhCbV8BXYunko2AHsQioSkz9uA9qqIvEr/f3wY5gFpCX2P52
        DjgkmAU0Jdbv0ocoUZTY+XsuI8wvDRt/s6OzmQX4JN597YH7d8e8J1B/qUkc2r0Eql5G4vT0
        hcwTGJVmIcJ6FpLFsxAWL2BkXsUollpQnJueWmxYYIocvZsYwclVy3IH47FzPocYBTgYlXh4
        G+SFYoVYE8uKK3MPMUpwMCuJ8C5NFIgV4k1JrKxKLcqPLyrNSS0+xGgK9P9EZinR5Hxg4s8r
        iTc0NTI2NrYwMTQzNTRUEueN574ZIySQnliSmp2aWpBaBNPHxMEp1cDo8sJ+oqVq7cQ/z3RC
        c9u0Fi4+2dq436vTx2d5ouVCu6qlFe/L31w46naCv7y9Rm7p7Acpz7ccz/NYclrymDTnv8PL
        NvW8tt7++dvF+n2i/wOXT1/rZjdvz8kDH24vWRr4ujWpcsGa9R8rlJe5rlth2SlUxFpyrjQt
        t0nl8pN2s/A6Xn5XjzmXlFiKMxINtZiLihMB0aFPNMQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190625213355epcas5p3805e632818ee999a91e48ef9a610a084
References: <20190625213337.157525-4-saravanak@google.com>
        <20190625213337.157525-1-saravanak@google.com>
        <CGME20190625213355epcas5p3805e632818ee999a91e48ef9a610a084@epcms1p4>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>The OPP table can be used often in devfreq. Trying to get it each time can
>be expensive, so cache it in the devfreq struct.
>
>Signed-off-by: Saravana Kannan <saravanak@google.com>
>---
> drivers/devfreq/devfreq.c | 6 ++++++
> include/linux/devfreq.h   | 1 +
> 2 files changed, 7 insertions(+)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

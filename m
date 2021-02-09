Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96C5314C86
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 11:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBIKGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 05:06:10 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:40096 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhBIKDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 05:03:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210209100212epoutp04c6513f76aa7d0081e0e8a359c3966ba1~iDBxDgMcb1572215722epoutp04U
        for <linux-pm@vger.kernel.org>; Tue,  9 Feb 2021 10:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210209100212epoutp04c6513f76aa7d0081e0e8a359c3966ba1~iDBxDgMcb1572215722epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612864932;
        bh=4dCZpx4ImufVGeBfFJgpvD6cXpDuzMBqydSmZNWwe4U=;
        h=To:Cc:From:Subject:Date:References:From;
        b=JToidA326JisjO8BlgAqf+3lcdUoKsBN4HAlq5qr1YcnUlUJeNOlSJJ0MRgMzkSiM
         E4P01Q6jaUbiAT/SdUk8vgtg5h9GzKsrG85wM7lrZJSN2IEZgzQ95+JJMC7Q06SxbJ
         cXSsuC1/xGUWqp3GssJLGFBfmXiYYsUJVeiJDiSU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210209100211epcas1p33aa468099df74d58783647d92c35a5f9~iDBwe85dO0531005310epcas1p3r;
        Tue,  9 Feb 2021 10:02:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DZdjC6mJhz4x9Ps; Tue,  9 Feb
        2021 10:02:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.1D.10463.F9D52206; Tue,  9 Feb 2021 19:02:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210209100206epcas1p25af750e4292a7af7c68b9238e24bca0e~iDBsOHMJh1140211402epcas1p2l;
        Tue,  9 Feb 2021 10:02:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210209100206epsmtrp2d39cfaa4e901ce875669ae724f6b682d~iDBsNTv5r1746217462epsmtrp2T;
        Tue,  9 Feb 2021 10:02:06 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-ac-60225d9fcbd8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.4D.13470.E9D52206; Tue,  9 Feb 2021 19:02:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210209100206epsmtip2c3bc2ddc58ac2ee5893c2d88f645c30a~iDBsDlo4G0881908819epsmtip2K;
        Tue,  9 Feb 2021 10:02:06 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.12
Organization: Samsung Electronics
Message-ID: <f0478d74-5539-4ad1-5be0-1aa0b3931f26@samsung.com>
Date:   Tue, 9 Feb 2021 19:18:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTX3d+rFKCQc8rQ4uJN66wWFz/8pzV
        4mzTG3aLz71HGC1uN65gszhz+hKrA5vHplWdbB5brrazePRtWcXo8XmTXABLVLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtByJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xsV1X9kLNvJW
        LN07hbmBcTJ3FyMHh4SAicSRFcldjFwcQgI7GCUeXzrNCuF8YpToebqCDcL5xihxaepS5i5G
        TrCO1pf3WCASexkl/j2YDNXynlFi4YuZLCBzRQTsJTo+ZII0MAv0M0n03tUDsdkEtCT2v7jB
        BmILA9mvT19gBbH5BRQlrv54zAhi8wrYSTzq6QWrYRFQkWh6egHMFhUIkzi5rQWqRlDi5Mwn
        LBDzxSVuPZnPBGHLS2x/O4cZ5B4Jga/sEhdX/2CEuNpFYuGOG1AfCEu8Or6FHcKWkvj8bi8b
        hF0tsfLkETaI5g5GiS37Ia6TEDCW2L90MhPIY8wCmhLrd+lDhBUldv6eywixmE/i3dceVkiY
        8kp0tAlBlChLXH5wlwnClpRY3N4JtcpD4sr2mcwTGBVnIXlnFpJ3ZiF5ZxbC4gWMLKsYxVIL
        inPTU4sNC0yQI3sTIzhdalnsYJz79oPeIUYmDsZDjBIczEoivIGdcglCvCmJlVWpRfnxRaU5
        qcWHGE2BATyRWUo0OR+YsPNK4g1NjYyNjS1MDM1MDQ2VxHmTDB7ECwmkJ5akZqemFqQWwfQx
        cXBKNTB1Lbu6IjTg0AfJzjanz605k+Z++xbPv6D97z325G8TrwV+zv/IdGNnx3zHeXz/DN5U
        ZMquuP52cf1LtetH6zfoz4ysZbd58D7hYPBvK5Uz4tcY3rt0WOyeYJM+3Z6576P8JybHxNSt
        ZWbX81gTP5Tlxr6elWgc/qr0prvU3JerzqTZ/NXKNyhdWXBaONSr+saZ5nPbm3a97c3g4UnN
        rNJJFdr6qPuHdf+mt/tcFP4KdDtc/bJ0+vqnvsf0XA+9O+uaGXlJSPep9L3FVp3bL/de+zI7
        Inahk+PrR511cxs/qrT0LJmR99v93IU7uw1u9W0oy3CuMtH7vL6ts/9GjiKjduCkhxvbI/sv
        v6ly5rilxFKckWioxVxUnAgAHO/bkiAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO68WKUEgxn3jSwm3rjCYnH9y3NW
        i7NNb9gtPvceYbS43biCzeLM6UusDmwem1Z1snlsudrO4tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZF9d9ZS/YyFuxdO8U5gbGydxdjJwcEgImEq0v77F0MXJxCAnsZpT40LueHSIhKTHt
        4lHmLkYOIFtY4vDhYoiat4wSP86sYAeJiwjYS3R8yASJMwtMZJL4OGUKI0gvm4CWxP4XN9hA
        bGEg+/XpC6wgNr+AosTVH4/BangF7CQe9fSC1bAIqEg0Pb0AZosKhEnsXPKYCaJGUOLkzCcs
        IDazgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg4C0nLLCQts5C0zELSsoCRZRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnAkaGnuYNy+6oPeIUYmDsZDjBIczEoivIGdcglCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MOnMXmFos8w602PO
        Uw0jpTW/1adlLLz36IqNzsWtVtkNrGnpq2NWT7mjuJJ74ttpk3rFVaLEZZXf+TJ1xdd/vidy
        wrj+rUp4VMPHwLNWJ2VaIpf1TlG+mKOv+evGaYGrPM2JTQv+n54We11d6GdJ53sRzT0GpV1s
        e697vprwuSX746H6X1JBISZftvktMvL9LdyT+zrcfLr/NoP/CdsmGd9+WRryMGbP8XP2Wz6f
        jkqJKZ5RF959dtthuRDPwhPXX2xLb+M6EXDjrKDLLKUnQibJ/0u32VbqbBJelXxYz72oYavh
        0x/GTL0XPmxI38p8+vrtc2xzbn1/93byrDcNj2b2cXhcYl9lNO9lik2+WI0SS3FGoqEWc1Fx
        IgAdHw5D8wIAAA==
X-CMS-MailID: 20210209100206epcas1p25af750e4292a7af7c68b9238e24bca0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210209100206epcas1p25af750e4292a7af7c68b9238e24bca0e
References: <CGME20210209100206epcas1p25af750e4292a7af7c68b9238e24bca0e@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.12-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.12

And OPP maintainer will send the pull request including the following patches:
[1] [v6,0/3] Add required-opps support to devfreq passive gov
- https://patchwork.kernel.org/project/linux-pm/cover/20210204081424.2219311-1-hsinyi@chromium.org/

Best Regards,
Chanwoo Choi

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.12

for you to fetch changes up to fc1745c0e40cfc98c0bc466b95ddedf28e5019b4:

  PM / devfreq: rk3399_dmc: Remove unneeded semicolon (2021-02-02 16:17:27 +0900)

----------------------------------------------------------------
Update devfreq for 5.12

Detailed description for this pull request:

1. Code clean-up
- Correct the spelling of comment  in devfreq core
- Replace devfreq->dev.parent with dev in devfreq core
- Remove unneeded simicolon in rk3399_dmc.c

----------------------------------------------------------------
Lukasz Luba (1):
      PM / devfreq: Correct spelling in a comment

Yang Li (1):
      PM / devfreq: rk3399_dmc: Remove unneeded semicolon

pierre Kuo (1):
      PM / devfreq: Replace devfreq->dev.parent as dev in devfreq_add_device

 drivers/devfreq/devfreq.c    | 4 ++--
 drivers/devfreq/governor.h   | 2 +-
 drivers/devfreq/rk3399_dmc.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

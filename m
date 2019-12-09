Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6052116716
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 07:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfLIGvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 01:51:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33746 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfLIGvT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 01:51:19 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191209065115epoutp037d65c71c12a7abce24555f9cab1e77cb~eoU3SXEYP1880218802epoutp03z
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 06:51:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191209065115epoutp037d65c71c12a7abce24555f9cab1e77cb~eoU3SXEYP1880218802epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874275;
        bh=LsaN0pPFmyhAyZW+6JHxwgUFxLvFkNwwC3oQiQya+AE=;
        h=To:Cc:From:Subject:Date:References:From;
        b=RWETZMUDOXnScr9c1n5z09DcsdOekebdfCFuYhAi1ukX2p8OjwaAOF7somIejOakM
         HdGoDc7oktTc4LexREx7IqzAGD0JJDetMPXDY+mn/VpeQnuz8HI/xfH8wsQ1JSJgJ4
         8Q9D0us9H3Z3drjuW8JcAnKl3vxLFA0Tqf2x7tyI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191209065114epcas1p4324743c64ba1e4c979646c6ba9ab40af~eoU2c0Xlj1318713187epcas1p40;
        Mon,  9 Dec 2019 06:51:14 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47WYkR1s4FzMqYm4; Mon,  9 Dec
        2019 06:51:11 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.D6.51241.CDEEDED5; Mon,  9 Dec 2019 15:51:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191209065107epcas1p4eaa96dffa943add96359b15cbd4d3b62~eoUwaGp2O1318713187epcas1p4T;
        Mon,  9 Dec 2019 06:51:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209065107epsmtrp106228911c264ff9a3bd0728c5655ebf7~eoUwZXu7G2247022470epsmtrp1S;
        Mon,  9 Dec 2019 06:51:07 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-ed-5dedeedc7476
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.08.10238.BDEEDED5; Mon,  9 Dec 2019 15:51:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209065107epsmtip24612d5091e2456a0b4f131ca352b9d5e~eoUwN54da0746207462epsmtip28;
        Mon,  9 Dec 2019 06:51:07 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq fixes for v5.5-rc2
Organization: Samsung Electronics
Message-ID: <f2f33725-5a73-0553-ef8a-52b192b80cfb@samsung.com>
Date:   Mon, 9 Dec 2019 15:57:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0gUYRTH+XZmx9Hc+lq7nIxynYrS0nbStVG0EiUWMjHKHqpFBx102Ss7
        q3R5yKK8kaZGSdtFo8Kyh2BbTIXYsLKWbprdKEtLw5TsfjEya8cx8u13zvkfzvl/36EJ9Ukq
        lDZanYLDypsZKohsuhYRFdX9ftigLfEt46qfPiS5J18HlNzdve8CuK7W4xT3peI64p7vOUdx
        d24/UK4J0Lsbyyi951EJqa/0NCL9F/f8DHKLKTFf4HMFh0aw5thyjda8JGbdxqyULF2clo1i
        47mVjMbKW4QkJjUtI2qt0ezfgNEU8uYCfyqDF0Vm+apEh63AKWjybaIziRHsuWZ7vD1a5C1i
        gTUvOsdmSWC12hU6vzDblN/jbkf2N3j7qb4xsggNqspRIA04FnofFynLURCtxs0IRjvGCDn4
        jODd3k8KOfiOoGHfJfSvxVd+n5BYja8guPMjRBZ9QHDDe8xfoOkZeDWUfjRKeQJ3KMDr6QmQ
        GigcCd63TymJQ3A0fN9foZR4Gg6HRyN94wNUeBV0j1aOa0i8EHrrT5ASz8Sbwde0b0IzHXxH
        +8fzBJ4Nz/rrFDKHweXh44S8aBcFLZ8YmVPhZ3UFJXMIDN30BMgcCoMHiyd4F5z3XaekpQGX
        IvB4O5RyIQa8Zw8pJGMEjoCLrcvldDi0/DqB5LlT4f23A0pJAlgFpcVqWbIAunpfKGSeA6dL
        yihZooe6srAqFO6aZMY1yYxrkhnX/7n1iGxEswS7aMkTRNaum/zXbjR+m5Hxzaj9XlobwjRi
        glWahGGDWskXijssbQhogpmhOlM9ZFCrcvkdOwWHLctRYBbENqTzv3U1ETozx+a/dKszi9Wt
        iImJ4WLZOB3LMrNV9EinQY3zeKdgEgS74PjXp6ADQ4vQ9lNpPpNJt2hJfWPxPEPD7iO+qrVz
        iwZ9nt+Zhy9c3PC66XRXUOWrAcpY13Ky5/BARXBz+s3+6drM2MIxsu9JZ2b3rZrsB1sfJ4bU
        lp5JOLK0sxPPiv+4qGpj/dzB5MKv6UHJHxQvsznurLM2cPEBbkprynlz3zbd0FX3vZqrfzat
        f8mQYj7PRhIOkf8Le/I3P7EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO7td29jDfYu17OYeOMKi8X1L89Z
        Lc42vWG3uLxrDpvF594jjBa3G1ewWZw5fYnVgd1j06pONo8tV9tZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSvj/qZjjAVPBSoWPv7H0sD4kreLkZNDQsBE4mTXeWYQW0hgN6PEvu/8EHFJ
        iWkXjwLFOYBsYYnDh4u7GLmASt4ySry/f4EJJC4iYC/R8SETJM4scIlJYtavTywgvWwCWhL7
        X9xgA7GFBfQkvrX2soLY/AKKEld/PGYEsXkF7CTu/OkDq2ERUJF4sGAuWK+oQJjEziWPmSBq
        BCVOznwCFmcWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGAVnIWmZhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4ILc0djJeXxB9iFOBgVOLhrbB5GyvEmlhW
        XJl7iFGCg1lJhHfJxFexQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgt
        gskycXBKNTDyPlv81M1Vo/LHfqFcY9GLpxkaP80+bN8YMtlnaoLnF8nPpz3lLReavn6p+/V1
        XmF8153nSxLTReUVv8yU/WNzle+MT4TmxllFm7VX8gh5sWlVvLvuFqGv80gwWWleoVDmn69T
        tYXF7+b8cn1pa5Ajp9zUssm0p7yrwOb7Vp9T2e++GKS02yixFGckGmoxFxUnAgAAW9AghAIA
        AA==
X-CMS-MailID: 20191209065107epcas1p4eaa96dffa943add96359b15cbd4d3b62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065107epcas1p4eaa96dffa943add96359b15cbd4d3b62
References: <CGME20191209065107epcas1p4eaa96dffa943add96359b15cbd4d3b62@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-fixes pull request for v5.5-rc2. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-fixes-for-5.5-rc2

Regards,
Chanwoo Choi

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.5-rc2

for you to fetch changes up to 27dbc542f651ed09de910f274b32634904103774:

  PM / devfreq: Use PM QoS for sysfs min/max_freq (2019-12-09 12:19:16 +0900)

----------------------------------------------------------------

Update devfreq for 5.5-rc2

Detailed description for this pull request:
1. Update devfreq core
- Add PM QoS support for devfreq device with following QoS type. External user
of devfreq device can request the minimum and maximum frequency according to
their multiple requirements.
: DEV_PM_QOS_MIN_FREQUENCY is used for requesting the minimum device frequency.
: DEV_PM_QOS_MAX_FREQUENCY is used for requesting the maximum device frequency.

- Use PM QoS interface when entering the min/max_freq via sysfs interface.

- Add get_freq_range() helper function in order to get the final min/max
frequency among the multiple requirements of min/max frequency.

- Fix the issue such as fixing the return value and modify code
for more correct exception handling if error happen.

----------------------------------------------------------------

Leonard Crestez (6):
      PM / devfreq: Fix devfreq_notifier_call returning errno
      PM / devfreq: Set scaling_max_freq to max on OPP notifier error
      PM / devfreq: Introduce get_freq_range helper
      PM / devfreq: Don't fail devfreq_dev_release if not in list
      PM / devfreq: Add PM QoS support
      PM / devfreq: Use PM QoS for sysfs min/max_freq

 drivers/devfreq/devfreq.c | 273 ++++++++++++++++++++++++++++++++++------------
 include/linux/devfreq.h   |  14 ++-
 2 files changed, 212 insertions(+), 75 deletions(-)

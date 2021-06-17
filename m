Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF763AAB4A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFQFtF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:49:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20915 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFQFtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:49:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210617054652epoutp0244f68d92699bf39d27a690ec557f2552~JSHYUMQTA0839108391epoutp029
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 05:46:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210617054652epoutp0244f68d92699bf39d27a690ec557f2552~JSHYUMQTA0839108391epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623908812;
        bh=k7gyyYAl+1qd+FAUHUEYyQ6Ote75iT+2kNVCTZL61/U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NB5dedky2uQG8SoZ/lMwt+g7O4J9zPqr4CInMPh9r7R9NZ/Y59MOntf54/3hbPgXA
         KHJJ16baKmGEeMGXfaT9qquRl5ae3rXYTkxqMv7R6/m8t2BAnEhOG9CfZ8bYxMRPlm
         hlMuJKmJBOwwVo2mbVoRwDenpDPCRMnE50Wwq8Tg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210617054652epcas1p2446601adfd1b71e6d522b3b81d767c9e~JSHXyW0CL1754417544epcas1p25;
        Thu, 17 Jun 2021 05:46:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G59zX1lt6z4x9Pp; Thu, 17 Jun
        2021 05:46:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.3F.09578.8C1EAC06; Thu, 17 Jun 2021 14:46:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epcas1p3f1ef3ddef736496151ff77df4f50749a~JSHTbOV9Z1876818768epcas1p3a;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617054647epsmtrp274a56050c555210f9f1164d5a17ea03e~JSHTaUACH2416924169epsmtrp20;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-27-60cae1c8e080
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.96.08163.7C1EAC06; Thu, 17 Jun 2021 14:46:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epsmtip1b7f3ae65dbf0132cb3c67b0b2f707996~JSHTKiB8m1031410314epsmtip1Z;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org
Cc:     sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org, cwchoi00@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PM / devfreq: Add cpu based scaling support to passive
 governor
Date:   Thu, 17 Jun 2021 15:05:42 +0900
Message-Id: <20210617060546.26933-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmru6Jh6cSDFq+sltsX/+C1WLijSss
        Fte/PGe1eHZU22JC63Zmi7NNb9gtLu+aw2bxufcIo8XtxhVsFl2H/rJZXFv4ntWB22N2w0UW
        j8t9vUweO2fdZfdYsKnUY9OqTjaPlpP7WTz6tqxi9Pi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoTiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsa7KeEFC/gqfv3tZWtgvMrd
        xcjJISFgIvFh2g7mLkYuDiGBHYwSbSc7mUESQgKfGCU+LhaFSHxmlPjZ1csI03H63jU2iMQu
        RomJd58zQThfGCWO/FjHAlLFJqAlsf/FDTYQW0TAVGLP4YksIEXMAvcYJR4tPw+WEBYIk3ja
        8Z8JxGYRUJV4/fg12G5eASuJWRMPsEOsk5dYveEA2IESAo/YJa7sfs0EkXCR6L+ykxXCFpZ4
        dXwLVIOUxOd3e9kg7GqJlSePsEE0dzBKbNl/AarBWGL/0slAgziATtKUWL9LHyKsKLHz91yw
        P5kF+CTefe1hBSmREOCV6GgTgihRlrj84C7UCZISi9s7oVZ5SNxYvpQJEnaxEi8ffWSZwCg7
        C2HBAkbGVYxiqQXFuempxYYFhsixtIkRnPa0THcwTnz7Qe8QIxMH4yFGCQ5mJRFe3eITCUK8
        KYmVValF+fFFpTmpxYcYTYEBNpFZSjQ5H5h480riDU2NjI2NLUwMzUwNDZXEeXeyHUoQEkhP
        LEnNTk0tSC2C6WPi4JRqYLIRrShvWmnGM/2lxERmRSsOBVPrhr/svqqVfN0RDrOXlrPf/bOg
        2LuOw+qw5t2l/4+9YNh4+qyT0on/95+9d/3s3+HzSPTHFNczFR/UJmQ6SV/0bc9f3D5NqKLp
        Vz93lRzf0q/VrGduTTjkq64j8IpZ/SVD1Kx82fIT0ZNPPNEX8TK4Y/8y+j9jiDHL8Ycy554t
        2tW3aMWZhJrvxzjUXwcwvA+feEZZcUrkHNF4piquzg5H7hzOTn/eA7+s4oQPWr2ZufOmeOXC
        GYnvEoorfZM1plzLWz2t5/UNXa0Hld3PPu6paUuoiThvbsO69uKKI2KSxp+dGVpY+xzb92nm
        7FLZdaGh6O7pSxX9c0wjlViKMxINtZiLihMBSRYViQQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnO7xh6cSDC7uELDYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPasDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxrsp
        4QUL+Cp+/e1la2C8yt3FyMkhIWAicfreNbYuRi4OIYEdjBJnl69hhkhISky7eBTI5gCyhSUO
        Hy6GqPnEKLHt9jMmkBo2AS2J/S9usIHUiAiYSxy/Eg1SwyzwilHi3tnHrCA1wgIhEocvzwer
        ZxFQlXj9+DXYfF4BK4lZEw+wQ+ySl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OL
        S/PS9ZLzczcxgoNQS2sH455VH/QOMTJxMB5ilOBgVhLh1S0+kSDEm5JYWZValB9fVJqTWnyI
        UZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD02TPnpJrUz8vD5+5PLI9Vl/EyO7qYon2
        +48yeBZXPX8ulr/55KmFfs9YgrjOVof9qfgnEHXoaqRQhLFX0Mk5nD/E6rqumn48Ub0sLKC4
        49EkVb+FxxmZypUZrCUFPeekKWmLRMnLmchp1eyXbp7PJyuXvy16YmfSNPuZoZw9fxw8In5F
        pXaZTD7y/2O/9LuNUyb57Jkz+bbg+usPVxyI3RK07f3P/eYfPM6cPSGs9yo4YccPvikO+fKi
        nhUymxcsOcP32vHxIZc9zw9x28z0yJ3t0PlxvadLXeD2ew8yH878P+vZjbzMynX1WV/lWiab
        /7m2iyWaU1E57fHNo1fMZ04qm9i6N//Ub42DT6e4pCqxFGckGmoxFxUnAgCm2jZlsQIAAA==
X-CMS-MailID: 20210617054647epcas1p3f1ef3ddef736496151ff77df4f50749a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617054647epcas1p3f1ef3ddef736496151ff77df4f50749a
References: <CGME20210617054647epcas1p3f1ef3ddef736496151ff77df4f50749a@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq passive governor has already supported the devfreq parent device
for coupling the frequency change if some hardware have the constraints
such as power sharing and so on.

Add cpu based scaling support to passive governor with required-opp property.
It uses the cpufreq notifier to catch the frequency change timing of cpufreq
and get the next frequency according to new cpu frequency by using required-opp
property. It is based on patch[1] and then just code clean-up by myself.

Make the common code for both passive_devfreq and passive_cpufreq
parent type to remove the duplicate code.

The patch[2] is required for this patchset to use required-opp property.

[1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
- https://lore.kernel.org/patchwork/patch/1101049/
[2] opp: Allow required-opps to be used for non genpd use cases
- https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=5736929761d187499bdf8e2019090e3ed43d3d7b


Dear Andrew-sh.Cheng and Hsin-Yi Wang,
Please test your patches based on this patchset and then reply the test result
with your Tested-by tag or reviewed-by tag. Thanks for your work.

Chanwoo Choi (3):
  PM / devfreq: passive: Fix get_target_freq when not using required-opp
  PM / devfreq: Export devfreq_get_freq_ragne symbol within devfreq
  PM / devfreq: passive: Reduce duplicate code when passive_devfreq case

Saravana Kannan (1):
  PM / devfreq: Add cpu based scaling support to passive governor

 drivers/devfreq/devfreq.c          |  17 +-
 drivers/devfreq/governor.h         |  24 +++
 drivers/devfreq/governor_passive.c | 325 +++++++++++++++++++++++------
 include/linux/devfreq.h            |  16 +-
 4 files changed, 310 insertions(+), 72 deletions(-)

-- 
2.17.1


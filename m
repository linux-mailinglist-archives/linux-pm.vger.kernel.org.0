Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5D2197FE
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGIFdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 01:33:47 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21832 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGIFdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 01:33:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200709053343epoutp045dde00574d6c568a9c051c1fa06c1b49~f-q_8hlSN1190911909epoutp04p
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 05:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200709053343epoutp045dde00574d6c568a9c051c1fa06c1b49~f-q_8hlSN1190911909epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594272823;
        bh=sfkpQ9HHY0HvMIk919py9z+6K8m7VZ3LXraenZFelz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNc4WtO7vhk6MsGHnPgiDzN4wM9kSMSz8Ss2j09SdS4eN2uIa4Cj+pvcPUzApSQGd
         gyNpQDD9RaWU4lqj1IrwF+Jk3DfF1TCDWSPYPCvGR3+fVPeaF7JUK7UsYT8kUo1Y/f
         EvLmLpbT47EEU9EVM5n2JqhIEWTba+wb9YOZDyho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200709053343epcas1p3e21a6a9cc827ab154ec5c4eb42a85cea~f-q_Xabdh0095300953epcas1p35;
        Thu,  9 Jul 2020 05:33:43 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B2Pwh3jdyzMqYm2; Thu,  9 Jul
        2020 05:33:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.CC.28581.43CA60F5; Thu,  9 Jul 2020 14:33:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200709053340epcas1p3bc307da98530bc166c7d354a62e4c894~f-q7aHAjo0095300953epcas1p3t;
        Thu,  9 Jul 2020 05:33:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200709053340epsmtrp1095143372c99b801f9a4c354a683ea5d~f-q7ZR-ss2587325873epsmtrp1P;
        Thu,  9 Jul 2020 05:33:40 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-7c-5f06ac349ad5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.F6.08303.33CA60F5; Thu,  9 Jul 2020 14:33:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200709053339epsmtip14829e8e1b42e3ef1aac96617c44eec41~f-q7J4Hex1123511235epsmtip1S;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Use delayed timer
 as default
Date:   Thu,  9 Jul 2020 14:45:04 +0900
Message-Id: <20200709054504.656-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709054504.656-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTV9dkDVu8wcafYhYbZ6xntZh44wqL
        xfUvz1ktFnyawWrR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaL
        240r2CwOv2lntfh24hGjA7/HmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfAFpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PGu1tM
        BZ/ZK94e+8XSwPiMrYuRk0NCwETiw94f7CC2kMAORom7v3m6GLmA7E+MElubvzNBOJ8ZJV70
        vIHr+PL5BjNEYhejxKJTz1ggnC+MEkvnHQarYhPQktj/4gaYLSIQKjH73lSwDmaBXUwSX6bN
        ZAZJCAuES3x8/IsJxGYRUJXY/XE+C4jNK2Ah8Xv/MVaIdfISqzccAKvnFLCU2HJjGivIIAmB
        Tg6Jpi/LGSGKXCT+X+qFahCWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F6AajCX2L50M
        dAUH0HmaEut36UOEFSV2/p4LNp9ZgE/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO6FB
        5CHRsvQxNFR6GCXWrz3BNIFRbhbChgWMjKsYxVILinPTU4sNC0yQ42wTIzhRalnsYJz79oPe
        IUYmDsZDjBIczEoivAaKrPFCvCmJlVWpRfnxRaU5qcWHGE2BoTeRWUo0OR+YqvNK4g1NjYyN
        jS1MDM1MDQ2VxHk/LWCLFxJITyxJzU5NLUgtgulj4uCUamBSMHu3YW6jLZPMu5hlwSUf378X
        YugKPL64/EOa5wHtby5/z2jK9JafLoxeduJCMYfx73aLWz+PynpL6pxc0XCt5fijo9xt7x+d
        TbjFVzr1/MoJn+yq2Lpmvo7XrHqq/XTNVFuZreq3V0vLyPY+qEu615iq+/uXofHhjpY0D4NJ
        ixx3pbwykHhj0pX8VyzeekV2jWNvOPN+BeZ+3cJFZhnBatLbD4jrb7l22mOV6+vNE4+12IT5
        GCX5NQgze12ROR65I/YDb22H8bbuW7kmcut3cgrXz34Zb/jzqPQvlo1aUbOnf9Y0uGbyIjHn
        PIuL+uQ292JRc9+6xjfv7H9vW/HiicFjy8chWS5SRSIzVymxFGckGmoxFxUnAgDtiiseHQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnK7xGrZ4gxdPrC02zljPajHxxhUW
        i+tfnrNaLPg0g9Wi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewW
        txtXsFkcftPOavHtxCNGB36PNfPWMHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6ALYrLJiU1
        J7MstUjfLoEr48a7W0wFn9kr3h77xdLA+Iyti5GTQ0LAROLL5xvMXYxcHEICOxglVs34yAiR
        kJSYdvEoUIIDyBaWOHy4GKLmE1DN/dWsIDVsAloS+1/cABskIhApcb7hKBtIEbPAMSaJ5W/b
        WUASwgKhEmcOzgazWQRUJXZ/nA9m8wpYSPzef4wVYpm8xOoNB5hBbE4BS4ktN6aBxYWAatZP
        W8w6gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4HDW0trBuGfVB71DjEwc
        jIcYJTiYlUR4DRRZ44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgm
        y8TBKdXApHVe2pCv6VhN76nO491mv65Fdb/k45i49l6J7ZSOZ/Nbrv+7phkid2cfu8SSSzIS
        clssJ9TrdCZxz+pUXuIWwn5qmtLZh6GPn84P45p8kCOMM+Snyu2ij7eU7z0IXXuaKSsgrGXi
        esfSso63OfU9mzTn/D9h6fB8AXOH9qT2H3J71lmcfRK+UUDhw90Ge99X4ta3l/xaN+OR4pWN
        Qb1bz3z42dSns6JK1f5t2EHeZoM7hre9Zs2P6vFbluF4reMH73pV/Q1bA2aEldf7yL5X3Ppp
        ikGR4u741MOt/BMa9JhsPew7uR7kH4z+97ql51ud/CpelQPua7e2q9+dEepp9GbBi3Md3jl3
        NpQErgjvUmIpzkg01GIuKk4EAA+ZIdnWAgAA
X-CMS-MailID: 20200709053340epcas1p3bc307da98530bc166c7d354a62e4c894
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709053340epcas1p3bc307da98530bc166c7d354a62e4c894
References: <20200709054504.656-1-cw00.choi@samsung.com>
        <CGME20200709053340epcas1p3bc307da98530bc166c7d354a62e4c894@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use delayed timer as default instead of deferrable timer
in order to monitor the DMC status regardless of CPU idle.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 25196d6268e2..93e9c2429c0d 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -945,6 +945,7 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
  * It provides to the devfreq framework needed functions and polling period.
  */
 static struct devfreq_dev_profile exynos5_dmc_df_profile = {
+	.timer = DEVFREQ_TIMER_DELAYED,
 	.target = exynos5_dmc_target,
 	.get_dev_status = exynos5_dmc_get_status,
 	.get_cur_freq = exynos5_dmc_get_cur_freq,
-- 
2.17.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1066FCB0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfGVJrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52305 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfGVJrd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094732euoutp014c58827d1e725d47bfd77d661dbed98b~zsa0BOjSx1472414724euoutp01l
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190722094732euoutp014c58827d1e725d47bfd77d661dbed98b~zsa0BOjSx1472414724euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788852;
        bh=3WP8EDAu+5H7APsQt9nFgGZ+xA43IHtfClvOa7dqrls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbIw7BeGVTHVQcU+vdFARKogBq43MANaMRD5fjs7bL0Sqsa4gOQrGGikcS6QNQAe3
         O1I8GwENALWJaaxwvm8/kG2kSIYXaSIrCQBeE4Wr60Mh9auGZgQe7Al9ebb1nb6afH
         sVmcxHklBvirQSWNXLaEj4ns9DrWMuqHFXly9A1E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722094731eucas1p16d813ca2307bc7f16074daf17d00a174~zsay_OP4B3210732107eucas1p1K;
        Mon, 22 Jul 2019 09:47:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.85.04298.236853D5; Mon, 22
        Jul 2019 10:47:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b~zsayLJyb52048020480eucas1p2W;
        Mon, 22 Jul 2019 09:47:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722094730eusmtrp2c8ea01538982730512d30f27ef0b3479~zsax81-ZE2448224482eusmtrp2t;
        Mon, 22 Jul 2019 09:47:30 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-b2-5d35863296dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 83.E1.04146.136853D5; Mon, 22
        Jul 2019 10:47:29 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094728eusmtip20519d633df222b31eec8054937e1b051~zsaw7lwWP1005410054eusmtip2M;
        Mon, 22 Jul 2019 09:47:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 6/9] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Mon, 22 Jul 2019 11:46:43 +0200
Message-Id: <20190722094646.13342-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUwTQRTGne7RpaFmLUaeiJo0EZVILQpxokbxSlajiQZjIgS1yApGWrAr
        eMciARU5FA9QQPAK0KIcIgJRQajUVAQBI1rjAY2AiAdnPOJB7ar/ffO93/vem8kwhOIz5cFs
        1+3i9TpNpJKWkRUNX5t95iT6h6h7Lvnh0sxiCrcPdVM419xEYVO/HeH4y8U0PmXNkeDG41qc
        Zn9P4ObmEil+dLhPim0GT9yf/IrCbdXZNB5MMSOc2XxXgq+ZX0rx1fYWCW6xrsAv4gponHDH
        LMX1fUco/PNpKYlrnqzCL76PxSMPOlHARK7oQhHiRobTSe7TswQpl2VoIbmq8y+lXJnxGM3V
        5BRJuZT4jzR37+NtCZdabkTcjYf7ucGyKWtdg2QLw/jI7bG8fvaiLbII6/1hIrqR3vMkbxgZ
        UDmVhFwYYP3g21srnYRkjIItQGD79kY8DCF4fatT4jwMIrhljUd/W7q+2EUqH8H3OhPxr6Uw
        vWq0wjA0q4JK405Hw3g2E0FWT6CDIdgOAlKvZf9JcmMDwWRMRQ6eZKfBkYFDDlvOLoa03hRx
        v6lgKqklHIgLGwDvLFpHDLA5DPTY80RmObS1ZpNO7Qa9lnKpU3vCr6pciVMLYEi5KF7gANjT
        ckRmAdRbWihHPsHOhOLq2U57CZhPt//ZDNix8OzDOIdNjMr0igzCacvhaKLCSc+A8uTH4qAJ
        kF90Vgzn4LXlhPhSpxCYLp8jT6Cp5/8Py0PIiNz5GEEbzgu+On63StBohRhduGprlLYMjf7D
        hz8tA5VouDW0DrEMUrrK1RV+IQpKEyvs1dYhYAjleLlO7R+ikIdp9u7j9VGb9TGRvFCHJjGk
        0l2+f8ybYAUbrtnF7+D5aF7/typhXDwMyHXf1YNhXhkd1yds/WRTxy1b2t46I/dcL/E1M9+t
        xofYlL558J0Q3HSyZP3RK8+7b9623euYW7puo2yNduWKcK+mpp0XsW/tj5hS718TV086syp0
        myp/A+CoUH93m3m+l6q2Zpmf1+5D04M6SxqWFE4O6mps7R7wma6W99v67LMa5n1QkkKExteb
        0Aua35w01MyDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7qGbaaxBhPfW1lsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GWcOvqVueAMW8WVBV8ZGxi3sHYxcnJICJhIPPvxmK2LkYtDSGAp
        o8S11UegEmISk/ZtZ4ewhSX+XOuCKvrEKNH78BxQgoODTUBPYseqQpC4iMAcRomfXdsYQRxm
        gd/MEgfv9oN1CwsESrz6sIcVpIFFQFWi/VM9SJhXwF6i/1Uv1DJ5idUbDjCDlHAKOEi8PJ4L
        EhYCKtn/YjvjBEa+BYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjdNuxn5t3MF7aGHyI
        UYCDUYmH12CbSawQa2JZcWXuIUYJDmYlEd48A9NYId6UxMqq1KL8+KLSnNTiQ4ymQCdNZJYS
        Tc4HJo+8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MuW4v+d69
        +6bjZiD3w47rbdBLkdQ5H++vPxol9fBjQ+W00/xLbMpevmDNeLAzY1FT4tIAYy+2qAeedw/e
        YNp7bpvu+huyRTtmKeof01nq77To/lvX+GJea9VFVj81svY0R7pP0mJYHnHsOG8eoz+HnbZE
        11KftTOVbruaet9WXDYt6mhk6+PrSizFGYmGWsxFxYkAml/daOYCAAA=
X-CMS-MailID: 20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the chipid label which allows to use it in phandle from other device.
Use syscon in compatible to get the regmap of the device register set.
The chipid is used in DMC during initialization to compare compatibility.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 67f9b4504a42..4801ca759feb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,8 +35,8 @@
 		#size-cells = <1>;
 		ranges;
 
-		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+		chipid: chipid@10000000 {
+			compatible = "samsung,exynos4210-chipid", "syscon";
 			reg = <0x10000000 0x100>;
 		};
 
-- 
2.17.1


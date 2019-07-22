Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677886FC8D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfGVJr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42147 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfGVJr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094726euoutp02f4d1b999c9f45a081367c5fb7623d8a4~zsavE6w3Z2848028480euoutp02y
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094726euoutp02f4d1b999c9f45a081367c5fb7623d8a4~zsavE6w3Z2848028480euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788846;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6D0/NuSBh3mKOC3yPgK/9jq0tzH30/pV6EVFQdv7L3T/Eek2HKmQeBc1nOFGeEBv
         OmM9yCWc27fQqyj7vh396Xfh/nLzPfZ+twXFeUXYo9PSH+NXeY4+SVPXJ1I+I2HLny
         wRrp16vatPVHp0Kf1FSzIto/ZFvGMBRhp8Gr/TWw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722094725eucas1p186b764e83be784d329656218de0849c9~zsauKTJmJ1254012540eucas1p1B;
        Mon, 22 Jul 2019 09:47:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EB.16.04377.D26853D5; Mon, 22
        Jul 2019 10:47:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722094725eucas1p1c91c43892ef73011bdf554574a1637e0~zsatU6Doj3210732107eucas1p1D;
        Mon, 22 Jul 2019 09:47:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722094724eusmtrp2dbf19f78aa78dc4e230dc72dbc70f819~zsatGQ6sV2448224482eusmtrp2e;
        Mon, 22 Jul 2019 09:47:24 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-e7-5d35862dc640
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.D1.04146.C26853D5; Mon, 22
        Jul 2019 10:47:24 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094723eusmtip23397592c4cf17d60608cc89aabd47583~zsasJ2unr0863108631eusmtip2O;
        Mon, 22 Jul 2019 09:47:23 +0000 (GMT)
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
Subject: [PATCH v12 1/9] dt-bindings: ddr: rename lpddr2 directory
Date:   Mon, 22 Jul 2019 11:46:38 +0200
Message-Id: <20190722094646.13342-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUiTYRzv2XtqTZ6m1JNFxlKoIDXJeqDLougtCAK/FbKWvtjhVu7VrgUt
        zTKbXVaKpuvAozmZ2jK1w5wyK481yrLDLikzbblcWhhWb++qb7//7/zyZwnFIBXMbtWm8Dqt
        OklJ+5M1ju8dc+cejo6LzE8Lw1V5Vgo/8fZS2NTcQeFyTw/A6ZetNM65XyjDbcc0+ERPP4Gd
        zkoGt6cNMPiZYRr2GF9S+GH9eRoPZTcDnOe8LcMVzd0MLn7ikmHX/VX4+cEyGmfcamZw08AR
        Co89riJxw6O1+PloAB6++xbETOEsRRbADX89TXKfuzIYrsDgIrm6/G6GqzYfpbmGQgvDZae7
        aa7RfVPGHbeZAXe1Vc8NVU9fP2GD/+IEPmnrLl4XsXST/xZzo5nYeUi+x1J6jTCAW+OzgB+L
        4HzUecVKZQF/VgHLALp75yQtHV6Aajtf+Y4hgEb6Koi/kbb2NEISSgFqMJ6h/kUslwaZLMCy
        NAxHteZkMRAE8wAq+BAregj4hkDHK84DUQiEK5C74i0tYhKGIbvjFCNiOVyGcgdHZNJaCCqv
        vEOInX4wBvW1aMQeBItZ5C25yEielcjzZZiWcCD62GLz8dPQzzqTr0dAhuyLQML7Uc+JQp9n
        EWpqcVFiPwFnI2t9hEQvR2MDGTKRRjAAdX2aKNLEb3i6JpeQaDnKPKyQ3LOQzfjANzQJlVrO
        +co5VOzO/DOqgDkAtbaBkyAk///WBQDMYDKfKmgSeSFKy+8OF9QaIVWbGB6/Q1MNfv9h61iL
        txbU/9hsB5AFygnyyJr5cQpKvUvYq7EDxBLKILk2MjpOIU9Q793H63aodKlJvGAHU1lSOVmu
        H/d6owImqlP47Ty/k9f9VWWsX7ABWOztL6ICy1Wru9Jmp+tDXw3O9MZ2H+sfUlGjZLFjifXd
        U234GdPLGcZ41nkjV++d960o+sL+fZmqHpveszAoNfRNXXLTmgOa9yD4FEwwJYTeM24LHZ9J
        Oo9et8s/rXMvOAu9MZW9yt57e3LOOlTx/SklfSMNMR5be5UrxDG6RkkKW9Tz5hA6Qf0LTyU6
        J4MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7o6baaxBge+6llsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GWsOriKuaCFt2LN8q3MDYx7ubsYOTkkBEwkzpxtYu5i5OIQEljK
        KLHn+lkWiISYxKR929khbGGJP9e62CCKPjFKHHhxgbGLkYODTUBPYseqQpC4iMAcRomfXdsY
        QRxmgd/MEgfv9oN1Cws4Sbxb+4gNxGYRUJU4dGwiWJxXwF5i+ofvTBAb5CVWbzjADDKUU8BB
        4uXxXJCwEFDJ/hfbGScw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGKPbjv3cvIPx
        0sbgQ4wCHIxKPLwG20xihVgTy4orcw8xSnAwK4nw5hmYxgrxpiRWVqUW5ccXleakFh9iNAW6
        aSKzlGhyPjB95JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYHSJ
        erlS9e192bbpOQ8aFZdPca/q+HlK/dqqq3tjRK/u+xd+OcxZf3qI7Pu6Ix9EJ2pWHotN/fKF
        d6JlaWX6zBWmma/kFBim7f4Qa/uzt/RnE3+dYNM9tgXu5QdCIvfMO3srxj7AOFx8qbPM4eRr
        y68tyE3Tr911QE3R2NV6bekW6w8P9pt91VFiKc5INNRiLipOBAAi8AuD5wIAAA==
X-CMS-MailID: 20190722094725eucas1p1c91c43892ef73011bdf554574a1637e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094725eucas1p1c91c43892ef73011bdf554574a1637e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094725eucas1p1c91c43892ef73011bdf554574a1637e0
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094725eucas1p1c91c43892ef73011bdf554574a1637e0@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change directory name to be ready for new types of memories.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt      | 0
 Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)

diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
similarity index 100%
rename from Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
rename to Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt b/Documentation/devicetree/bindings/ddr/lpddr2.txt
similarity index 96%
rename from Documentation/devicetree/bindings/lpddr2/lpddr2.txt
rename to Documentation/devicetree/bindings/ddr/lpddr2.txt
index 58354a075e13..ddd40121e6f6 100644
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
+++ b/Documentation/devicetree/bindings/ddr/lpddr2.txt
@@ -36,7 +36,7 @@ Child nodes:
   "lpddr2-timings" provides AC timing parameters of the device for
   a given speed-bin. The user may provide the timings for as many
   speed-bins as is required. Please see Documentation/devicetree/
-  bindings/lpddr2/lpddr2-timings.txt for more information on "lpddr2-timings"
+  bindings/ddr/lpddr2-timings.txt for more information on "lpddr2-timings"
 
 Example:
 
-- 
2.17.1


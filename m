Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246371628FA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 15:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBRO67 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 09:58:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:60305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRO67 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 09:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582037931;
        bh=AKEe5GkAENzAllhW9wit/K+ItMrJsGooEPHh3QAMS0k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ed7nv27MmOhrCRb0jwaNMfXunQDoloW4nb5x+FCQnrh07A48s4qz6N5ATdIDn0LCz
         X8K4vzni2aHWEiFxXjmXVqj4EV5d+56JH9ZL9wulut8zPyb4EREeGguEPRTI0FK0va
         68zNHNYqpE1ufNSib185SEpXDSZyGryWmT7r1GKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1jJFjf1fXk-00t96u; Tue, 18
 Feb 2020 15:58:51 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: power: Drop reference to interface.rst
Date:   Tue, 18 Feb 2020 15:58:18 +0100
Message-Id: <20200218145819.17314-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:um4vvbYIrZ3DzIDgpFy8U3EJcAeplKNx0PjRgZ9T90zJsCXrjwv
 myE4G3+RGIwO04LcuGoQvgZFjRfuqJxGgNYFsagp10+E6uZ+vHDgDw+hr3xlVuRwQFSOVjO
 Ta8Gxyngnf9ahBfWSliHXW9HrtD9ztaaWDkhgr4ChpDHFUUnoq0FNtunIRJNjoBuHpDE+Er
 rfgJ4hDefe4vcIjTxG2Jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i/NGwyUvS8o=:nhloy+zYvjuZO518bPkL94
 85pfXbdDHw4O7z+AGvux7vtbr8Re614aoznpLTV4dnYt50XwShIOnjlc/W8I6hb/XtmVhDgB/
 X13Rt/hEPCCashEbOvEbTLhURIqyfeOdh+nBYOPDHEWlwN0SOMb035z77mo+TkcK3p6QMGhwp
 mzr2PFuGcMCIy4sUSwdoqM6rDuSgVAB7r4UQ9ilR8Ar4ZrRYg+ylsMMiaifvvGLKYsAQkQ4x9
 E2+tZ+f3SfGqYTsIWRAwSLoF4ALxS/3i//2SVRWdTSxO86R5xcffsndsB88QxCSq8G1ibj9w9
 6lPtQ8HOkoaKWoNLVssn0XsN0hCLyKa1FWRRh7n3tt6IwpcLpPXk6pANi9xWkcyKq/9RleuNi
 htQNHKefgfR7gKeo4V+hzW8njcEMc8EYM+agEKge1UqwSeO6/B4e4aUD9ZsZCFs8iac01jEHu
 NZ3tG3Qhl/Fucj9jStu8/Y1me3G1sXXbsSLDVaki4r5mmh6IUBVFCPrRJltEEQ8/iST9Q8fC3
 vsjAAGovEGInY3G2SvE+9kbb3rOPoZdgamlGaPX1Xj/BbLhzSXUwNcBIZHM3pSXRw+y7EyTc7
 7vdPSo94Q16fIBmh57Vbuur8XsI+HPyy73GTS+14Qx67h1/FtDV/fAUExFo6TkemIxbJ1X1Gz
 XIHbSPkIBD08hh0LkOTu1BllJ44XbtvlX/vxCbnks2TyJ/D3j9rikvwEPO2Fg6qacdCGXV6he
 2ytBBq1abPGtOR+fh/Ui1iylHF4L+jSvBW7GfqRVJI14G0+nVKEmYs0/JNNzZhWFPeYufDIO2
 H7/ycGCd/jWElNpYO3E0PL81D27hqFnIwjjaBXLHhTbA9BznILiST3s/bnZrsfnZ5q3lvditN
 b/4NpL9WHBqUJGOQXelsN1eU/3fGP4X92QuxgdLCuKH5KLtTPB548NNYNGFGw9hEVw7D1/LOL
 NGzQJedjLnri0nom6aM1oO/XnqIEt98Wv8oEJwLCelmIZ0atdpZvcWdTHePfC73GsacNlt+AL
 4VL8bi291grKWEB043ZztXe4cTwe/W7L3O96gScMO9+byF+fpHJ03gHs5V7dCbv9bin+L0isn
 4/L3P5Ev5es7oRza6ABs5hYVGtGKaE8XVxTkOUhwjUX/S8q8eWKoRu90qqNoX5DwCalA5LdNh
 vZj473yErNNYdPwrT95x7MbaV7KSxzg5aflRrQPPe7r60Nd7pHndhh2wIFHUz3ONQeOO5tEiX
 oQwkSP2af4/gBCPjf
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It has been merged into sleep-states.rst.

Fixes: c21502efdaed ("Documentation: admin-guide: PM: Update sleep states =
documentation")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/power/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index 002e42745263..ced8a8007434 100644
=2D-- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -13,7 +13,6 @@ Power Management
     drivers-testing
     energy-model
     freezing-of-tasks
-    interface
     opp
     pci
     pm_qos_interface
=2D-
2.20.1


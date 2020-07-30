Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370D2337FF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgG3RxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 13:53:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:37489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3RxC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 13:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596131562;
        bh=ziofVbDPyMepDQRodxoTHDhSQkTSPPyJObV8bPWtPoc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VzisHPZ8rHX/27/tdJTZGe0Knw1gxZZFH+Gs0xSVfHCITUTMuiLdvXehjs7KId8L0
         XtAl1C6XNpM8xMtaISjmWjLRk+SNZu9yt5tBsjbfLCR38V39diIBj+/V7FC8tuPMRr
         iSfF5SsVGE15kqZp6BV6ZJGpUKMjhuXFt/Damflg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.153.170] ([217.61.153.170]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Thu, 30 Jul 2020
 19:52:41 +0200
MIME-Version: 1.0
Message-ID: <trinity-7671b933-7c8b-4967-9785-1994ffbd090d-1596131561877@3c-app-gmx-bs42>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Steven Liu <steven.liu@mediatek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kao <michael.kao@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v2 1/2] thermal: mediatek: prepare to add support
 for other platforms
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 30 Jul 2020 19:52:41 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <94d81c8a-2710-98a1-4cae-040e9b51fcd9@gmail.com>
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
 <1588238074-19338-2-git-send-email-henry.yen@mediatek.com>
 <94d81c8a-2710-98a1-4cae-040e9b51fcd9@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:B0nL+ATtvwAyy4RCra60ZlFLZfK70cMRXJYEps3ztLnlxLK3gcn9MyGnUiOpxnF0vzZwJ
 GYOw1yAEZFHaxM8v146laW3/ZOLx6LyJbSNMXzBB/F7QHiSGR5l5WzsKXrrwFDGfFpSEv/njZpgk
 ZASUvk/u6PkzmEZ3dRcEMvVIOMbUank8trxUvH8mz8xUCw29719kul5IrnlutqBTdFYzrzU+ojxW
 ro8wjUCNgp7MiYpepnm6CaiOm8Rmlls8c9MzSRkQtMDeSTziFYXLK/WnyT22ne1apfgl5gOsiGl8
 hI=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AY1TYB4J/HM=:JN0ihmh5O4YRngTK21lUrk
 fGON3AijZ8jsJdOR4HawKEyV367AecVtwwIZvoLxiS+yQf7k9dFFc/toW1+K/MiXtQS/zO5B3
 b2tY/vWuyhRoQoi29HwBmIduDLcTtq/VuONNCpO4+l53R2XaSH6pzK3nns4xzcYK45yheK6ik
 8zI1uB9KyJHjX56OxOScoc+GiKW3yjPyc9L14xeVFGrtxnIzxrs5NRB2645Ck3nQU/kQRSmNd
 RTNpWxEDkyMRPINJfQDvLCZ0lqtSPF4bXfL62yb/TDcLCOt6Ns6ufHAsuQ+P8wsL0HMVmsO90
 6Ssv6sxjs2t82o5fQ9subWfJRnXdRyZQe3dBiFvYG2lx6ccdTTT4ED50vldcGct91msKIW70p
 1Rb12/gMAp7HCanAxQQcduuhv8jmwIJW+cBdTxOiXIN+jaLTAFu9ZF8hVLv9CDT1elWZst/7I
 XXnwyTVJ0gUgV5FKdd7n86MLaFcYnivPUewUdSwm90jrg28I1l7ApDt9RBbI38/sgSFALbKvW
 dxtytUJ8kHbbQnZQ9dC8WSmIWv25265LDG3A+2z8lQgda3B3WxcGQt4x3EJEYzxgSb1hvufeG
 Ec6X8XVlOUUF5ZkKsLryPmFT/vb4loOGUhvogdEwrRuiiEm01Y+8V8mi+GCpamusMdgfduGaU
 PTBDVL1a0BEg8Je2AZFwaFXB83TATE79v3wiijcxmAEsWJhZ6/mI5g3NGo57z2gMo5Cw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested on bpi-r64 and r2, i hope this can be merged to next / 5.9

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank

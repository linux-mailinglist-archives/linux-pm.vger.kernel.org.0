Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4C310E3
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaPKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:10:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaPKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 11:10:06 -0400
Received: from orion.localdomain ([77.7.63.28]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZkxd-1h3HwP1gaV-00WlMu; Fri, 31 May 2019 17:09:10 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: clean some unneeded #ifdef MODULE
Date:   Fri, 31 May 2019 17:09:01 +0200
Message-Id: <1559315344-10384-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:PrS//R/BJWbSCiEFeyNXflSE6uQtBtKrpHigy2MFykA7Fp+zNo3
 7XrHrtMx38tuo5kYPHGcelicWyYAAWToMO+L8sI8UiUEk+D3CrxvZhAgH1QjaWmEXGlfLy/
 7Yt/wrGlKG0Sc3XToaE+UPAhqFV6iwRe+tRWZmjFyQJxo73VextLvoxa2lP/ItlAq9TVd8r
 gpruHdRRfy3w8KTu26AaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oJnEBJlP45s=:MJrLj4/4u/r7O5pAS0zSqq
 xLqf1yfhcB4u0OP7KGbtCcjZ7Vl5vLiRfQp6xjMmgJ4Ob53afyKw5Y+vEDpErNKahjsf8IseG
 DBhJTLPq5nPJt3GSUKvVrNwQOWzn7H3DbhKdZFB8mKcjkdQ6dqIXsNl8LvHT2ODHDwRNvswig
 ARAVfcRlGpuk3rYUtiAt3QbxFNtv1cD46ze5VqyCb4IxPwAD/volq5Lf5Np/sNFEsO5s5LTqB
 CLNyKTBGfaz1LMecQ965jZOSSpbypkWMRx9+TPjcVMy/FDOsI4htnZaU5S0X13tFs6kbC1jN6
 4LeOsfy6iEIj+BtmTR95aFKi+x50HVfWpbugfnYcaHj5/0OwoUnJIekUQxoqncxW+MX1UNRZh
 TgZ/Xn8I0reR4LrEKvOA4/6udduSkUTIDOD4/leWMsKFgLnquiWsMX1/Ot2+VvWaMcL4PPE3g
 96qUtJQMrnsApV0cq2gsjp0qZxREVVdkeESm1dmoR7/1pfvek23Vit69ey+LGROIGSG7UvgEx
 3dgpzTUKcEmcZfgoi+dIElY+jYBt51/OS9gMFmIiWElbfH9tb0T6wzK8XNpPrQ6lE3JB1ORXC
 xl7pQE4POXvucv7/qdIC+tz2pfu3PPFg7HZ9yH3+PWuLgcnvPWCTUmkVO6QSuYzVB1AcVeVu6
 wVLX3MZg/O4whpB1hvMflkNgS7m62s80P+M4rmUfKbVWbJYcQlw+2Je2oIqfqu2yavasnO9qv
 f9qsXC3nT2/Ig6bZNidmaaTCuGpyk8DDs0knkA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

here're some patches that clean up uncessary cases of #ifdef MODULE.
These ifdef's just exlude MODULE_DEVICE_TABLE's when the kernel is
built w/o module support. As MODULE_DEVICE_TABLE() macro already
checks for that, these extra #ifdef's shouldn't be necessary.


--mtx

